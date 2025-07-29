import { supabase } from "@/lib/supabase";

// Tipos para o sistema de permissões
export type AdminLevel = "super_admin" | "admin_regional" | "admin_local";

export interface AdminProfile {
  id: string;
  email: string;
  full_name: string;
  role: string;
  admin_level: AdminLevel;
  region?: string;
  permissions: Record<string, boolean>;
  created_at: string;
  updated_at: string;
}

export interface ConductorAudit {
  id: string;
  conductor_id: string;
  changed_by: string;
  previous_status: boolean;
  new_status: boolean;
  reason?: string;
  region: string;
  admin_level: AdminLevel;
  created_at: string;
  metadata: Record<string, unknown>;
}

/**
 * Verifica se o usuário atual tem permissão para gerenciar um condutor específico
 */
export const checkConductorPermission = async (
  conductorId: string
): Promise<boolean> => {
  try {
    const { data, error } = await supabase.rpc("check_admin_permissions", {
      target_conductor_id: conductorId,
      admin_user_id: (await supabase.auth.getUser()).data.user?.id,
    });

    if (error) {
      console.error("Erro ao verificar permissões:", error);
      return false;
    }

    return data;
  } catch (error) {
    console.error("Erro ao verificar permissões:", error);
    return false;
  }
};

/**
 * Atualiza o status de um condutor com verificação de permissões e auditoria
 */
export const updateDriverTrackingStatusWithPermissions = async (
  conductorId: string,
  isTrackingActive: boolean,
  reason?: string
): Promise<void> => {
  console.log(
    `📡 Atualizando status do condutor ${conductorId} para ${
      isTrackingActive ? "ATIVO" : "INATIVO"
    }`
  );

  if (!conductorId || conductorId.trim() === "") {
    throw new Error("ID do condutor é obrigatório");
  }

  // Verificar permissões primeiro
  const hasPermission = await checkConductorPermission(conductorId);
  if (!hasPermission) {
    throw new Error("Você não tem permissão para alterar este condutor");
  }

  const { data, error } = await supabase
    .from("conductors")
    .update({
      is_active: isTrackingActive,
      updated_at: new Date().toISOString(),
    })
    .eq("id", conductorId)
    .select();

  if (error) {
    console.error("❌ Erro do Supabase:", error);
    throw new Error(`Erro do Supabase: ${error.message}`);
  }

  if (!data || data.length === 0) {
    throw new Error(`Condutor não encontrado (ID: ${conductorId})`);
  }

  console.log(
    `✅ Status atualizado com sucesso para ${
      isTrackingActive ? "ATIVO" : "INATIVO"
    }`
  );
};

/**
 * Busca o perfil de admin do usuário atual
 */
export const getCurrentAdminProfile =
  async (): Promise<AdminProfile | null> => {
    try {
      const {
        data: { user },
      } = await supabase.auth.getUser();
      if (!user) return null;

      const { data, error } = await supabase
        .from("profiles")
        .select("*")
        .eq("id", user.id)
        .eq("role", "admin")
        .single();

      if (error) {
        console.error("Erro ao buscar perfil admin:", error);
        return null;
      }

      console.log("[DEBUG] Perfil retornado pelo Supabase:", data);
      return data;
    } catch (error) {
      console.error("Erro ao buscar perfil admin:", error);
      return null;
    }
  };

/**
 * Busca condutores baseado nas permissões do admin
 */
export const fetchConductorsWithPermissions = async () => {
  try {
    const adminProfile = await getCurrentAdminProfile();
    if (!adminProfile) {
      throw new Error("Perfil de admin não encontrado");
    }

    let query = supabase.from("conductors").select("*").order("name");

    // Aplicar filtros baseados no nível de admin
    if (adminProfile.admin_level !== "super_admin" && adminProfile.region) {
      query = query.eq("region", adminProfile.region);
    }

    const { data, error } = await query;

    if (error) {
      console.error("Erro ao buscar condutores:", error);
      throw error;
    }

    return data || [];
  } catch (error) {
    console.error("Erro ao buscar condutores:", error);
    throw error;
  }
};

/**
 * Busca logs de auditoria de mudanças de status
 */
export const fetchConductorAuditLogs = async (
  conductorId?: string
): Promise<ConductorAudit[]> => {
  try {
    let query = supabase
      .from("conductor_status_audit")
      .select(
        `
        *,
        conductor:conductors(name),
        admin:profiles!changed_by(full_name, email)
      `
      )
      .order("created_at", { ascending: false });

    if (conductorId) {
      query = query.eq("conductor_id", conductorId);
    }

    const { data, error } = await query;

    if (error) {
      console.error("Erro ao buscar logs de auditoria:", error);
      throw error;
    }

    return data || [];
  } catch (error) {
    console.error("Erro ao buscar logs de auditoria:", error);
    return [];
  }
};

/**
 * Verifica se o admin atual pode criar outros admins
 */
export const canCreateAdmins = async (): Promise<boolean> => {
  try {
    const adminProfile = await getCurrentAdminProfile();
    return (
      adminProfile?.admin_level === "super_admin" ||
      adminProfile?.permissions?.can_create_admins === true
    );
  } catch (error) {
    console.error("Erro ao verificar permissão de criação:", error);
    return false;
  }
};

/**
 * Cria um novo admin com permissões específicas
 */
export const createAdminUser = async (
  email: string,
  fullName: string,
  adminLevel: AdminLevel,
  region?: string,
  permissions?: Record<string, boolean>
): Promise<void> => {
  try {
    const canCreate = await canCreateAdmins();
    if (!canCreate) {
      throw new Error(
        "Você não tem permissão para criar novos administradores"
      );
    }

    // Criar usuário via Supabase Auth (isso normalmente seria feito via Admin API)
    // Por enquanto, apenas criamos o perfil assumindo que o usuário já existe
    const { data, error } = await supabase.from("profiles").upsert({
      email,
      full_name: fullName,
      role: "admin",
      admin_level: adminLevel,
      region,
      permissions: permissions || {},
      created_by: (await supabase.auth.getUser()).data.user?.id,
      updated_at: new Date().toISOString(),
    });

    if (error) {
      console.error("Erro ao criar admin:", error);
      throw error;
    }

    console.log("✅ Admin criado com sucesso");
  } catch (error) {
    console.error("Erro ao criar admin:", error);
    throw error;
  }
};

/**
 * Lista todos os admins (apenas para super admins)
 */
export const fetchAllAdmins = async (): Promise<AdminProfile[]> => {
  try {
    const adminProfile = await getCurrentAdminProfile();
    if (adminProfile?.admin_level !== "super_admin") {
      throw new Error(
        "Apenas super admins podem listar todos os administradores"
      );
    }

    const { data, error } = await supabase
      .from("profiles")
      .select("*")
      .eq("role", "admin")
      .order("created_at", { ascending: false });

    if (error) {
      console.error("Erro ao buscar admins:", error);
      throw error;
    }

    return data || [];
  } catch (error) {
    console.error("Erro ao buscar admins:", error);
    return [];
  }
};

/**
 * Verifica permissões para múltiplos condutores de uma vez (otimização)
 */
export const checkMultipleConductorPermissions = async (
  conductorIds: string[]
): Promise<Record<string, boolean>> => {
  try {
    const {
      data: { user },
    } = await supabase.auth.getUser();
    if (!user) return {};

    const adminProfile = await getCurrentAdminProfile();
    if (!adminProfile) return {};

    // Super admin pode tudo
    if (adminProfile.admin_level === "super_admin") {
      return conductorIds.reduce((acc, id) => ({ ...acc, [id]: true }), {});
    }

    // Para outros admins, verificar região
    const { data: conductors, error } = await supabase
      .from("conductors")
      .select("id, region")
      .in("id", conductorIds);

    if (error) {
      console.error("Erro ao verificar permissões em lote:", error);
      return {};
    }

    const permissions: Record<string, boolean> = {};
    conductors?.forEach((conductor) => {
      permissions[conductor.id] = conductor.region === adminProfile.region;
    });

    return permissions;
  } catch (error) {
    console.error("Erro ao verificar permissões em lote:", error);
    return {};
  }
};
