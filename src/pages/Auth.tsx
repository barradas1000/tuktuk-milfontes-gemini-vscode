import { EmergencyCacheHelper } from "@/components/EmergencyCacheHelper";
import DevCacheHelper from "@/components/DevCacheHelper";
import { allowedAdmins } from "@/constants/allowedAdmins";
import { useAuth } from "@/hooks/useAuth";
import { supabase } from "@/lib/supabase";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { Loader2, Lock, Eye, EyeOff } from "lucide-react";
import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";

export default function Auth() {
  const navigate = useNavigate();
  const { signIn, signUp, user, loading } = useAuth();
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);
  const [activeTab, setActiveTab] = useState("login");
  const [showEmergencyHelper, setShowEmergencyHelper] = useState(false);

  // Password visibility states
  const [showLoginPassword, setShowLoginPassword] = useState(false);
  const [showSignupPassword, setShowSignupPassword] = useState(false);

  // Login form state
  const [loginEmail, setLoginEmail] = useState("");
  const [loginPassword, setLoginPassword] = useState("");

  // Signup form state
  const [signupEmail, setSignupEmail] = useState("");
  const [signupPassword, setSignupPassword] = useState("");
  const [signupFullName, setSignupFullName] = useState("");

  // Reset password state
  const [resetEmail, setResetEmail] = useState("");
  const [isResettingPassword, setIsResettingPassword] = useState(false);
  const [showResetForm, setShowResetForm] = useState(false);

  // Adicionar timeout para autenticação
  // Isso evita que a página fique presa carregando indefinidamente
  useEffect(() => {
    const authTimeout = setTimeout(() => {
      // Se após 5 segundos ainda estivermos carregando, forçar exibição do helper
      if (loading) {
        console.warn(
          "⚠️ Timeout na autenticação - forçando exibição do helper"
        );
        setShowEmergencyHelper(true);
      }
    }, 5000);

    return () => clearTimeout(authTimeout);
  }, [loading]);

  // Verificação de scripts externos em segundo plano, com menor prioridade
  useEffect(() => {
    // Função para detectar possíveis extensões que causam conflitos
    const detectExtensionConflicts = () => {
      try {
        // Verificar extensões com baixa prioridade (não bloqueante)
        setTimeout(() => {
          // Verificar se há inpage.js (normalmente de extensões de carteiras crypto)
          const inpageScripts = Array.from(
            document.querySelectorAll("script")
          ).filter((script) => script.src.includes("inpage.js"));

          if (inpageScripts.length > 0) {
            console.warn(
              "Detectadas extensões que podem causar erros no console:",
              inpageScripts.map((s) => s.src)
            );
          }
        }, 2000); // Executar após 2 segundos para não atrasar carregamento inicial
      } catch (e) {
        // Não fazer nada em caso de erro - isso é apenas para diagnóstico
      }
    };

    // Iniciar detecção só depois que componentes principais estiverem carregados
    if (document.readyState === "complete") {
      detectExtensionConflicts();
    } else {
      window.addEventListener("load", detectExtensionConflicts, { once: true });
    }

    return () => window.removeEventListener("load", detectExtensionConflicts);
  }, []);

  // Este bloco de declarações foi removido para evitar duplicidade

  // Adicionar mecanismo para permitir exibir manualmente o helper com parâmetro de URL
  useEffect(() => {
    // Verificar se existe um parâmetro na URL para forçar a exibição do helper
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get("showHelper") === "true") {
      setShowEmergencyHelper(true);
    }
  }, []);

  // Limpar automaticamente sessões antigas ao carregar a página de login diretamente
  useEffect(() => {
    // Verificar se estamos na página de login
    const isLoginPage = window.location.pathname.includes("/login");

    // Se o usuário já está autenticado e estamos na página de login, redirecionamos para /admin
    if (user && !loading && isLoginPage) {
      console.log(
        "[Auth] Usuário já autenticado na página de login, redirecionando..."
      );
      navigate("/admin");
      return;
    }

    // Somente executar limpeza se estivermos na página de login sem usuário autenticado
    if (isLoginPage && !user) {
      // Detecta acesso direto à página de login usando o referrer
      let isDirectAccess = document.referrer === "";

      try {
        // Verificação adicional usando a API de navegação
        if (
          performance.getEntriesByType &&
          performance.getEntriesByType("navigation").length > 0 &&
          performance.getEntriesByType("navigation")[0] !== null
        ) {
          const navType = (
            performance.getEntriesByType(
              "navigation"
            )[0] as PerformanceNavigationTiming
          )?.type;
          if (navType === "reload") {
            isDirectAccess = true;
          }
        }
      } catch (e) {
        console.warn("Não foi possível verificar o tipo de navegação:", e);
        // Fallback - assume acesso direto se não conseguir verificar
        isDirectAccess = true;
      }

      console.log("[Auth] Verificação de sessão:", {
        isLoginPage,
        isDirectAccess,
        user: !!user,
      });

      // Limpar sessão apenas se for acesso direto
      if (isDirectAccess) {
        try {
          console.log("🧹 Limpando sessão na página de login (acesso direto)");
          // Limpar localStorage e sessionStorage
          localStorage.clear();
          sessionStorage.clear();
        } catch (error) {
          console.error("❌ Erro ao limpar sessão:", error);
        }
      }
    }
  }, [user, loading, navigate]);

  // Mostrar o ajudante de emergência apenas se houver problemas específicos de carregamento
  useEffect(() => {
    // Reduzido para 3 segundos para melhorar a experiência do usuário
    // Só exibimos o ajudante de emergência se o usuário ficar preso na tela de carregamento
    const timer = setTimeout(() => {
      try {
        // Verificamos se ainda estamos carregando ou se houve um erro
        if (
          loading ||
          error ||
          document.querySelector('[data-loading-auth="true"]')
        ) {
          console.log("Ativando helper de emergência após timeout");
          setShowEmergencyHelper(true);
        }
      } catch (e) {
        // Em caso de erro, mostra o helper
        console.warn("Erro ao verificar estado de carregamento:", e);
        setShowEmergencyHelper(true);
      }
    }, 3000);

    return () => clearTimeout(timer);
  }, [loading, error]);

  // Efeito para redirecionamento após login bem-sucedido
  // Este efeito deve ter alta prioridade e não deve ser interrompido
  useEffect(() => {
    if (user && !loading) {
      // Usuário está autenticado e o carregamento terminou
      console.log("[Auth] Usuário autenticado, redirecionando para /admin:", {
        userId: user.id,
        email: user.email,
        loading,
      });

      // Usando setTimeout para garantir que o redirecionamento aconteça após outros efeitos
      const redirectTimer = setTimeout(() => {
        navigate("/admin", { replace: true });
      }, 100);

      return () => clearTimeout(redirectTimer);
    } else {
      console.log("[Auth] Não redirecionando:", {
        hasUser: !!user,
        isLoading: loading,
        timestamp: new Date().toISOString(),
      });
    }
  }, [user, loading, navigate]);

  // Clear errors when switching tabs
  useEffect(() => {
    setError(null);
    setSuccess(null);
  }, [activeTab]);

  const handleSignIn = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);
    setError(null);

    try {
      const { error } = await signIn(loginEmail, loginPassword);

      if (error) {
        type ErrorWithMessage = { message: string };
        const errorMessage =
          typeof error === "object" &&
          error !== null &&
          "message" in error &&
          typeof (error as ErrorWithMessage).message === "string"
            ? (error as ErrorWithMessage).message
            : "";
        if (errorMessage.includes("Invalid login credentials")) {
          setError("Email ou senha incorretos");
        } else if (errorMessage.includes("Email not confirmed")) {
          setError("Por favor, confirme seu email antes de fazer login");
        } else {
          setError(errorMessage || "Erro desconhecido ao fazer login.");
        }
      } else {
        // Login bem-sucedido, redirecionar explicitamente para admin
        console.log("[Auth] Login bem-sucedido, forçando redirecionamento");
        navigate("/admin", { replace: true });
        return; // Importante: sair da função para não executar o setIsLoading(false)
      }
    } catch (err: unknown) {
      setError("Erro ao fazer login. Tente novamente.");
      console.error("Login error:", err);
    } finally {
      setIsLoading(false);
    }
  };

  const handleSignUp = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);
    setError(null);
    setSuccess(null);

    try {
      const { error } = await signUp(
        signupEmail,
        signupPassword,
        signupFullName
      );

      if (error) {
        const errorMessage =
          typeof error === "object" &&
          error !== null &&
          "message" in error &&
          typeof (error as { message: unknown }).message === "string"
            ? (error as { message: string }).message
            : "";
        if (
          errorMessage.includes("already registered") ||
          errorMessage.includes("User already registered")
        ) {
          setError(
            "Este email já está registado. Por favor, faça login ou recupere a senha."
          );
        } else {
          setError(errorMessage || "Erro ao criar conta.");
        }
      }
    } catch (err: unknown) {
      setError("Erro ao criar conta. Tente novamente.");
      console.error("Signup error:", err);
    } finally {
      setIsLoading(false);
    }
  };

  const handleResetPassword = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsResettingPassword(true);
    setError(null);
    setSuccess(null);

    try {
      const email = resetEmail.trim().toLowerCase();
      if (!allowedAdmins.includes(email)) {
        setError("Email não autorizado para recuperação de senha.");
        setIsResettingPassword(false);
        return;
      }

      // Verifica se o utilizador já tem conta criada no Supabase Auth
      const { data, error: fetchError } = await supabase
        .from("profiles")
        .select("id")
        .eq("email", email)
        .single();

      if (fetchError || !data) {
        setError(
          "Este email ainda não criou a sua conta de acesso, crie primeiro a sua conta "
        );
        setIsResettingPassword(false);
        return;
      }

      const { error } = await supabase.auth.resetPasswordForEmail(resetEmail, {
        redirectTo: "https://tuktuk-milfontes.vercel.app/reset-password",
      });

      if (error) {
        setError("Erro ao enviar email de recuperação: " + error.message);
      } else {
        setSuccess(
          "Email de recuperação enviado! Verifique sua caixa de entrada."
        );
        setResetEmail("");
        setShowResetForm(false);
      }
    } catch (err: unknown) {
      setError("Erro ao enviar email de recuperação. Tente novamente.");
      console.error("Reset password error:", err);
    } finally {
      setIsResettingPassword(false);
    }
  };

  // Diagnóstico visual do contexto de autenticação - simplificado para melhor desempenho
  if (loading) {
    // Log simplificado para não sobrecarregar o console
    console.log("[Auth] Carregando:", {
      hasUser: !!user,
      loading,
      hasError: !!error,
      url: window.location.href,
    });

    return (
      <div
        className="min-h-screen flex flex-col items-center justify-center"
        data-loading-auth="true"
      >
        <Loader2 className="h-8 w-8 animate-spin mb-4" />
        <div className="text-gray-600 mb-2">Carregando autenticação...</div>

        {/* Botão para mostrar helper manualmente sem esperar timeout */}
        <button
          onClick={() => setShowEmergencyHelper(true)}
          className="mt-6 text-xs text-blue-500 hover:text-blue-700 underline"
        >
          Problema ao carregar? Clique aqui para limpar cache
        </button>
      </div>
    );
  }

  try {
    // Lógica mais robusta: exibir o helper de emergência quando explicitamente solicitado
    // ou quando temos problemas detectados
    if (
      showEmergencyHelper &&
      (error || loading || window.location.search.includes("showHelper=true"))
    ) {
      console.log("Exibindo helper de emergência devido a:", {
        error,
        loading,
        showEmergencyHelper,
      });
      return <EmergencyCacheHelper />;
    }

    return (
      <>
        <div className="min-h-screen flex items-center justify-center bg-gray-50 px-4">
          <div className="w-full max-w-md">
            <div className="text-center mb-8">
              <Lock className="mx-auto h-12 w-12 text-blue-600 mb-4" />
              <h1 className="text-3xl font-bold text-gray-900">
                Área Administrativa
              </h1>
              <p className="text-gray-600 mt-2">
                Faça login para acessar o painel administrativo da aplicação
                Tuktuk-milfontes.
              </p>
            </div>

            <Card>
              <CardHeader>
                <Tabs
                  value={activeTab}
                  onValueChange={setActiveTab}
                  className="w-full"
                >
                  <TabsList className="grid w-full grid-cols-2">
                    <TabsTrigger value="login">Entrar</TabsTrigger>
                    <TabsTrigger value="signup">Criar Conta</TabsTrigger>
                  </TabsList>

                  <TabsContent value="login">
                    <CardTitle>Fazer Login</CardTitle>
                    <CardDescription>
                      Entre com suas credenciais para acessar o sistema
                    </CardDescription>
                  </TabsContent>

                  <TabsContent value="signup">
                    <CardTitle>Criar Conta</CardTitle>
                    <CardDescription>
                      Crie uma nova conta de administrador
                    </CardDescription>
                  </TabsContent>
                </Tabs>
              </CardHeader>

              <CardContent>
                {error && (
                  <Alert className="mb-4 border-red-200 bg-red-50">
                    <AlertDescription className="text-red-800">
                      {error}
                    </AlertDescription>
                  </Alert>
                )}

                {success && (
                  <Alert className="mb-4 border-green-200 bg-green-50">
                    <AlertDescription className="text-green-800">
                      {success}
                    </AlertDescription>
                  </Alert>
                )}

                {showResetForm ? (
                  <form onSubmit={handleResetPassword} className="space-y-4">
                    <div className="text-center mb-4">
                      <h3 className="text-lg font-medium">Recuperar Senha</h3>
                      <p className="text-sm text-gray-600">
                        Digite seu email para receber o link de recuperação
                      </p>
                    </div>

                    <div>
                      <Label htmlFor="reset-email">Email</Label>
                      <Input
                        id="reset-email"
                        type="email"
                        value={resetEmail}
                        onChange={(e) => setResetEmail(e.target.value)}
                        placeholder="seu@email.com"
                        required
                        disabled={isResettingPassword}
                      />
                    </div>

                    <div className="flex space-x-2">
                      <Button
                        type="button"
                        variant="outline"
                        onClick={() => setShowResetForm(false)}
                        className="flex-1"
                        disabled={isResettingPassword}
                      >
                        Cancelar
                      </Button>
                      <Button
                        type="submit"
                        className="flex-1"
                        disabled={isResettingPassword}
                      >
                        {isResettingPassword ? (
                          <>
                            <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                            Enviando...
                          </>
                        ) : (
                          "Enviar Email"
                        )}
                      </Button>
                    </div>
                  </form>
                ) : (
                  <Tabs
                    value={activeTab}
                    onValueChange={setActiveTab}
                    className="w-full"
                  >
                    <TabsContent value="login">
                      <form onSubmit={handleSignIn} className="space-y-4">
                        <div>
                          <Label htmlFor="login-email">Email</Label>
                          <Input
                            id="login-email"
                            type="email"
                            value={loginEmail}
                            onChange={(e) => setLoginEmail(e.target.value)}
                            placeholder="seu@email.com"
                            required
                            disabled={isLoading}
                          />
                        </div>

                        <div>
                          <Label htmlFor="login-password">Senha</Label>
                          <div className="relative">
                            <Input
                              id="login-password"
                              type={showLoginPassword ? "text" : "password"}
                              value={loginPassword}
                              onChange={(e) => setLoginPassword(e.target.value)}
                              placeholder="••••••••"
                              required
                              disabled={isLoading}
                              className="pr-10"
                            />
                            <button
                              type="button"
                              className="absolute inset-y-0 right-0 pr-3 flex items-center"
                              onClick={() =>
                                setShowLoginPassword(!showLoginPassword)
                              }
                            >
                              {showLoginPassword ? (
                                <EyeOff className="h-4 w-4 text-gray-400" />
                              ) : (
                                <Eye className="h-4 w-4 text-gray-400" />
                              )}
                            </button>
                          </div>
                        </div>

                        <Button
                          type="submit"
                          className="w-full"
                          disabled={isLoading}
                        >
                          {isLoading ? (
                            <>
                              <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                              Entrando...
                            </>
                          ) : (
                            "Entrar"
                          )}
                        </Button>

                        <div className="text-center">
                          <button
                            type="button"
                            className="text-sm text-blue-600 hover:underline"
                            onClick={() => setShowResetForm(true)}
                          >
                            Esqueci minha senha
                          </button>
                        </div>
                      </form>
                    </TabsContent>

                    <TabsContent value="signup">
                      <form onSubmit={handleSignUp} className="space-y-4">
                        <div>
                          <Label htmlFor="signup-name">Nome Completo</Label>
                          <Input
                            id="signup-name"
                            type="text"
                            value={signupFullName}
                            onChange={(e) => setSignupFullName(e.target.value)}
                            placeholder="Seu nome completo"
                            required
                            disabled={isLoading}
                          />
                        </div>

                        <div>
                          <Label htmlFor="signup-email">Email</Label>
                          <Input
                            id="signup-email"
                            type="email"
                            value={signupEmail}
                            onChange={(e) => setSignupEmail(e.target.value)}
                            placeholder="seu@email.com"
                            required
                            disabled={isLoading}
                          />
                        </div>

                        <div>
                          <Label htmlFor="signup-password">Senha</Label>
                          <div className="relative">
                            <Input
                              id="signup-password"
                              type={showSignupPassword ? "text" : "password"}
                              value={signupPassword}
                              onChange={(e) =>
                                setSignupPassword(e.target.value)
                              }
                              placeholder="••••••••"
                              required
                              minLength={6}
                              disabled={isLoading}
                              className="pr-10"
                            />
                            <button
                              type="button"
                              className="absolute inset-y-0 right-0 pr-3 flex items-center"
                              onClick={() =>
                                setShowSignupPassword(!showSignupPassword)
                              }
                            >
                              {showSignupPassword ? (
                                <EyeOff className="h-4 w-4 text-gray-400" />
                              ) : (
                                <Eye className="h-4 w-4 text-gray-400" />
                              )}
                            </button>
                          </div>
                        </div>

                        <Button
                          type="submit"
                          className="w-full"
                          disabled={isLoading}
                        >
                          {isLoading ? (
                            <>
                              <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                              Criando conta...
                            </>
                          ) : (
                            "Criar Conta"
                          )}
                        </Button>
                      </form>
                    </TabsContent>
                  </Tabs>
                )}
              </CardContent>
            </Card>

            <div className="text-center mt-6">
              <Button
                variant="ghost"
                onClick={() => navigate("/")}
                className="text-gray-600 hover:text-gray-900"
              >
                ← Voltar ao site
              </Button>
              {/* Botão para mostrar o helper de emergência manualmente */}
              {!showEmergencyHelper && (
                <button
                  onClick={() => setShowEmergencyHelper(true)}
                  className="text-xs text-gray-500 hover:text-gray-700 block mx-auto mt-2"
                >
                  Problemas para acessar? Clique aqui
                </button>
              )}
            </div>

            {/* Helper de cache apenas em desenvolvimento */}
            {process.env.NODE_ENV === "development" && <DevCacheHelper />}
          </div>
        </div>
      </>
    );
  } catch (error) {
    // Se ocorrer qualquer erro durante a renderização, mostramos apenas o helper
    console.error("Erro ao renderizar página de autenticação:", error);
    return <EmergencyCacheHelper />;
  }
}
