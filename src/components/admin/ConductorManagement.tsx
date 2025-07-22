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
import { Textarea } from "@/components/ui/textarea";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { Label } from "@/components/ui/label";
import {
  useConductors,
  useBlockConductor,
  useUnblockConductor,
  useExpelConductor,
  useAssignVehicle,
  useRemoveVehicleAssignment,
  useVehicles,
} from "@/hooks/useConductorManagement";
import {
  formatConductorStatus,
  formatRelativeTime,
  BLOCK_REASONS,
  BLOCK_DURATIONS,
} from "@/utils/conductorManagementUtils";
import type {
  ConductorFilters,
  ConductorProfile,
  BlockConductorParams,
  ExpelConductorParams,
  ConductorStatus,
  TukTukVehicle,
} from "@/types/conductor-management";
import {
  Users,
  Search,
  Filter,
  MoreVertical,
  Shield,
  UserX,
  Car,
  MapPin,
  Phone,
  Mail,
  AlertTriangle,
  CheckCircle,
} from "lucide-react";

interface ConductorManagementProps {
  region?: string;
  adminLevel: "super_admin" | "admin_regional" | "admin_local";
}

export const ConductorManagement: React.FC<ConductorManagementProps> = ({
  region,
  adminLevel,
}) => {
  const [filters, setFilters] = useState<ConductorFilters>({
    region: region ? [region] : undefined,
  });
  const [searchTerm, setSearchTerm] = useState("");
  const [selectedConductor, setSelectedConductor] =
    useState<ConductorProfile | null>(null);
  const [actionType, setActionType] = useState<
    "block" | "expel" | "assign" | null
  >(null);

  const { data: conductorsData, isLoading } = useConductors(filters, {
    page: 1,
    limit: 50,
  });
  const { data: vehiclesData } = useVehicles({
    region: region ? [region] : undefined,
    isAvailable: true,
  });

  const blockConductor = useBlockConductor();
  const unblockConductor = useUnblockConductor();
  const expelConductor = useExpelConductor();
  const assignVehicle = useAssignVehicle();
  const removeVehicle = useRemoveVehicleAssignment();

  const conductors = conductorsData?.data || [];
  const availableVehicles = vehiclesData?.data || [];

  const handleSearch = (term: string) => {
    setSearchTerm(term);
    setFilters((prev) => ({
      ...prev,
      searchTerm: term || undefined,
    }));
  };

  const handleAction = (
    conductor: ConductorProfile,
    action: "block" | "expel" | "assign"
  ) => {
    setSelectedConductor(conductor);
    setActionType(action);
  };

  const closeModal = () => {
    setSelectedConductor(null);
    setActionType(null);
  };

  if (isLoading) {
    return (
      <div className="space-y-6">
        <div className="space-y-4">
          {[...Array(5)].map((_, i) => (
            <Card key={i} className="animate-pulse">
              <CardContent className="p-6">
                <div className="flex items-center space-x-4">
                  <div className="w-12 h-12 bg-gray-200 rounded-full"></div>
                  <div className="flex-1 space-y-2">
                    <div className="h-4 bg-gray-200 rounded w-1/4"></div>
                    <div className="h-3 bg-gray-200 rounded w-1/3"></div>
                  </div>
                </div>
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
          <h2 className="text-2xl font-bold text-gray-900">
            Gestão de Condutores
          </h2>
          <p className="text-gray-600">
            {conductors.length} condutor{conductors.length !== 1 ? "es" : ""} na
            região
          </p>
        </div>

        <div className="flex gap-2">
          <div className="relative">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 h-4 w-4" />
            <Input
              placeholder="Buscar condutores..."
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
                status:
                  value === "all" ? undefined : [value as ConductorStatus],
              }))
            }
          >
            <SelectTrigger className="w-48">
              <Filter className="h-4 w-4 mr-2" />
              <SelectValue placeholder="Filtrar por status" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">Todos os status</SelectItem>
              <SelectItem value="active">Ativos</SelectItem>
              <SelectItem value="blocked">Bloqueados</SelectItem>
              <SelectItem value="expelled">Expulsos</SelectItem>
              <SelectItem value="inactive">Inativos</SelectItem>
            </SelectContent>
          </Select>
        </div>
      </div>

      {/* Lista de Condutores */}
      <div className="space-y-4">
        {conductors.map((conductor) => (
          <ConductorCard
            key={conductor.id}
            conductor={conductor}
            onAction={handleAction}
            onUnblock={() => unblockConductor.mutate(conductor.id)}
            onRemoveVehicle={() => removeVehicle.mutate(conductor.id)}
          />
        ))}

        {conductors.length === 0 && (
          <div className="text-center py-12">
            <Users className="h-12 w-12 text-gray-400 mx-auto mb-4" />
            <p className="text-gray-500 text-lg">Nenhum condutor encontrado</p>
            <p className="text-gray-400">
              {searchTerm
                ? "Tente ajustar os filtros de busca"
                : "Não há condutores cadastrados"}
            </p>
          </div>
        )}
      </div>

      {/* Modais de Ação */}
      {selectedConductor && actionType === "block" && (
        <BlockConductorModal
          conductor={selectedConductor}
          open={true}
          onClose={closeModal}
          onBlock={(params) => {
            blockConductor.mutate(params);
            closeModal();
          }}
        />
      )}

      {selectedConductor && actionType === "expel" && (
        <ExpelConductorModal
          conductor={selectedConductor}
          open={true}
          onClose={closeModal}
          onExpel={(params) => {
            expelConductor.mutate(params);
            closeModal();
          }}
        />
      )}

      {selectedConductor && actionType === "assign" && (
        <AssignVehicleModal
          conductor={selectedConductor}
          vehicles={availableVehicles}
          open={true}
          onClose={closeModal}
          onAssign={(params) => {
            assignVehicle.mutate(params);
            closeModal();
          }}
        />
      )}
    </div>
  );
};

// Componente do Card de Condutor
interface ConductorCardProps {
  conductor: ConductorProfile;
  onAction: (
    conductor: ConductorProfile,
    action: "block" | "expel" | "assign"
  ) => void;
  onUnblock: () => void;
  onRemoveVehicle: () => void;
}

const ConductorCard: React.FC<ConductorCardProps> = ({
  conductor,
  onAction,
  onUnblock,
  onRemoveVehicle,
}) => {
  const statusInfo = formatConductorStatus(conductor.status);

  return (
    <Card className="hover:shadow-md transition-shadow">
      <CardContent className="p-6">
        <div className="flex items-center justify-between">
          {/* Informações do Condutor */}
          <div className="flex items-center space-x-4">
            <div
              className={`w-12 h-12 rounded-full flex items-center justify-center ${
                conductor.status === "active"
                  ? "bg-green-100"
                  : conductor.status === "blocked"
                  ? "bg-yellow-100"
                  : conductor.status === "expelled"
                  ? "bg-red-100"
                  : "bg-gray-100"
              }`}
            >
              <Users
                className={`h-6 w-6 ${
                  conductor.status === "active"
                    ? "text-green-600"
                    : conductor.status === "blocked"
                    ? "text-yellow-600"
                    : conductor.status === "expelled"
                    ? "text-red-600"
                    : "text-gray-600"
                }`}
              />
            </div>

            <div className="flex-1">
              <div className="flex items-center space-x-3 mb-2">
                <h3 className="font-semibold text-lg">{conductor.name}</h3>
                <Badge className={statusInfo.color}>
                  {statusInfo.icon} {statusInfo.label}
                </Badge>
                {conductor.assigned_vehicle && (
                  <Badge
                    variant="secondary"
                    className="bg-blue-50 text-blue-700"
                  >
                    <Car className="h-3 w-3 mr-1" />
                    {conductor.vehicle?.vehicle_name || "Veículo"}
                  </Badge>
                )}
              </div>

              <div className="grid grid-cols-1 md:grid-cols-3 gap-4 text-sm text-gray-600">
                <div className="flex items-center space-x-2">
                  <Mail className="h-4 w-4" />
                  <span>{conductor.email}</span>
                </div>
                {conductor.whatsapp && (
                  <div className="flex items-center space-x-2">
                    <Phone className="h-4 w-4" />
                    <span>{conductor.whatsapp}</span>
                  </div>
                )}
                <div className="flex items-center space-x-2">
                  <MapPin className="h-4 w-4" />
                  <span>{conductor.region}</span>
                </div>
              </div>

              {/* Informações de Bloqueio */}
              {conductor.status === "blocked" && conductor.block_reason && (
                <div className="mt-3 p-3 bg-yellow-50 border-l-4 border-yellow-400 rounded">
                  <div className="flex items-center space-x-2">
                    <AlertTriangle className="h-4 w-4 text-yellow-600" />
                    <p className="text-sm text-yellow-800">
                      <strong>Bloqueado:</strong> {conductor.block_reason}
                    </p>
                  </div>
                  {conductor.blocked_at && (
                    <p className="text-xs text-yellow-700 mt-1">
                      {formatRelativeTime(conductor.blocked_at)}
                    </p>
                  )}
                </div>
              )}
            </div>
          </div>

          {/* Ações */}
          <div className="flex items-center space-x-2">
            {conductor.status === "active" && (
              <>
                {!conductor.assigned_vehicle ? (
                  <Button
                    variant="outline"
                    size="sm"
                    onClick={() => onAction(conductor, "assign")}
                  >
                    <Car className="h-4 w-4 mr-2" />
                    Atribuir Veículo
                  </Button>
                ) : (
                  <Button variant="outline" size="sm" onClick={onRemoveVehicle}>
                    <Car className="h-4 w-4 mr-2" />
                    Remover Veículo
                  </Button>
                )}

                <Dialog>
                  <DialogTrigger asChild>
                    <Button variant="ghost" size="sm">
                      <MoreVertical className="h-4 w-4" />
                    </Button>
                  </DialogTrigger>
                  <DialogContent className="sm:max-w-md">
                    <DialogHeader>
                      <DialogTitle>Ações do Condutor</DialogTitle>
                    </DialogHeader>
                    <div className="space-y-2">
                      <Button
                        variant="outline"
                        className="w-full justify-start text-yellow-600 hover:text-yellow-700"
                        onClick={() => onAction(conductor, "block")}
                      >
                        <Shield className="h-4 w-4 mr-2" />
                        Bloquear Temporariamente
                      </Button>
                      <Button
                        variant="outline"
                        className="w-full justify-start text-red-600 hover:text-red-700"
                        onClick={() => onAction(conductor, "expel")}
                      >
                        <UserX className="h-4 w-4 mr-2" />
                        Expulsar Permanentemente
                      </Button>
                    </div>
                  </DialogContent>
                </Dialog>
              </>
            )}

            {conductor.status === "blocked" && (
              <Button
                variant="outline"
                size="sm"
                onClick={onUnblock}
                className="text-green-600 hover:text-green-700"
              >
                <CheckCircle className="h-4 w-4 mr-2" />
                Desbloquear
              </Button>
            )}

            {conductor.status === "expelled" && (
              <Badge variant="destructive" className="text-xs">
                Expulso do Sistema
              </Badge>
            )}
          </div>
        </div>
      </CardContent>
    </Card>
  );
};

// Modal de Bloqueio
interface BlockConductorModalProps {
  conductor: ConductorProfile;
  open: boolean;
  onClose: () => void;
  onBlock: (params: BlockConductorParams) => void;
}

const BlockConductorModal: React.FC<BlockConductorModalProps> = ({
  conductor,
  open,
  onClose,
  onBlock,
}) => {
  const [reason, setReason] = useState("");
  const [duration, setDuration] = useState<
    "1day" | "3days" | "1week" | "1month" | "indefinite"
  >("1week");
  const [details, setDetails] = useState("");

  const handleSubmit = () => {
    if (!reason || !details.trim()) return;

    onBlock({
      conductorId: conductor.id,
      reason,
      duration,
      details: details.trim(),
    });
  };

  return (
    <Dialog open={open} onOpenChange={onClose}>
      <DialogContent className="sm:max-w-lg">
        <DialogHeader>
          <DialogTitle className="text-xl text-yellow-600">
            🚫 Bloquear Condutor: {conductor.name}
          </DialogTitle>
        </DialogHeader>

        <div className="space-y-6">
          <div className="p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
            <p className="text-sm text-yellow-800">
              <strong>Atenção:</strong> O condutor será temporariamente impedido
              de trabalhar e não poderá usar o sistema durante o período
              especificado.
            </p>
          </div>

          <div>
            <Label className="text-sm font-medium">Motivo do Bloqueio</Label>
            <RadioGroup
              value={reason}
              onValueChange={setReason}
              className="mt-2"
            >
              {BLOCK_REASONS.map((option) => (
                <div key={option.value} className="flex items-center space-x-2">
                  <RadioGroupItem value={option.value} id={option.value} />
                  <Label htmlFor={option.value} className="text-sm">
                    {option.label}
                  </Label>
                </div>
              ))}
            </RadioGroup>
          </div>

          <div>
            <Label htmlFor="duration" className="text-sm font-medium">
              Duração do Bloqueio
            </Label>
            <Select
              value={duration}
              onValueChange={(
                value: "1day" | "3days" | "1week" | "1month" | "indefinite"
              ) => setDuration(value)}
            >
              <SelectTrigger className="mt-2">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                {BLOCK_DURATIONS.map((option) => (
                  <SelectItem key={option.value} value={option.value}>
                    {option.label}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          <div>
            <Label htmlFor="details" className="text-sm font-medium">
              Detalhes do Motivo (Obrigatório)
            </Label>
            <Textarea
              id="details"
              value={details}
              onChange={(e) => setDetails(e.target.value)}
              placeholder="Descreva detalhadamente o motivo do bloqueio..."
              className="mt-2"
              rows={4}
            />
          </div>

          <div className="flex justify-end space-x-2">
            <Button variant="outline" onClick={onClose}>
              Cancelar
            </Button>
            <Button
              onClick={handleSubmit}
              disabled={!reason || !details.trim()}
              className="bg-yellow-600 hover:bg-yellow-700"
            >
              Confirmar Bloqueio
            </Button>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
};

// Modal de Expulsão
interface ExpelConductorModalProps {
  conductor: ConductorProfile;
  open: boolean;
  onClose: () => void;
  onExpel: (params: ExpelConductorParams) => void;
}

const ExpelConductorModal: React.FC<ExpelConductorModalProps> = ({
  conductor,
  open,
  onClose,
  onExpel,
}) => {
  const [reason, setReason] = useState("");
  const [details, setDetails] = useState("");

  const handleSubmit = () => {
    if (!reason || !details.trim()) return;

    onExpel({
      conductorId: conductor.id,
      reason,
      details: details.trim(),
    });
  };

  return (
    <Dialog open={open} onOpenChange={onClose}>
      <DialogContent className="sm:max-w-lg">
        <DialogHeader>
          <DialogTitle className="text-xl text-red-600">
            ⛔ Expulsar Condutor: {conductor.name}
          </DialogTitle>
        </DialogHeader>

        <div className="space-y-6">
          <div className="p-4 bg-red-50 border border-red-200 rounded-lg">
            <p className="text-sm text-red-800">
              <strong>ATENÇÃO:</strong> Esta ação é <strong>PERMANENTE</strong>.
              O condutor será expulso do sistema e não poderá mais trabalhar. O
              veículo atribuído será automaticamente liberado.
            </p>
          </div>

          <div>
            <Label className="text-sm font-medium">Motivo da Expulsão</Label>
            <RadioGroup
              value={reason}
              onValueChange={setReason}
              className="mt-2"
            >
              {BLOCK_REASONS.map((option) => (
                <div key={option.value} className="flex items-center space-x-2">
                  <RadioGroupItem
                    value={option.value}
                    id={`expel-${option.value}`}
                  />
                  <Label htmlFor={`expel-${option.value}`} className="text-sm">
                    {option.label}
                  </Label>
                </div>
              ))}
            </RadioGroup>
          </div>

          <div>
            <Label htmlFor="expel-details" className="text-sm font-medium">
              Detalhes da Expulsão (Obrigatório)
            </Label>
            <Textarea
              id="expel-details"
              value={details}
              onChange={(e) => setDetails(e.target.value)}
              placeholder="Descreva detalhadamente o motivo da expulsão..."
              className="mt-2"
              rows={4}
            />
          </div>

          <div className="flex justify-end space-x-2">
            <Button variant="outline" onClick={onClose}>
              Cancelar
            </Button>
            <Button
              onClick={handleSubmit}
              disabled={!reason || !details.trim()}
              variant="destructive"
            >
              Confirmar Expulsão
            </Button>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
};

// Modal de Atribuição de Veículo
interface AssignVehicleModalProps {
  conductor: ConductorProfile;
  vehicles: TukTukVehicle[];
  open: boolean;
  onClose: () => void;
  onAssign: (params: { conductorId: string; vehicleId: string }) => void;
}

const AssignVehicleModal: React.FC<AssignVehicleModalProps> = ({
  conductor,
  vehicles,
  open,
  onClose,
  onAssign,
}) => {
  const [selectedVehicleId, setSelectedVehicleId] = useState("");

  const handleSubmit = () => {
    if (!selectedVehicleId) return;

    onAssign({
      conductorId: conductor.id,
      vehicleId: selectedVehicleId,
    });
  };

  return (
    <Dialog open={open} onOpenChange={onClose}>
      <DialogContent className="sm:max-w-lg">
        <DialogHeader>
          <DialogTitle className="text-xl">
            🚗 Atribuir Veículo: {conductor.name}
          </DialogTitle>
        </DialogHeader>

        <div className="space-y-6">
          <div>
            <Label className="text-sm font-medium">
              Selecionar Veículo Disponível
            </Label>
            <Select
              value={selectedVehicleId}
              onValueChange={setSelectedVehicleId}
            >
              <SelectTrigger className="mt-2">
                <SelectValue placeholder="Escolher veículo..." />
              </SelectTrigger>
              <SelectContent>
                {vehicles.map((vehicle) => (
                  <SelectItem key={vehicle.id} value={vehicle.id}>
                    <div className="flex items-center space-x-2">
                      <span>{vehicle.vehicle_name}</span>
                      <span className="text-gray-500">
                        ({vehicle.license_plate})
                      </span>
                      <span className="text-xs text-blue-600">
                        {vehicle.zone}
                      </span>
                    </div>
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          {vehicles.length === 0 && (
            <div className="p-4 bg-gray-50 border border-gray-200 rounded-lg">
              <p className="text-sm text-gray-600">
                Não há veículos disponíveis no momento. Verifique se existem
                veículos operacionais sem condutor atribuído.
              </p>
            </div>
          )}

          <div className="flex justify-end space-x-2">
            <Button variant="outline" onClick={onClose}>
              Cancelar
            </Button>
            <Button onClick={handleSubmit} disabled={!selectedVehicleId}>
              Atribuir Veículo
            </Button>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
};

export default ConductorManagement;
