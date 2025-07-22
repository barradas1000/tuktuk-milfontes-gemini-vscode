import React, { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { supabase } from "../lib/supabase";
import { useToast } from "@/components/ui/use-toast";

interface SimpleTrackingButtonProps {
  conductorId: string;
}

const SimpleTrackingButton: React.FC<SimpleTrackingButtonProps> = ({
  conductorId,
}) => {
  const [isTracking, setIsTracking] = useState(false);
  const [loading, setLoading] = useState(false);
  const [watchId, setWatchId] = useState<number | null>(null);
  const { toast } = useToast();

  // Verificar status inicial
  useEffect(() => {
    const checkStatus = async () => {
      if (!conductorId) return;

      try {
        const { data, error } = await supabase
          .from("conductors")
          .select("is_active")
          .eq("id", conductorId)
          .single();

        if (!error && data) {
          setIsTracking(data.is_active || false);
        }
      } catch (error) {
        console.error("Erro ao verificar status:", error);
      }
    };

    checkStatus();
  }, [conductorId]);

  const startTracking = async () => {
    setLoading(true);

    try {
      // 1. Atualizar status na base de dados
      const { error: updateError } = await supabase
        .from("conductors")
        .update({ is_active: true })
        .eq("id", conductorId);

      if (updateError) {
        throw new Error(`Erro ao ativar tracking: ${updateError.message}`);
      }

      // 2. Iniciar geolocalização
      if (!navigator.geolocation) {
        throw new Error("Geolocalização não suportada");
      }

      const id = navigator.geolocation.watchPosition(
        async (position) => {
          const { latitude, longitude } = position.coords;

          // Atualizar localização em tempo real
          await supabase
            .from("conductors")
            .update({ latitude, longitude })
            .eq("id", conductorId);

          // Opcional: Salvar no histórico
          await supabase.from("conductor_locations").insert({
            conductor_id: conductorId,
            latitude,
            longitude,
            accuracy: position.coords.accuracy || 0,
          });
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
        variant: "default",
      });
    } catch (error) {
      console.error("Erro ao iniciar tracking:", error);
      toast({
        title: "Erro",
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

    try {
      // 1. Parar geolocalização
      if (watchId !== null) {
        navigator.geolocation.clearWatch(watchId);
        setWatchId(null);
      }

      // 2. Atualizar status na base de dados
      const { error } = await supabase
        .from("conductors")
        .update({ is_active: false })
        .eq("id", conductorId);

      if (error) {
        throw new Error(`Erro ao desativar tracking: ${error.message}`);
      }

      setIsTracking(false);

      toast({
        title: "Tracking Desativo",
        description: "TukTuk não está mais visível no mapa",
        variant: "default",
      });
    } catch (error) {
      console.error("Erro ao parar tracking:", error);
      toast({
        title: "Erro",
        description:
          error instanceof Error ? error.message : "Erro desconhecido",
        variant: "destructive",
      });
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
    </div>
  );
};

export default SimpleTrackingButton;
