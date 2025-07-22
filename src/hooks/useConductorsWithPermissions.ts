import {
  useQuery,
  useMutation,
  useQueryClient,
  useQueries,
} from "@tanstack/react-query";
import {
  fetchConductorsWithPermissions,
  // fetchActiveConductors, // <-- Removido porque não existe
  updateDriverTrackingStatusWithPermissions,
  getCurrentAdminProfile,
  fetchConductorAuditLogs,
  checkConductorPermission,
  checkMultipleConductorPermissions,
  type AdminProfile,
  type ConductorAudit,
} from "@/services/adminPermissionsService";

// Tipos
interface Conductor {
  id: string;
  name: string;
  whatsapp: string;
  is_active: boolean;
  user_id: string;
  latitude?: number;
  longitude?: number;
  region?: string;
  updated_at?: string;
  updated_by?: string;
}

// Query Keys - Centralizados
export const CONDUCTOR_KEYS = {
  all: ["conductors"] as const,
  lists: () => [...CONDUCTOR_KEYS.all, "list"] as const,
  list: (filters: string) => [...CONDUCTOR_KEYS.lists(), { filters }] as const,
  active: () => [...CONDUCTOR_KEYS.all, "active"] as const,
  detail: (id: string) => [...CONDUCTOR_KEYS.all, "detail", id] as const,
  audit: () => [...CONDUCTOR_KEYS.all, "audit"] as const,
  auditById: (id: string) => [...CONDUCTOR_KEYS.audit(), id] as const,
  permissions: () => [...CONDUCTOR_KEYS.all, "permissions"] as const,
  adminProfile: () => ["admin", "profile"] as const,
} as const;

/**
 * Hook profissional para gerenciar condutores com controle de permissões
 * Substitui todas as chamadas diretas e adiciona controle granular de acesso
 */
export const useConductorsWithPermissions = () => {
  const queryClient = useQueryClient();

  // ⚡ OTIMIZAÇÃO: Paralelizar queries principais
  const parallelQueries = useQueries({
    queries: [
      {
        queryKey: CONDUCTOR_KEYS.adminProfile(),
        queryFn: getCurrentAdminProfile,
        staleTime: 10 * 60 * 1000, // 10 minutos
        gcTime: 15 * 60 * 1000, // 15 minutos
      },
      {
        queryKey: CONDUCTOR_KEYS.lists(),
        queryFn: fetchConductorsWithPermissions,
        staleTime: 5 * 60 * 1000, // 5 minutos
        gcTime: 10 * 60 * 1000, // 10 minutos
        retry: 3,
        retryDelay: (attemptIndex) => Math.min(1000 * 2 ** attemptIndex, 30000),
      },
    ],
  });

  const [adminProfileQuery, conductorsQuery] = parallelQueries;

  // Query para logs de auditoria (condicional)
  const auditLogsQuery = useQuery({
    queryKey: CONDUCTOR_KEYS.audit(),
    queryFn: () => fetchConductorAuditLogs(),
    enabled: adminProfileQuery.data?.admin_level === "super_admin",
  });

  // Mutation para atualizar status do condutor com permissões
  const updateStatusMutation = useMutation({
    mutationFn: async ({
      conductorId,
      isActive,
      reason,
    }: {
      conductorId: string;
      isActive: boolean;
      reason?: string;
    }) => {
      await updateDriverTrackingStatusWithPermissions(
        conductorId,
        isActive,
        reason
      );
    },

    onMutate: async ({ conductorId, isActive }) => {
      // Verificar permissões antes do optimistic update
      const hasPermission = await checkConductorPermission(conductorId);
      if (!hasPermission) {
        throw new Error("Você não tem permissão para alterar este condutor");
      }

      // Optimistic update
      await queryClient.cancelQueries({ queryKey: CONDUCTOR_KEYS.lists() });

      const previousAll = queryClient.getQueryData(CONDUCTOR_KEYS.lists());

      // Update all conductors
      queryClient.setQueryData(CONDUCTOR_KEYS.lists(), (old: Conductor[]) => {
        if (!old) return old;
        return old.map((conductor) =>
          conductor.id === conductorId
            ? {
                ...conductor,
                is_active: isActive,
                updated_at: new Date().toISOString(),
              }
            : conductor
        );
      });

      return { previousAll };
    },

    onError: (err, variables, context) => {
      // Rollback on error
      if (context?.previousAll) {
        queryClient.setQueryData(CONDUCTOR_KEYS.lists(), context.previousAll);
      }
      console.error("Erro ao atualizar status do condutor:", err);
    },

    onSettled: (data, error, variables) => {
      // ⚡ Invalidação seletiva para melhor performance
      queryClient.invalidateQueries({ queryKey: CONDUCTOR_KEYS.lists() });

      // Só invalidar auditoria se for super admin
      const adminData = queryClient.getQueryData(
        CONDUCTOR_KEYS.adminProfile()
      ) as AdminProfile | undefined;
      if (adminData?.admin_level === "super_admin") {
        queryClient.invalidateQueries({ queryKey: CONDUCTOR_KEYS.audit() });
      }

      // Invalidar permissão específica
      if (variables?.conductorId) {
        queryClient.invalidateQueries({
          queryKey: [...CONDUCTOR_KEYS.permissions(), variables.conductorId],
        });
      }
    },
  });

  // Hook para verificar permissão específica
  const usePermissionCheck = (conductorId: string) => {
    return useQuery({
      queryKey: [...CONDUCTOR_KEYS.permissions(), conductorId],
      queryFn: () => checkConductorPermission(conductorId),
      staleTime: 5 * 60 * 1000, // 5 minutos
      enabled: !!conductorId && !!adminProfileQuery.data,
    });
  };

  // ⚡ Hook para verificação em lote (otimização)
  const useBatchPermissionCheck = (conductorIds: string[]) => {
    return useQuery({
      queryKey: [
        ...CONDUCTOR_KEYS.permissions(),
        "batch",
        conductorIds.sort().join(","),
      ],
      queryFn: () => checkMultipleConductorPermissions(conductorIds),
      staleTime: 5 * 60 * 1000, // 5 minutos
      enabled: conductorIds.length > 0 && !!adminProfileQuery.data,
    });
  };

  return {
    // Dados
    conductors: conductorsQuery.data || [],
    activeConductors: [], // Removido pois não há query para condutores ativos
    adminProfile: adminProfileQuery.data,
    auditLogs: auditLogsQuery.data || [],

    // Estados
    isLoading: conductorsQuery.isLoading || adminProfileQuery.isLoading,
    isLoadingConductors: conductorsQuery.isLoading,
    isLoadingActive: false, // Removido pois não há query para condutores ativos
    isLoadingProfile: adminProfileQuery.isLoading,
    isLoadingAudit: auditLogsQuery.isLoading,

    // Erros
    error: conductorsQuery.error || adminProfileQuery.error,
    conductorsError: conductorsQuery.error,
    activeError: null, // Removido pois não há query para condutores ativos
    profileError: adminProfileQuery.error,
    auditError: auditLogsQuery.error,

    // Mutations
    updateStatus: updateStatusMutation.mutate,
    updateError: updateStatusMutation.error,

    // Utilities
    refetch: () => {
      conductorsQuery.refetch();
      adminProfileQuery.refetch();
      auditLogsQuery.refetch();
    },

    // Helper para obter condutor por ID
    getConductorById: (id: string) => {
      return conductorsQuery.data?.find((c) => c.id === id);
    },

    // Helper para verificar se condutor está ativo
    isConductorActive: (id: string) => {
      // Como não temos query de condutores ativos, verificamos o campo is_active
      const conductor = conductorsQuery.data?.find((c) => c.id === id);
      return conductor?.is_active || false;
    },

    // Hook para verificar permissões
    usePermissionCheck,
    useBatchPermissionCheck,

    // Verificações de permissão baseadas no perfil
    canManageAllConductors:
      adminProfileQuery.data?.admin_level === "super_admin",
    canViewAuditLogs:
      adminProfileQuery.data?.admin_level === "super_admin" ||
      adminProfileQuery.data?.permissions?.can_view_audit_logs === true,
    canCreateAdmins:
      adminProfileQuery.data?.admin_level === "super_admin" ||
      adminProfileQuery.data?.permissions?.can_create_admins === true,

    // Informações do admin
    adminLevel: adminProfileQuery.data?.admin_level,
    adminRegion: adminProfileQuery.data?.region,
  };
};

// Manter compatibilidade com o hook anterior
export const useConductors = useConductorsWithPermissions;
