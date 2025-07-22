import { supabase } from "@/lib/supabase";
import { toast } from "sonner";
import { simpleNotificationService } from "./simpleNotificationService";
import type {
  ConductorApplication,
  ApplicationFilters,
  PaginatedResponse,
} from "@/types/conductor-management";

export interface PublicApplicationData {
  full_name: string;
  email: string;
  phone: string;
  whatsapp?: string;
  region: string;
  zone?: string;
  license_number?: string;
  vehicle_info: {
    marca?: string;
    modelo?: string;
    ano?: number;
    matricula?: string;
  };
  experience?: string;
  motivation?: string;
}

export interface ApplicationApprovalData {
  applicationId: string;
  approved: boolean;
  adminNotes?: string;
  rejectionReason?: string;
}

/**
 * Serviço para gestão de candidaturas de condutores
 */
export class CandidaturaService {
  /**
   * Submeter candidatura pública (sem autenticação)
   */
  static async submitPublicApplication(
    data: PublicApplicationData
  ): Promise<{ id: string; token: string }> {
    try {
      // Gerar token único para seguimento
      const registrationToken = crypto.randomUUID();

      const applicationData = {
        full_name: data.full_name,
        email: data.email,
        phone: data.phone,
        whatsapp: data.whatsapp,
        region: data.region,
        zone: data.zone,
        license_number: data.license_number,
        vehicle_info: {
          ...data.vehicle_info,
          experience: data.experience,
          motivation: data.motivation,
        },
        status: "submitted" as const,
        admin_level: "admin_local" as const, // Será processada por admin local
        registration_token: registrationToken,
        submitted_at: new Date().toISOString(),
      };

      const { data: application, error } = await supabase
        .from("conductor_applications")
        .insert(applicationData)
        .select("id, registration_token")
        .single();

      if (error) throw error;

      // Enviar notificações simples
      await simpleNotificationService.notifyApplicationSubmitted({
        candidateName: data.full_name,
        candidateEmail: data.email,
        applicationId: application.id,
        region: data.region,
        zone: data.zone,
      });

      return {
        id: application.id,
        token: application.registration_token,
      };
    } catch (error) {
      console.error("Erro ao submeter candidatura:", error);
      throw new Error("Erro ao submeter candidatura. Tente novamente.");
    }
  }

  /**
   * Obter candidaturas pendentes para administradores
   */
  static async getPendingApplications(
    region?: string,
    adminLevel?: string
  ): Promise<ConductorApplication[]> {
    try {
      let query = supabase
        .from("conductor_applications")
        .select("*")
        .in("status", ["submitted", "link_created"]);

      // Filtrar por região se não for super_admin
      if (adminLevel !== "super_admin" && region) {
        query = query.eq("region", region);
      }

      query = query.order("created_at", { ascending: false });

      const { data, error } = await query;

      if (error) throw error;

      return data || [];
    } catch (error) {
      console.error("Erro ao buscar candidaturas:", error);
      throw new Error("Erro ao carregar candidaturas pendentes");
    }
  }

  /**
   * Aprovar candidatura
   */
  static async approveApplication(
    data: ApplicationApprovalData
  ): Promise<void> {
    try {
      const { data: user } = await supabase.auth.getUser();
      if (!user.user) throw new Error("Utilizador não autenticado");

      const updateData = {
        status: data.approved ? "approved" : "rejected",
        reviewed_at: new Date().toISOString(),
        admin_notes: data.adminNotes,
        rejection_reason: data.approved ? null : data.rejectionReason,
        approved_at: data.approved ? new Date().toISOString() : null,
      };

      const { error } = await supabase
        .from("conductor_applications")
        .update(updateData)
        .eq("id", data.applicationId);

      if (error) throw error;

      // Se aprovado, criar perfil de condutor
      if (data.approved) {
        await this.createConductorFromApplication(data.applicationId);
      }

      // Buscar dados da candidatura para notificações
      const { data: application } = await supabase
        .from("conductor_applications")
        .select("full_name, email, region, zone")
        .eq("id", data.applicationId)
        .single();

      if (application) {
        // Enviar notificações simples
        if (data.approved) {
          await simpleNotificationService.notifyApplicationApproved({
            candidateName: application.full_name,
            candidateEmail: application.email,
            applicationId: data.applicationId,
            region: application.region,
            zone: application.zone,
            adminNotes: data.adminNotes,
          });
        } else {
          await simpleNotificationService.notifyApplicationRejected({
            candidateName: application.full_name,
            candidateEmail: application.email,
            applicationId: data.applicationId,
            region: application.region,
            zone: application.zone,
            rejectionReason: data.rejectionReason,
            adminNotes: data.adminNotes,
          });
        }
      }
    } catch (error) {
      console.error("Erro ao processar candidatura:", error);
      throw new Error("Erro ao processar candidatura");
    }
  }

  /**
   * Criar condutor a partir de candidatura aprovada
   */
  private static async createConductorFromApplication(
    applicationId: string
  ): Promise<void> {
    try {
      // Buscar dados da candidatura
      const { data: application, error: fetchError } = await supabase
        .from("conductor_applications")
        .select("*")
        .eq("id", applicationId)
        .single();

      if (fetchError) throw fetchError;

      // Criar entrada na tabela conductors
      const conductorData = {
        name: application.full_name,
        email: application.email,
        whatsapp: application.phone, // Usar phone como whatsapp por defeito
        region: application.region,
        vehicle_info: application.vehicle_info,
        license_number: application.license_number,
        is_active: true,
        status: "active",
        created_at: new Date().toISOString(),
      };

      const { error: insertError } = await supabase
        .from("conductors")
        .insert(conductorData);

      if (insertError) throw insertError;
    } catch (error) {
      console.error("Erro ao criar condutor:", error);
      throw new Error("Erro ao criar perfil de condutor");
    }
  }

  /**
   * Obter candidatura por token (para seguimento público)
   */
  static async getApplicationByToken(
    token: string
  ): Promise<Partial<ConductorApplication> | null> {
    try {
      const { data, error } = await supabase
        .from("conductor_applications")
        .select(
          "id, full_name, email, status, created_at, submitted_at, reviewed_at, rejection_reason"
        )
        .eq("registration_token", token)
        .single();

      if (error) {
        if (error.code === "PGRST116") return null; // Not found
        throw error;
      }

      return data;
    } catch (error) {
      console.error("Erro ao buscar candidatura:", error);
      return null;
    }
  }

  /**
   * Obter estatísticas de candidaturas para dashboard admin
   */
  static async getApplicationStats(region?: string): Promise<{
    total: number;
    pending: number;
    approved: number;
    rejected: number;
    thisMonth: number;
  }> {
    try {
      let query = supabase
        .from("conductor_applications")
        .select("status, created_at");

      if (region) {
        query = query.eq("region", region);
      }

      const { data, error } = await query;

      if (error) throw error;

      const now = new Date();
      const startOfMonth = new Date(now.getFullYear(), now.getMonth(), 1);

      return {
        total: data.length,
        pending: data.filter((app) =>
          ["submitted", "link_created"].includes(app.status)
        ).length,
        approved: data.filter((app) => app.status === "approved").length,
        rejected: data.filter((app) => app.status === "rejected").length,
        thisMonth: data.filter(
          (app) => new Date(app.created_at) >= startOfMonth
        ).length,
      };
    } catch (error) {
      console.error("Erro ao obter estatísticas:", error);
      return { total: 0, pending: 0, approved: 0, rejected: 0, thisMonth: 0 };
    }
  }
}

export default CandidaturaService;
