import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { useAuth } from "@/hooks/useAuth";
import AdminDashboard from "@/components/admin/AdminDashboard";
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
  }, [user, loading, isAdmin, navigate]);

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <Loader2 className="h-8 w-8 animate-spin mx-auto mb-4" />
          <p className="text-gray-600">Carregando...</p>
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
    </div>
  );
};

export default Admin;
