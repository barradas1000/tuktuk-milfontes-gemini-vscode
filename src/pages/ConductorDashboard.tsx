import React, { useState, useEffect, useCallback, useRef } from "react";
import ConductorStatusToggle from "../components/ConductorStatusToggle";
import ConductorReservationsList from "../components/ConductorReservationsList";
import ConductorBlockedPeriods from "../components/ConductorBlockedPeriods";
import "../styles/ConductorDashboard.css";
import { useAuth } from "../hooks/useAuth";
import { useNavigate, useParams } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { ArrowLeft } from "lucide-react";
import { fetchConductorProfile } from "../services/conductorService";
import PassengerMap from "../components/PassengerMap";
import ToggleConductorTrackingButton from "../components/ToggleConductorTrackingButton";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { supabase } from "@/lib/supabase";

function ConductorDashboard() {
  const { profile, isAdmin, loading } = useAuth(); // Obter o estado de loading
  const navigate = useNavigate();
  const { conductorId } = useParams<{ conductorId?: string }>();
  const [targetConductorId, setTargetConductorId] = useState<string | null>(
    null
  );

  // Nova função para buscar o ID do condutor baseado no user_id
  const fetchConductorIdByUserId = async (
    userId: string
  ): Promise<string | null> => {
    console.log(`🔍 Buscando conductorId para user_id: "${userId}"`);
    try {
      const { data, error } = await supabase
        .from("conductors")
        .select("id")
        .eq("user_id", userId)
        .single();

      if (error) {
        console.error("❌ Erro na query conductors:", error);
        return null;
      }

      if (!data) {
        console.log("⚠️ Nenhum condutor encontrado para este user_id");
        return null;
      }

      console.log(`✅ Conductor encontrado - ID: "${data.id}"`);
      return data.id;
    } catch (err) {
      console.error("💥 Exceção ao buscar condutor:", err);
      return null;
    }
  };

  // Effect para determinar o targetConductorId
  useEffect(() => {
    const determineConductorId = async () => {
      console.log(`📝 ConductorDashboard: Determinando conductorId...`);
      console.log(
        `📝 ConductorDashboard: conductorId da URL: "${conductorId}"`
      );
      console.log(`📝 ConductorDashboard: profile.id: "${profile?.id}"`);

      if (conductorId) {
        // Se veio da URL, usa esse ID
        console.log(
          `✅ ConductorDashboard: Usando conductorId da URL: "${conductorId}"`
        );
        setTargetConductorId(conductorId);
      } else if (profile?.id) {
        // Busca o ID do condutor baseado no user_id (nova relação)
        console.log(
          `🔍 ConductorDashboard: Buscando conductorId por user_id: "${profile.id}"`
        );
        const conductorIdFromDB = await fetchConductorIdByUserId(profile.id);
        console.log(
          `🎯 ConductorDashboard: ConductorId encontrado na DB: "${conductorIdFromDB}"`
        );
        setTargetConductorId(conductorIdFromDB);
      } else {
        console.log(`⚠️ ConductorDashboard: Nenhum conductorId disponível`);
      }
    };

    if (!loading) {
      console.log(
        `🚀 ConductorDashboard: Profile carregado, determinando conductorId...`
      );
      determineConductorId();
    } else {
      console.log(`⏳ ConductorDashboard: Profile ainda a carregar...`);
    }
  }, [conductorId, profile?.id, loading]);

  useEffect(() => {
    console.log("ConductorDashboard: profile", profile);
    console.log("ConductorDashboard: conductorId from params", conductorId);
    console.log("ConductorDashboard: targetConductorId", targetConductorId);
  }, [profile, conductorId, targetConductorId]);

  const [conductorName, setConductorName] = React.useState("Condutor");

  React.useEffect(() => {
    const loadConductorName = async () => {
      if (targetConductorId) {
        try {
          const conductorProfile = await fetchConductorProfile(
            targetConductorId as string
          );
          if (conductorProfile) {
            setConductorName(conductorProfile.name);
          } else {
            setConductorName("Condutor Desconhecido");
          }
        } catch (error) {
          console.error("Erro ao carregar nome do condutor:", error);
          setConductorName("Condutor");
        }
      } else if (profile?.full_name) {
        setConductorName(profile.full_name);
      } else {
        setConductorName("Condutor");
      }
    };
    if (!loading) {
      // Só carrega o nome se o perfil já tiver terminado de carregar
      loadConductorName();
    }
  }, [targetConductorId, profile?.full_name, loading]); // Adicionar loading como dependência

  if (loading) {
    return (
      <div className="conductor-dashboard-container loading-state">
        <p>Carregando perfil...</p>
      </div>
    );
  }

  if (!profile) {
    return (
      <div className="conductor-dashboard-container error-state">
        <p>
          Perfil não encontrado. Por favor, inicie sessão novamente ou contacte
          o suporte.
        </p>
        <Button onClick={() => navigate("/login")}>Ir para Login</Button>
      </div>
    );
  }

  // Se o perfil existe mas não conseguiu determinar o conductor_id
  if (!targetConductorId) {
    return (
      <div className="conductor-dashboard-container error-state">
        <p>
          Não foi possível identificar o ID do condutor para este perfil. Por
          favor, verifique se o seu perfil está corretamente associado a um
          condutor ou contacte o suporte.
        </p>
        <Button onClick={() => navigate("/login")}>Ir para Login</Button>
      </div>
    );
  }

  return (
    <div className="conductor-dashboard-container">
      <header className="dashboard-header">
        {isAdmin && (
          <Button
            variant="outline"
            size="sm"
            onClick={() => navigate("/admin")}
            className="back-to-admin-button"
            title="Voltar para a Área de Administração"
          >
            <ArrowLeft className="h-4 w-4 mr-2" />
            Voltar para Admin
          </Button>
        )}
        <h2>Bem-vindo, {conductorName}!</h2>
        <p>Aqui você pode gerenciar suas reservas e disponibilidade.</p>
      </header>

      <div className="dashboard-content">
        <section className="dashboard-section status-section">
          {targetConductorId && (
            <ConductorStatusToggle conductorId={targetConductorId as string} />
          )}
        </section>

        <section className="dashboard-section reservations-section">
          {targetConductorId && (
            <ConductorReservationsList
              conductorId={targetConductorId as string}
            />
          )}
        </section>

        <section className="dashboard-section blocked-periods-section">
          {targetConductorId && (
            <ConductorBlockedPeriods
              conductorId={targetConductorId as string}
            />
          )}
        </section>

        <div className="lg:col-span-2">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                🗺️ Mapa em Tempo Real
              </CardTitle>
            </CardHeader>
            <CardContent>
              <PassengerMap />
            </CardContent>
          </Card>
        </div>

        <div className="lg:col-span-1">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                🎛️ Controlo de Localização
              </CardTitle>
            </CardHeader>
            <CardContent>
              {targetConductorId ? (
                <>
                  {console.log(
                    `🎛️ Renderizando ToggleConductorTrackingButton com conductorId: "${targetConductorId}"`
                  )}
                  <ToggleConductorTrackingButton
                    conductorId={targetConductorId as string}
                  />
                </>
              ) : (
                <div className="text-center text-gray-500">
                  Não foi possível carregar os controlos de rastreamento.
                </div>
              )}
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  );
}

export default ConductorDashboard;
