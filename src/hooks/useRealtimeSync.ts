import { useEffect } from "react";
import { useQueryClient } from "@tanstack/react-query";
import { supabase } from "@/lib/supabase";
import { RealtimeChannel } from "@supabase/supabase-js";

interface RealtimeListenerOptions {
  enabled?: boolean;
  tables?: string[]; // tabelas para escutar
  onUpdate?: (
    table: string,
    eventType: string,
    data: Record<string, unknown>
  ) => void;
}

/**
 * Hook para escutar mudanças em tempo real no Supabase
 * Invalida queries automaticamente quando dados mudam
 */
export const useRealtimeSync = (options: RealtimeListenerOptions = {}) => {
  const {
    enabled = true,
    tables = ["conductors", "reservations", "profiles"],
    onUpdate,
  } = options;

  const queryClient = useQueryClient();

  useEffect(() => {
    if (!enabled) return;

    const channels: RealtimeChannel[] = [];

    console.log("🔴 [Realtime] Iniciando listeners para tabelas:", tables);

    // Configurar listener para cada tabela
    tables.forEach((tableName) => {
      const channel = supabase
        .channel(`public:${tableName}`)
        .on(
          "postgres_changes",
          {
            event: "*", // INSERT, UPDATE, DELETE
            schema: "public",
            table: tableName,
          },
          async (payload) => {
            console.log(
              `🔴 [Realtime] Mudança detectada na tabela '${tableName}':`,
              payload.eventType
            );

            try {
              // Invalidar queries relacionadas à tabela
              await queryClient.invalidateQueries({
                queryKey: [tableName],
              });

              // Invalidar queries específicas baseadas na tabela
              switch (tableName) {
                case "conductors":
                  await queryClient.invalidateQueries({
                    queryKey: ["activeConductors"],
                  });
                  await queryClient.invalidateQueries({
                    queryKey: ["conductorsList"],
                  });
                  break;
                case "reservations":
                  await queryClient.invalidateQueries({
                    queryKey: ["adminReservations"],
                  });
                  await queryClient.invalidateQueries({
                    queryKey: ["conductorReservations"],
                  });
                  break;
                case "profiles":
                  await queryClient.invalidateQueries({
                    queryKey: ["userProfile"],
                  });
                  break;
              }

              console.log(
                `✅ [Realtime] Queries invalidadas para '${tableName}'`
              );

              // Callback personalizado se fornecido
              if (onUpdate) {
                onUpdate(
                  tableName,
                  payload.eventType,
                  payload.new || payload.old
                );
              }
            } catch (error) {
              console.error(
                `❌ [Realtime] Erro ao processar mudança em '${tableName}':`,
                error
              );
            }
          }
        )
        .subscribe((status) => {
          if (status === "SUBSCRIBED") {
            console.log(`✅ [Realtime] Conectado à tabela '${tableName}'`);
          } else if (status === "CHANNEL_ERROR") {
            console.error(`❌ [Realtime] Erro na conexão com '${tableName}'`);
          }
        });

      channels.push(channel);
    });

    // Cleanup
    return () => {
      console.log("🛑 [Realtime] Desconectando listeners");
      channels.forEach((channel) => {
        supabase.removeChannel(channel);
      });
    };
  }, [enabled, tables, queryClient, onUpdate]);

  return {
    // Função para forçar reconexão
    reconnect: () => {
      console.log("🔄 [Realtime] Forçando reconexão...");
      // O useEffect será retriggered
    },
  };
};
