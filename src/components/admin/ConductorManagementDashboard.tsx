import React from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Button } from "@/components/ui/button";
import { useConductorManagementOverview } from "@/hooks/useConductorManagement";
import {
  formatConductorStatus,
  formatVehicleStatus,
  formatApplicationStatus,
} from "@/utils/conductorManagementUtils";
import FleetManagement from "./FleetManagement";
import ConductorManagement from "./ConductorManagement";
import {
  Users,
  Car,
  FileText,
  Activity,
  Plus,
  AlertTriangle,
} from "lucide-react";

interface ConductorManagementDashboardProps {
  region?: string;
  adminLevel: "super_admin" | "admin_regional" | "admin_local";
}

export const ConductorManagementDashboard: React.FC<
  ConductorManagementDashboardProps
> = ({ region, adminLevel }) => {
  const {
    dashboard,
    vehicles,
    conductors,
    pendingApplications,
    activeSessions,
    isLoading,
  } = useConductorManagementOverview(region);

  if (isLoading) {
    return (
      <div className="space-y-6">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          {[...Array(4)].map((_, i) => (
            <Card key={i} className="animate-pulse">
              <CardContent className="p-6">
                <div className="h-4 bg-gray-200 rounded w-3/4 mb-2"></div>
                <div className="h-8 bg-gray-200 rounded w-1/2"></div>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    );
  }

  const dashboardData = dashboard.data;
  const vehiclesData = vehicles.data?.data || [];
  const conductorsData = conductors.data?.data || [];
  const applicationsData = pendingApplications.data?.data || [];
  const sessionsData = activeSessions.data || [];

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">
            Gestão de Condutores
          </h1>
          <p className="text-gray-600 mt-1">
            {region ? `Região: ${region}` : "Visão Global"} •{" "}
            {adminLevel.replace("_", " ").toUpperCase()}
          </p>
        </div>
        <div className="flex gap-2">
          <Button>
            <Plus className="h-4 w-4 mr-2" />
            Convidar Novo Condutor
          </Button>
        </div>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {/* Condutores Stats */}
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">
              Condutores Ativos
            </CardTitle>
            <Users className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-green-600">
              {dashboardData?.conductorStats.activeConductors || 0}
            </div>
            <p className="text-xs text-muted-foreground">
              de {dashboardData?.conductorStats.totalConductors || 0} total
            </p>
            {dashboardData?.conductorStats.blockedConductors ? (
              <div className="flex items-center mt-2">
                <AlertTriangle className="h-3 w-3 text-yellow-500 mr-1" />
                <span className="text-xs text-yellow-600">
                  {dashboardData.conductorStats.blockedConductors} bloqueados
                </span>
              </div>
            ) : null}
          </CardContent>
        </Card>

        {/* Veículos Stats */}
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">
              Veículos Operacionais
            </CardTitle>
            <Car className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-blue-600">
              {dashboardData?.fleetStats.operationalVehicles || 0}
            </div>
            <p className="text-xs text-muted-foreground">
              de {dashboardData?.fleetStats.totalVehicles || 0} total
            </p>
            {dashboardData?.fleetStats.maintenanceVehicles ? (
              <div className="flex items-center mt-2">
                <AlertTriangle className="h-3 w-3 text-orange-500 mr-1" />
                <span className="text-xs text-orange-600">
                  {dashboardData.fleetStats.maintenanceVehicles} em manutenção
                </span>
              </div>
            ) : null}
          </CardContent>
        </Card>

        {/* Candidaturas Stats */}
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">
              Candidaturas Pendentes
            </CardTitle>
            <FileText className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-purple-600">
              {dashboardData?.applicationStats.submittedApplications || 0}
            </div>
            <p className="text-xs text-muted-foreground">aguardam revisão</p>
            <div className="text-xs text-green-600 mt-2">
              {dashboardData?.applicationStats.approvedApplications || 0}{" "}
              aprovadas hoje
            </div>
          </CardContent>
        </Card>

        {/* Sessões Ativas */}
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">
              Sessões Ativas
            </CardTitle>
            <Activity className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-indigo-600">
              {dashboardData?.activeSessions || 0}
            </div>
            <p className="text-xs text-muted-foreground">
              condutores trabalhando
            </p>
            <div className="text-xs text-blue-600 mt-2">
              {dashboardData?.fleetStats.activeVehicles || 0} veículos em uso
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Main Tabs */}
      <Tabs defaultValue="overview" className="space-y-6">
        <TabsList>
          <TabsTrigger value="overview">Visão Geral</TabsTrigger>
          <TabsTrigger value="fleet">Frota ({vehiclesData.length})</TabsTrigger>
          <TabsTrigger value="conductors">
            Condutores ({conductorsData.length})
          </TabsTrigger>
          <TabsTrigger value="applications">
            Candidaturas ({applicationsData.length})
            {applicationsData.length > 0 && (
              <Badge variant="secondary" className="ml-2">
                {applicationsData.length}
              </Badge>
            )}
          </TabsTrigger>
        </TabsList>

        {/* Overview Tab */}
        <TabsContent value="overview" className="space-y-6">
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            {/* Veículos Recentes */}
            <Card>
              <CardHeader>
                <CardTitle className="text-lg">Estado da Frota</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {vehiclesData.slice(0, 5).map((vehicle) => (
                    <div
                      key={vehicle.id}
                      className="flex items-center justify-between"
                    >
                      <div className="flex items-center space-x-3">
                        <div className="w-2 h-2 rounded-full bg-blue-500"></div>
                        <div>
                          <p className="font-medium">{vehicle.vehicle_name}</p>
                          <p className="text-sm text-gray-500">
                            {vehicle.license_plate}
                          </p>
                        </div>
                      </div>
                      <div className="flex items-center space-x-2">
                        <Badge
                          variant="outline"
                          className={
                            formatVehicleStatus(vehicle.maintenance_status)
                              .color
                          }
                        >
                          {formatVehicleStatus(vehicle.maintenance_status).icon}{" "}
                          {
                            formatVehicleStatus(vehicle.maintenance_status)
                              .label
                          }
                        </Badge>
                        {vehicle.current_conductor && (
                          <Badge variant="secondary">Em Uso</Badge>
                        )}
                      </div>
                    </div>
                  ))}
                  {vehiclesData.length === 0 && (
                    <p className="text-gray-500 text-center py-4">
                      Nenhum veículo encontrado
                    </p>
                  )}
                </div>
              </CardContent>
            </Card>

            {/* Condutores Recentes */}
            <Card>
              <CardHeader>
                <CardTitle className="text-lg">Condutores Ativos</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {conductorsData.slice(0, 5).map((conductor) => (
                    <div
                      key={conductor.id}
                      className="flex items-center justify-between"
                    >
                      <div className="flex items-center space-x-3">
                        <div className="w-8 h-8 rounded-full bg-gray-200 flex items-center justify-center">
                          <Users className="h-4 w-4 text-gray-600" />
                        </div>
                        <div>
                          <p className="font-medium">{conductor.name}</p>
                          <p className="text-sm text-gray-500">
                            {conductor.email}
                          </p>
                        </div>
                      </div>
                      <div className="flex items-center space-x-2">
                        <Badge
                          variant="outline"
                          className={
                            formatConductorStatus(conductor.status).color
                          }
                        >
                          {formatConductorStatus(conductor.status).icon}{" "}
                          {formatConductorStatus(conductor.status).label}
                        </Badge>
                        {conductor.assigned_vehicle && (
                          <Badge variant="secondary">
                            {conductor.vehicle?.vehicle_name || "Veículo"}
                          </Badge>
                        )}
                      </div>
                    </div>
                  ))}
                  {conductorsData.length === 0 && (
                    <p className="text-gray-500 text-center py-4">
                      Nenhum condutor encontrado
                    </p>
                  )}
                </div>
              </CardContent>
            </Card>
          </div>

          {/* Candidaturas Pendentes */}
          {applicationsData.length > 0 && (
            <Card>
              <CardHeader>
                <CardTitle className="text-lg">
                  Candidaturas Aguardando Revisão
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {applicationsData.map((application) => (
                    <div
                      key={application.id}
                      className="flex items-center justify-between p-4 border rounded-lg"
                    >
                      <div className="flex items-center space-x-3">
                        <div className="w-8 h-8 rounded-full bg-purple-100 flex items-center justify-center">
                          <FileText className="h-4 w-4 text-purple-600" />
                        </div>
                        <div>
                          <p className="font-medium">{application.full_name}</p>
                          <p className="text-sm text-gray-500">
                            {application.email} • {application.region}
                          </p>
                        </div>
                      </div>
                      <div className="flex items-center space-x-2">
                        <Badge
                          variant="outline"
                          className={
                            formatApplicationStatus(application.status).color
                          }
                        >
                          {formatApplicationStatus(application.status).icon}{" "}
                          {formatApplicationStatus(application.status).label}
                        </Badge>
                        <Button size="sm" variant="outline">
                          Revisar
                        </Button>
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          )}
        </TabsContent>

        {/* Fleet Tab */}
        <TabsContent value="fleet">
          <FleetManagement region={region} adminLevel={adminLevel} />
        </TabsContent>

        {/* Conductors Tab */}
        <TabsContent value="conductors">
          <ConductorManagement region={region} adminLevel={adminLevel} />
        </TabsContent>

        {/* Applications Tab - Placeholder */}
        <TabsContent value="applications">
          <Card>
            <CardHeader>
              <CardTitle>Gestão de Candidaturas</CardTitle>
            </CardHeader>
            <CardContent>
              <p className="text-gray-500">
                Componente de gestão de candidaturas será implementado aqui.
              </p>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
};
