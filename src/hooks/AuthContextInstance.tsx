import { createContext } from "react";
import type { User, Session } from "@supabase/supabase-js";

export interface Profile {
  id: string;
  email: string;
  full_name?: string;
  role?: string;
  [key: string]: unknown;
}

export interface AuthContextType {
  user: User | null;
  session: Session | null;
  profile: Profile | null;
  loading: boolean;
  signIn: (email: string, password: string) => Promise<{ error: unknown }>;
  signUp: (
    email: string,
    password: string,
    fullName: string
  ) => Promise<{ error: unknown }>;
  signOut: () => Promise<void>;
  isAdmin: boolean;
  refreshProfile: () => Promise<void>;
}

// Criar o contexto de autenticação
export const AuthContext = createContext<AuthContextType | undefined>(
  undefined
);
