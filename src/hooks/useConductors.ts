import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import {
  fetchActiveConductors,
  fetchConductors,
  updateDriverTrackingStatus,
} from "@/services/supabaseService";

// Tipos
interface Conductor {
  id: string;
  name: string;
  whatsapp: string;
  is_active: boolean;
  user_id: string;
  latitude?: number;
  longitude?: number;
}

// Query Keys - Centralizados
export const CONDUCTOR_KEYS = {
  all: ["conductors"] as const,
  lists: () => [...CONDUCTOR_KEYS.all, "list"] as const,
  list: (filters: string) => [...CONDUCTOR_KEYS.lists(), { filters }] as const,
  active: () => [...CONDUCTOR_KEYS.all, "active"] as const,
  detail: (id: string) => [...CONDUCTOR_KEYS.all, "detail", id] as const,
} as const;

/**
 * Hook profissional para gerenciar condutores
 * Substitui todas as chamadas diretas a fetchActiveConductors/fetchConductors
 */
export const useConductors = () => {
  const queryClient = useQueryClient();

  // Query para todos os condutores
  const conductorsQuery = useQuery({
    queryKey: CONDUCTOR_KEYS.lists(),
    queryFn: fetchConductors,
    staleTime: 5 * 60 * 1000, // 5 minutos
    gcTime: 10 * 60 * 1000, // 10 minutos (era cacheTime)
    retry: 3,
    retryDelay: (attemptIndex) => Math.min(1000 * 2 ** attemptIndex, 30000),
  });

  // Query para condutores ativos
  const activeConductorsQuery = useQuery({
    queryKey: CONDUCTOR_KEYS.active(),
    queryFn: fetchActiveConductors,
    staleTime: 30 * 1000, // 30 segundos (dados mais críticos)
    gcTime: 5 * 60 * 1000, // 5 minutos
    retry: 3,
    refetchOnWindowFocus: true,
    refetchInterval: 60 * 1000, // Auto-refresh a cada 1 minuto
  });

  // Mutation para atualizar status do condutor
  const updateStatusMutation = useMutation({
    mutationFn: ({
      conductorId,
      isActive,
    }: {
      conductorId: string;
      isActive: boolean;
    }) => updateDriverTrackingStatus(conductorId, isActive),

    onMutate: async ({ conductorId, isActive }) => {
      // Optimistic update
      await queryClient.cancelQueries({ queryKey: CONDUCTOR_KEYS.active() });
      await queryClient.cancelQueries({ queryKey: CONDUCTOR_KEYS.lists() });

      const previousActive = queryClient.getQueryData(CONDUCTOR_KEYS.active());
      const previousAll = queryClient.getQueryData(CONDUCTOR_KEYS.lists());

      // Update active conductors
      queryClient.setQueryData(CONDUCTOR_KEYS.active(), (old: Conductor[]) => {
        if (!old) return old;
        if (isActive) {
          // Adicionar à lista se não existe
          const exists = old.some((c) => c.id === conductorId);
          if (!exists) {
            // Buscar dados completos do condutor
            const allConductors = queryClient.getQueryData(
              CONDUCTOR_KEYS.lists()
            ) as Conductor[];
            const conductor = allConductors?.find((c) => c.id === conductorId);
            if (conductor) {
              return [...old, { ...conductor, is_active: true }];
            }
          }
          return old;
        } else {
          // Remover da lista
          return old.filter((c) => c.id !== conductorId);
        }
      });

      // Update all conductors
      queryClient.setQueryData(CONDUCTOR_KEYS.lists(), (old: Conductor[]) => {
        if (!old) return old;
        return old.map((conductor) =>
          conductor.id === conductorId
            ? { ...conductor, is_active: isActive }
            : conductor
        );
      });

      return { previousActive, previousAll };
    },

    onError: (err, variables, context) => {
      // Rollback on error
      if (context?.previousActive) {
        queryClient.setQueryData(
          CONDUCTOR_KEYS.active(),
          context.previousActive
        );
      }
      if (context?.previousAll) {
        queryClient.setQueryData(CONDUCTOR_KEYS.lists(), context.previousAll);
      }
      console.error("Erro ao atualizar status do condutor:", err);
    },

    onSettled: () => {
      // Refetch para garantir sincronização
      queryClient.invalidateQueries({ queryKey: CONDUCTOR_KEYS.active() });
      queryClient.invalidateQueries({ queryKey: CONDUCTOR_KEYS.lists() });
    },
  });

  return {
    // Dados
    conductors: conductorsQuery.data || [],
    activeConductors: activeConductorsQuery.data || [],

    // Estados
    isLoading: conductorsQuery.isLoading || activeConductorsQuery.isLoading,
    isLoadingConductors: conductorsQuery.isLoading,
    isLoadingActive: activeConductorsQuery.isLoading,

    // Erros
    error: conductorsQuery.error || activeConductorsQuery.error,
    conductorsError: conductorsQuery.error,
    activeError: activeConductorsQuery.error,

    // Mutations
    updateStatus: updateStatusMutation.mutate,
    isUpdating: updateStatusMutation.isPending,
    updateError: updateStatusMutation.error,

    // Utilities
    refetch: () => {
      conductorsQuery.refetch();
      activeConductorsQuery.refetch();
    },

    // Helper para obter condutor por ID
    getConductorById: (id: string) => {
      return conductorsQuery.data?.find((c) => c.id === id);
    },

    // Helper para verificar se condutor está ativo
    isConductorActive: (id: string) => {
      return activeConductorsQuery.data?.some((c) => c.id === id) || false;
    },
  };
};
