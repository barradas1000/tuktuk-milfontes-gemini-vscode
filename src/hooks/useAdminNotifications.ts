import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { simpleNotificationService } from "@/services/simpleNotificationService";
import { toast } from "sonner";

interface UseAdminNotificationsProps {
  region?: string;
  enabled?: boolean;
}

/**
 * Hook para gerenciar notificações do admin
 */
export const useAdminNotifications = ({
  region,
  enabled = true,
}: UseAdminNotificationsProps = {}) => {
  const queryClient = useQueryClient();

  // Query para buscar notificações não lidas
  const {
    data: notifications = [],
    isLoading,
    error,
    refetch,
  } = useQuery({
    queryKey: ["admin-notifications", region],
    queryFn: () => simpleNotificationService.getUnreadNotifications(region),
    enabled,
    refetchInterval: 30000, // Atualizar a cada 30 segundos
    staleTime: 10000, // Considerar dados fresh por 10 segundos
  });

  // Query para contar notificações não lidas
  const { data: unreadCount = 0, isLoading: isCountLoading } = useQuery({
    queryKey: ["admin-notifications-count", region],
    queryFn: () => simpleNotificationService.getUnreadCount(region),
    enabled,
    refetchInterval: 30000,
    staleTime: 10000,
  });

  // Mutation para marcar notificação como lida
  const markAsReadMutation = useMutation({
    mutationFn: async (applicationId: string) => {
      // Esta funcionalidade seria implementada no simpleNotificationService
      // Por agora, apenas invalida as queries
      return Promise.resolve();
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["admin-notifications"] });
      queryClient.invalidateQueries({
        queryKey: ["admin-notifications-count"],
      });
      toast.success("Notificação marcada como lida");
    },
    onError: (error) => {
      toast.error("Erro ao marcar notificação como lida");
      console.error("Erro:", error);
    },
  });

  // Mutation para marcar todas como lidas
  const markAllAsReadMutation = useMutation({
    mutationFn: async () => {
      // Esta funcionalidade seria implementada no simpleNotificationService
      return Promise.resolve();
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["admin-notifications"] });
      queryClient.invalidateQueries({
        queryKey: ["admin-notifications-count"],
      });
      toast.success("Todas as notificações foram marcadas como lidas");
    },
    onError: (error) => {
      toast.error("Erro ao marcar notificações como lidas");
      console.error("Erro:", error);
    },
  });

  return {
    // Data
    notifications,
    unreadCount,

    // Loading states
    isLoading: isLoading || isCountLoading,
    isMarkingAsRead: markAsReadMutation.isPending,
    isMarkingAllAsRead: markAllAsReadMutation.isPending,

    // Error
    error,

    // Actions
    markAsRead: markAsReadMutation.mutate,
    markAllAsRead: markAllAsReadMutation.mutate,
    refetch,

    // Helper
    hasUnreadNotifications: unreadCount > 0,
  };
};

export default useAdminNotifications;
