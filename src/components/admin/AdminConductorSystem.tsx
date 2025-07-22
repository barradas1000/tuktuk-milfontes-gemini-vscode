import React, { useEffect, useState } from "react";
import { ConductorManagementDashboard } from "./ConductorManagementDashboard";
import { useProfile } from "@/hooks/useProfile";
import { Card, CardContent } from "@/components/ui/card";
import { AlertTriangle, Shield } from "lucide-react";

export const AdminConductorSystem: React.FC = () => {
  const { data: profile, isLoading: profileLoading } = useProfile();
  const [adminLevel, setAdminLevel] = useState<
    "super_admin" | "admin_regional" | "admin_local"
  >("admin_local");
  const [region, setRegion] = useState<string | undefined>();

  useEffect(() => {
    if (profile) {
      // Verificar se é admin
      if (profile.role !== "admin") {
        return;
      }

      setAdminLevel(profile.admin_level || "admin_local");
      setRegion(profile.region);
    }
  }, [profile]);

  // Loading state
  if (profileLoading) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-gray-600">Carregando perfil...</p>
        </div>
      </div>
    );
  }

  // Verificação de permissões
  if (!profile || profile.role !== "admin") {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center p-4">
        <Card className="w-full max-w-md">
          <CardContent className="p-6 text-center">
            <AlertTriangle className="h-12 w-12 text-red-500 mx-auto mb-4" />
            <h2 className="text-xl font-semibold text-gray-900 mb-2">
              Acesso Negado
            </h2>
            <p className="text-gray-600 mb-4">
              Você não tem permissões de administrador para acessar esta área.
            </p>
            <p className="text-sm text-gray-500">
              Entre em contato com um super admin para obter acesso.
            </p>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header com informações do admin */}
      <div className="bg-white border-b border-gray-200 px-4 py-3">
        <div className="max-w-7xl mx-auto flex items-center justify-between">
          <div className="flex items-center space-x-4">
            <Shield className="h-6 w-6 text-blue-600" />
            <div>
              <h1 className="text-lg font-semibold text-gray-900">
                Painel Administrativo
              </h1>
              <p className="text-sm text-gray-600">
                {profile.full_name} •{" "}
                {adminLevel.replace("_", " ").toUpperCase()}
                {region && ` • ${region}`}
              </p>
            </div>
          </div>

          <div className="flex items-center space-x-2">
            <div
              className={`px-3 py-1 rounded-full text-xs font-medium ${
                adminLevel === "super_admin"
                  ? "bg-purple-100 text-purple-800"
                  : adminLevel === "admin_regional"
                  ? "bg-blue-100 text-blue-800"
                  : "bg-green-100 text-green-800"
              }`}
            >
              {adminLevel === "super_admin"
                ? "👑 Super Admin"
                : adminLevel === "admin_regional"
                ? "🔵 Admin Regional"
                : "🟢 Admin Local"}
            </div>
          </div>
        </div>
      </div>

      {/* Conteúdo principal */}
      <div className="max-w-7xl mx-auto p-4 sm:p-6 lg:p-8">
        <ConductorManagementDashboard region={region} adminLevel={adminLevel} />
      </div>
    </div>
  );
};
