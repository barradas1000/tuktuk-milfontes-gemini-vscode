import { supabase } from "@/lib/supabase";
import { toast } from "sonner";

interface NotificationData {
  candidateName: string;
  candidateEmail: string;
  applicationId: string;
  region?: string;
  zone?: string;
  adminNotes?: string;
  rejectionReason?: string;
}

interface AdminNotification {
  id?: string;
  type: string;
  title: string;
  message: string;
  application_id: string;
  region?: string;
  read: boolean;
  created_at: string;
  resolved_at?: string;
}

/**
 * Sistema de notificações internas simples
 * Sem email - apenas notificações no dashboard e toasts
 */
class SimpleNotificationService {
  /**
   * Confirma submissão para o candidato (apenas toast)
   */
  async notifyApplicationSubmitted(data: NotificationData): Promise<void> {
    // Toast de sucesso para o candidato
    toast.success("Candidatura enviada com sucesso!", {
      description: "Entraremos em contacto em 2-3 dias úteis.",
      duration: 5000,
    });

    // Criar notificação interna para admins
    await this.createAdminNotification({
      type: "nova_candidatura",
      title: `Nova candidatura: ${data.candidateName}`,
      message: `Candidatura recebida de ${data.candidateName} (${data.candidateEmail}) para ${data.region}`,
      applicationId: data.applicationId,
      region: data.region,
    });

    console.log(`✅ Candidatura submetida: ${data.candidateName}`);
  }

  /**
   * Notifica aprovação (toast + atualização no dashboard)
   */
  async notifyApplicationApproved(data: NotificationData): Promise<void> {
    toast.success("Candidatura aprovada!", {
      description: `${data.candidateName} foi aprovado como condutor.`,
      duration: 4000,
    });

    // Marcar notificação como resolvida
    await this.resolveAdminNotification(data.applicationId);

    console.log(`✅ Candidatura aprovada: ${data.candidateName}`);
  }

  /**
   * Notifica rejeição
   */
  async notifyApplicationRejected(data: NotificationData): Promise<void> {
    const reasonMap: Record<string, string> = {
      incomplete: "Informações incompletas",
      requirements: "Não cumpre requisitos",
      region: "Região não disponível",
      capacity: "Capacidade máxima atingida",
      other: "Outros motivos",
    };

    const reason = data.rejectionReason
      ? reasonMap[data.rejectionReason] || data.rejectionReason
      : "Não especificado";

    toast.error("Candidatura rejeitada", {
      description: `${data.candidateName} - Motivo: ${reason}`,
      duration: 4000,
    });

    // Marcar notificação como resolvida
    await this.resolveAdminNotification(data.applicationId);

    console.log(`❌ Candidatura rejeitada: ${data.candidateName} - ${reason}`);
  }

  /**
   * Cria notificação interna para administradores
   */
  private async createAdminNotification(notification: {
    type: string;
    title: string;
    message: string;
    applicationId: string;
    region?: string;
  }): Promise<void> {
    try {
      const { error } = await supabase.from("admin_notifications").insert({
        type: notification.type,
        title: notification.title,
        message: notification.message,
        application_id: notification.applicationId,
        region: notification.region,
        read: false,
        created_at: new Date().toISOString(),
      });

      if (error) {
        console.error("Erro ao criar notificação admin:", error);
        // Fallback: log simples se tabela não existir
        console.log("📢 NOTIFICAÇÃO ADMIN:", notification.title);
      }
    } catch (error) {
      console.error("Erro ao criar notificação:", error);
      // Em caso de erro, apenas log
      console.log("📢 NOTIFICAÇÃO ADMIN:", notification.title);
    }
  }

  /**
   * Marca notificação como resolvida
   */
  private async resolveAdminNotification(applicationId: string): Promise<void> {
    try {
      const { error } = await supabase
        .from("admin_notifications")
        .update({
          read: true,
          resolved_at: new Date().toISOString(),
        })
        .eq("application_id", applicationId);

      if (error) {
        console.error("Erro ao resolver notificação:", error);
      }
    } catch (error) {
      console.error("Erro ao resolver notificação:", error);
    }
  }

  /**
   * Busca notificações não lidas para o dashboard admin
   */
  async getUnreadNotifications(region?: string): Promise<AdminNotification[]> {
    try {
      let query = supabase
        .from("admin_notifications")
        .select("*")
        .eq("read", false)
        .order("created_at", { ascending: false });

      if (region) {
        query = query.or(`region.eq.${region},region.is.null`);
      }

      const { data, error } = await query;

      if (error) throw error;

      return data || [];
    } catch (error) {
      console.error("Erro ao buscar notificações:", error);
      return [];
    }
  }

  /**
   * Conta notificações não lidas
   */
  async getUnreadCount(region?: string): Promise<number> {
    const notifications = await this.getUnreadNotifications(region);
    return notifications.length;
  }
}

// Instância singleton
export const simpleNotificationService = new SimpleNotificationService();

export default simpleNotificationService;
