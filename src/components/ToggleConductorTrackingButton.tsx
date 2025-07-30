import React, { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { useToast } from "@/components/ui/use-toast";
import { supabase } from "../lib/supabase";
import {
  updateDriverTrackingStatus,
  getDriverTrackingStatus,
  updateConductorLocation,
} from "@/services/supabaseService";

interface ToggleConductorTrackingButtonProps {
  conductorId: string;
}

const ToggleConductorTrackingButton: React.FC<ToggleConductorTrackingButtonProps> = ({ conductorId }) => {
  // Estado inicial lido do localStorage
  const [isTracking, setIsTracking] = useState(() => {
    const local = localStorage.getItem("isTrackingEnabled");
    return local === "true";
  });
  const [loading, setLoading] = useState(false);
  const [watchId, setWatchId] = useState<number | null>(null);
  const { toast } = useToast();

  useEffect(() => {
    if (!conductorId) return;
    (async () => {
      try {
        const trackingStatus = await getDriverTrackingStatus(conductorId);
        setIsTracking(trackingStatus);
        localStorage.setItem("isTrackingEnabled", String(trackingStatus));
      } catch (error) {
        console.error("Erro ao verificar status inicial:", error);
      }
    })();
  }, [conductorId]);

  useEffect(() => {
    localStorage.setItem("isTrackingEnabled", String(isTracking));
  }, [isTracking]);

  const mostrarToastErro = (titulo: string, descricao: string) =>
    toast({ title: titulo, description: descricao, variant: "destructive" });

  const mostrarToastSucesso = (titulo: string, descricao: string) =>
    toast({ title: titulo, description: descricao });

  const iniciarGeolocalizacao = () => {
    return navigator.geolocation.watchPosition(
      async ({ coords: { latitude, longitude } }) => {
        try {
          await updateConductorLocation(conductorId, latitude, longitude);
        } catch (error) {
          console.error("Erro ao atualizar localização:", error);
        }
      },
      (error) => {
        console.error("Erro de geolocalização:", error);
        mostrarToastErro("Erro de Localização", "Verifique as permissões do navegador");
      },
      {
        enableHighAccuracy: true,
        timeout: 10000,
        maximumAge: 30000,
      }
    );
  };

  const startTracking = async () => {
    if (!navigator.geolocation) {
      mostrarToastErro("Erro", "Geolocalização não suportada");
      return;
    }

    setLoading(true);
    try {
      await updateDriverTrackingStatus(conductorId, true);
      const id = iniciarGeolocalizacao();
      setWatchId(id);
      setIsTracking(true);
      localStorage.setItem("isTrackingEnabled", "true");
      mostrarToastSucesso("Tracking Ativo", "TukTuk está agora visível no mapa");
    } catch (error) {
      console.error("Erro ao iniciar tracking:", error);
      mostrarToastErro("Erro ao Iniciar", error instanceof Error ? error.message : "Erro desconhecido");
    } finally {
      setLoading(false);
    }
  };

  const stopTracking = async () => {
    setLoading(true);
    try {
      if (watchId !== null) {
        navigator.geolocation.clearWatch(watchId);
        setWatchId(null);
      }

      await updateDriverTrackingStatus(conductorId, false);
      setIsTracking(false);
      localStorage.setItem("isTrackingEnabled", "false");

      mostrarToastSucesso("Tracking Desativo", "TukTuk não está mais visível no mapa");
    } catch (error) {
      console.error("Erro ao parar tracking:", error);
      mostrarToastErro("Erro ao Parar", error instanceof Error ? error.message : "Erro desconhecido");

      // Mesmo com erro, limpar
      setIsTracking(false);
      localStorage.setItem("isTrackingEnabled", "false");
      if (watchId !== null) {
        navigator.geolocation.clearWatch(watchId);
      }
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="flex flex-col items-center gap-4 p-6 bg-white rounded-lg shadow-lg">
      <div className="text-center">
        <h3 className="text-lg font-semibold text-gray-800 mb-2">🎛️ Controlo de Rastreamento</h3>
        <p className="text-sm text-gray-600">
          {isTracking ? "🟢 TukTuk visível no mapa" : "🔴 TukTuk offline"}
        </p>
      </div>

      <Button
        onClick={isTracking ? stopTracking : startTracking}
        disabled={loading}
        className={`px-8 py-3 text-lg font-semibold ${
          isTracking ? "bg-red-500 hover:bg-red-600" : "bg-green-500 hover:bg-green-600"
        } text-white`}
      >
        {loading ? (
          <div className="flex items-center gap-2">
            <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
            {isTracking ? "A parar..." : "A iniciar..."}
          </div>
        ) : (
          <div className="flex items-center gap-2">
            {isTracking ? "🛑 DESLIGAR" : "▶️ LIGAR"}
          </div>
        )}
      </Button>

      {isTracking && (
        <div className="text-xs text-green-600 bg-green-50 px-3 py-2 rounded">
          📍 Enviando localização em tempo real...
        </div>
      )}

      {import.meta.env.DEV && (
        <div className="text-xs text-gray-400 text-center">
          <p>Debug: conductorId = {conductorId}</p>
          <p>WatchID: {watchId ?? "null"}</p>
        </div>
      )}
    </div>
  );
};

export default ToggleConductorTrackingButton;
