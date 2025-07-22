/**
 * Utilitário para gerenciar Service Worker e cache da aplicação
 */

// Adicionar ao react import
import { useState, useEffect } from "react";

// Tipos para cache status
interface CacheInfo {
  count: number;
  urls: string[];
}

interface CacheStatus {
  [cacheName: string]: CacheInfo;
}

// Registrar Service Worker
export const registerServiceWorker = async (): Promise<boolean> => {
  if ("serviceWorker" in navigator && import.meta.env.PROD) {
    try {
      console.log("📋 Registrando Service Worker...");

      const registration = await navigator.serviceWorker.register("/sw.js", {
        scope: "/",
      });

      console.log(
        "✅ Service Worker registrado com sucesso:",
        registration.scope
      );

      // Listener para atualizações
      registration.addEventListener("updatefound", () => {
        const newWorker = registration.installing;
        if (newWorker) {
          newWorker.addEventListener("statechange", () => {
            if (
              newWorker.state === "installed" &&
              navigator.serviceWorker.controller
            ) {
              console.log("🔄 Nova versão do Service Worker disponível");

              // Notificar usuário sobre atualização disponível
              if (
                window.confirm(
                  "Nova versão disponível! Deseja atualizar a página?"
                )
              ) {
                window.location.reload();
              }
            }
          });
        }
      });

      return true;
    } catch (error) {
      console.error("❌ Erro ao registrar Service Worker:", error);
      return false;
    }
  } else {
    console.log("⚠️ Service Worker não suportado ou em modo desenvolvimento");
    return false;
  }
};

// Obter status do cache
export const getCacheStatus = async (): Promise<CacheStatus | null> => {
  if ("serviceWorker" in navigator && navigator.serviceWorker.controller) {
    return new Promise((resolve) => {
      const channel = new MessageChannel();

      channel.port1.onmessage = (event) => {
        resolve(event.data);
      };

      navigator.serviceWorker.controller.postMessage(
        { type: "GET_CACHE_STATUS" },
        [channel.port2]
      );
    });
  }
  return null;
};

// Limpar cache
export const clearCache = async (): Promise<boolean> => {
  if ("serviceWorker" in navigator && navigator.serviceWorker.controller) {
    return new Promise((resolve) => {
      const channel = new MessageChannel();

      channel.port1.onmessage = (event) => {
        resolve(event.data.success);
      };

      navigator.serviceWorker.controller.postMessage({ type: "CLEAR_CACHE" }, [
        channel.port2,
      ]);
    });
  }
  return false;
};

// Verificar se está offline
export const isOnline = (): boolean => {
  return navigator.onLine;
};

// Listener para mudanças de conectividade
export const setupConnectivityListeners = () => {
  const handleOnline = () => {
    console.log("🌐 Conexão restaurada");
    // Opcional: mostrar notificação de volta online
  };

  const handleOffline = () => {
    console.log("📶 Conexão perdida - modo offline ativado");
    // Opcional: mostrar notificação de modo offline
  };

  window.addEventListener("online", handleOnline);
  window.addEventListener("offline", handleOffline);

  // Retornar função de cleanup
  return () => {
    window.removeEventListener("online", handleOnline);
    window.removeEventListener("offline", handleOffline);
  };
};

// Hook React para Service Worker
export const useServiceWorker = () => {
  const [isRegistered, setIsRegistered] = useState(false);
  const [cacheStatus, setCacheStatus] = useState<CacheStatus | null>(null);
  const [isOnlineState, setIsOnlineState] = useState(navigator.onLine);

  useEffect(() => {
    // Registrar Service Worker
    registerServiceWorker().then(setIsRegistered);

    // Setup listeners de conectividade
    const cleanup = setupConnectivityListeners();

    const handleOnlineChange = () => setIsOnlineState(navigator.onLine);
    window.addEventListener("online", handleOnlineChange);
    window.addEventListener("offline", handleOnlineChange);

    return () => {
      cleanup();
      window.removeEventListener("online", handleOnlineChange);
      window.removeEventListener("offline", handleOnlineChange);
    };
  }, []);

  const refreshCacheStatus = async () => {
    const status = await getCacheStatus();
    setCacheStatus(status);
  };

  const clearAppCache = async () => {
    const success = await clearCache();
    if (success) {
      setCacheStatus(null);
      console.log("✅ Cache limpo com sucesso");
    }
    return success;
  };

  return {
    isRegistered,
    cacheStatus,
    isOnline: isOnlineState,
    refreshCacheStatus,
    clearAppCache,
  };
};
