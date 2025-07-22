import { supabase } from "@/lib/supabase";
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
  PaginatedResponse,
  RegionalDashboard,
} from "@/types/conductor-management";

export class ConductorManagementService {
  // ==================== GESTÃO DE VEÍCULOS ====================

  async getVehicles(
    filters?: VehicleFilters,
    pagination?: PaginationParams
  ): Promise<PaginatedResponse<TukTukVehicle>> {
    let query = supabase.from("tuktuk_vehicles").select(`
        *,
        conductor:current_conductor(
          id, name, email, status
        ),
        manager:managed_by(
          id, full_name, email
        )
      `);

    // Aplicar filtros
    if (filters?.status?.length) {
      query = query.in("maintenance_status", filters.status);
    }
    if (filters?.region?.length) {
      query = query.in("region", filters.region);
    }
    if (filters?.zone?.length) {
      query = query.in("zone", filters.zone);
    }
    if (filters?.isAvailable !== undefined) {
      query = query.eq("is_available", filters.isAvailable);
    }
    if (filters?.isActive !== undefined) {
      query = query.eq("is_active", filters.isActive);
    }
    if (filters?.searchTerm) {
      query = query.or(
        `vehicle_name.ilike.%${filters.searchTerm}%,license_plate.ilike.%${filters.searchTerm}%`
      );
    }

    // Aplicar paginação e ordenação
    if (pagination) {
      const {
        page,
        limit,
        sortBy = "vehicle_number",
        sortOrder = "asc",
      } = pagination;
      const offset = (page - 1) * limit;

      query = query
        .order(sortBy, { ascending: sortOrder === "asc" })
        .range(offset, offset + limit - 1);
    }

    const { data, error, count } = await query;

    if (error) throw error;

    return {
      data: data || [],
      pagination: pagination
        ? {
            page: pagination.page,
            limit: pagination.limit,
            total: count || 0,
            totalPages: Math.ceil((count || 0) / pagination.limit),
            hasNextPage: pagination.page * pagination.limit < (count || 0),
            hasPreviousPage: pagination.page > 1,
          }
        : {
            page: 1,
            limit: data?.length || 0,
            total: data?.length || 0,
            totalPages: 1,
            hasNextPage: false,
            hasPreviousPage: false,
          },
    };
  }

  async getVehicleById(vehicleId: string): Promise<TukTukVehicle> {
    const { data, error } = await supabase
      .from("tuktuk_vehicles")
      .select(
        `
        *,
        conductor:current_conductor(
          id, name, email, status, whatsapp
        ),
        manager:managed_by(
          id, full_name, email
        )
      `
      )
      .eq("id", vehicleId)
      .single();

    if (error) throw error;
    return data;
  }

  async updateVehicleStatus(
    vehicleId: string,
    status: "operational" | "maintenance" | "out_of_service"
  ): Promise<void> {
    const { error } = await supabase
      .from("tuktuk_vehicles")
      .update({
        maintenance_status: status,
        is_available: status === "operational",
      })
      .eq("id", vehicleId);

    if (error) throw error;
  }

  // ==================== GESTÃO DE CONDUTORES ====================

  async getConductors(
    filters?: ConductorFilters,
    pagination?: PaginationParams
  ): Promise<PaginatedResponse<ConductorProfile>> {
    let query = supabase.from("conductors").select(`
        *,
        vehicle:assigned_vehicle(
          id, vehicle_name, license_plate, maintenance_status
        ),
        blocker:blocked_by(
          id, full_name, email
        ),
        active_session:conductor_vehicle_sessions!inner(
          id, started_at, vehicle_id, is_active
        )
      `);

    // Aplicar filtros
    if (filters?.status?.length) {
      query = query.in("status", filters.status);
    }
    if (filters?.region?.length) {
      query = query.in("region", filters.region);
    }
    if (filters?.hasVehicle !== undefined) {
      if (filters.hasVehicle) {
        query = query.not("assigned_vehicle", "is", null);
      } else {
        query = query.is("assigned_vehicle", null);
      }
    }
    if (filters?.searchTerm) {
      query = query.or(
        `name.ilike.%${filters.searchTerm}%,email.ilike.%${filters.searchTerm}%`
      );
    }

    // Aplicar paginação
    if (pagination) {
      const {
        page,
        limit,
        sortBy = "created_at",
        sortOrder = "desc",
      } = pagination;
      const offset = (page - 1) * limit;

      query = query
        .order(sortBy, { ascending: sortOrder === "asc" })
        .range(offset, offset + limit - 1);
    }

    const { data, error, count } = await query;

    if (error) throw error;

    return {
      data: data || [],
      pagination: pagination
        ? {
            page: pagination.page,
            limit: pagination.limit,
            total: count || 0,
            totalPages: Math.ceil((count || 0) / pagination.limit),
            hasNextPage: pagination.page * pagination.limit < (count || 0),
            hasPreviousPage: pagination.page > 1,
          }
        : {
            page: 1,
            limit: data?.length || 0,
            total: data?.length || 0,
            totalPages: 1,
            hasNextPage: false,
            hasPreviousPage: false,
          },
    };
  }

  async blockConductor(params: BlockConductorParams): Promise<void> {
    const { data: user } = await supabase.auth.getUser();
    if (!user.user) throw new Error("Não autenticado");

    const { error } = await supabase.rpc("block_conductor", {
      conductor_id: params.conductorId,
      block_reason: `${params.reason}: ${params.details || ""}`,
      blocked_by: user.user.id,
      duration: params.duration,
    });

    if (error) throw error;
  }

  async unblockConductor(conductorId: string): Promise<void> {
    const { data: user } = await supabase.auth.getUser();
    if (!user.user) throw new Error("Não autenticado");

    const { error } = await supabase.rpc("unblock_conductor", {
      conductor_id: conductorId,
      unblocked_by: user.user.id,
    });

    if (error) throw error;
  }

  async expelConductor(params: ExpelConductorParams): Promise<void> {
    const { data: user } = await supabase.auth.getUser();
    if (!user.user) throw new Error("Não autenticado");

    const { error } = await supabase.rpc("expel_conductor", {
      conductor_id: params.conductorId,
      expulsion_reason: `${params.reason}: ${params.details}`,
      expelled_by: user.user.id,
    });

    if (error) throw error;
  }

  async assignVehicle(params: AssignVehicleParams): Promise<void> {
    const { data: user } = await supabase.auth.getUser();
    if (!user.user) throw new Error("Não autenticado");

    const { error } = await supabase.rpc("assign_vehicle", {
      conductor_id: params.conductorId,
      vehicle_id: params.vehicleId,
      assigned_by: user.user.id,
    });

    if (error) throw error;
  }

  async removeVehicleAssignment(conductorId: string): Promise<void> {
    // Remover condutor do veículo
    const { error: vehicleError } = await supabase
      .from("tuktuk_vehicles")
      .update({ current_conductor: null })
      .eq("current_conductor", conductorId);

    if (vehicleError) throw vehicleError;

    // Remover veículo do condutor
    const { error: conductorError } = await supabase
      .from("conductors")
      .update({ assigned_vehicle: null })
      .eq("id", conductorId);

    if (conductorError) throw conductorError;
  }

  // ==================== GESTÃO DE CANDIDATURAS ====================

  async getApplications(
    filters?: ApplicationFilters,
    pagination?: PaginationParams
  ): Promise<PaginatedResponse<ConductorApplication>> {
    let query = supabase.from("conductor_applications").select(`
        *,
        creator:created_by(
          id, full_name, email, admin_level
        )
      `);

    // Aplicar filtros
    if (filters?.status?.length) {
      query = query.in("status", filters.status);
    }
    if (filters?.region?.length) {
      query = query.in("region", filters.region);
    }
    if (filters?.createdBy?.length) {
      query = query.in("created_by", filters.createdBy);
    }
    if (filters?.dateRange) {
      query = query
        .gte("created_at", filters.dateRange.from)
        .lte("created_at", filters.dateRange.to);
    }

    // Aplicar paginação
    if (pagination) {
      const {
        page,
        limit,
        sortBy = "created_at",
        sortOrder = "desc",
      } = pagination;
      const offset = (page - 1) * limit;

      query = query
        .order(sortBy, { ascending: sortOrder === "asc" })
        .range(offset, offset + limit - 1);
    }

    const { data, error, count } = await query;

    if (error) throw error;

    return {
      data: data || [],
      pagination: pagination
        ? {
            page: pagination.page,
            limit: pagination.limit,
            total: count || 0,
            totalPages: Math.ceil((count || 0) / pagination.limit),
            hasNextPage: pagination.page * pagination.limit < (count || 0),
            hasPreviousPage: pagination.page > 1,
          }
        : {
            page: 1,
            limit: data?.length || 0,
            total: data?.length || 0,
            totalPages: 1,
            hasNextPage: false,
            hasPreviousPage: false,
          },
    };
  }

  async createApplication(
    params: CreateApplicationParams
  ): Promise<ConductorApplication> {
    const { data: user } = await supabase.auth.getUser();
    if (!user.user) throw new Error("Não autenticado");

    // Obter dados do admin
    const { data: profile } = await supabase
      .from("profiles")
      .select("admin_level")
      .eq("id", user.user.id)
      .single();

    if (!profile) throw new Error("Perfil de admin não encontrado");

    const { data, error } = await supabase
      .from("conductor_applications")
      .insert({
        region: params.region,
        zone: params.zone,
        assigned_coordinates: params.coordinates,
        admin_notes: params.adminNotes,
        created_by: user.user.id,
        admin_level: profile.admin_level,
        status: "link_created",
      })
      .select()
      .single();

    if (error) throw error;
    return data;
  }

  async getApplicationByToken(token: string): Promise<ConductorApplication> {
    const { data, error } = await supabase
      .from("conductor_applications")
      .select("*")
      .eq("registration_token", token)
      .single();

    if (error) throw error;
    return data;
  }

  async submitApplication(params: SubmitApplicationParams): Promise<void> {
    // Upload de documentos se fornecidos
    const documents: Record<string, string> = {};

    if (params.documents) {
      for (const [key, file] of Object.entries(params.documents)) {
        if (file) {
          const fileExt = file.name.split(".").pop();
          const fileName = `${Date.now()}-${key}.${fileExt}`;

          const { data: uploadData, error: uploadError } =
            await supabase.storage
              .from("conductor-documents")
              .upload(fileName, file);

          if (uploadError) throw uploadError;

          documents[key] = uploadData.path;
        }
      }
    }

    // Atualizar candidatura
    const { error } = await supabase
      .from("conductor_applications")
      .update({
        full_name: params.personalInfo.fullName,
        email: params.personalInfo.email,
        phone: params.personalInfo.phone,
        whatsapp: params.personalInfo.whatsapp,
        vehicle_info: params.vehicleInfo,
        license_number: params.licenseNumber,
        documents,
        status: "submitted",
        submitted_at: new Date().toISOString(),
      })
      .eq("registration_token", params.token);

    if (error) throw error;
  }

  async updateApplicationStatus(
    params: UpdateApplicationStatusParams
  ): Promise<void> {
    const { error } = await supabase
      .from("conductor_applications")
      .update({
        status: params.status,
        admin_notes: params.adminNotes,
        rejection_reason: params.rejectionReason,
        reviewed_at: new Date().toISOString(),
      })
      .eq("id", params.applicationId);

    if (error) throw error;
  }

  // ==================== SESSÕES DE TRABALHO ====================

  async getActiveSessions(region?: string): Promise<ConductorVehicleSession[]> {
    let query = supabase
      .from("conductor_vehicle_sessions")
      .select(
        `
        *,
        conductor:conductor_id(
          id, name, email, region
        ),
        vehicle:vehicle_id(
          id, vehicle_name, license_plate, region
        )
      `
      )
      .eq("is_active", true);

    if (region) {
      query = query.eq("conductor.region", region);
    }

    const { data, error } = await query;

    if (error) throw error;
    return data || [];
  }

  // ==================== DASHBOARD E ESTATÍSTICAS ====================

  async getRegionalDashboard(region?: string): Promise<RegionalDashboard> {
    // Se não especificar região e for super admin, usar estatísticas globais
    const { data: user } = await supabase.auth.getUser();
    const { data: profile } = await supabase
      .from("profiles")
      .select("admin_level, region")
      .eq("id", user.user?.id)
      .single();

    const targetRegion = region || profile?.region;

    // Estatísticas de veículos
    const { data: vehicleStats } = await supabase
      .from("tuktuk_vehicles")
      .select("maintenance_status, is_available, is_active")
      .eq(targetRegion ? "region" : "id", targetRegion || "all");

    // Estatísticas de condutores
    const { data: conductorStats } = await supabase
      .from("conductors")
      .select("status")
      .eq(targetRegion ? "region" : "id", targetRegion || "all");

    // Estatísticas de candidaturas
    const { data: applicationStats } = await supabase
      .from("conductor_applications")
      .select("status")
      .eq(targetRegion ? "region" : "id", targetRegion || "all");

    // Sessões ativas
    let sessionsQuery = supabase
      .from("conductor_vehicle_sessions")
      .select("id")
      .eq("is_active", true);

    if (targetRegion) {
      // Join com conductors para filtrar por região
      sessionsQuery = supabase
        .from("conductor_vehicle_sessions")
        .select("id, conductors!inner(region)")
        .eq("is_active", true)
        .eq("conductors.region", targetRegion);
    }

    const { data: sessionsData } = await sessionsQuery;
    const activeSessions = sessionsData?.length || 0;

    return {
      region: targetRegion || "global",
      fleetStats: {
        totalVehicles: vehicleStats?.length || 0,
        operationalVehicles:
          vehicleStats?.filter((v) => v.maintenance_status === "operational")
            .length || 0,
        maintenanceVehicles:
          vehicleStats?.filter((v) => v.maintenance_status === "maintenance")
            .length || 0,
        activeVehicles: vehicleStats?.filter((v) => v.is_active).length || 0,
        availableVehicles:
          vehicleStats?.filter((v) => v.is_available).length || 0,
      },
      conductorStats: {
        totalConductors: conductorStats?.length || 0,
        activeConductors:
          conductorStats?.filter((c) => c.status === "active").length || 0,
        blockedConductors:
          conductorStats?.filter((c) => c.status === "blocked").length || 0,
        expelledConductors:
          conductorStats?.filter((c) => c.status === "expelled").length || 0,
        inactiveConductors:
          conductorStats?.filter((c) => c.status === "inactive").length || 0,
      },
      applicationStats: {
        pendingApplications:
          applicationStats?.filter((a) => a.status === "link_created").length ||
          0,
        submittedApplications:
          applicationStats?.filter((a) => a.status === "submitted").length || 0,
        approvedApplications:
          applicationStats?.filter((a) => a.status === "approved").length || 0,
        rejectedApplications:
          applicationStats?.filter((a) => a.status === "rejected").length || 0,
        expiredApplications:
          applicationStats?.filter((a) => a.status === "expired").length || 0,
      },
      activeSessions,
      lastUpdated: new Date().toISOString(),
    };
  }
}

export const conductorManagementService = new ConductorManagementService();
