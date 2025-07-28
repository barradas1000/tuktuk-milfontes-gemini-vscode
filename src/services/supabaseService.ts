import { supabase } from "@/lib/supabase";
import { AdminReservation, BlockedPeriod } from "@/types/adminReservations";
import { SupabaseClient } from "@supabase/supabase-js";

// Definir um tipo básico para o cliente Supabase
// eslint-disable-next-line @typescript-eslint/no-explicit-any
type TypedSupabaseClient = SupabaseClient<any, "public", any>;

export const checkSupabaseConfiguration = (): boolean => {
  const url = import.meta.env.VITE_SUPABASE_URL;
  const anonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

  if (!url || !anonKey) {
    console.log("Supabase not configured, using mock data");
    return false;
  }
  return true;
};

export const fetchReservationsFromSupabase = async (): Promise<
  AdminReservation[]
> => {
  console.log("Fetching reservations from Supabase...");

  try {
    const { data, error } = await (supabase as TypedSupabaseClient)
      .from("reservations")
      .select("*")
      .order("created_at", { ascending: false });

    if (error) {
      console.error("Supabase error:", error);
      return [];
    }

    console.log("Reservations loaded from Supabase:", data?.length || 0);
    return data || [];
  } catch (error) {
    console.error("Error fetching reservations:", error);
    return [];
  }
};

export const updateReservationInSupabase = async (
  id: string,
  status: string
) => {
  console.log("Updating reservation in Supabase:", { id, status });

  try {
    const { data, error } = await (supabase as TypedSupabaseClient)
      .from("reservations")
      .update({ status, updated_at: new Date().toISOString() })
      .eq("id", id)
      .select();

    if (error) {
      console.error("Error updating reservation:", error);
      throw error;
    }

    return data?.[0];
  } catch (error) {
    console.error("Error updating reservation:", error);
    throw error;
  }
};

export const updateManualPaymentInSupabase = async (
  id: string,
  manualPayment: number
) => {
  console.log("Updating manual payment in Supabase:", { id, manualPayment });

  try {
    const { data, error } = await (supabase as TypedSupabaseClient)
      .from("reservations")
      .update({
        manual_payment: manualPayment,
        updated_at: new Date().toISOString(),
      })
      .eq("id", id)
      .select();

    if (error) {
      console.error("Error updating manual payment:", error);
      throw error;
    }

    return data?.[0];
  } catch (error) {
    console.error("Error updating manual payment:", error);
    throw error;
  }
};

// --- Funções simplificadas para condutores ---
export const fetchActiveConductors = async () => {
  try {
    const { data, error } = await (supabase as TypedSupabaseClient)
      .from("conductors")
      .select("id, name, latitude, longitude, is_active")
      .eq("is_active", true);

    if (error) {
      console.error("Error fetching active conductors:", error);
      return [];
    }

    return data || [];
  } catch (error) {
    console.error("Error fetching active conductors:", error);
    return [];
  }
};

export const fetchConductors = async () => {
  try {
    const { data, error } = await (supabase as TypedSupabaseClient)
      .from("conductors")
      .select("*")
      .order("name");

    if (error) {
      console.error("Error fetching conductors:", error);
      return [];
    }

    return data || [];
  } catch (error) {
    console.error("Error fetching conductors:", error);
    return [];
  }
};

// --- Novas funções para bloqueios ---
export const fetchBlockedPeriods = async (): Promise<BlockedPeriod[]> => {
  try {
    const { data, error } = await (supabase as TypedSupabaseClient)
      .from("blocked_periods")
      .select("*")
      .order("created_at", { ascending: false });

    if (error) {
      console.error("Error fetching blocked periods:", error);
      return [];
    }

    // Mapear os campos do banco para a interface TypeScript
    return (data || []).map(
      (item: {
        id: string;
        date: string;
        start_time: string | null;
        end_time: string | null;
        reason: string;
        created_by: string;
        created_at: string;
      }) => ({
        id: item.id,
        date: item.date,
        startTime: item.start_time,
        endTime: item.end_time,
        reason: item.reason,
        createdBy: item.created_by,
        createdAt: item.created_at, // <-- incluir campo de data de criação
      })
    );
  } catch (error) {
    console.error("Error fetching blocked periods:", error);
    throw error;
  }
};

export const createBlockedPeriod = async (
  blockedPeriod: Omit<BlockedPeriod, "id"> & { createdAt?: string }
): Promise<BlockedPeriod> => {
  try {
    // Mapear os campos da interface para o banco de dados
    const dbBlockedPeriod = {
      date: blockedPeriod.date,
      start_time: blockedPeriod.startTime,
      end_time: blockedPeriod.endTime,
      reason: blockedPeriod.reason,
      created_by: blockedPeriod.createdBy,
      created_at: blockedPeriod.createdAt, // <-- incluir campo de data de criação se fornecido
    };

    const { data, error } = await (supabase as TypedSupabaseClient)
      .from("blocked_periods")
      .insert(dbBlockedPeriod)
      .select()
      .single();

    if (error) {
      console.error("Error creating blocked period:", error);
      throw error;
    }

    // Mapear de volta para a interface TypeScript
    return {
      id: data.id,
      date: data.date,
      startTime: data.start_time,
      endTime: data.end_time,
      reason: data.reason,
      createdBy: data.created_by,
      createdAt: data.created_at, // <-- incluir campo de data de criação
    };
  } catch (error) {
    console.error("Error creating blocked period:", error);
    throw error;
  }
};

export const deleteBlockedPeriod = async (id: string): Promise<void> => {
  try {
    const { error } = await (supabase as TypedSupabaseClient)
      .from("blocked_periods")
      .delete()
      .eq("id", id);

    if (error) {
      console.error("Error deleting blocked period:", error);
      throw error;
    }
  } catch (error) {
    console.error("Error deleting blocked period:", error);
    throw error;
  }
};

export const deleteBlockedPeriodsByDate = async (
  date: string,
  startTime?: string,
  onlyTimeBlocks?: boolean
): Promise<void> => {
  try {
    console.log(
      `Deletando bloqueios para data: ${date}, horário: ${
        startTime || "N/A"
      }, onlyTimeBlocks: ${!!onlyTimeBlocks}`
    );

    let query = (supabase as TypedSupabaseClient)
      .from("blocked_periods")
      .delete()
      .eq("date", date);

    if (onlyTimeBlocks) {
      // Apaga todos os bloqueios de hora para a data
      query = query.not("start_time", "is", null);
    } else if (startTime) {
      // Apaga um bloqueio de hora específico
      query = query.eq("start_time", startTime);
    } else {
      // Apaga um bloqueio de dia inteiro (comportamento original)
      query = query.is("start_time", null);
    }

    const { error, count } = await query;

    if (error) {
      console.error("Error deleting blocked periods by date:", error);
      throw error;
    }

    console.log(`${count} bloqueios deletados com sucesso.`);
  } catch (error) {
    console.error("Error deleting blocked periods by date:", error);
    throw error;
  }
};

export const deleteBlockedPeriodByReservationId = async (
  reservationId: string
): Promise<void> => {
  try {
    console.log(`Deletando bloqueio para a reserva ID: ${reservationId}`);

    const { error, count } = await (supabase as TypedSupabaseClient)
      .from("blocked_periods")
      .delete()
      .like("reason", `%ID: ${reservationId})`);

    if (error) {
      console.error(
        `Erro ao deletar bloqueio para a reserva ${reservationId}:`,
        error
      );
      throw error;
    }

    if (count && count > 0) {
      console.log(
        `Bloqueio associado à reserva ${reservationId} deletado com sucesso.`
      );
    } else {
      console.log(
        `Nenhum bloqueio encontrado para a reserva ${reservationId}. Nenhuma ação foi tomada.`
      );
    }
  } catch (error) {
    console.error(
      `Erro na função deleteBlockedPeriodByReservationId para a reserva ${reservationId}:`,
      error
    );
    throw error;
  }
};

export const cleanDuplicateBlockedPeriods = async (): Promise<number> => {
  try {
    console.log("Iniciando limpeza de bloqueios duplicados...");

    // Buscar todos os bloqueios
    const { data: allBlockedPeriods, error: fetchError } = await (
      supabase as TypedSupabaseClient
    )
      .from("blocked_periods")
      .select("*")
      .order("created_at", { ascending: false });

    if (fetchError) {
      console.error("Error fetching blocked periods for cleanup:", fetchError);
      throw fetchError;
    }

    if (!allBlockedPeriods || allBlockedPeriods.length === 0) {
      console.log("Nenhum bloqueio encontrado para limpeza");
      return 0;
    }

    // Agrupar por data e horário
    const groupedByDateAndTime: { [key: string]: BlockedPeriod[] } = {};

    allBlockedPeriods.forEach((period: BlockedPeriod) => {
      const key = `${period.date}_${period.startTime}`;
      if (!groupedByDateAndTime[key]) {
        groupedByDateAndTime[key] = [];
      }
      groupedByDateAndTime[key].push(period);
    });

    // Identificar duplicados (mais de 1 bloqueio para mesma data/horário)
    const duplicatesToRemove: string[] = [];

    Object.values(groupedByDateAndTime).forEach((periods: BlockedPeriod[]) => {
      if (periods.length > 1) {
        // Manter o mais recente (primeiro da lista, já ordenado por created_at desc)
        const toRemove = periods.slice(1); // Remove todos exceto o primeiro
        toRemove.forEach((period: BlockedPeriod) => {
          duplicatesToRemove.push(period.id);
        });
      }
    });

    if (duplicatesToRemove.length === 0) {
      console.log("Nenhum bloqueio duplicado encontrado");
      return 0;
    }

    console.log(
      `Encontrados ${duplicatesToRemove.length} bloqueios duplicados para remoção`
    );

    // Remover duplicados
    const { error: deleteError, count } = await (
      supabase as TypedSupabaseClient
    )
      .from("blocked_periods")
      .delete()
      .in("id", duplicatesToRemove);

    if (deleteError) {
      console.error("Error deleting duplicate blocked periods:", deleteError);
      throw deleteError;
    }

    console.log(`Limpeza concluída: ${count} bloqueados duplicados removidos`);
    return count || 0;
  } catch (error) {
    console.error("Error cleaning duplicate blocked periods:", error);
    throw error;
  }
};

// --- Funções de rastreamento simplificadas ---
export const getDriverTrackingStatus = async (
  conductorId: string
): Promise<boolean> => {
  try {
    const { data, error } = await (supabase as TypedSupabaseClient)
      .from("conductors")
      .select("is_active")
      .eq("id", conductorId)
      .single();

    if (error && error.code !== "PGRST116") {
      console.error("Error fetching conductor tracking status:", error);
      return false;
    }

    return data?.is_active || false;
  } catch (error) {
    console.error("Error fetching conductor tracking status:", error);
    return false;
  }
};

export const updateDriverTrackingStatus = async (
  conductorId: string,
  isTrackingActive: boolean
): Promise<void> => {
  console.log(
    `📡 Atualizando status do condutor ${conductorId} para ${
      isTrackingActive ? "ATIVO" : "INATIVO"
    }`
  );

  if (!conductorId || conductorId.trim() === "") {
    throw new Error("ID do condutor é obrigatório");
  }

  const { data, error } = await (supabase as TypedSupabaseClient)
    .from("conductors")
    .update({ is_active: isTrackingActive })
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

export const updateConductorLocation = async (
  conductorId: string,
  latitude: number,
  longitude: number
): Promise<void> => {
  // Atualizar localização atual na tabela conductors
  const { error: locationError } = await (supabase as TypedSupabaseClient)
    .from("conductors")
    .update({ latitude, longitude })
    .eq("id", conductorId);

  if (locationError) {
    console.error("Erro ao atualizar localização:", locationError);
    throw locationError;
  }

  // Salvar no histórico (opcional)
  const { error: historyError } = await (supabase as TypedSupabaseClient)
    .from("conductor_locations")
    .insert({
      conductor_id: conductorId,
      latitude,
      longitude,
      accuracy: 0,
    });

  if (historyError) {
    console.warn(
      "Aviso: Erro ao salvar histórico de localização:",
      historyError
    );
    // Não fazemos throw aqui porque o histórico é opcional
  }
};

export const testSupabaseConnection = async () => {
  try {
    const { data, error } = await supabase.from('profiles').select('*').limit(1);
    if (error) {
      console.error('Erro ao conectar ao Supabase:', error);
    } else {
      console.log('Conexão com Supabase bem-sucedida:', data);
    }
  } catch (err) {
    console.error('Erro inesperado ao conectar ao Supabase:', err);
  }
};
