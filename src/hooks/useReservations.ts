import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { supabase } from "@/lib/supabase";
import { useToast } from "@/hooks/use-toast";
import { useCallback } from "react"; // Importação explícita do useCallback

export interface Reservation {
  id?: string;
  customer_name: string;
  customer_email: string;
  customer_phone: string;
  reservation_date: string;
  reservation_time: string;
  number_of_people: number;
  tour_type: string;
  special_requests?: string;
  status?: string;
  total_price: number;
  language?: string;
}

export interface AvailableSlot {
  time: string;
  available: boolean;
  capacity: number;
  reserved: number;
}

export interface TourType {
  id: string;
  name: string;
  base_price: number;
  duration_minutes: number;
}

const DEFAULT_TOUR_TYPES: TourType[] = [
  {
    id: "1",
    name: "Passeio panorâmico pela vila",
    base_price: 10,
    duration_minutes: 60,
  },
  {
    id: "2",
    name: "Vila Nova de Milfontes → Praia das Furnas",
    base_price: 14,
    duration_minutes: 90,
  },
  {
    id: "3",
    name: "Travessia pela ponte",
    base_price: 10,
    duration_minutes: 45,
  },
];

export const useReservations = () => {
  const { toast } = useToast();
  const queryClient = useQueryClient();

  const { data: availability, isLoading: availabilityLoading, error: availabilityError } = useQuery<AvailableSlot[], Error>({
    queryKey: ["availability"],
    queryFn: async () => {
      const { data, error } = await supabase
        .from("tuk_tuk_availability")
        .select("*");

      if (error) {
        throw new Error(`Erro ao buscar disponibilidade: ${error.message}`);
      }
      return data || [];
    },
  });

  const getAvailableSlots = useCallback((date: string, reservations: Reservation[]): AvailableSlot[] => {
    const timeSlots = [
      "09:00",
      "10:30",
      "12:00",
      "14:00",
      "15:30",
      "17:00",
      "18:30",
    ];

    return timeSlots.map((time) => {
      const slotReservations = reservations.filter(
        (r) => r.reservation_time === time && r.status !== "cancelled"
      );
      const reserved = slotReservations.reduce(
        (sum, r) => sum + (r.number_of_people || 0),
        0
      );

      return {
        time,
        available: reserved < 4,
        capacity: 4,
        reserved,
      };
    });
  }, []);

  const createReservationMutation = useMutation<Reservation[], Error, Reservation>({
    mutationFn: async (reservationData: Reservation) => {
      const { data, error } = await supabase
        .from("reservations")
        .insert([reservationData]) // Garantir que seja uma lista para o Supabase
        .select();

      if (error) {
        throw new Error(`Erro ao criar reserva: ${error.message}`);
      }

      return data;
    },
    onSuccess: (data) => {
      queryClient.invalidateQueries({ queryKey: ["reservations"] });

      const reservationCount = data?.length || 0;
      const totalPeople =
        data?.reduce(
          (sum: number, r: Reservation) => sum + (r.number_of_people || 0),
          0
        ) || 0;
      const totalPrice =
        data?.reduce((sum: number, r: Reservation) => sum + (r.total_price || 0), 0) ||
        0;

      toast({
        title: "Reserva criada com sucesso!",
        description: `${reservationCount} reserva(s) para ${totalPeople} pessoa(s) - €${totalPrice}`,
      });
    },
    onError: (error: Error) => {
      toast({
        title: "Erro ao criar reserva",
        description: error.message || "Tente novamente mais tarde",
        variant: "destructive",
      });
    },
  });

  const { data: tourTypes, isLoading: tourTypesLoading, error: tourTypesError } = useQuery<TourType[], Error>({
    queryKey: ["tourTypes"],
    queryFn: async () => {
      const { data, error } = await supabase
        .from("tour_types")
        .select("*")
        .eq("is_active", true)
        .order("name");

      if (error) {
        throw new Error(`Erro ao buscar tipos de passeio: ${error.message}`);
      }
      return data || DEFAULT_TOUR_TYPES;
    },
  });

  return {
    availability,
    availabilityLoading,
    tourTypes,
    tourTypesLoading,
    createReservation: createReservationMutation.mutate,
    isCreatingReservation: createReservationMutation.isPending,
    getAvailableSlots,
  };
};
