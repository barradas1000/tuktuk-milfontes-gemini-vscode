import React, { useState, useEffect, useRef } from "react";
import { useNavigate } from "react-router-dom";
import { supabase } from "@/lib/supabase";
import type { User, Session } from "@supabase/supabase-js";
import { allowedAdmins } from "@/constants/authConstants";
import { AuthContext, AuthContextType, Profile } from "./AuthContextInstance";

// Componente Provider para autenticação
export const AuthProvider = ({ children }: { children: React.ReactNode }) => {
  const [user, setUser] = useState<User | null>(null);
  const [session, setSession] = useState<Session | null>(null);
  const [profile, setProfile] = useState<Profile | null>(null);
  const [loading, setLoading] = useState(true);
  const authResolved = useRef(false);
  const [sessionExpired, setSessionExpired] = useState(false);
  const navigate = useNavigate();

  // Função centralizada para resolver o perfil do usuário
  const resolveUserProfile = async (sessionUser: User | null) => {
    console.log("[AuthContext] Resolving user profile:", sessionUser?.id);

    if (!sessionUser) {
      console.log("[AuthContext] No user, setting profile to null");
      setProfile(null);
      setLoading(false);
      return;
    }

    try {
      // Buscar perfil do banco de dados
      const { data: profileData, error } = await supabase
        .from("profiles")
        .select("*")
        .eq("id", sessionUser.id)
        .single();

      console.log("[AuthContext] Profile query result:", {
        userId: sessionUser.id,
        profileData,
        error,
        timestamp: new Date().toISOString(),
      });

      if (!error && profileData) {
        setProfile(profileData);
        console.log("[AuthContext] Profile set from DB:", profileData);
      } else {
        // Fallback para metadados do usuário se o perfil não existir no banco
        const fallbackProfile: Profile = {
          id: sessionUser.id,
          email: sessionUser.email || "",
          full_name: sessionUser.user_metadata?.full_name || "",
          role: sessionUser.user_metadata?.role || "user",
        };
        setProfile(fallbackProfile);
        console.log(
          "[AuthContext] Using fallback profile from metadata:",
          fallbackProfile
        );
      }
    } catch (err) {
      console.error("[AuthContext] Exception during profile resolution:", err);
      // Fallback no caso de exceção
      const fallbackProfile: Profile = {
        id: sessionUser.id,
        email: sessionUser.email || "",
        full_name: sessionUser.user_metadata?.full_name || "",
        role: sessionUser.user_metadata?.role || "user",
      };
      setProfile(fallbackProfile);
      console.log(
        "[AuthContext] Exception fallback profile set:",
        fallbackProfile
      );
    } finally {
      // Garantir que loading seja sempre false após resolver o perfil
      setLoading(false);
    }
  };

  useEffect(() => {
    console.log("[AuthContext] Initializing authentication");

    // Flag para evitar resolução duplicada do perfil
    let mounted = true;

    // Verificar a sessão inicial
    const initializeAuth = async () => {
      try {
        const { data, error } = await supabase.auth.getSession();
        console.log("[AuthContext] Initial session check:", {
          hasData: !!data,
          hasSession: !!data.session,
          hasError: !!error,
          timestamp: new Date().toISOString(),
        });

        if (error) {
          console.error("[AuthContext] Error getting session:", error);
          setSessionExpired(true);
        } else if (data && data.session) {
          console.log(
            "[AuthContext] Setting initial session for user:",
            data.session.user.id
          );
          setSession(data.session);
          setUser(data.session.user);

          if (mounted && !authResolved.current) {
            authResolved.current = true;
            await resolveUserProfile(data.session.user);
          }
        } else {
          console.log("[AuthContext] No initial session found");
          setLoading(false);
        }
      } catch (e) {
        console.error("[AuthContext] Exception during initialization:", e);
        setLoading(false);
      }
    };

    // Inicializar autenticação
    initializeAuth();

    // Configurar o listener de alterações de autenticação
    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange(async (event, newSession) => {
      console.log("[AuthContext] Auth state change:", {
        event,
        userId: newSession?.user?.id,
      });

      if (mounted) {
        if (event === "SIGNED_IN" && newSession) {
          console.log(
            "[AuthContext] User signed in:",
            newSession.user.id,
            "at",
            new Date().toISOString()
          );
          setSession(newSession);
          setUser(newSession.user);

          if (!authResolved.current) {
            authResolved.current = true;
            await resolveUserProfile(newSession.user);
          }
        } else if (event === "SIGNED_OUT") {
          console.log("[AuthContext] User signed out");
          setUser(null);
          setSession(null);
          setProfile(null);
          setLoading(false);
        } else if (event === "TOKEN_REFRESHED" && newSession) {
          console.log(
            "[AuthContext] Token refreshed for user:",
            newSession.user.id
          );
          setSession(newSession);
        } else if (event === "USER_UPDATED" && newSession) {
          console.log(
            "[AuthContext] User updated:",
            newSession.user.id,
            "at",
            new Date().toISOString()
          );
          setSession(newSession);
          setUser(newSession.user);
          await resolveUserProfile(newSession.user);
        }
      }
    });

    // Limpeza ao desmontar o componente
    return () => {
      mounted = false;
      subscription.unsubscribe();
    };
  }, []);

  const signIn = async (email: string, password: string) => {
    const { error } = await supabase.auth.signInWithPassword({
      email,
      password,
    });
    return { error };
  };

  const signUp = async (email: string, password: string, fullName: string) => {
    if (!allowedAdmins.includes(email.trim().toLowerCase())) {
      return {
        error: {
          message: "Email não autorizado para registo de administrador.",
        },
      };
    }
    const redirectUrl = `${window.location.origin}/login`;
    const { error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        emailRedirectTo: redirectUrl,
        data: { full_name: fullName, role: "admin" },
      },
    });
    return { error };
  };

  const signOut = async () => {
    const { error } = await supabase.auth.signOut();
    if (!error) {
      setProfile(null);
      setUser(null);
      setSession(null);
    }
  };

  const refreshProfile = async () => {
    if (!user?.id) {
      console.log("[AuthContext] No user ID available for refresh");
      return;
    }

    console.log("[AuthContext] Forcing profile refresh for user:", user.id);
    setLoading(true);

    try {
      // First, try to refresh the session to ensure we have the latest data
      const { data: sessionData, error: sessionError } =
        await supabase.auth.getSession();

      if (sessionError) {
        console.error("[AuthContext] Error refreshing session:", sessionError);
        throw sessionError;
      }

      if (sessionData && sessionData.session) {
        setSession(sessionData.session);
        setUser(sessionData.session.user);
      }

      // Then update the profile
      await resolveUserProfile(user);
    } catch (err) {
      console.error("[AuthContext] Error during profile refresh:", err);
      setLoading(false);
    } finally {
      // Make sure loading is reset
      setTimeout(() => {
        setLoading(false);
      }, 500);
    }
  };

  const isAdmin = profile?.role === "admin";

  const value = {
    user,
    session,
    profile,
    loading,
    signIn,
    signUp,
    signOut,
    isAdmin,
    refreshProfile,
  };

  // Painel de diagnóstico avançado
  const [localStorageContent, setLocalStorageContent] = useState<
    Record<string, string> | string | null
  >(null);
  const [sessionStorageContent, setSessionStorageContent] = useState<
    Record<string, string> | string | null
  >(null);
  const [supabaseSession, setSupabaseSession] = useState<Session | null>(null);

  useEffect(() => {
    // Serializar todos os valores para garantir que não há erro de JSON
    try {
      const ls: Record<string, string> = {};
      for (let i = 0; i < localStorage.length; i++) {
        const key = localStorage.key(i);
        if (key) {
          try {
            const value = localStorage.getItem(key);
            ls[key] = value !== null ? value : "";
          } catch (err) {
            ls[key] = "[Erro ao ler]";
          }
        }
      }
      setLocalStorageContent(ls);
    } catch (e) {
      setLocalStorageContent("Erro ao acessar localStorage");
    }

    try {
      const ss: Record<string, string> = {};
      for (let i = 0; i < sessionStorage.length; i++) {
        const key = sessionStorage.key(i);
        if (key) {
          try {
            const value = sessionStorage.getItem(key);
            ss[key] = value !== null ? value : "";
          } catch (err) {
            ss[key] = "[Erro ao ler]";
          }
        }
      }
      setSessionStorageContent(ss);
    } catch (e) {
      setSessionStorageContent("Erro ao acessar sessionStorage");
    }

    // Update supabaseSession when session changes
    setSupabaseSession(session);
  }, [session]);

  useEffect(() => {
    if (sessionExpired) {
      // Mostrar mensagem e redirecionar para login
      alert("Sessão expirada. Por favor, faça login novamente.");
      navigate("/login");
    }
  }, [sessionExpired, navigate]);

  // Retornar o contexto com o valor e os filhos
  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};
