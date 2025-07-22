import React, { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import {
  useVehicles,
  useUpdateVehicleStatus,
} from "@/hooks/useConductorManagement";
import {
  formatVehicleStatus,
  formatRelativeTime,
  REGIONS,
  ZONES,
} from "@/utils/conductorManagementUtils";
import type {
  VehicleFilters,
  TukTukVehicle,
  VehicleStatus,
} from "@/types/conductor-management";
import {
  Car,
  Settings,
  MapPin,
  User,
  Wrench,
  CheckCircle,
  XCircle,
  Search,
  Filter,
  MoreVertical,
} from "lucide-react";

interface FleetManagementProps {
  region?: string;
  adminLevel: "super_admin" | "admin_regional" | "admin_local";
}

export const FleetManagement: React.FC<FleetManagementProps> = ({
  region,
  adminLevel,
}) => {
  const [filters, setFilters] = useState<VehicleFilters>({
    region: region ? [region] : undefined,
  });
  const [searchTerm, setSearchTerm] = useState("");
  const [selectedVehicle, setSelectedVehicle] = useState<TukTukVehicle | null>(
    null
  );

  const { data: vehiclesData, isLoading } = useVehicles(filters, {
    page: 1,
    limit: 50,
  });
  const updateVehicleStatus = useUpdateVehicleStatus();

  const vehicles = vehiclesData?.data || [];

  const handleStatusUpdate = async (
    vehicleId: string,
    status: "operational" | "maintenance" | "out_of_service"
  ) => {
    try {
      await updateVehicleStatus.mutateAsync({ vehicleId, status });
    } catch (error) {
      console.error("Erro ao atualizar status:", error);
    }
  };

  const handleSearch = (term: string) => {
    setSearchTerm(term);
    setFilters((prev) => ({
      ...prev,
      searchTerm: term || undefined,
    }));
  };

  const filteredVehicles = vehicles.filter((vehicle) => {
    if (!searchTerm) return true;
    return (
      vehicle.vehicle_name.toLowerCase().includes(searchTerm.toLowerCase()) ||
      vehicle.license_plate?.toLowerCase().includes(searchTerm.toLowerCase()) ||
      vehicle.zone?.toLowerCase().includes(searchTerm.toLowerCase())
    );
  });

  if (isLoading) {
    return (
      <div className="space-y-6">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {[...Array(6)].map((_, i) => (
            <Card key={i} className="animate-pulse">
              <CardContent className="p-6">
                <div className="h-4 bg-gray-200 rounded w-3/4 mb-4"></div>
                <div className="h-16 bg-gray-200 rounded mb-4"></div>
                <div className="h-4 bg-gray-200 rounded w-1/2"></div>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Header com filtros */}
      <div className="flex flex-col sm:flex-row gap-4 justify-between">
        <div>
          <h2 className="text-2xl font-bold text-gray-900">Gestão da Frota</h2>
          <p className="text-gray-600">
            {vehicles.length} veículo{vehicles.length !== 1 ? "s" : ""} na frota
          </p>
        </div>

        <div className="flex gap-2">
          <div className="relative">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 h-4 w-4" />
            <Input
              placeholder="Buscar veículos..."
              value={searchTerm}
              onChange={(e) => handleSearch(e.target.value)}
              className="pl-10 w-64"
            />
          </div>

          <Select
            value={filters.status?.[0] || "all"}
            onValueChange={(value) =>
              setFilters((prev) => ({
                ...prev,
                status: value === "all" ? undefined : [value as VehicleStatus],
              }))
            }
          >
            <SelectTrigger className="w-48">
              <Filter className="h-4 w-4 mr-2" />
              <SelectValue placeholder="Filtrar por status" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">Todos os status</SelectItem>
              <SelectItem value="operational">Operacional</SelectItem>
              <SelectItem value="maintenance">Manutenção</SelectItem>
              <SelectItem value="out_of_service">Fora de Serviço</SelectItem>
            </SelectContent>
          </Select>
        </div>
      </div>

      {/* Grid de Veículos */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {filteredVehicles.map((vehicle) => (
          <VehicleCard
            key={vehicle.id}
            vehicle={vehicle}
            onStatusUpdate={handleStatusUpdate}
            onViewDetails={() => setSelectedVehicle(vehicle)}
          />
        ))}

        {filteredVehicles.length === 0 && (
          <div className="col-span-full text-center py-12">
            <Car className="h-12 w-12 text-gray-400 mx-auto mb-4" />
            <p className="text-gray-500 text-lg">Nenhum veículo encontrado</p>
            <p className="text-gray-400">
              {searchTerm
                ? "Tente ajustar os filtros de busca"
                : "Não há veículos cadastrados"}
            </p>
          </div>
        )}
      </div>

      {/* Modal de Detalhes do Veículo */}
      {selectedVehicle && (
        <VehicleDetailsModal
          vehicle={selectedVehicle}
          open={!!selectedVehicle}
          onClose={() => setSelectedVehicle(null)}
          onStatusUpdate={handleStatusUpdate}
        />
      )}
    </div>
  );
};

// Componente do Card de Veículo
interface VehicleCardProps {
  vehicle: TukTukVehicle;
  onStatusUpdate: (
    vehicleId: string,
    status: "operational" | "maintenance" | "out_of_service"
  ) => void;
  onViewDetails: () => void;
}

const VehicleCard: React.FC<VehicleCardProps> = ({
  vehicle,
  onStatusUpdate,
  onViewDetails,
}) => {
  const statusInfo = formatVehicleStatus(vehicle.maintenance_status);
  const vehicleInfo = vehicle.vehicle_info || {};

  return (
    <Card className="relative group hover:shadow-lg transition-shadow">
      <CardHeader className="pb-3">
        <div className="flex items-center justify-between">
          <div className="flex items-center space-x-3">
            <div
              className={`w-12 h-12 rounded-lg flex items-center justify-center ${
                vehicle.maintenance_status === "operational"
                  ? "bg-green-100"
                  : vehicle.maintenance_status === "maintenance"
                  ? "bg-orange-100"
                  : "bg-red-100"
              }`}
            >
              <Car
                className={`h-6 w-6 ${
                  vehicle.maintenance_status === "operational"
                    ? "text-green-600"
                    : vehicle.maintenance_status === "maintenance"
                    ? "text-orange-600"
                    : "text-red-600"
                }`}
              />
            </div>
            <div>
              <h3 className="font-semibold text-lg">{vehicle.vehicle_name}</h3>
              <p className="text-sm text-gray-500">{vehicle.license_plate}</p>
            </div>
          </div>

          <Dialog>
            <DialogTrigger asChild>
              <Button variant="ghost" size="sm">
                <MoreVertical className="h-4 w-4" />
              </Button>
            </DialogTrigger>
            <DialogContent className="sm:max-w-md">
              <DialogHeader>
                <DialogTitle>Ações do Veículo</DialogTitle>
              </DialogHeader>
              <div className="space-y-2">
                <Button
                  variant="outline"
                  className="w-full justify-start"
                  onClick={() => onStatusUpdate(vehicle.id, "operational")}
                  disabled={vehicle.maintenance_status === "operational"}
                >
                  <CheckCircle className="h-4 w-4 mr-2" />
                  Marcar como Operacional
                </Button>
                <Button
                  variant="outline"
                  className="w-full justify-start"
                  onClick={() => onStatusUpdate(vehicle.id, "maintenance")}
                  disabled={vehicle.maintenance_status === "maintenance"}
                >
                  <Wrench className="h-4 w-4 mr-2" />
                  Enviar para Manutenção
                </Button>
                <Button
                  variant="outline"
                  className="w-full justify-start"
                  onClick={() => onStatusUpdate(vehicle.id, "out_of_service")}
                  disabled={vehicle.maintenance_status === "out_of_service"}
                >
                  <XCircle className="h-4 w-4 mr-2" />
                  Marcar Fora de Serviço
                </Button>
              </div>
            </DialogContent>
          </Dialog>
        </div>
      </CardHeader>

      <CardContent className="space-y-4">
        {/* Status Principal */}
        <div className="flex items-center justify-between">
          <Badge className={statusInfo.color}>
            {statusInfo.icon} {statusInfo.label}
          </Badge>
          {vehicle.is_active && (
            <Badge variant="secondary" className="bg-blue-50 text-blue-700">
              🔴 Em Uso
            </Badge>
          )}
        </div>

        {/* Informações do Veículo */}
        <div className="space-y-2 text-sm">
          <div className="flex items-center justify-between">
            <span className="text-gray-500">Marca/Modelo:</span>
            <span>
              {vehicleInfo.marca || "N/A"} {vehicleInfo.modelo || ""}
            </span>
          </div>
          <div className="flex items-center justify-between">
            <span className="text-gray-500">Ano:</span>
            <span>{vehicleInfo.ano || "N/A"}</span>
          </div>
          <div className="flex items-center justify-between">
            <span className="text-gray-500">Cor:</span>
            <span>{vehicleInfo.cor || "N/A"}</span>
          </div>
        </div>

        {/* Localização */}
        <div className="flex items-center space-x-2 text-sm text-gray-600">
          <MapPin className="h-4 w-4" />
          <span>{vehicle.region}</span>
          {vehicle.zone && (
            <>
              <span>•</span>
              <span>{vehicle.zone}</span>
            </>
          )}
        </div>

        {/* Condutor Atual */}
        {vehicle.current_conductor ? (
          <div className="flex items-center space-x-2 text-sm">
            <User className="h-4 w-4 text-blue-500" />
            <span className="text-blue-600">
              {vehicle.conductor?.name || "Condutor Ativo"}
            </span>
          </div>
        ) : (
          <div className="flex items-center space-x-2 text-sm text-gray-500">
            <User className="h-4 w-4" />
            <span>Sem condutor atribuído</span>
          </div>
        )}

        {/* Ações */}
        <div className="pt-2 border-t">
          <Button
            variant="outline"
            size="sm"
            className="w-full"
            onClick={onViewDetails}
          >
            <Settings className="h-4 w-4 mr-2" />
            Ver Detalhes
          </Button>
        </div>
      </CardContent>
    </Card>
  );
};

// Modal de Detalhes do Veículo
interface VehicleDetailsModalProps {
  vehicle: TukTukVehicle;
  open: boolean;
  onClose: () => void;
  onStatusUpdate: (
    vehicleId: string,
    status: "operational" | "maintenance" | "out_of_service"
  ) => void;
}

const VehicleDetailsModal: React.FC<VehicleDetailsModalProps> = ({
  vehicle,
  open,
  onClose,
  onStatusUpdate,
}) => {
  const statusInfo = formatVehicleStatus(vehicle.maintenance_status);
  const vehicleInfo = vehicle.vehicle_info || {};

  return (
    <Dialog open={open} onOpenChange={onClose}>
      <DialogContent className="sm:max-w-2xl max-h-[80vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl">
            Detalhes: {vehicle.vehicle_name}
          </DialogTitle>
        </DialogHeader>

        <div className="space-y-6">
          {/* Status e Informações Básicas */}
          <div className="grid grid-cols-2 gap-4">
            <div>
              <h3 className="font-semibold mb-3">Status do Veículo</h3>
              <Badge className={`${statusInfo.color} text-sm`}>
                {statusInfo.icon} {statusInfo.label}
              </Badge>
              <div className="mt-2 space-y-1 text-sm">
                <p>Disponível: {vehicle.is_available ? "✅ Sim" : "❌ Não"}</p>
                <p>Em Uso: {vehicle.is_active ? "🔴 Sim" : "⚪ Não"}</p>
                <p>Criado: {formatRelativeTime(vehicle.created_at)}</p>
              </div>
            </div>

            <div>
              <h3 className="font-semibold mb-3">Informações Técnicas</h3>
              <div className="space-y-1 text-sm">
                <p>
                  <strong>Matrícula:</strong> {vehicle.license_plate || "N/A"}
                </p>
                <p>
                  <strong>Marca:</strong> {vehicleInfo.marca || "N/A"}
                </p>
                <p>
                  <strong>Modelo:</strong> {vehicleInfo.modelo || "N/A"}
                </p>
                <p>
                  <strong>Ano:</strong> {vehicleInfo.ano || "N/A"}
                </p>
                <p>
                  <strong>Cor:</strong> {vehicleInfo.cor || "N/A"}
                </p>
              </div>
            </div>
          </div>

          {/* Localização */}
          <div>
            <h3 className="font-semibold mb-3">Localização</h3>
            <div className="flex items-center space-x-4">
              <div className="flex items-center space-x-2">
                <MapPin className="h-4 w-4 text-gray-500" />
                <span>
                  <strong>Região:</strong> {vehicle.region}
                </span>
              </div>
              {vehicle.zone && (
                <div>
                  <span>
                    <strong>Zona:</strong> {vehicle.zone}
                  </span>
                </div>
              )}
            </div>
          </div>

          {/* Condutor Atual */}
          <div>
            <h3 className="font-semibold mb-3">Condutor</h3>
            {vehicle.current_conductor ? (
              <div className="flex items-center space-x-4 p-3 bg-blue-50 rounded-lg">
                <User className="h-8 w-8 text-blue-500" />
                <div>
                  <p className="font-medium">
                    {vehicle.conductor?.name || "Nome não disponível"}
                  </p>
                  <p className="text-sm text-gray-600">
                    {vehicle.conductor?.email || ""}
                  </p>
                  <p className="text-sm text-blue-600">Ativo no momento</p>
                </div>
              </div>
            ) : (
              <div className="flex items-center space-x-4 p-3 bg-gray-50 rounded-lg">
                <User className="h-8 w-8 text-gray-400" />
                <div>
                  <p className="text-gray-600">Nenhum condutor atribuído</p>
                  <p className="text-sm text-gray-500">
                    Veículo disponível para atribuição
                  </p>
                </div>
              </div>
            )}
          </div>

          {/* Ações */}
          <div>
            <h3 className="font-semibold mb-3">Ações</h3>
            <div className="flex flex-wrap gap-2">
              <Button
                variant="outline"
                onClick={() => onStatusUpdate(vehicle.id, "operational")}
                disabled={vehicle.maintenance_status === "operational"}
              >
                <CheckCircle className="h-4 w-4 mr-2" />
                Operacional
              </Button>
              <Button
                variant="outline"
                onClick={() => onStatusUpdate(vehicle.id, "maintenance")}
                disabled={vehicle.maintenance_status === "maintenance"}
              >
                <Wrench className="h-4 w-4 mr-2" />
                Manutenção
              </Button>
              <Button
                variant="outline"
                onClick={() => onStatusUpdate(vehicle.id, "out_of_service")}
                disabled={vehicle.maintenance_status === "out_of_service"}
              >
                <XCircle className="h-4 w-4 mr-2" />
                Fora de Serviço
              </Button>
            </div>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
};

export default FleetManagement;
