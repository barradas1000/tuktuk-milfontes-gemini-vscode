import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import CandidaturaService, {
  type PublicApplicationData,
  type ApplicationApprovalData,
} from "@/services/candidaturaService";
import { toast } from "sonner";

// Query Keys
export const CANDIDATURA_KEYS = {
  all: ["candidaturas"] as const,
  pending: (region?: string) =>
    [...CANDIDATURA_KEYS.all, "pending", region] as const,
  stats: (region?: string) =>
    [...CANDIDATURA_KEYS.all, "stats", region] as const,
  byToken: (token: string) =>
    [...CANDIDATURA_KEYS.all, "token", token] as const,
} as const;

/**
 * Hook para submeter candidatura pública
 */
export const useSubmitCandidatura = () => {
  return useMutation({
    mutationFn: (data: PublicApplicationData) =>
      CandidaturaService.submitPublicApplication(data),
    onSuccess: () => {
      toast.success("Candidatura enviada com sucesso!");
    },
    onError: (error: Error) => {
      toast.error(error.message || "Erro ao enviar candidatura");
    },
  });
};

/**
 * Hook para obter candidaturas pendentes (Admin)
 */
export const usePendingApplications = (
  region?: string,
  adminLevel?: string
) => {
  return useQuery({
    queryKey: CANDIDATURA_KEYS.pending(region),
    queryFn: () =>
      CandidaturaService.getPendingApplications(region, adminLevel),
    staleTime: 2 * 60 * 1000, // 2 minutos
    gcTime: 5 * 60 * 1000, // 5 minutos
    refetchInterval: 30 * 1000, // Atualizar a cada 30 segundos
    retry: 3,
  });
};

/**
 * Hook para aprovar/rejeitar candidaturas (Admin)
 */
export const useApproveApplication = () => {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: (data: ApplicationApprovalData) =>
      CandidaturaService.approveApplication(data),
    onSuccess: (_, variables) => {
      // Invalidar candidaturas pendentes
      queryClient.invalidateQueries({ queryKey: CANDIDATURA_KEYS.all });

      // Invalidar também condutores se foi aprovado
      if (variables.approved) {
        queryClient.invalidateQueries({ queryKey: ["conductors"] });
      }

      toast.success(
        variables.approved
          ? "Candidatura aprovada com sucesso!"
          : "Candidatura rejeitada"
      );
    },
    onError: (error: Error) => {
      toast.error(error.message || "Erro ao processar candidatura");
    },
  });
};

/**
 * Hook para obter candidatura por token (Público)
 */
export const useApplicationByToken = (token?: string) => {
  return useQuery({
    queryKey: CANDIDATURA_KEYS.byToken(token || ""),
    queryFn: () =>
      token ? CandidaturaService.getApplicationByToken(token) : null,
    enabled: !!token,
    staleTime: 5 * 60 * 1000, // 5 minutos
    retry: 2,
  });
};

/**
 * Hook para estatísticas de candidaturas (Admin)
 */
export const useApplicationStats = (region?: string) => {
  return useQuery({
    queryKey: CANDIDATURA_KEYS.stats(region),
    queryFn: () => CandidaturaService.getApplicationStats(region),
    staleTime: 5 * 60 * 1000, // 5 minutos
    gcTime: 10 * 60 * 1000, // 10 minutos
    retry: 3,
  });
};

/**
 * Hook composto para dashboard de candidaturas admin
 */
export const useCandidaturaDashboard = (
  region?: string,
  adminLevel?: string
) => {
  const pendingQuery = usePendingApplications(region, adminLevel);
  const statsQuery = useApplicationStats(region);
  const approveMutation = useApproveApplication();

  return {
    // Dados
    applications: pendingQuery.data || [],
    stats: statsQuery.data || {
      total: 0,
      pending: 0,
      approved: 0,
      rejected: 0,
      thisMonth: 0,
    },

    // Estados
    isLoading: pendingQuery.isLoading || statsQuery.isLoading,
    isLoadingApplications: pendingQuery.isLoading,
    isLoadingStats: statsQuery.isLoading,

    // Erros
    error: pendingQuery.error || statsQuery.error,
    applicationsError: pendingQuery.error,
    statsError: statsQuery.error,

    // Ações
    approveApplication: approveMutation.mutate,
    isApproving: approveMutation.isPending,
    approveError: approveMutation.error,

    // Utilitários
    refetch: () => {
      pendingQuery.refetch();
      statsQuery.refetch();
    },

    // Helper para obter aplicação por ID
    getApplicationById: (id: string) => {
      return pendingQuery.data?.find((app) => app.id === id);
    },
  };
};
