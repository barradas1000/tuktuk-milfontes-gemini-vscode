import memoize from 'memoize-one';
import { AdminReservation, ReservationStatistics } from "@/types/adminReservations";
import { format } from "date-fns";
import { pt } from "date-fns/locale";

export type SlotStatus =
  | "available"
  | "blocked_by_admin"
  | "blocked_by_reservation"
  | "blocked_by_unconfirmed_reservation"
  | "unavailable";

export interface AvailabilitySlot {
  date: string;
  time: string;
  status: SlotStatus;
  capacity: number;
  reserved: number;
  reason?: string;
}

// Memoizada para evitar refiltragem desnecessária
export const getReservationsByDate = memoize(
  (reservations: AdminReservation[], date: string): AdminReservation[] => {
    const result = reservations?.filter((r) => r.reservation_date === date) || [];
    console.log(`Reservations for ${date}:`, result.length); // Mantido para depuração
    return result;
  }
);

// Memoizada para evitar regerar horários iguais
export const generateDynamicTimeSlots = memoize(
  (startHour = 8, endHour = 23, intervalMinutes = 30): string[] => {
    const slots: string[] = [];
    for (let hour = startHour; hour <= endHour; hour++) {
      for (let min = 0; min < 60; min += intervalMinutes) {
        const h = hour.toString().padStart(2, "0");
        const m = min.toString().padStart(2, "0");
        slots.push(`${h}:${m}`);
      }
    }
    return slots;
  }
);

// Memoizada para evitar recalcular disponibilidade
export const getAvailabilityForDate = memoize(
  (reservations: AdminReservation[], date: string): AvailabilitySlot[] => {
    console.log("Getting availability for date:", date); // Mantido para depuração
    const timeSlots = generateDynamicTimeSlots();
    const dateReservations = getReservationsByDate(reservations, date);

    return timeSlots.map((time) => {
      const slotReservations = dateReservations.filter(
        (r) => r.reservation_time === time && r.status !== "cancelled"
      );
      const reserved = slotReservations.reduce(
        (sum, r) => sum + r.number_of_people,
        0
      );

      return {
        date,
        time,
        status: reserved < 4 ? "available" : "unavailable",
        capacity: 4,
        reserved,
      };
    });
  }
);

// Memoizada para otimizar cálculo com bloqueios
export const getAvailabilityWithBlocks = memoize(
  (
    reservations: AdminReservation[],
    blockedPeriods: { date: string; startTime?: string; reason?: string }[],
    date: string
  ): AvailabilitySlot[] => {
    const timeSlots = generateDynamicTimeSlots();
    const dateReservations = getReservationsByDate(reservations, date);

    return timeSlots.map((time) => {
      const slotReservations = dateReservations.filter(
        (r) => r.reservation_time === time && r.status !== "cancelled"
      );
      const reserved = slotReservations.reduce(
        (sum, r) => sum + r.number_of_people,
        0
      );

      // Bloqueio por reserva confirmada
      const hasConfirmedReservation = dateReservations.some(
        (r) => r.reservation_time === time && r.status === "confirmed"
      );
      if (hasConfirmedReservation) {
        return {
          date,
          time,
          status: "blocked_by_reservation",
          capacity: 4,
          reserved,
          reason: "Reserva confirmada",
        };
      }

      // Bloqueio manual do admin
      const adminBlock = blockedPeriods.find(
        (b) => b.date === date && b.startTime === time
      );
      if (adminBlock) {
        return {
          date,
          time,
          status: "blocked_by_admin",
          capacity: 4,
          reserved,
          reason: adminBlock.reason,
        };
      }

      // Bloqueio por reserva pendente
      const hasUnconfirmedReservation = dateReservations.some(
        (r) => r.reservation_time === time && r.status === "pending"
      );
      if (hasUnconfirmedReservation) {
        return {
          date,
          time,
          status: "blocked_by_unconfirmed_reservation",
          capacity: 4,
          reserved,
          reason: "Reserva pendente de confirmação",
        };
      }

      // Disponível ou indisponível por lotação
      if (reserved < 4) {
        return {
          date,
          time,
          status: "available",
          capacity: 4,
          reserved,
        };
      } else {
        return {
          date,
          time,
          status: "unavailable",
          capacity: 4,
          reserved,
        };
      }
    });
  }
);

// Memoizada para evitar recalcular estatísticas
export const calculateStatistics = memoize(
  (reservations: AdminReservation[]): ReservationStatistics | null => {
    console.log("Calculating statistics..."); // Mantido para depuração
    if (!reservations) {
      console.log("No reservations data for statistics");
      return null;
    }

    const today = new Date().toISOString().split("T")[0];
    const thisMonth = new Date().toISOString().slice(0, 7);

    const stats = {
      totalReservations: reservations.length,
      pendingReservations: reservations.filter((r) => r.status === "pending").length,
      confirmedReservations: reservations.filter((r) => r.status === "confirmed").length,
      todayReservations: reservations.filter((r) => r.reservation_date === today).length,
      monthlyReservations: reservations.filter((r) =>
        r.reservation_date.startsWith(thisMonth)
      ).length,
      totalRevenue: reservations
        .filter((r) => r.status === "confirmed" || r.status === "completed")
        .reduce(
          (sum, r) =>
            sum +
            (typeof r.manual_payment === "number" ? r.manual_payment : r.total_price),
          0
        ),
    };

    console.log("Statistics calculated:", stats); // Mantido para depuração
    return stats;
  }
);
