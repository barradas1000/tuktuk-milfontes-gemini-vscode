import { useQuery } from "@tanstack/react-query";
import { supabase } from "@/lib/supabase";

interface Profile {
  id: string;
  full_name: string;
  email: string;
  phone?: string;
  whatsapp?: string;
  role: "admin" | "conductor" | "user";
  region?: string;
  admin_level?: "super_admin" | "admin_regional" | "admin_local";
  is_active: boolean;
  created_at: string;
  updated_at: string;
}

async function fetchProfile(): Promise<Profile | null> {
  try {
    // Get current user
    const { data: user } = await supabase.auth.getUser();

    if (!user.user) {
      return null;
    }

    // Get profile from database
    const { data: profile, error } = await supabase
      .from("profiles")
      .select("*")
      .eq("id", user.user.id)
      .single();

    if (error) {
      console.error("Error fetching profile:", error);
      return null;
    }

    return profile;
  } catch (error) {
    console.error("Error in fetchProfile:", error);
    return null;
  }
}

export function useProfile() {
  return useQuery({
    queryKey: ["profile"],
    queryFn: fetchProfile,
    staleTime: 5 * 60 * 1000, // 5 minutes
    gcTime: 10 * 60 * 1000, // 10 minutes (renamed from cacheTime in v5)
    retry: 3,
    retryDelay: (attemptIndex) => Math.min(1000 * 2 ** attemptIndex, 30000),
  });
}
