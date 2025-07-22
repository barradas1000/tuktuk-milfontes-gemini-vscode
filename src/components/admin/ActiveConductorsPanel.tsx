import React, { useState, useCallback, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Switch } from "@/components/ui/switch";
import {
  Select,
  SelectTrigger,
  SelectContent,
  SelectItem,
  SelectValue,
} from "@/components/ui/select";
import { AlertCircle, Radio, ExternalLink } from "lucide-react";
import { useAuth } from "@/hooks/useAuth";
import { useToast } from "@/components/ui/use-toast";
import { useTranslation } from "react-i18next";
import { useNavigate } from "react-router-dom";
import { useConductors } from "@/hooks/useConductors";
import ToggleTrackingButton from "../ToggleConductorTrackingButton";

// IDs dos condutores a serem excluídos da exibição
const EXCLUDED_CONDUCTOR_IDS = [
  "11111111-1111-1111-1111-111111111111", // Condutor 1
  "22222222-2222-2222-2222-222222222222", // Condutor 2
  "25158bf6-d02c-43ca-9efd-2608a32d4a60", // Motorista Teste
];

const ActiveConductorsPanel: React.FC = () => {
  const { toast } = useToast();
  const { t } = useTranslation();
  const { user } = useAuth();
  const navigate = useNavigate();

  // 🎯 SOLUÇÃO PROFISSIONAL: Hook unificado com React Query
  // ✅ Resolve: "React Query usado apenas para reservas"
  // ✅ Resolve: "Condutores chamados diretamente via fetchActiveConductors em 20+ locais"
  // ✅ Resolve: "Cache fragmentado: Alguns dados cacheados, outros não"
  // ✅ Resolve: "Estados duplicados: useState + Supabase + React Query"
  const {
    conductors, // ← Cache unificado React Query
    isLoading, // ← Estado centralizado
    error, // ← Error handling automático
    updateStatus, // ← Mutation com optimistic updates
    isUpdating, // ← Loading state da mutation
    isConductorActive, // ← Helper function cacheada
    getConductorById, // ← Query derivada cacheada
  } = useConductors(); // ← SUBSTITUIU 20+ fetchActiveConductors diretos

  const [selectedDriverId, setSelectedDriverId] = useState<string>("");

  // Debug da autenticação
  useEffect(() => {
    console.log("🔍 [ActiveConductorsPanel] Estado da autenticação:");
    console.log("   User:", user ? `${user.email} (${user.id})` : "null");
  }, [user]);

  // Função para determinar o WhatsApp responsável
  const getCurrentWhatsapp = useCallback(() => {
    const filteredConductors = conductors.filter(
      (c) => !EXCLUDED_CONDUCTOR_IDS.includes(c.id)
    );
    const currentActive = filteredConductors.filter((c) =>
      isConductorActive(c.id)
    );

    if (currentActive.length === 1) {
      return currentActive[0].whatsapp;
    }
    return filteredConductors[0]?.whatsapp || "351968784043";
  }, [conductors, isConductorActive]);

  // 🚀 FUNÇÃO MODERNA: Usando React Query mutation com optimistic updates
  // ✅ Elimina: setState manual + cache localStorage + recarregamento manual
  const handleSwitchChange = async (conductorId: string, checked: boolean) => {
    // Verificar autenticação
    if (!user) {
      toast({
        title: "Erro de Autenticação",
        description:
          "É necessário fazer login para ativar/desativar condutores.",
        variant: "destructive",
      });
      navigate("/auth");
      return;
    }

    console.log(
      `🔄 [Modern Cache] Alterando estado do condutor ${conductorId} para ${
        checked ? "ATIVO" : "INATIVO"
      }`
    );
    console.log(`👤 Usuário autenticado: ${user.email} (${user.id})`);

    try {
      // 🎯 MAGIA DO REACT QUERY:
      // - Optimistic update (UI muda instantaneamente)
      // - Auto rollback se erro
      // - Cache sync automático em toda app
      // - Zero código manual de cache
      updateStatus({
        conductorId,
        isActive: checked,
      });

      // Atualizar selectedDriverId conforme necessário
      if (checked && !selectedDriverId) {
        setSelectedDriverId(conductorId);
      } else if (!checked && selectedDriverId === conductorId) {
        const nextActive = conductors.find(
          (c) =>
            isConductorActive(c.id) && !EXCLUDED_CONDUCTOR_IDS.includes(c.id)
        );
        setSelectedDriverId(nextActive?.id || "");
      }

      toast({
        title: checked ? "Condutor ativado" : "Condutor desativado",
        description: `${getConductorById(conductorId)?.name || "Condutor"} ${
          checked ? "ativado" : "desativado"
        } com sucesso.`,
      });
    } catch (error) {
      console.error("❌ Erro ao atualizar condutor:", error);
      toast({
        title: "Erro ao atualizar condutor",
        description:
          error instanceof Error
            ? error.message
            : "Tente novamente mais tarde.",
        variant: "destructive",
      });
    }
  };

  // 🎯 ESTADO DERIVADO: Calculado automaticamente do cache React Query
  // ✅ Elimina: useState duplicado para activeConductors
  const activeConductors = conductors.filter((c) => isConductorActive(c.id));

  return (
    <div className="mb-6 p-4 bg-purple-50 border border-purple-200 rounded-xl flex flex-col gap-3 items-center shadow-md">
      <h2 className="text-lg font-bold text-purple-900 mb-2">
        {t("Condutores Ativos")}
      </h2>

      {/* Aviso de autenticação */}
      {!user && (
        <div className="w-full p-3 bg-yellow-100 border border-yellow-400 rounded-lg text-yellow-800 text-sm text-center">
          ⚠️ <strong>Atenção:</strong> É necessário fazer login para
          ativar/desativar condutores.
        </div>
      )}

      {/* Debug visual para usuário logado */}
      {user && (
        <div className="w-full p-3 bg-green-100 border border-green-400 rounded-lg text-green-800 text-sm text-center">
          ✅ <strong>Usuário logado:</strong> {user.email}
          <br />
          <small>ID: {user.id}</small>
        </div>
      )}

      {/* 🎯 ESTADOS UNIFICADOS: React Query gerencia loading/error automaticamente */}
      {isLoading ? (
        <div className="text-gray-700">Carregando condutores...</div>
      ) : error ? (
        <div className="text-red-600">
          Erro ao carregar condutores: {error.message}
        </div>
      ) : (
        <div className="flex flex-col sm:flex-row gap-4 w-full justify-center">
          {conductors
            .filter((c) => !EXCLUDED_CONDUCTOR_IDS.includes(c.id))
            .map((c) => (
              <div
                key={c.id}
                className="flex items-center gap-3 bg-white rounded-lg px-4 py-2 shadow-sm border border-gray-200"
              >
                <span className="font-semibold text-gray-800 min-w-[90px]">
                  {c.name}
                  <span className="ml-2 text-xs text-gray-500">
                    ({c.whatsapp})
                  </span>
                </span>
                <Switch
                  checked={isConductorActive(c.id)} // ← Cache React Query
                  onCheckedChange={
                    (checked) => handleSwitchChange(c.id, checked) // ← Mutation React Query
                  }
                  id={`switch-${c.id}`}
                  disabled={!user || isUpdating} // ← Estado da mutation
                />
                <span
                  className={
                    isConductorActive(c.id)
                      ? "text-green-600 font-semibold"
                      : "text-gray-400"
                  }
                >
                  {isConductorActive(c.id) ? "Ativo" : "Inativo"}
                </span>
                <Button
                  variant="outline"
                  size="sm"
                  onClick={() => navigate("/condutor/dashboard")}
                  className="ml-2"
                  title="Ir para o Painel do Condutor"
                >
                  <ExternalLink className="h-4 w-4" />
                </Button>
              </div>
            ))}
        </div>
      )}

      <div className="mt-4 text-base text-purple-900 font-semibold">
        WhatsApp responsável:{" "}
        <span className="text-purple-700">{getCurrentWhatsapp()}</span>
      </div>

      <Card className="mt-6 w-full max-w-md mx-auto bg-blue-50 border-blue-200">
        <CardHeader>
          <CardTitle className="flex items-center gap-2 text-blue-900">
            <Radio className="w-5 h-5 text-blue-600" />{" "}
            {t("Rastreamento em Tempo Real")}
          </CardTitle>
          <div className="text-gray-700 text-sm mt-1">
            {t(
              "Ative o envio da localização do TukTuk para aparecer no mapa dos passageiros."
            )}
          </div>
        </CardHeader>
        <CardContent>
          {activeConductors.length === 0 ? (
            <div className="text-red-600 font-semibold flex items-center gap-2">
              <AlertCircle className="w-5 h-5" />
              {t("Ative um condutor para habilitar o rastreamento.")}
            </div>
          ) : activeConductors.length === 1 ? (
            <>
              <div className="mb-2 text-gray-700">
                Motorista selecionado:{" "}
                <b>{activeConductors[0]?.name || "Desconhecido"}</b>
              </div>
              <ToggleTrackingButton conductorId={activeConductors[0].id} />
            </>
          ) : (
            <>
              <div className="mb-2 text-gray-700">
                {t("Selecione o motorista para rastreamento:")}
              </div>
              <Select
                value={selectedDriverId || ""}
                onValueChange={setSelectedDriverId}
              >
                <SelectTrigger className="mb-2">
                  <SelectValue placeholder={t("Escolha o motorista")} />
                </SelectTrigger>
                <SelectContent>
                  {activeConductors
                    .filter((c) => !EXCLUDED_CONDUCTOR_IDS.includes(c.id))
                    .map((c) => (
                      <SelectItem key={c.id} value={c.id}>
                        {c.name} ({c.whatsapp})
                      </SelectItem>
                    ))}
                </SelectContent>
              </Select>
              {selectedDriverId && (
                <>
                  <div className="mb-2 text-gray-700">
                    Motorista selecionado:{" "}
                    <b>
                      {getConductorById(selectedDriverId)?.name ||
                        "Desconhecido"}
                    </b>
                  </div>
                  <ToggleTrackingButton conductorId={selectedDriverId} />
                </>
              )}
            </>
          )}
        </CardContent>
      </Card>
    </div>
  );
};

export default ActiveConductorsPanel;
