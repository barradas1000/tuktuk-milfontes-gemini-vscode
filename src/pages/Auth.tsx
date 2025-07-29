import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { Lock, Loader2, Eye, EyeOff } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardHeader,
  CardTitle,
  CardDescription,
} from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Tabs, TabsList, TabsTrigger, TabsContent } from "@/components/ui/tabs";
import { Alert, AlertDescription } from "@/components/ui/alert";
import { useAuth } from "@/hooks/useAuth";

export default function Auth() {
  const navigate = useNavigate();
  const { signIn, signUp, user, loading } = useAuth();

  const [activeTab, setActiveTab] = useState<"login" | "signup">("login");
  const [loginEmail, setLoginEmail] = useState("");
  const [loginPassword, setLoginPassword] = useState("");
  const [showLoginPassword, setShowLoginPassword] = useState(false);
  const [signupEmail, setSignupEmail] = useState("");
  const [signupPassword, setSignupPassword] = useState("");
  const [signupFullName, setSignupFullName] = useState("");
  const [showSignupPassword, setShowSignupPassword] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(false);

  // Função para limpar cache/localStorage e recarregar a página
  const clearBrowserCache = () => {
    try {
      localStorage.clear();
      sessionStorage.clear();
      if ("serviceWorker" in navigator) {
        navigator.serviceWorker.getRegistrations().then((registrations) => {
          for (const registration of registrations) {
            registration.unregister();
          }
        });
      }
    } catch (e) {
      // Silenciar erros de limpeza de cache
    }
    window.location.reload();
  };

  // Redireciona se já estiver autenticado
  const { profile } = useAuth();
  React.useEffect(() => {
    console.log("[Auth] Checking redirection conditions:", {
      user: !!user,
      loading,
      profile: profile ? { id: profile.id, role: profile.role } : null,
      timestamp: new Date().toISOString(),
    });

    if (user && !loading && profile) {
      console.log("[Auth] Redirecting user with role:", profile.role);
      setIsLoading(false); // Reset loading antes do redirecionamento
      
      if (profile.role === "admin" || profile.role === "super_admin") {
        console.log("[Auth] Navigating to admin dashboard");
        navigate("/admin");
      } else if (profile.role === "condutor") {
        console.log("[Auth] Navigating to condutor dashboard");
        navigate("/condutor/dashboard");
      } else {
        console.log("[Auth] Navigating to home page");
        navigate("/"); // Ou página de acesso limitado
      }
    }
  }, [user, loading, profile, navigate]);

  // Timeout de segurança para resetar loading se redirecionamento falhar
  React.useEffect(() => {
    if (isLoading && user && !loading) {
      const timeout = setTimeout(() => {
        console.log("[Auth] Timeout reached, resetting loading state");
        setIsLoading(false);
      }, 5000); // 5 segundos timeout

      return () => clearTimeout(timeout);
    }
  }, [isLoading, user, loading]);

  const handleSignIn = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setIsLoading(true);
    setError(null);
    console.log("[Auth] Starting sign in process");

    try {
      const { error } = await signIn(loginEmail, loginPassword);
      console.log("[Auth] Sign in result:", { hasError: !!error });

      if (error) {
        setError((error as Error).message || "Erro ao fazer login");
        setIsLoading(false); // Só resetar loading em caso de erro
      } else {
        setSuccess("Login realizado com sucesso!");
        setLoginEmail("");
        setLoginPassword("");
        console.log(
          "[Auth] Login successful, waiting for profile resolution..."
        );
        // Não resetar isLoading aqui - será resetado após redirecionamento ou timeout
      }
    } catch (err: unknown) {
      console.error("[Auth] Sign in exception:", err);
      setError((err as Error).message || "Erro ao fazer login");
      setIsLoading(false); // Só resetar loading em caso de exceção
    }
  };

  const handleSignUp = async (e: React.FormEvent<HTMLFormElement>) => {
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
        setError((error as Error).message || "Erro ao criar conta");
      } else {
        setSuccess("Conta criada! Verifique seu email para confirmar.");
        setSignupEmail("");
        setSignupPassword("");
        setSignupFullName("");
        setActiveTab("login");
      }
    } catch (err: unknown) {
      setError((err as Error).message || "Erro ao criar conta");
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-50 px-4">
      <div className="w-full max-w-md">
        <div className="text-center mb-8">
          <Lock className="mx-auto h-12 w-12 text-blue-600 mb-4" />
          <h1 className="text-3xl font-bold text-gray-900">
            Área Administrativa
          </h1>
          <p className="text-gray-600 mt-2">
            Faça login para acessar o painel administrativo.
          </p>
        </div>
        <div className="bg-white rounded-lg shadow-md p-6">
          <Card>
            <CardHeader>
              <Tabs
                value={activeTab}
                onValueChange={(v) => setActiveTab(v as "login" | "signup")}
                className="w-full"
              >
                <TabsList className="grid w-full grid-cols-2">
                  <TabsTrigger value="login">Entrar</TabsTrigger>
                  <TabsTrigger value="signup">Criar Conta</TabsTrigger>
                </TabsList>
              </Tabs>
            </CardHeader>
            <CardContent className="pt-6">
              {error && (
                <Alert variant="destructive" className="mb-4">
                  <AlertDescription>
                    {typeof error === "string" ? error : ""}
                  </AlertDescription>
                </Alert>
              )}
              {success && (
                <Alert className="mb-4 border-green-200 bg-green-50 text-green-800">
                  <AlertDescription>{success}</AlertDescription>
                </Alert>
              )}
              {activeTab === "login" && (
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
                        onClick={() => setShowLoginPassword(!showLoginPassword)}
                      >
                        {showLoginPassword ? (
                          <EyeOff className="h-4 w-4 text-gray-400" />
                        ) : (
                          <Eye className="h-4 w-4 text-gray-400" />
                        )}
                      </button>
                    </div>
                  </div>
                  <Button type="submit" className="w-full" disabled={isLoading}>
                    {isLoading ? (
                      <>
                        <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                        Entrando...
                      </>
                    ) : (
                      "Entrar"
                    )}
                  </Button>
                </form>
              )}
              {activeTab === "signup" && (
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
                        onChange={(e) => setSignupPassword(e.target.value)}
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
                  <Button type="submit" className="w-full" disabled={isLoading}>
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
              )}
            </CardContent>
          </Card>
          <div className="text-center mt-6 space-y-2">
            <Button
              variant="ghost"
              onClick={() => navigate("/")}
              className="text-gray-600 hover:text-gray-900"
            >
              ← Voltar ao site
            </Button>
            <button
              type="button"
              onClick={clearBrowserCache}
              className="text-xs text-blue-500 hover:text-blue-700 underline block mx-auto mt-2"
            >
              Problema ao carregar? Clique aqui para atualizar
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
