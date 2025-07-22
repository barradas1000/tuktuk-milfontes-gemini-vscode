import React, { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  FileText,
  User,
  MapPin,
  Car,
  Phone,
  Mail,
  CheckCircle,
  XCircle,
  Clock,
  Eye,
  Calendar,
  TrendingUp,
} from "lucide-react";
import { useCandidaturaDashboard } from "@/hooks/useCandidatura";
import InviteConductor from "./InviteConductor";
import DevCacheHelper from "@/components/DevCacheHelper";
import type { ConductorApplication } from "@/types/conductor-management";
import { format } from "date-fns";
import { pt } from "date-fns/locale";

interface CandidaturaAdminDashboardProps {
  region?: string;
  adminLevel: "super_admin" | "admin_regional" | "admin_local";
}

export const CandidaturaAdminDashboard: React.FC<
  CandidaturaAdminDashboardProps
> = ({ region, adminLevel }) => {
  const {
    applications,
    stats,
    isLoading,
    approveApplication,
    isApproving,
    error,
    refetch,
  } = useCandidaturaDashboard(region, adminLevel);

  const [selectedApplication, setSelectedApplication] =
    useState<ConductorApplication | null>(null);
  const [reviewModalOpen, setReviewModalOpen] = useState(false);
  const [adminNotes, setAdminNotes] = useState("");
  const [rejectionReason, setRejectionReason] = useState("");
  const [reviewDecision, setReviewDecision] = useState<
    "approve" | "reject" | null
  >(null);

  const getStatusBadge = (status: string) => {
    const variants = {
      submitted: "bg-blue-100 text-blue-800 border-blue-200",
      link_created: "bg-yellow-100 text-yellow-800 border-yellow-200",
      approved: "bg-green-100 text-green-800 border-green-200",
      rejected: "bg-red-100 text-red-800 border-red-200",
      expired: "bg-gray-100 text-gray-800 border-gray-200",
    };

    const labels = {
      submitted: "Submetida",
      link_created: "Link Criado",
      approved: "Aprovada",
      rejected: "Rejeitada",
      expired: "Expirada",
    };

    return (
      <Badge
        variant="outline"
        className={variants[status as keyof typeof variants] || ""}
      >
        {labels[status as keyof typeof labels] || status}
      </Badge>
    );
  };

  const handleReviewSubmit = () => {
    if (!selectedApplication || !reviewDecision) return;

    approveApplication({
      applicationId: selectedApplication.id,
      approved: reviewDecision === "approve",
      adminNotes: adminNotes || undefined,
      rejectionReason:
        reviewDecision === "reject" ? rejectionReason : undefined,
    });

    // Reset form
    setReviewModalOpen(false);
    setSelectedApplication(null);
    setAdminNotes("");
    setRejectionReason("");
    setReviewDecision(null);
  };

  const openReviewModal = (
    application: ConductorApplication,
    decision: "approve" | "reject"
  ) => {
    setSelectedApplication(application);
    setReviewDecision(decision);
    setReviewModalOpen(true);
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center p-8">
        <div className="text-center">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p>Carregando candidaturas...</p>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex items-center justify-center p-8">
        <div className="text-center">
          <XCircle className="h-12 w-12 text-red-500 mx-auto mb-4" />
          <h3 className="text-lg font-semibold text-gray-900 mb-2">
            Erro ao Carregar
          </h3>
          <p className="text-gray-600 mb-4">
            Não foi possível carregar as candidaturas.
          </p>
          <Button onClick={() => refetch()}>Tentar Novamente</Button>
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Header com Estatísticas */}
      <div>
        <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-6">
          <h2 className="text-2xl font-bold text-gray-900">
            Gestão de Candidaturas
          </h2>

          {/* Botão para convidar novo condutor */}
          <InviteConductor region={region} adminLevel={adminLevel} />
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-4 mb-6">
          <Card>
            <CardContent className="p-4 text-center">
              <FileText className="h-8 w-8 text-blue-600 mx-auto mb-2" />
              <p className="text-2xl font-bold text-gray-900">{stats.total}</p>
              <p className="text-sm text-gray-600">Total</p>
            </CardContent>
          </Card>

          <Card>
            <CardContent className="p-4 text-center">
              <Clock className="h-8 w-8 text-yellow-600 mx-auto mb-2" />
              <p className="text-2xl font-bold text-gray-900">
                {stats.pending}
              </p>
              <p className="text-sm text-gray-600">Pendentes</p>
            </CardContent>
          </Card>

          <Card>
            <CardContent className="p-4 text-center">
              <CheckCircle className="h-8 w-8 text-green-600 mx-auto mb-2" />
              <p className="text-2xl font-bold text-gray-900">
                {stats.approved}
              </p>
              <p className="text-sm text-gray-600">Aprovadas</p>
            </CardContent>
          </Card>

          <Card>
            <CardContent className="p-4 text-center">
              <XCircle className="h-8 w-8 text-red-600 mx-auto mb-2" />
              <p className="text-2xl font-bold text-gray-900">
                {stats.rejected}
              </p>
              <p className="text-sm text-gray-600">Rejeitadas</p>
            </CardContent>
          </Card>

          <Card>
            <CardContent className="p-4 text-center">
              <TrendingUp className="h-8 w-8 text-purple-600 mx-auto mb-2" />
              <p className="text-2xl font-bold text-gray-900">
                {stats.thisMonth}
              </p>
              <p className="text-sm text-gray-600">Este Mês</p>
            </CardContent>
          </Card>
        </div>
      </div>

      {/* Lista de Candidaturas */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <FileText className="h-5 w-5" />
            Candidaturas Pendentes ({applications.length})
          </CardTitle>
        </CardHeader>
        <CardContent>
          {applications.length === 0 ? (
            <div className="text-center py-8">
              <FileText className="h-12 w-12 text-gray-400 mx-auto mb-4" />
              <h3 className="text-lg font-semibold text-gray-900 mb-2">
                Nenhuma candidatura pendente
              </h3>
              <p className="text-gray-600">
                Não há candidaturas aguardando revisão no momento.
              </p>
            </div>
          ) : (
            <div className="space-y-4">
              {applications.map((application) => (
                <Card
                  key={application.id}
                  className="border-l-4 border-l-blue-500"
                >
                  <CardContent className="p-4">
                    <div className="flex items-start justify-between">
                      <div className="flex-1">
                        <div className="flex items-center gap-3 mb-2">
                          <h3 className="font-semibold text-lg">
                            {application.full_name}
                          </h3>
                          {getStatusBadge(application.status)}
                        </div>

                        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 text-sm text-gray-600">
                          <div className="flex items-center gap-2">
                            <Mail className="h-4 w-4" />
                            {application.email}
                          </div>
                          <div className="flex items-center gap-2">
                            <Phone className="h-4 w-4" />
                            {application.phone}
                          </div>
                          <div className="flex items-center gap-2">
                            <MapPin className="h-4 w-4" />
                            {application.region}
                            {application.zone && ` • ${application.zone}`}
                          </div>
                        </div>

                        {application.vehicle_info &&
                          Object.keys(application.vehicle_info).length > 0 && (
                            <div className="flex items-center gap-2 mt-2 text-sm text-gray-600">
                              <Car className="h-4 w-4" />
                              {application.vehicle_info.marca}{" "}
                              {application.vehicle_info.modelo}
                              {application.vehicle_info.ano &&
                                ` (${application.vehicle_info.ano})`}
                            </div>
                          )}

                        <div className="flex items-center gap-2 mt-2 text-sm text-gray-500">
                          <Calendar className="h-4 w-4" />
                          Submetida em{" "}
                          {format(
                            new Date(application.created_at),
                            "dd/MM/yyyy 'às' HH:mm",
                            { locale: pt }
                          )}
                        </div>
                      </div>

                      <div className="flex flex-col gap-2 ml-4">
                        <Dialog>
                          <DialogTrigger asChild>
                            <Button variant="outline" size="sm">
                              <Eye className="h-4 w-4 mr-2" />
                              Ver Detalhes
                            </Button>
                          </DialogTrigger>
                          <DialogContent className="max-w-2xl max-h-[80vh] overflow-y-auto">
                            <DialogHeader>
                              <DialogTitle>Detalhes da Candidatura</DialogTitle>
                            </DialogHeader>
                            <div className="space-y-4">
                              <div className="grid grid-cols-2 gap-4">
                                <div>
                                  <Label className="text-sm font-medium">
                                    Nome Completo
                                  </Label>
                                  <p className="text-sm">
                                    {application.full_name}
                                  </p>
                                </div>
                                <div>
                                  <Label className="text-sm font-medium">
                                    Email
                                  </Label>
                                  <p className="text-sm">{application.email}</p>
                                </div>
                                <div>
                                  <Label className="text-sm font-medium">
                                    Telemóvel
                                  </Label>
                                  <p className="text-sm">{application.phone}</p>
                                </div>
                                <div>
                                  <Label className="text-sm font-medium">
                                    WhatsApp
                                  </Label>
                                  <p className="text-sm">
                                    {application.whatsapp || "Não fornecido"}
                                  </p>
                                </div>
                                <div>
                                  <Label className="text-sm font-medium">
                                    Região
                                  </Label>
                                  <p className="text-sm">
                                    {application.region}
                                  </p>
                                </div>
                                <div>
                                  <Label className="text-sm font-medium">
                                    Zona
                                  </Label>
                                  <p className="text-sm">
                                    {application.zone || "Não especificada"}
                                  </p>
                                </div>
                              </div>

                              {application.license_number && (
                                <div>
                                  <Label className="text-sm font-medium">
                                    Carta de Condução
                                  </Label>
                                  <p className="text-sm">
                                    {application.license_number}
                                  </p>
                                </div>
                              )}

                              {application.vehicle_info && (
                                <div>
                                  <Label className="text-sm font-medium">
                                    Informações do Veículo
                                  </Label>
                                  <div className="text-sm bg-gray-50 p-3 rounded">
                                    <pre>
                                      {JSON.stringify(
                                        application.vehicle_info,
                                        null,
                                        2
                                      )}
                                    </pre>
                                  </div>
                                </div>
                              )}
                            </div>
                          </DialogContent>
                        </Dialog>

                        <Button
                          onClick={() =>
                            openReviewModal(application, "approve")
                          }
                          size="sm"
                          className="bg-green-600 hover:bg-green-700"
                          disabled={isApproving}
                        >
                          <CheckCircle className="h-4 w-4 mr-2" />
                          Aprovar
                        </Button>

                        <Button
                          onClick={() => openReviewModal(application, "reject")}
                          variant="destructive"
                          size="sm"
                          disabled={isApproving}
                        >
                          <XCircle className="h-4 w-4 mr-2" />
                          Rejeitar
                        </Button>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
        </CardContent>
      </Card>

      {/* Modal de Revisão */}
      <Dialog open={reviewModalOpen} onOpenChange={setReviewModalOpen}>
        <DialogContent className="max-h-[80vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle>
              {reviewDecision === "approve" ? "Aprovar" : "Rejeitar"}{" "}
              Candidatura
            </DialogTitle>
          </DialogHeader>

          {selectedApplication && (
            <div className="space-y-4">
              <div className="bg-gray-50 p-4 rounded-lg">
                <h4 className="font-semibold">
                  {selectedApplication.full_name}
                </h4>
                <p className="text-sm text-gray-600">
                  {selectedApplication.email}
                </p>
                <p className="text-sm text-gray-600">
                  {selectedApplication.region}
                </p>
              </div>

              <div>
                <Label htmlFor="admin-notes">Notas do Administrador</Label>
                <Textarea
                  id="admin-notes"
                  value={adminNotes}
                  onChange={(e) => setAdminNotes(e.target.value)}
                  placeholder="Adicione notas sobre esta decisão..."
                  rows={3}
                />
              </div>

              {reviewDecision === "reject" && (
                <div>
                  <Label htmlFor="rejection-reason">Motivo da Rejeição *</Label>
                  <Select
                    value={rejectionReason}
                    onValueChange={setRejectionReason}
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="Selecione o motivo" />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="incomplete">
                        Informações incompletas
                      </SelectItem>
                      <SelectItem value="requirements">
                        Não cumpre requisitos
                      </SelectItem>
                      <SelectItem value="region">
                        Região não disponível
                      </SelectItem>
                      <SelectItem value="capacity">
                        Capacidade máxima atingida
                      </SelectItem>
                      <SelectItem value="other">Outro motivo</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              )}

              <div className="flex justify-end gap-2 pt-4">
                <Button
                  variant="outline"
                  onClick={() => setReviewModalOpen(false)}
                  disabled={isApproving}
                >
                  Cancelar
                </Button>
                <Button
                  onClick={handleReviewSubmit}
                  disabled={
                    isApproving ||
                    (reviewDecision === "reject" && !rejectionReason)
                  }
                  className={
                    reviewDecision === "approve"
                      ? "bg-green-600 hover:bg-green-700"
                      : ""
                  }
                  variant={
                    reviewDecision === "reject" ? "destructive" : "default"
                  }
                >
                  {isApproving
                    ? "Processando..."
                    : reviewDecision === "approve"
                    ? "Aprovar"
                    : "Rejeitar"}
                </Button>
              </div>
            </div>
          )}
        </DialogContent>
      </Dialog>

      {/* Helper de cache para desenvolvimento */}
      <DevCacheHelper />
    </div>
  );
};

export default CandidaturaAdminDashboard;
