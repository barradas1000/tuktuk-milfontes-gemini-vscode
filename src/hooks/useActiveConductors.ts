import { useQuery } from "@tanstack/react-query";
import { supabase } from "@/lib/supabase";

export interface Conductor {
  id: string;
  name: string;
  whatsapp: string;
  is_active: boolean;
  latitude?: number;
  longitude?: number;
  region?: string;
  iconUrl?: string;
}

const fetchActiveConductors = async (): Promise<Conductor[]> => {
  const { data, error } = await supabase
    .from("conductors")
    .select("*")
    .eq("is_active", true)
    .not("latitude", "is", null)
    .not("longitude", "is", null)
    .order("name");
  if (error) throw error;
  return data || [];
};

export function useActiveConductors() {
  return useQuery<Conductor[], Error>({
    queryKey: ["activeConductors"],
    queryFn: fetchActiveConductors,
    staleTime: 0,
    retry: 2,
    refetchInterval: 2000, // Atualiza a cada 2 segundos
    refetchIntervalInBackground: true,
  });
}
