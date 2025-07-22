import React, { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { AlertTriangle, Users, Shield, Clock, Eye, Edit3 } from "lucide-react";
import { useConductorsWithPermissions } from "@/hooks/useConductorsWithPermissions";
import { toast } from "sonner";

interface ConductorPermissionsManagerProps {
  className?: string;
}

const ConductorPermissionsManager: React.FC<
  ConductorPermissionsManagerProps
> = ({ className }) => {
  const {
    conductors,
    adminProfile,
    auditLogs,
    isLoading,
    updateStatus,
    updateError,
    canManageAllConductors,
    canViewAuditLogs,
    adminLevel,
    adminRegion,
    usePermissionCheck,
  } = useConductorsWithPermissions();

  // Calcular condutores ativos a partir dos dados carregados
  const activeConductors = conductors.filter((c) => c.is_active);

  const [selectedConductor, setSelectedConductor] = useState<string | null>(
    null
  );
  const [reason, setReason] = useState("");
  const [isUpdating, setIsUpdating] = useState(false);

  const getAdminLevelBadge = (level?: string) => {
    const variants = {
      super_admin: "bg-red-100 text-red-800 border-red-200",
      admin_regional: "bg-blue-100 text-blue-800 border-blue-200",
      admin_local: "bg-green-100 text-green-800 border-green-200",
    };

    const labels = {
      super_admin: "Super Admin",
      admin_regional: "Admin Regional",
      admin_local: "Admin Local",
    };

    return (
      <Badge
        variant="outline"
        className={variants[level as keyof typeof variants] || ""}
      >
        {labels[level as keyof typeof labels] || level}
      </Badge>
    );
  };

  const handleStatusToggle = async (
    conductorId: string,
    currentStatus: boolean
  ) => {
    setIsUpdating(true);
    try {
      await updateStatus({
        conductorId,
        isActive: !currentStatus,
        reason: reason || undefined,
      });

      toast.success(
        `Condutor ${!currentStatus ? "ativado" : "desativado"} com sucesso!`
      );
      setReason("");
      setSelectedConductor(null);
    } catch (error) {
      toast.error(
        `Erro: ${error instanceof Error ? error.message : "Erro desconhecido"}`
      );
    } finally {
      setIsUpdating(false);
    }
  };

  const ConductorPermissionCheck: React.FC<{
    conductorId: string;
    children: React.ReactNode;
  }> = ({ conductorId, children }) => {
    const { data: hasPermission, isLoading: checkingPermission } =
      usePermissionCheck(conductorId);

    if (checkingPermission) {
      return <div className="animate-pulse bg-gray-200 h-8 w-20 rounded"></div>;
    }

    if (!hasPermission) {
      return (
        <Badge variant="outline" className="bg-gray-100 text-gray-600">
          Sem Permissão
        </Badge>
      );
    }

    return <>{children}</>;
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center p-8">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
      </div>
    );
  }

  return (
    <div className={`space-y-6 ${className}`}>
      {/* Cabeçalho com informações do admin */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Shield className="h-5 w-5" />
            Gerenciamento de Condutores - Controle de Permissões
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="flex flex-wrap gap-4 items-center">
            <div className="flex items-center gap-2">
              <span className="text-sm font-medium">Seu Nível:</span>
              {getAdminLevelBadge(adminLevel)}
            </div>
            {adminRegion && (
              <div className="flex items-center gap-2">
                <span className="text-sm font-medium">Região:</span>
                <Badge variant="outline">{adminRegion}</Badge>
              </div>
            )}
            <div className="flex items-center gap-2">
              <span className="text-sm font-medium">
                Condutores Gerenciáveis:
              </span>
              <Badge variant="outline">
                {canManageAllConductors ? "Todos" : `Região: ${adminRegion}`}
              </Badge>
            </div>
          </div>
        </CardContent>
      </Card>

      <Tabs defaultValue="conductors" className="w-full">
        <TabsList className="grid w-full grid-cols-3">
          <TabsTrigger value="conductors" className="flex items-center gap-2">
            <Users className="h-4 w-4" />
            Condutores ({conductors.length})
          </TabsTrigger>
          <TabsTrigger value="active" className="flex items-center gap-2">
            <Eye className="h-4 w-4" />
            Ativos ({activeConductors.length})
          </TabsTrigger>
          {canViewAuditLogs && (
            <TabsTrigger value="audit" className="flex items-center gap-2">
              <Clock className="h-4 w-4" />
              Auditoria ({auditLogs.length})
            </TabsTrigger>
          )}
        </TabsList>

        <TabsContent value="conductors" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Lista de Condutores</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                {conductors.map((conductor) => (
                  <div
                    key={conductor.id}
                    className="flex items-center justify-between p-4 border rounded-lg hover:bg-gray-50"
                  >
                    <div className="flex items-center gap-3">
                      <div>
                        <h3 className="font-medium">{conductor.name}</h3>
                        <p className="text-sm text-gray-600">
                          {conductor.whatsapp} •{" "}
                          {conductor.region || "Região não definida"}
                        </p>
                      </div>
                      <Badge
                        variant={conductor.is_active ? "default" : "secondary"}
                        className={
                          conductor.is_active
                            ? "bg-green-100 text-green-800"
                            : ""
                        }
                      >
                        {conductor.is_active ? "Ativo" : "Inativo"}
                      </Badge>
                    </div>
                    <div className="flex items-center gap-2">
                      <ConductorPermissionCheck conductorId={conductor.id}>
                        <Button
                          variant={
                            conductor.is_active ? "destructive" : "default"
                          }
                          size="sm"
                          onClick={() => setSelectedConductor(conductor.id)}
                          disabled={isUpdating}
                          className="flex items-center gap-1"
                        >
                          <Edit3 className="h-3 w-3" />
                          {conductor.is_active ? "Desativar" : "Ativar"}
                        </Button>
                      </ConductorPermissionCheck>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="active" className="space-y-4">
          <Card>
            <CardHeader>
              <CardTitle>Condutores Ativos</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
                {activeConductors.map((conductor) => (
                  <Card key={conductor.id} className="border-green-200">
                    <CardContent className="p-4">
                      <div className="space-y-2">
                        <h3 className="font-medium">{conductor.name}</h3>
                        <p className="text-sm text-gray-600">
                          {conductor.whatsapp}
                        </p>
                        {conductor.region && (
                          <Badge variant="outline" className="text-xs">
                            {conductor.region}
                          </Badge>
                        )}
                        <div className="flex justify-between items-center pt-2">
                          <Badge className="bg-green-100 text-green-800">
                            Ativo
                          </Badge>
                          <ConductorPermissionCheck conductorId={conductor.id}>
                            <Button
                              variant="destructive"
                              size="sm"
                              onClick={() => setSelectedConductor(conductor.id)}
                              disabled={isUpdating}
                            >
                              Desativar
                            </Button>
                          </ConductorPermissionCheck>
                        </div>
                      </div>
                    </CardContent>
                  </Card>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {canViewAuditLogs && (
          <TabsContent value="audit" className="space-y-4">
            <Card>
              <CardHeader>
                <CardTitle>Log de Auditoria</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-3">
                  {auditLogs.map((log) => (
                    <div
                      key={log.id}
                      className="flex items-center justify-between p-4 border rounded-lg"
                    >
                      <div className="flex items-center gap-3">
                        <AlertTriangle
                          className={`h-4 w-4 ${
                            log.new_status ? "text-green-600" : "text-red-600"
                          }`}
                        />
                        <div>
                          <p className="font-medium">
                            {log.new_status ? "Ativação" : "Desativação"} de
                            condutor
                          </p>
                          <p className="text-sm text-gray-600">
                            {new Date(log.created_at).toLocaleString("pt-BR")} •{" "}
                            {log.region}
                          </p>
                        </div>
                      </div>
                      <div className="text-right">
                        {getAdminLevelBadge(log.admin_level)}
                        {log.reason && (
                          <p className="text-xs text-gray-600 mt-1">
                            Motivo: {log.reason}
                          </p>
                        )}
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </TabsContent>
        )}
      </Tabs>

      {/* Modal de confirmação */}
      {selectedConductor && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
          <Card className="w-full max-w-md mx-4">
            <CardHeader>
              <CardTitle>Confirmar Alteração</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <p>Deseja alterar o status deste condutor?</p>
              <div>
                <label className="block text-sm font-medium mb-2">
                  Motivo (opcional):
                </label>
                <textarea
                  className="w-full p-2 border rounded-md"
                  rows={3}
                  value={reason}
                  onChange={(e) => setReason(e.target.value)}
                  placeholder="Digite o motivo da alteração..."
                />
              </div>
              <div className="flex gap-2 justify-end">
                <Button
                  variant="outline"
                  onClick={() => {
                    setSelectedConductor(null);
                    setReason("");
                  }}
                >
                  Cancelar
                </Button>
                <Button
                  onClick={() => {
                    const conductor = conductors.find(
                      (c) => c.id === selectedConductor
                    );
                    if (conductor) {
                      handleStatusToggle(
                        selectedConductor,
                        conductor.is_active
                      );
                    }
                  }}
                  disabled={isUpdating}
                >
                  {isUpdating ? "Atualizando..." : "Confirmar"}
                </Button>
              </div>
            </CardContent>
          </Card>
        </div>
      )}
    </div>
  );
};

export default ConductorPermissionsManager;
