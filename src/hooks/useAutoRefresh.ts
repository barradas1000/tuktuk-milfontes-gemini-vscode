import { useEffect, useRef } from "react";
import { useQueryClient } from "@tanstack/react-query";

interface AutoRefreshOptions {
  enabled?: boolean;
  interval?: number; // em milissegundos
  queryKeys?: string[]; // queries específicas para invalidar
}

/**
 * Hook para auto-refresh inteligente de queries
 * Invalida queries automaticamente em intervalos regulares
 */
export const useAutoRefresh = (options: AutoRefreshOptions = {}) => {
  const {
    enabled = true,
    interval = 30000, // 30 segundos por padrão
    queryKeys = [], // se vazio, invalida todas as queries
  } = options;

  const queryClient = useQueryClient();
  const intervalRef = useRef<NodeJS.Timeout | null>(null);

  useEffect(() => {
    if (!enabled) return;

    console.log(
      "🔄 [AutoRefresh] Iniciando auto-refresh com intervalo de",
      interval / 1000,
      "segundos"
    );

    const invalidateQueries = async () => {
      try {
        if (queryKeys.length > 0) {
          // Invalidar queries específicas
          for (const key of queryKeys) {
            await queryClient.invalidateQueries({ queryKey: [key] });
            console.log(`🔄 [AutoRefresh] Query '${key}' invalidada`);
          }
        } else {
          // Invalidar todas as queries relacionadas aos dados principais
          const mainQueries = [
            "conductors",
            "activeConductors",
            "reservations",
            "profiles",
          ];
          for (const key of mainQueries) {
            await queryClient.invalidateQueries({ queryKey: [key] });
          }
          console.log("🔄 [AutoRefresh] Queries principais invalidadas");
        }
      } catch (error) {
        console.error("❌ [AutoRefresh] Erro ao invalidar queries:", error);
      }
    };

    // Invalidar imediatamente se habilitado
    invalidateQueries();

    // Configurar intervalo
    intervalRef.current = setInterval(invalidateQueries, interval);

    return () => {
      if (intervalRef.current) {
        clearInterval(intervalRef.current);
        console.log("🛑 [AutoRefresh] Auto-refresh desabilitado");
      }
    };
  }, [enabled, interval, queryKeys, queryClient]);

  // Função para invalidar manualmente
  const invalidateNow = async () => {
    if (queryKeys.length > 0) {
      for (const key of queryKeys) {
        await queryClient.invalidateQueries({ queryKey: [key] });
      }
    } else {
      await queryClient.invalidateQueries();
    }
    console.log("🔄 [AutoRefresh] Invalidação manual executada");
  };

  return { invalidateNow };
};
