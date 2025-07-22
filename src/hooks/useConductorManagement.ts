import {
  useQuery,
  useMutation,
  useQueryClient,
  useQueries,
} from "@tanstack/react-query";
import { toast } from "sonner";
import { conductorManagementService } from "@/services/conductorManagementService";
import type {
  TukTukVehicle,
  ConductorApplication,
  ConductorProfile,
  ConductorVehicleSession,
  BlockConductorParams,
  ExpelConductorParams,
  AssignVehicleParams,
  CreateApplicationParams,
  SubmitApplicationParams,
  UpdateApplicationStatusParams,
  ConductorFilters,
  VehicleFilters,
  ApplicationFilters,
  PaginationParams,
  RegionalDashboard,
} from "@/types/conductor-management";

// ==================== QUERY KEYS ====================
export const conductorManagementKeys = {
  all: ["conductor-management"] as const,
  vehicles: () => [...conductorManagementKeys.all, "vehicles"] as const,
  vehicle: (id: string) => [...conductorManagementKeys.vehicles(), id] as const,
  vehiclesList: (filters?: VehicleFilters, pagination?: PaginationParams) =>
    [
      ...conductorManagementKeys.vehicles(),
      "list",
      filters,
      pagination,
    ] as const,

  conductors: () => [...conductorManagementKeys.all, "conductors"] as const,
  conductor: (id: string) =>
    [...conductorManagementKeys.conductors(), id] as const,
  conductorsList: (filters?: ConductorFilters, pagination?: PaginationParams) =>
    [
      ...conductorManagementKeys.conductors(),
      "list",
      filters,
      pagination,
    ] as const,

  applications: () => [...conductorManagementKeys.all, "applications"] as const,
  application: (id: string) =>
    [...conductorManagementKeys.applications(), id] as const,
  applicationByToken: (token: string) =>
    [...conductorManagementKeys.applications(), "token", token] as const,
  applicationsList: (
    filters?: ApplicationFilters,
    pagination?: PaginationParams
  ) =>
    [
      ...conductorManagementKeys.applications(),
      "list",
      filters,
      pagination,
    ] as const,

  sessions: () => [...conductorManagementKeys.all, "sessions"] as const,
  activeSessions: (region?: string) =>
    [...conductorManagementKeys.sessions(), "active", region] as const,

  dashboard: () => [...conductorManagementKeys.all, "dashboard"] as const,
  regionalDashboard: (region?: string) =>
    [...conductorManagementKeys.dashboard(), region] as const,
};

// ==================== HOOKS PARA VEÍCULOS ====================

export const useVehicles = (
  filters?: VehicleFilters,
  pagination?: PaginationParams
) => {
  return useQuery({
    queryKey: conductorManagementKeys.vehiclesList(filters, pagination),
    queryFn: () => conductorManagementService.getVehicles(filters, pagination),
    staleTime: 30 * 1000, // 30 segundos
    gcTime: 5 * 60 * 1000, // 5 minutos
  });
};

export const useVehicle = (vehicleId: string) => {
  return useQuery({
    queryKey: conductorManagementKeys.vehicle(vehicleId),
    queryFn: () => conductorManagementService.getVehicleById(vehicleId),
    enabled: !!vehicleId,
    staleTime: 60 * 1000, // 1 minuto
  });
};

export const useUpdateVehicleStatus = () => {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: ({
      vehicleId,
      status,
    }: {
      vehicleId: string;
      status: "operational" | "maintenance" | "out_of_service";
    }) => conductorManagementService.updateVehicleStatus(vehicleId, status),
    onSuccess: (_, { vehicleId }) => {
      // Invalidar queries relacionadas
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.vehicles(),
      });
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.vehicle(vehicleId),
      });
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.dashboard(),
      });

      toast.success("Status do veículo atualizado com sucesso");
    },
    onError: (error) => {
      console.error("Erro ao atualizar status do veículo:", error);
      toast.error("Erro ao atualizar status do veículo");
    },
  });
};

// ==================== HOOKS PARA CONDUTORES ====================

export const useConductors = (
  filters?: ConductorFilters,
  pagination?: PaginationParams
) => {
  return useQuery({
    queryKey: conductorManagementKeys.conductorsList(filters, pagination),
    queryFn: () =>
      conductorManagementService.getConductors(filters, pagination),
    staleTime: 30 * 1000, // 30 segundos
    gcTime: 5 * 60 * 1000, // 5 minutos
  });
};

export const useBlockConductor = () => {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: (params: BlockConductorParams) =>
      conductorManagementService.blockConductor(params),
    onSuccess: () => {
      // Invalidar todas as queries de condutores
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.conductors(),
      });
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.dashboard(),
      });

      toast.success("Condutor bloqueado com sucesso");
    },
    onError: (error) => {
      console.error("Erro ao bloquear condutor:", error);
      toast.error("Erro ao bloquear condutor");
    },
  });
};

export const useUnblockConductor = () => {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: (conductorId: string) =>
      conductorManagementService.unblockConductor(conductorId),
    onSuccess: () => {
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.conductors(),
      });
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.dashboard(),
      });

      toast.success("Condutor desbloqueado com sucesso");
    },
    onError: (error) => {
      console.error("Erro ao desbloquear condutor:", error);
      toast.error("Erro ao desbloquear condutor");
    },
  });
};

export const useExpelConductor = () => {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: (params: ExpelConductorParams) =>
      conductorManagementService.expelConductor(params),
    onSuccess: () => {
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.conductors(),
      });
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.vehicles(),
      });
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.dashboard(),
      });

      toast.success("Condutor expulso do sistema");
    },
    onError: (error) => {
      console.error("Erro ao expulsar condutor:", error);
      toast.error("Erro ao expulsar condutor");
    },
  });
};

export const useAssignVehicle = () => {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: (params: AssignVehicleParams) =>
      conductorManagementService.assignVehicle(params),
    onSuccess: () => {
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.conductors(),
      });
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.vehicles(),
      });
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.dashboard(),
      });

      toast.success("Veículo atribuído com sucesso");
    },
    onError: (error) => {
      console.error("Erro ao atribuir veículo:", error);
      toast.error("Erro ao atribuir veículo");
    },
  });
};

export const useRemoveVehicleAssignment = () => {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: (conductorId: string) =>
      conductorManagementService.removeVehicleAssignment(conductorId),
    onSuccess: () => {
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.conductors(),
      });
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.vehicles(),
      });
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.dashboard(),
      });

      toast.success("Veículo removido do condutor");
    },
    onError: (error) => {
      console.error("Erro ao remover veículo:", error);
      toast.error("Erro ao remover veículo");
    },
  });
};

// ==================== HOOKS PARA CANDIDATURAS ====================

export const useApplications = (
  filters?: ApplicationFilters,
  pagination?: PaginationParams
) => {
  return useQuery({
    queryKey: conductorManagementKeys.applicationsList(filters, pagination),
    queryFn: () =>
      conductorManagementService.getApplications(filters, pagination),
    staleTime: 30 * 1000, // 30 segundos
    gcTime: 5 * 60 * 1000, // 5 minutos
  });
};

export const useApplicationByToken = (token: string) => {
  return useQuery({
    queryKey: conductorManagementKeys.applicationByToken(token),
    queryFn: () => conductorManagementService.getApplicationByToken(token),
    enabled: !!token,
    staleTime: 60 * 1000, // 1 minuto
    retry: false, // Não retry se token inválido
  });
};

export const useCreateApplication = () => {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: (params: CreateApplicationParams) =>
      conductorManagementService.createApplication(params),
    onSuccess: () => {
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.applications(),
      });
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.dashboard(),
      });

      toast.success("Link de candidatura criado com sucesso");
    },
    onError: (error) => {
      console.error("Erro ao criar candidatura:", error);
      toast.error("Erro ao criar candidatura");
    },
  });
};

export const useSubmitApplication = () => {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: (params: SubmitApplicationParams) =>
      conductorManagementService.submitApplication(params),
    onSuccess: (_, { token }) => {
      // Invalidar a candidatura específica
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.applicationByToken(token),
      });
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.applications(),
      });

      toast.success(
        "Candidatura submetida com sucesso! Aguarde a revisão do administrador."
      );
    },
    onError: (error) => {
      console.error("Erro ao submeter candidatura:", error);
      toast.error("Erro ao submeter candidatura");
    },
  });
};

export const useUpdateApplicationStatus = () => {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: (params: UpdateApplicationStatusParams) =>
      conductorManagementService.updateApplicationStatus(params),
    onSuccess: (_, { status }) => {
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.applications(),
      });
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.conductors(),
      });
      queryClient.invalidateQueries({
        queryKey: conductorManagementKeys.dashboard(),
      });

      const message =
        status === "approved"
          ? "Candidatura aprovada! Novo condutor criado automaticamente."
          : "Candidatura rejeitada.";

      toast.success(message);
    },
    onError: (error) => {
      console.error("Erro ao atualizar status da candidatura:", error);
      toast.error("Erro ao atualizar candidatura");
    },
  });
};

// ==================== HOOKS PARA SESSÕES ====================

export const useActiveSessions = (region?: string) => {
  return useQuery({
    queryKey: conductorManagementKeys.activeSessions(region),
    queryFn: () => conductorManagementService.getActiveSessions(region),
    staleTime: 15 * 1000, // 15 segundos (dados mais dinâmicos)
    refetchInterval: 30 * 1000, // Atualizar a cada 30 segundos
  });
};

// ==================== HOOKS PARA DASHBOARD ====================

export const useRegionalDashboard = (region?: string) => {
  return useQuery({
    queryKey: conductorManagementKeys.regionalDashboard(region),
    queryFn: () => conductorManagementService.getRegionalDashboard(region),
    staleTime: 60 * 1000, // 1 minuto
    refetchInterval: 2 * 60 * 1000, // Atualizar a cada 2 minutos
  });
};

// ==================== HOOK COMPOSTO PARA OVERVIEW COMPLETO ====================

export const useConductorManagementOverview = (region?: string) => {
  return useQueries({
    queries: [
      {
        queryKey: conductorManagementKeys.regionalDashboard(region),
        queryFn: () => conductorManagementService.getRegionalDashboard(region),
        staleTime: 60 * 1000,
      },
      {
        queryKey: conductorManagementKeys.vehiclesList({
          region: region ? [region] : undefined,
        }),
        queryFn: () =>
          conductorManagementService.getVehicles(
            { region: region ? [region] : undefined },
            { page: 1, limit: 20 }
          ),
        staleTime: 30 * 1000,
      },
      {
        queryKey: conductorManagementKeys.conductorsList({
          region: region ? [region] : undefined,
        }),
        queryFn: () =>
          conductorManagementService.getConductors(
            { region: region ? [region] : undefined },
            { page: 1, limit: 20 }
          ),
        staleTime: 30 * 1000,
      },
      {
        queryKey: conductorManagementKeys.applicationsList({
          region: region ? [region] : undefined,
          status: ["submitted"], // Apenas candidaturas que precisam de revisão
        }),
        queryFn: () =>
          conductorManagementService.getApplications(
            {
              region: region ? [region] : undefined,
              status: ["submitted"],
            },
            { page: 1, limit: 10 }
          ),
        staleTime: 30 * 1000,
      },
      {
        queryKey: conductorManagementKeys.activeSessions(region),
        queryFn: () => conductorManagementService.getActiveSessions(region),
        staleTime: 15 * 1000,
      },
    ],
    combine: (results) => {
      return {
        dashboard: results[0],
        vehicles: results[1],
        conductors: results[2],
        pendingApplications: results[3],
        activeSessions: results[4],
        isLoading: results.some((result) => result.isLoading),
        isError: results.some((result) => result.isError),
        errors: results
          .filter((result) => result.error)
          .map((result) => result.error),
      };
    },
  });
};
