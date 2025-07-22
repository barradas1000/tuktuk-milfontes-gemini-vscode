import { supabase } from "../lib/supabase";

/**
 * Atribui o papel de 'condutor' a um utilizador e associa-o a um condutor existente.
 * Esta função deve ser utilizada apenas por administradores.
 * @param userId O ID do utilizador (do auth.users e public.profiles).
 * @param conductorId O ID do condutor existente na tabela public.conductors.
 * @returns O perfil atualizado do utilizador ou um erro.
 */
export async function assignConductorRole(userId: string, conductorId: string) {
  try {
    // Nova estrutura: atualizar o campo user_id na tabela conductors
    const { data: conductorData, error: conductorError } = await supabase
      .from("conductors")
      .update({ user_id: userId })
      .eq("id", conductorId)
      .select();

    if (conductorError) {
      throw new Error(
        `Erro ao associar utilizador ao condutor: ${conductorError.message}`
      );
    }

    // Atualizar o role do utilizador para 'condutor'
    const { data: profileData, error: profileError } = await supabase
      .from("profiles")
      .update({ role: "condutor" })
      .eq("id", userId)
      .select();

    if (profileError) {
      throw new Error(
        `Erro ao atribuir papel de condutor: ${profileError.message}`
      );
    }

    if (!profileData || profileData.length === 0) {
      throw new Error(
        "Nenhum perfil encontrado para o ID do utilizador fornecido."
      );
    }

    return profileData[0];
  } catch (error) {
    console.error("Erro em assignConductorRole:", error);
    throw error;
  }
}

/**
 * Remove o papel de 'condutor' de um utilizador e desassocia-o de qualquer condutor.
 * Esta função deve ser utilizada apenas por administradores.
 * @param userId O ID do utilizador (do auth.users e public.profiles).
 * @returns O perfil atualizado do utilizador ou um erro.
 */
export async function removeConductorRole(userId: string) {
  try {
    // Nova estrutura: remover a associação user_id da tabela conductors
    const { error: conductorError } = await supabase
      .from("conductors")
      .update({ user_id: null })
      .eq("user_id", userId);

    if (conductorError) {
      throw new Error(
        `Erro ao desassociar utilizador do condutor: ${conductorError.message}`
      );
    }

    // Atualizar o role do utilizador de volta para 'user'
    const { data, error } = await supabase
      .from("profiles")
      .update({ role: "user" })
      .eq("id", userId)
      .select();

    if (error) {
      throw new Error(`Erro ao remover papel de condutor: ${error.message}`);
    }

    if (!data || data.length === 0) {
      throw new Error(
        "Nenhum perfil encontrado para o ID do utilizador fornecido."
      );
    }

    return data[0];
  } catch (error) {
    console.error("Erro em removeConductorRole:", error);
    throw error;
  }
}

/**
 * Atribui um condutor a uma reserva específica.
 * Esta função deve ser utilizada apenas por administradores.
 * @param reservationId O ID da reserva a ser atualizada.
 * @param conductorId O ID do condutor a ser atribuído à reserva.
 * @returns A reserva atualizada ou um erro.
 */
export async function assignConductorToReservation(
  reservationId: string,
  conductorId: string
) {
  try {
    const { data, error } = await supabase
      .from("reservations")
      .update({ assigned_conductor_id: conductorId })
      .eq("id", reservationId)
      .select();

    if (error) {
      throw new Error(`Erro ao atribuir condutor à reserva: ${error.message}`);
    }

    if (!data || data.length === 0) {
      throw new Error("Nenhuma reserva encontrada para o ID fornecido.");
    }

    return data[0];
  } catch (error) {
    console.error("Erro em assignConductorToReservation:", error);
    throw error;
  }
}

/**
 * Obtém todos os condutores.
 * Esta função deve ser utilizada apenas por administradores.
 * @returns Uma lista de condutores ou um erro.
 */
export async function getAllConductors() {
  try {
    const { data: conductors, error } = await supabase
      .from("conductors")
      .select("*");

    if (error) {
      throw new Error(`Erro ao obter condutores: ${error.message}`);
    }

    return conductors;
  } catch (error) {
    console.error("Erro em getAllConductors:", error);
    throw error;
  }
}

/**
 * Obtém todos os perfis de utilizadores.
 * Esta função deve ser utilizada apenas por administradores.
 * @returns Uma lista de perfis de utilizadores ou um erro.
 */
export async function getAllProfiles() {
  try {
    const { data: profiles, error } = await supabase
      .from("profiles")
      .select("*");

    if (error) {
      throw new Error(`Erro ao obter perfis: ${error.message}`);
    }

    return profiles;
  } catch (error) {
    console.error("Erro em getAllProfiles:", error);
    throw error;
  }
}

/**
 * Obtém todas as reservas.
 * Esta função deve ser utilizada apenas por administradores.
 * @returns Uma lista de reservas ou um erro.
 */
export async function getAllReservations() {
  try {
    const { data: reservations, error } = await supabase
      .from("reservations")
      .select("*");

    if (error) {
      throw new Error(`Erro ao obter reservas: ${error.message}`);
    }

    return reservations;
  } catch (error) {
    console.error("Erro em getAllReservations:", error);
    throw error;
  }
}
