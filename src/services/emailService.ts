import { supabase } from "@/integrations/supabase/client";

interface EmailTemplateData {
  candidateName: string;
  candidateEmail: string;
  applicationId: string;
  region?: string;
  zone?: string;
  adminNotes?: string;
  rejectionReason?: string;
  loginLink?: string;
}

interface EmailNotificationService {
  sendApplicationSubmitted: (data: EmailTemplateData) => Promise<void>;
  sendApplicationApproved: (data: EmailTemplateData) => Promise<void>;
  sendApplicationRejected: (data: EmailTemplateData) => Promise<void>;
  sendAdminNotification: (data: EmailTemplateData) => Promise<void>;
}

class EmailService implements EmailNotificationService {
  private baseUrl =
    import.meta.env.VITE_APP_URL || "https://tuktuk-milfontes.pt";

  /**
   * Notifica o candidato que a candidatura foi submetida
   */
  async sendApplicationSubmitted(data: EmailTemplateData): Promise<void> {
    try {
      const emailContent = this.generateSubmissionTemplate(data);

      await this.sendEmail({
        to: data.candidateEmail,
        subject: "Candidatura recebida - TukTuk Milfontes",
        html: emailContent,
        type: "application_submitted",
        metadata: { applicationId: data.applicationId },
      });

      console.log(`Email de confirmação enviado para ${data.candidateEmail}`);
    } catch (error) {
      console.error("Erro ao enviar email de submissão:", error);
      throw error;
    }
  }

  /**
   * Notifica o candidato que foi aprovado
   */
  async sendApplicationApproved(data: EmailTemplateData): Promise<void> {
    try {
      const emailContent = this.generateApprovalTemplate(data);

      await this.sendEmail({
        to: data.candidateEmail,
        subject: "🎉 Candidatura aprovada - Bem-vindo à TukTuk Milfontes!",
        html: emailContent,
        type: "application_approved",
        metadata: { applicationId: data.applicationId },
      });

      console.log(`Email de aprovação enviado para ${data.candidateEmail}`);
    } catch (error) {
      console.error("Erro ao enviar email de aprovação:", error);
      throw error;
    }
  }

  /**
   * Notifica o candidato que foi rejeitado
   */
  async sendApplicationRejected(data: EmailTemplateData): Promise<void> {
    try {
      const emailContent = this.generateRejectionTemplate(data);

      await this.sendEmail({
        to: data.candidateEmail,
        subject: "Candidatura não aprovada - TukTuk Milfontes",
        html: emailContent,
        type: "application_rejected",
        metadata: { applicationId: data.applicationId },
      });

      console.log(`Email de rejeição enviado para ${data.candidateEmail}`);
    } catch (error) {
      console.error("Erro ao enviar email de rejeição:", error);
      throw error;
    }
  }

  /**
   * Notifica os administradores sobre nova candidatura
   */
  async sendAdminNotification(data: EmailTemplateData): Promise<void> {
    try {
      const adminEmails = await this.getAdminEmails(data.region);
      const emailContent = this.generateAdminNotificationTemplate(data);

      for (const adminEmail of adminEmails) {
        await this.sendEmail({
          to: adminEmail,
          subject: `Nova candidatura recebida - ${data.candidateName}`,
          html: emailContent,
          type: "admin_notification",
          metadata: { applicationId: data.applicationId },
        });
      }

      console.log(
        `Notificação enviada para ${adminEmails.length} administradores`
      );
    } catch (error) {
      console.error("Erro ao enviar notificação para admin:", error);
      throw error;
    }
  }

  /**
   * Busca emails dos administradores para uma região específica
   */
  private async getAdminEmails(region?: string): Promise<string[]> {
    try {
      let query = supabase
        .from("profiles")
        .select("email")
        .in("role", ["admin", "super_admin"]);

      if (region) {
        query = query.or(`region.eq.${region},role.eq.super_admin`);
      }

      const { data, error } = await query;

      if (error) throw error;

      return data?.map((profile) => profile.email).filter(Boolean) || [];
    } catch (error) {
      console.error("Erro ao buscar emails de administradores:", error);
      // Fallback para email padrão
      return ["admin@tuktuk-milfontes.pt"];
    }
  }

  /**
   * Função genérica para enviar emails via Supabase Edge Function
   */
  private async sendEmail(emailData: {
    to: string;
    subject: string;
    html: string;
    type: string;
    metadata?: Record<string, string | number>;
  }): Promise<void> {
    try {
      const { error } = await supabase.functions.invoke("send-email", {
        body: emailData,
      });

      if (error) throw error;
    } catch (error) {
      console.error("Erro ao enviar email:", error);
      // Em desenvolvimento ou se não houver função configurada, apenas log
      if (import.meta.env.DEV) {
        console.log("Email que seria enviado:", emailData);
      }
    }
  }

  /**
   * Template para confirmação de submissão
   */
  private generateSubmissionTemplate(data: EmailTemplateData): string {
    return `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <title>Candidatura Recebida</title>
        <style>
          body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
          .container { max-width: 600px; margin: 0 auto; padding: 20px; }
          .header { background: linear-gradient(135deg, #2563eb, #16a34a); color: white; padding: 30px; text-align: center; border-radius: 8px 8px 0 0; }
          .content { background: #f8fafc; padding: 30px; border-radius: 0 0 8px 8px; }
          .button { display: inline-block; background: #2563eb; color: white; padding: 12px 24px; text-decoration: none; border-radius: 6px; margin: 20px 0; }
          .status-box { background: #dbeafe; border-left: 4px solid #2563eb; padding: 15px; margin: 20px 0; }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="header">
            <h1>🛺 TukTuk Milfontes</h1>
            <h2>Candidatura Recebida</h2>
          </div>
          <div class="content">
            <p>Olá <strong>${data.candidateName}</strong>,</p>
            
            <p>A sua candidatura para se tornar condutor TukTuk foi recebida com sucesso!</p>
            
            <div class="status-box">
              <strong>📋 Detalhes da sua candidatura:</strong><br>
              • Email: ${data.candidateEmail}<br>
              ${data.region ? `• Região: ${data.region}<br>` : ""}
              ${data.zone ? `• Zona: ${data.zone}<br>` : ""}
              • ID: ${data.applicationId}
            </div>

            <p><strong>O que acontece agora?</strong></p>
            <ul>
              <li>A nossa equipa irá analisar a sua candidatura</li>
              <li>Entraremos em contacto consigo num prazo de 2-3 dias úteis</li>
              <li>Se aprovado, receberá as instruções para começar</li>
            </ul>

            <p>Se tiver alguma questão, não hesite em contactar-nos através do email <a href="mailto:condutores@tuktuk-milfontes.pt">condutores@tuktuk-milfontes.pt</a> ou telefone +351 123 456 789.</p>

            <p>Obrigado pelo seu interesse em fazer parte da nossa equipa!</p>
            
            <p>Cumprimentos,<br>
            <strong>Equipa TukTuk Milfontes</strong></p>
          </div>
        </div>
      </body>
      </html>
    `;
  }

  /**
   * Template para aprovação
   */
  private generateApprovalTemplate(data: EmailTemplateData): string {
    return `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <title>Candidatura Aprovada</title>
        <style>
          body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
          .container { max-width: 600px; margin: 0 auto; padding: 20px; }
          .header { background: linear-gradient(135deg, #16a34a, #22c55e); color: white; padding: 30px; text-align: center; border-radius: 8px 8px 0 0; }
          .content { background: #f8fafc; padding: 30px; border-radius: 0 0 8px 8px; }
          .button { display: inline-block; background: #16a34a; color: white; padding: 12px 24px; text-decoration: none; border-radius: 6px; margin: 20px 0; }
          .success-box { background: #dcfce7; border-left: 4px solid #16a34a; padding: 15px; margin: 20px 0; }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="header">
            <h1>🎉 Parabéns!</h1>
            <h2>Candidatura Aprovada</h2>
          </div>
          <div class="content">
            <p>Olá <strong>${data.candidateName}</strong>,</p>
            
            <div class="success-box">
              <strong>✅ A sua candidatura foi aprovada!</strong><br>
              Bem-vindo à equipa TukTuk Milfontes!
            </div>

            ${
              data.adminNotes
                ? `
            <p><strong>Notas do administrador:</strong><br>
            <em>${data.adminNotes}</em></p>
            `
                : ""
            }

            <p><strong>Próximos passos:</strong></p>
            <ol>
              <li>Aceda à sua conta através do link abaixo</li>
              <li>Complete o seu perfil de condutor</li>
              <li>Configure os seus horários de disponibilidade</li>
              <li>Comece a receber reservas!</li>
            </ol>

            ${
              data.loginLink
                ? `
            <p style="text-align: center;">
              <a href="${data.loginLink}" class="button">Aceder à Minha Conta</a>
            </p>
            `
                : ""
            }

            <p><strong>Contactos de apoio:</strong></p>
            <ul>
              <li>Email: <a href="mailto:condutores@tuktuk-milfontes.pt">condutores@tuktuk-milfontes.pt</a></li>
              <li>Telefone: +351 123 456 789</li>
              <li>WhatsApp: +351 123 456 789</li>
            </ul>

            <p>Estamos ansiosos por tê-lo na nossa equipa!</p>
            
            <p>Cumprimentos,<br>
            <strong>Equipa TukTuk Milfontes</strong></p>
          </div>
        </div>
      </body>
      </html>
    `;
  }

  /**
   * Template para rejeição
   */
  private generateRejectionTemplate(data: EmailTemplateData): string {
    const reasonMap: Record<string, string> = {
      incomplete: "Informações incompletas ou incorretas",
      requirements: "Não cumprimento dos requisitos mínimos",
      region: "Região não disponível no momento",
      capacity: "Capacidade máxima de condutores atingida na região",
      other: "Outros motivos",
    };

    const reasonText = data.rejectionReason
      ? reasonMap[data.rejectionReason] || data.rejectionReason
      : "Não especificado";

    return `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <title>Candidatura Não Aprovada</title>
        <style>
          body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
          .container { max-width: 600px; margin: 0 auto; padding: 20px; }
          .header { background: linear-gradient(135deg, #ef4444, #f97316); color: white; padding: 30px; text-align: center; border-radius: 8px 8px 0 0; }
          .content { background: #f8fafc; padding: 30px; border-radius: 0 0 8px 8px; }
          .button { display: inline-block; background: #2563eb; color: white; padding: 12px 24px; text-decoration: none; border-radius: 6px; margin: 20px 0; }
          .info-box { background: #fef3c7; border-left: 4px solid #f59e0b; padding: 15px; margin: 20px 0; }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="header">
            <h1>TukTuk Milfontes</h1>
            <h2>Candidatura Não Aprovada</h2>
          </div>
          <div class="content">
            <p>Olá <strong>${data.candidateName}</strong>,</p>
            
            <p>Agradecemos o seu interesse em fazer parte da equipa TukTuk Milfontes.</p>
            
            <div class="info-box">
              <strong>Motivo:</strong> ${reasonText}
            </div>

            ${
              data.adminNotes
                ? `
            <p><strong>Notas adicionais:</strong><br>
            <em>${data.adminNotes}</em></p>
            `
                : ""
            }

            <p>Embora não possamos aprovar a sua candidatura neste momento, encorajamos-o a candidatar-se novamente no futuro caso a situação mude.</p>

            <p style="text-align: center;">
              <a href="${
                this.baseUrl
              }/candidatura-condutor" class="button">Nova Candidatura</a>
            </p>

            <p>Se tiver questões sobre esta decisão, pode contactar-nos através de:</p>
            <ul>
              <li>Email: <a href="mailto:condutores@tuktuk-milfontes.pt">condutores@tuktuk-milfontes.pt</a></li>
              <li>Telefone: +351 123 456 789</li>
            </ul>

            <p>Obrigado pela sua compreensão.</p>
            
            <p>Cumprimentos,<br>
            <strong>Equipa TukTuk Milfontes</strong></p>
          </div>
        </div>
      </body>
      </html>
    `;
  }

  /**
   * Template para notificação de administradores
   */
  private generateAdminNotificationTemplate(data: EmailTemplateData): string {
    return `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <title>Nova Candidatura</title>
        <style>
          body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
          .container { max-width: 600px; margin: 0 auto; padding: 20px; }
          .header { background: linear-gradient(135deg, #2563eb, #16a34a); color: white; padding: 30px; text-align: center; border-radius: 8px 8px 0 0; }
          .content { background: #f8fafc; padding: 30px; border-radius: 0 0 8px 8px; }
          .button { display: inline-block; background: #2563eb; color: white; padding: 12px 24px; text-decoration: none; border-radius: 6px; margin: 20px 0; }
          .candidate-box { background: #e0f2fe; border-left: 4px solid #0369a1; padding: 15px; margin: 20px 0; }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="header">
            <h1>📋 Nova Candidatura</h1>
            <h2>TukTuk Milfontes</h2>
          </div>
          <div class="content">
            <p>Foi recebida uma nova candidatura para condutor:</p>
            
            <div class="candidate-box">
              <strong>👤 Candidato:</strong> ${data.candidateName}<br>
              <strong>📧 Email:</strong> ${data.candidateEmail}<br>
              ${
                data.region
                  ? `<strong>📍 Região:</strong> ${data.region}<br>`
                  : ""
              }
              ${data.zone ? `<strong>🗺️ Zona:</strong> ${data.zone}<br>` : ""}
              <strong>🆔 ID:</strong> ${data.applicationId}
            </div>

            <p><strong>Ações necessárias:</strong></p>
            <ul>
              <li>Analisar a candidatura no painel administrativo</li>
              <li>Verificar documentação e requisitos</li>
              <li>Aprovar ou rejeitar com justificação</li>
            </ul>

            <p style="text-align: center;">
              <a href="${
                this.baseUrl
              }/admin/dashboard" class="button">Ver no Painel Admin</a>
            </p>

            <p><em>Esta é uma mensagem automática do sistema TukTuk Milfontes.</em></p>
          </div>
        </div>
      </body>
      </html>
    `;
  }
}

// Instância singleton do serviço
export const emailService = new EmailService();

export default emailService;
