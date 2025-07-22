import React, { useState } from "react";

/**
 * Componente de emergência para limpar cache
 * Este componente funciona mesmo quando a autenticação falha
 * e não depende do React Query ou outros hooks
 */
export const EmergencyCacheHelper: React.FC = () => {
  const [cleaning, setCleaning] = useState(false);
  const [message, setMessage] = useState<string | null>(null);

  const clearAllCache = async () => {
    try {
      setCleaning(true);
      setMessage("Limpando cache...");

      // 1. Limpar localStorage e sessionStorage imediatamente
      localStorage.clear();
      sessionStorage.clear();

      // 2. Limpar tokens de autenticação
      document.cookie =
        "sb-access-token=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
      document.cookie =
        "sb-refresh-token=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";

      // 3. Limpar cache do browser de forma assíncrona
      if ("caches" in window) {
        try {
          const names = await caches.keys();
          await Promise.all(names.map((name) => caches.delete(name)));
        } catch (e) {
          console.warn("Não foi possível limpar todos os caches:", e);
        }
      }

      setMessage("✅ Cache limpo! Redirecionando...");

      // 4. Recarregar página com parâmetro para evitar cache
      setTimeout(() => {
        window.location.href = `/login?t=${Date.now()}`;
      }, 800);
    } catch (error) {
      console.error("❌ Erro ao limpar cache:", error);
      setMessage("❌ Erro ao limpar cache. Tentando método alternativo...");

      // Método alternativo em caso de falha
      setTimeout(() => {
        try {
          localStorage.clear();
          sessionStorage.clear();
          window.location.href = `/login?forceClear=true&t=${Date.now()}`;
        } catch (e) {
          setMessage(
            "Falha completa. Por favor, feche o navegador e tente novamente."
          );
        }
      }, 1000);
    }
  };

  return (
    <div
      style={{
        position: "fixed",
        top: "50%",
        left: "50%",
        transform: "translate(-50%, -50%)",
        zIndex: 99999,
        background: "white",
        padding: "20px",
        borderRadius: "12px",
        boxShadow: "0 4px 20px rgba(0,0,0,0.3)",
        textAlign: "center",
        maxWidth: "90%",
        width: "360px",
      }}
    >
      <h2 style={{ margin: "0 0 16px", fontSize: "18px", color: "#333" }}>
        ⚠️ Problema de carregamento detectado
      </h2>
      <p style={{ margin: "0 0 20px", fontSize: "14px", color: "#666" }}>
        {message ||
          "Para resolver problemas de carregamento, é recomendado limpar o cache do navegador."}
      </p>

      {!cleaning && (
        <>
          <div
            style={{
              margin: "0 0 20px",
              fontSize: "12px",
              color: "#666",
              textAlign: "left",
              backgroundColor: "#f5f5f5",
              padding: "10px",
              borderRadius: "4px",
            }}
          >
            <div>
              <strong>Diagnóstico rápido:</strong>
            </div>
            <div>
              Cache:{" "}
              {Object.keys(localStorage).length +
                Object.keys(sessionStorage).length}{" "}
              itens
            </div>
            <div>URL: {window.location.pathname}</div>
            <div>Hora: {new Date().toLocaleTimeString()}</div>
          </div>

          <button
            onClick={clearAllCache}
            style={{
              padding: "12px 20px",
              background: "#007bff",
              color: "white",
              border: "none",
              borderRadius: "8px",
              cursor: "pointer",
              fontSize: "16px",
              fontWeight: "bold",
              width: "100%",
              transition: "background 0.2s ease",
            }}
            onMouseOver={(e) => (e.currentTarget.style.background = "#0069d9")}
            onMouseOut={(e) => (e.currentTarget.style.background = "#007bff")}
          >
            🧹 Limpar Cache e Resolver
          </button>
        </>
      )}

      {cleaning && (
        <div
          style={{
            display: "flex",
            flexDirection: "column",
            alignItems: "center",
            justifyContent: "center",
            padding: "20px 0",
          }}
        >
          <div
            style={{
              width: "40px",
              height: "40px",
              border: "3px solid rgba(0,0,0,0.1)",
              borderTop: "3px solid #007bff",
              borderRadius: "50%",
              animation: "spin 1s linear infinite",
              marginBottom: "20px",
            }}
          ></div>
          <style>{`
            @keyframes spin {
              0% { transform: rotate(0deg); }
              100% { transform: rotate(360deg); }
            }
          `}</style>
        </div>
      )}

      <p style={{ fontSize: "12px", color: "#999", marginTop: "16px" }}>
        Isto resolve problemas de carregamento e autenticação.
      </p>
    </div>
  );
};
