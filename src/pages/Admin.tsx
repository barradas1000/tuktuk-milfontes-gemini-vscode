import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { useAuth } from "@/hooks/useAuth";
import AdminDashboard from "@/components/admin/AdminDashboard";
import ConductorPermissionsManager from "@/components/admin/ConductorPermissionsManager";
import { Loader2 } from "lucide-react";
import { Button } from "@/components/ui/button";

const Admin = () => {
  console.log("Admin page component rendering...");

  const navigate = useNavigate();
  const { user, loading, isAdmin, signOut } = useAuth();
  const [logoutLoading, setLogoutLoading] = useState(false);

  useEffect(() => {
    console.log(
      "Admin useEffect triggered. Loading:",
      loading,
      "User:",
      user?.email,
      "IsAdmin:",
      isAdmin
    );

    // Verificar se é necessário redirecionar
    if (!loading) {
      if (!user) {
        console.log("No user found, redirecting to login");
        navigate("/login");
      } else if (!isAdmin) {
        console.log("User is not admin, access denied");
        // You could redirect to a "not authorized" page or show an error
        // For now, we'll still allow access but could be restricted
      }
    }

    // Verificação adicional da sessão para garantir que está corretamente carregada
    const checkSessionTimeout = setTimeout(() => {
      if (!user && !loading) {
        console.log(
          "Admin page: Session verification timeout - redirecting to login"
        );
        navigate("/login");
      }
    }, 2000);

    return () => clearTimeout(checkSessionTimeout);
  }, [user, loading, isAdmin, navigate]);

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <Loader2 className="h-8 w-8 animate-spin mx-auto mb-4" />
          <p className="text-gray-600">Carregando...</p>

          {/* Botão de emergência para forçar refresh da página */}
          <button
            onClick={() => window.location.reload()}
            className="mt-4 text-sm text-blue-500 hover:underline"
          >
            Problema ao carregar? Clique aqui para atualizar
          </button>
        </div>
      </div>
    );
  }

  if (!user) {
    return null; // Will redirect to auth
  }

  const handleLogout = async () => {
    setLogoutLoading(true);
    try {
      await signOut();
      console.log("Logout realizado com sucesso");
      navigate("/login");
    } catch (err) {
      console.error("Erro ao terminar sessão:", err);
      alert("Erro ao terminar sessão. Veja o console.");
    } finally {
      setLogoutLoading(false);
    }
  };

  return (
    <div className="relative min-h-screen">
      <div className="absolute top-4 right-4 z-10">
        <Button
          variant="outline"
          onClick={handleLogout}
          disabled={logoutLoading}
        >
          {logoutLoading ? "A terminar..." : "Terminar Sessão"}
        </Button>
      </div>

      <AdminDashboard />
      <div className="mt-8">
        <ConductorPermissionsManager />
      </div>
    </div>
  );
};

export default Admin;
