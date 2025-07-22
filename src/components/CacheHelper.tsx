import React, { useState } from "react";
import { useAuth } from "@/hooks/useAuth";
import { useQueryClient } from "@tanstack/react-query";
import { useAutoRefresh } from "@/hooks/useAutoRefresh";
import { useRealtimeSync } from "@/hooks/useRealtimeSync";

export const CacheHelper: React.FC = () => {
  const { refreshProfile } = useAuth();
  const queryClient = useQueryClient();
  const [isClearing, setIsClearing] = useState(false);
  const [autoRefreshEnabled, setAutoRefreshEnabled] = useState(true);
  const [realtimeEnabled, setRealtimeEnabled] = useState(true);

  // Inicializar auto-refresh e realtime
  const { invalidateNow } = useAutoRefresh({
    enabled: autoRefreshEnabled,
    interval: 30000, // 30 segundos
  });

  useRealtimeSync({
    enabled: realtimeEnabled,
    onUpdate: (table, eventType) => {
      console.log(
        `🔴 [CacheHelper] Mudança detectada: ${table} (${eventType})`
      );
    },
  });

  const clearAllCache = async () => {
    setIsClearing(true);
    try {
      // 1. Limpar React Query cache
      queryClient.clear();

      // 2. Limpar localStorage
      localStorage.clear();

      // 3. Limpar sessionStorage
      sessionStorage.clear();

      // 4. Limpar cache do browser (service workers, etc)
      if ("caches" in window) {
        const names = await caches.keys();
        await Promise.all(names.map((name) => caches.delete(name)));
      }

      // 5. Invalidar todas as queries
      await queryClient.invalidateQueries();

      console.log("✅ [CacheHelper] Todos os caches limpos");

      // 6. Recarregar página
      setTimeout(() => {
        window.location.reload();
      }, 500);
    } catch (error) {
      console.error("❌ [CacheHelper] Erro ao limpar cache:", error);
    } finally {
      setIsClearing(false);
    }
  };

  const smartRefresh = async () => {
    try {
      // Invalidar apenas queries principais
      await invalidateNow();
      console.log("✅ [CacheHelper] Smart refresh executado");
    } catch (error) {
      console.error("❌ [CacheHelper] Erro no smart refresh:", error);
    }
  };

  return (
    <div
      style={{
        position: "fixed",
        top: 10,
        right: 10,
        background: "#f8f9fa",
        border: "2px solid #dee2e6",
        borderRadius: 12,
        padding: 16,
        fontSize: 12,
        zIndex: 9999,
        maxWidth: 320,
        boxShadow: "0 4px 12px rgba(0,0,0,0.15)",
        fontFamily: "system-ui, -apple-system, sans-serif",
      }}
    >
      <div
        style={{
          fontWeight: "bold",
          marginBottom: 12,
          fontSize: 14,
          color: "#495057",
        }}
      >
        🔧 Cache Manager
      </div>

      {/* Status dos sistemas */}
      <div
        style={{
          marginBottom: 12,
          padding: 8,
          background: "#e9ecef",
          borderRadius: 6,
        }}
      >
        <div style={{ marginBottom: 4 }}>
          <span style={{ color: autoRefreshEnabled ? "#28a745" : "#6c757d" }}>
            {autoRefreshEnabled ? "🟢" : "🔴"} Auto-Refresh (30s)
          </span>
          <button
            onClick={() => setAutoRefreshEnabled(!autoRefreshEnabled)}
            style={{
              marginLeft: 8,
              padding: "2px 6px",
              fontSize: 10,
              background: "transparent",
              border: "1px solid #6c757d",
              borderRadius: 3,
              cursor: "pointer",
            }}
          >
            {autoRefreshEnabled ? "OFF" : "ON"}
          </button>
        </div>
        <div>
          <span style={{ color: realtimeEnabled ? "#28a745" : "#6c757d" }}>
            {realtimeEnabled ? "🟢" : "🔴"} Realtime Sync
          </span>
          <button
            onClick={() => setRealtimeEnabled(!realtimeEnabled)}
            style={{
              marginLeft: 8,
              padding: "2px 6px",
              fontSize: 10,
              background: "transparent",
              border: "1px solid #6c757d",
              borderRadius: 3,
              cursor: "pointer",
            }}
          >
            {realtimeEnabled ? "OFF" : "ON"}
          </button>
        </div>
      </div>

      <div style={{ marginBottom: 12, fontSize: 11, color: "#6c757d" }}>
        Se não vir alterações da BD:
      </div>

      {/* Botão Smart Refresh */}
      <button
        onClick={smartRefresh}
        style={{
          width: "100%",
          marginBottom: 6,
          padding: "8px 12px",
          background: "#17a2b8",
          color: "white",
          border: "none",
          borderRadius: 6,
          cursor: "pointer",
          fontSize: 11,
          fontWeight: "500",
        }}
      >
        ⚡ Smart Refresh
      </button>

      {/* Botão Refresh Profile */}
      <button
        onClick={refreshProfile}
        style={{
          width: "100%",
          marginBottom: 6,
          padding: "8px 12px",
          background: "#007bff",
          color: "white",
          border: "none",
          borderRadius: 6,
          cursor: "pointer",
          fontSize: 11,
          fontWeight: "500",
        }}
      >
        🔄 Refresh Profile
      </button>

      {/* Botão Clear All Cache */}
      <button
        onClick={clearAllCache}
        disabled={isClearing}
        style={{
          width: "100%",
          marginBottom: 6,
          padding: "8px 12px",
          background: isClearing ? "#6c757d" : "#dc3545",
          color: "white",
          border: "none",
          borderRadius: 6,
          cursor: isClearing ? "not-allowed" : "pointer",
          fontSize: 11,
          fontWeight: "500",
        }}
      >
        {isClearing ? "🔄 Limpando..." : "🗑️ Clear All Cache"}
      </button>

      <div
        style={{
          fontSize: 10,
          color: "#6c757d",
          marginTop: 12,
          borderTop: "1px solid #dee2e6",
          paddingTop: 8,
        }}
      >
        💡 Dica: Use Ctrl+Shift+R para hard refresh
        <br />
        🔴 Realtime detecta mudanças automaticamente
        <br />⚡ Smart Refresh é mais rápido que Clear All
      </div>
    </div>
  );
};
