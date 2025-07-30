import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { useAuth } from "@/hooks/useAuth";
import AdminDashboard from "@/components/admin/AdminDashboard";
import ConductorPermissionsManager from "@/components/admin/ConductorPermissionsManager";
import { Loader2 } from "lucide-react";
import { Button } from "@/components/ui/button";

const Admin = () => {
  const navigate = useNavigate();
  const { user, loading, isAdmin, signOut } = useAuth();
  const [logoutLoading, setLogoutLoading] = useState(false);

  // 🚦 Redirecionamento se o usuário não estiver autenticado
  useEffect(() => {
    if (!loading) {
      if (!user) {
        console.warn("Sem utilizador autenticado. Redirecionando para login...");
        navigate("/login");
      } else if (!isAdmin) {
        console.warn("Utilizador autenticado mas sem permissões de administrador.");
        // Aqui pode colocar um redirecionamento ou uma mensagem de acesso negado
      }
    }
  }, [user, loading, isAdmin, navigate]);

  // ⏳ Estado de carregamento
  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center text-center">
        <div>
          <Loader2 className="h-8 w-8 animate-spin mx-auto mb-4" />
          <p className="text-gray-600">Carregando...</p>
          <button
            onClick={() => window.location.reload()}
            className="mt-4 text-sm text-blue-500 hover:underline"
          >
            Problemas ao carregar? Clique aqui para atualizar
          </button>
        </div>
      </div>
    );
  }

  // 🔒 Se não há utilizador, não renderiza nada (redirecionamento ocorre no useEffect)
  if (!user) return null;

  // 🚪 Função de logout
  const handleLogout = async () => {
    setLogoutLoading(true);
    try {
      await signOut();
      console.log("Logout realizado com sucesso.");
      navigate("/login");
    } catch (err) {
      console.error("Erro ao terminar sessão:", err);
      alert("Erro ao terminar sessão. Veja o console.");
    } finally {
      setLogoutLoading(false);
    }
  };

  // 🧭 Render principal
  return (
    <div className="relative min-h-screen">
      {/* Botão de Terminar Sessão no canto superior direito */}
      <div className="absolute top-4 right-4 z-10">
        <Button
          variant="outline"
          onClick={handleLogout}
          disabled={logoutLoading}
        >
          {logoutLoading ? "A terminar..." : "Terminar Sessão"}
        </Button>
      </div>

      {/* Conteúdo principal do admin */}
      <AdminDashboard />
      <div className="mt-8">
        <ConductorPermissionsManager />
      </div>
    </div>
  );
};

export default Admin;
