import React, { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { supabase } from "../lib/supabase";
import {
  updateDriverTrackingStatus,
  getDriverTrackingStatus,
  updateConductorLocation,
} from "@/services/supabaseService";
import { useToast } from "@/components/ui/use-toast";

interface ToggleConductorTrackingButtonProps {
  conductorId: string;
}

const ToggleConductorTrackingButton: React.FC<
  ToggleConductorTrackingButtonProps
> = ({ conductorId }) => {
  const [isTracking, setIsTracking] = useState(false);
  const [loading, setLoading] = useState(false);
  const [watchId, setWatchId] = useState<number | null>(null);
  const { toast } = useToast();

  console.log(`🚗 TrackingButton inicializado para condutor: ${conductorId}`);

  // Verificar status inicial
  useEffect(() => {
    const checkStatus = async () => {
      if (!conductorId) {
        console.log("⚠️ Nenhum conductorId fornecido");
        return;
      }

      try {
        console.log(
          `🔍 Verificando status inicial do condutor: ${conductorId}`
        );
        const trackingStatus = await getDriverTrackingStatus(conductorId);
        console.log(
          `📊 Status inicial: ${trackingStatus ? "ATIVO" : "INATIVO"}`
        );
        setIsTracking(trackingStatus);
      } catch (error) {
        console.error("❌ Erro ao verificar status inicial:", error);
      }
    };

    checkStatus();
  }, [conductorId]);

  const startTracking = async () => {
    setLoading(true);
    console.log(`▶️ Iniciando tracking para condutor: ${conductorId}`);

    try {
      // 1. Verificar geolocalização
      if (!navigator.geolocation) {
        throw new Error("Geolocalização não suportada neste navegador");
      }

      // 2. Atualizar status na base de dados
      await updateDriverTrackingStatus(conductorId, true);

      // 3. Iniciar monitoramento de localização
      const id = navigator.geolocation.watchPosition(
        async (position) => {
          const { latitude, longitude } = position.coords;
          console.log(`📍 Nova localização: ${latitude}, ${longitude}`);

          try {
            await updateConductorLocation(conductorId, latitude, longitude);
          } catch (error) {
            console.error("Erro ao atualizar localização:", error);
          }
        },
        (error) => {
          console.error("Erro de geolocalização:", error);
          toast({
            title: "Erro de Localização",
            description: "Verifique as permissões do navegador",
            variant: "destructive",
          });
        },
        {
          enableHighAccuracy: true,
          timeout: 10000,
          maximumAge: 30000,
        }
      );

      setWatchId(id);
      setIsTracking(true);

      toast({
        title: "Tracking Ativo",
        description: "TukTuk está agora visível no mapa",
      });
    } catch (error) {
      console.error("❌ Erro ao iniciar tracking:", error);
      toast({
        title: "Erro ao Iniciar",
        description:
          error instanceof Error ? error.message : "Erro desconhecido",
        variant: "destructive",
      });
    } finally {
      setLoading(false);
    }
  };

  const stopTracking = async () => {
    setLoading(true);
    console.log(`🛑 Parando tracking para condutor: ${conductorId}`);

    try {
      // 1. Parar geolocalização
      if (watchId !== null) {
        console.log(`🔴 Parando watchPosition ID: ${watchId}`);
        navigator.geolocation.clearWatch(watchId);
        setWatchId(null);
      }

      // 2. Atualizar status na base de dados
      await updateDriverTrackingStatus(conductorId, false);

      setIsTracking(false);

      toast({
        title: "Tracking Desativo",
        description: "TukTuk não está mais visível no mapa",
      });
    } catch (error) {
      console.error("❌ Erro ao parar tracking:", error);
      toast({
        title: "Erro ao Parar",
        description:
          error instanceof Error ? error.message : "Erro desconhecido",
        variant: "destructive",
      });

      // Mesmo com erro, limpar estado local
      setIsTracking(false);
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
        <h3 className="text-lg font-semibold text-gray-800 mb-2">
          🎛️ Controlo de Rastreamento
        </h3>
        <p className="text-sm text-gray-600">
          {isTracking ? "🟢 TukTuk visível no mapa" : "🔴 TukTuk offline"}
        </p>
      </div>

      <Button
        onClick={isTracking ? stopTracking : startTracking}
        disabled={loading}
        className={`px-8 py-3 text-lg font-semibold ${
          isTracking
            ? "bg-red-500 hover:bg-red-600 text-white"
            : "bg-green-500 hover:bg-green-600 text-white"
        }`}
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

      {/* Debug info em desenvolvimento */}
      {import.meta.env.DEV && (
        <div className="text-xs text-gray-400 text-center">
          <p>Debug: conductorId = {conductorId}</p>
          <p>WatchID: {watchId || "null"}</p>
        </div>
      )}
    </div>
  );
};

export default ToggleConductorTrackingButton;
