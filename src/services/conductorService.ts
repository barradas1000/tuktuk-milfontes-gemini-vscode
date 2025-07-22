import { supabase } from "../lib/supabase";

/**
 * Helper function para obter o ID do condutor baseado no user_id
 * @param userId O ID do usuário (profiles.id)
 * @returns O ID do condutor ou null se não encontrado
 */
async function getConductorIdByUserId(userId: string): Promise<string | null> {
  const { data: conductor, error } = await supabase
    .from("conductors")
    .select("id")
    .eq("user_id", userId)
    .single();

  if (error || !conductor) {
    return null;
  }
  return conductor.id;
}

/**
 * Obtém as reservas atribuídas a um condutor.
 * @param targetConductorId Opcional: O ID do condutor alvo. Se não fornecido, usa o condutor autenticado.
 * @returns Uma lista de reservas ou um erro.
 */
export async function getAssignedReservations(targetConductorId?: string) {
  try {
    let conductorToQueryId = targetConductorId;

    if (!conductorToQueryId) {
      const {
        data: { user },
      } = await supabase.auth.getUser();
      if (!user) {
        throw new Error("Utilizador não autenticado.");
      }

      // Nova relação: buscar condutor pelo user_id
      conductorToQueryId = await getConductorIdByUserId(user.id);
      if (!conductorToQueryId) {
        throw new Error("Perfil de condutor não encontrado ou não associado.");
      }
    }

    const { data: reservations, error: reservationsError } = await supabase
      .from("reservations")
      .select("*")
      .eq("assigned_conductor_id", conductorToQueryId);

    if (reservationsError) {
      throw new Error(`Erro ao obter reservas: ${reservationsError.message}`);
    }

    return reservations;
  } catch (error) {
    console.error("Erro em getAssignedReservations:", error);
    throw error;
  }
}

/**
 * Obtém o perfil de um condutor pelo seu ID.
 * @param conductorId O ID do condutor.
 * @returns O perfil do condutor ou null se não encontrado.
 */
export async function fetchConductorProfile(conductorId: string) {
  try {
    const { data: conductor, error } = await supabase
      .from("conductors")
      .select("*")
      .eq("id", conductorId)
      .single();

    if (error) {
      console.error(`Erro ao obter perfil do condutor ${conductorId}:`, error);
      throw error;
    }

    return conductor;
  } catch (error) {
    console.error("Erro em fetchConductorProfile:", error);
    throw error;
  }
}

/**
 * Obtém o status ativo atual de um condutor.
 * @param targetConductorId Opcional: O ID do condutor alvo. Se não fornecido, usa o condutor autenticado.
 * @returns O status ativo do condutor ou um erro.
 */
export async function getConductorActiveStatus(targetConductorId?: string) {
  try {
    let conductorToQueryId = targetConductorId;

    if (!conductorToQueryId) {
      const {
        data: { user },
      } = await supabase.auth.getUser();
      if (!user) throw new Error("Utilizador não autenticado.");

      // Nova relação: buscar condutor pelo user_id
      conductorToQueryId = await getConductorIdByUserId(user.id);
      if (!conductorToQueryId) {
        throw new Error("Perfil de condutor não encontrado ou não associado.");
      }
    }

    const { data: conductor, error } = await supabase
      .from("conductors")
      .select("is_active")
      .eq("id", conductorToQueryId)
      .single();

    if (error) {
      throw new Error(`Erro ao obter status do condutor: ${error.message}`);
    }

    return conductor.is_active;
  } catch (error) {
    console.error("Erro em getConductorActiveStatus:", error);
    throw error;
  }
}

/**
 * Atualiza o status ativo de um condutor.
 * @param isActive O novo status ativo (true para ativo, false para inativo).
 * @param targetConductorId Opcional: O ID do condutor alvo. Se não fornecido, usa o condutor autenticado.
 * @returns O status ativo atualizado ou um erro.
 */
export async function updateConductorActiveStatus(
  isActive: boolean,
  targetConductorId?: string
) {
  try {
    let conductorToUpdateId = targetConductorId;

    if (!conductorToUpdateId) {
      const {
        data: { user },
      } = await supabase.auth.getUser();
      if (!user) throw new Error("Utilizador não autenticado.");

      // Nova relação: buscar condutor pelo user_id
      conductorToUpdateId = await getConductorIdByUserId(user.id);
      if (!conductorToUpdateId) {
        throw new Error("Perfil de condutor não encontrado ou não associado.");
      }
    }

    const { data, error } = await supabase
      .from("conductors")
      .update({ is_active: isActive })
      .eq("id", conductorToUpdateId)
      .select()
      .single();

    if (error) {
      throw new Error(`Erro ao atualizar status do condutor: ${error.message}`);
    }

    return data;
  } catch (error) {
    console.error("Erro em updateConductorActiveStatus:", error);
    throw error;
  }
}

/**
 * Obtém todos os períodos bloqueados para um condutor.
 * @param targetConductorId Opcional: O ID do condutor alvo. Se não fornecido, usa o condutor autenticado.
 * @returns Uma lista de períodos bloqueados ou um erro.
 */
export async function getBlockedPeriods(targetConductorId?: string) {
  try {
    let conductorToQueryId = targetConductorId;
    let conductorName: string | null = null;

    if (!conductorToQueryId) {
      const {
        data: { user },
      } = await supabase.auth.getUser();
      if (!user) {
        throw new Error("Utilizador não autenticado.");
      }

      // Nova relação: buscar condutor pelo user_id
      conductorToQueryId = await getConductorIdByUserId(user.id);
      if (!conductorToQueryId) {
        throw new Error("Perfil de condutor não encontrado ou não associado.");
      }
    }

    const { data: conductor, error: conductorError } = await supabase
      .from("conductors")
      .select("name")
      .eq("id", conductorToQueryId)
      .single();

    if (conductorError || !conductor?.name) {
      throw new Error("Nome do condutor não encontrado.");
    }
    conductorName = conductor.name;

    const { data: blockedPeriods, error: blockedPeriodsError } = await supabase
      .from("blocked_periods")
      .select("*")
      .eq("created_by", conductorName);

    if (blockedPeriodsError) {
      throw new Error(
        `Erro ao obter períodos bloqueados: ${blockedPeriodsError.message}`
      );
    }

    return blockedPeriods;
  } catch (error) {
    console.error("Erro em getBlockedPeriods:", error);
    throw error;
  }
}

/**
 * Adiciona um novo período bloqueado para um condutor.
 * @param date A data do bloqueio (formato yyyy-MM-dd).
 * @param startTime Opcional: hora de início (formato HH:mm).
 * @param endTime Opcional: hora de fim (formato HH:mm).
 * @param reason Opcional: motivo do bloqueio.
 * @param targetConductorId Opcional: O ID do condutor alvo. Se não fornecido, usa o condutor autenticado.
 * @returns O novo período bloqueado ou um erro.
 */
export async function addBlockedPeriod(
  date: string,
  startTime?: string,
  endTime?: string,
  reason?: string,
  targetConductorId?: string
) {
  try {
    let conductorToQueryId = targetConductorId;
    let conductorName: string | null = null;

    if (!conductorToQueryId) {
      const {
        data: { user },
      } = await supabase.auth.getUser();
      if (!user) {
        throw new Error("Utilizador não autenticado.");
      }

      // Nova relação: buscar condutor pelo user_id
      conductorToQueryId = await getConductorIdByUserId(user.id);
      if (!conductorToQueryId) {
        throw new Error("Perfil de condutor não encontrado ou não associado.");
      }
    }

    const { data: conductor, error: conductorError } = await supabase
      .from("conductors")
      .select("name")
      .eq("id", conductorToQueryId)
      .single();

    if (conductorError || !conductor?.name) {
      throw new Error("Nome do condutor não encontrado.");
    }
    conductorName = conductor.name;

    const { data, error } = await supabase
      .from("blocked_periods")
      .insert({
        date,
        start_time: startTime || null,
        end_time: endTime || null,
        reason: reason || null,
        created_by: conductorName,
      })
      .select();

    if (error) {
      throw new Error(`Erro ao adicionar período bloqueado: ${error.message}`);
    }

    return data?.[0];
  } catch (error) {
    console.error("Erro em addBlockedPeriod:", error);
    throw error;
  }
}

/**
 * Exclui um período bloqueado específico para um condutor.
 * @param blockedPeriodId O ID do período bloqueado a ser excluído.
 * @param targetConductorId Opcional: O ID do condutor alvo. Se não fornecido, usa o condutor autenticado.
 * @returns O período bloqueado excluído ou um erro.
 */
export async function deleteBlockedPeriod(
  blockedPeriodId: string,
  targetConductorId?: string
) {
  try {
    let conductorToQueryId = targetConductorId;
    let conductorName: string | null = null;

    if (!conductorToQueryId) {
      const {
        data: { user },
      } = await supabase.auth.getUser();
      if (!user) {
        throw new Error("Utilizador não autenticado.");
      }

      // Nova relação: buscar condutor pelo user_id
      conductorToQueryId = await getConductorIdByUserId(user.id);
      if (!conductorToQueryId) {
        throw new Error("Perfil de condutor não encontrado ou não associado.");
      }
    }

    const { data: conductor, error: conductorError } = await supabase
      .from("conductors")
      .select("name")
      .eq("id", conductorToQueryId)
      .single();

    if (conductorError || !conductor?.name) {
      throw new Error("Nome do condutor não encontrado.");
    }
    conductorName = conductor.name;

    const { data, error } = await supabase
      .from("blocked_periods")
      .delete()
      .eq("id", blockedPeriodId)
      .eq("created_by", conductorName)
      .select();

    if (error) {
      throw new Error(`Erro ao excluir período bloqueado: ${error.message}`);
    }

    if (!data || data.length === 0) {
      throw new Error(
        "Período bloqueado não encontrado ou não autorizado para exclusão."
      );
    }

    return data[0];
  } catch (error) {
    console.error("Erro em deleteBlockedPeriod:", error);
    throw error;
  }
}
