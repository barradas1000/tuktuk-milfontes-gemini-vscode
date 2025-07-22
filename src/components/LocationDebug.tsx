import React, { useState, useEffect } from "react";
import { useGeolocation } from "../hooks/useGeolocation";
import { Coordinates, calculateDistance } from "../utils/locationUtils";

interface LocationDebugProps {
  className?: string;
}

export const LocationDebug: React.FC<LocationDebugProps> = ({
  className = "",
}) => {
  const { position, error, permission, isLoading, isSupported } =
    useGeolocation();
  const [showDebug, setShowDebug] = useState(false);
  const [tuktukPosition] = useState<Coordinates>({ lat: 37.889, lng: -8.785 }); // 📍 CORRIGIDO: Coordenadas reais

  const calculateDistanceToTuktuk = () => {
    if (!position) return null;

    const userPos: Coordinates = {
      lat: position.coords.latitude,
      lng: position.coords.longitude,
    };

    return calculateDistance(
      userPos.lat,
      userPos.lng,
      tuktukPosition.lat,
      tuktukPosition.lng
    );
  };

  const distance = calculateDistanceToTuktuk();

  if (!showDebug) {
    return (
      <div className={`location-debug-toggle ${className}`}>
        <button
          onClick={() => setShowDebug(true)}
          className="debug-toggle-button"
          title="Mostrar informações de debug"
        >
          🐛 Debug
        </button>
      </div>
    );
  }

  return (
    <div className={`location-debug-panel ${className}`}>
      <div className="debug-header">
        <h3>🐛 Debug de Localização</h3>
        <button
          onClick={() => setShowDebug(false)}
          className="debug-close-button"
        >
          ✕
        </button>
      </div>

      <div className="debug-content">
        <div className="debug-section">
          <h4>📱 Suporte do Navegador</h4>
          <p>Geolocalização suportada: {isSupported ? "✅ Sim" : "❌ Não"}</p>
          <p>Status da permissão: {permission}</p>
          <p>Carregando: {isLoading ? "⏳ Sim" : "✅ Não"}</p>
        </div>

        <div className="debug-section">
          <h4>📍 Sua Localização</h4>
          {position ? (
            <>
              <p>Latitude: {position.coords.latitude.toFixed(6)}</p>
              <p>Longitude: {position.coords.longitude.toFixed(6)}</p>
              <p>
                Precisão:{" "}
                {position.coords.accuracy
                  ? `${Math.round(position.coords.accuracy)}m`
                  : "N/A"}
              </p>
              <p>Timestamp: {new Date(position.timestamp).toLocaleString()}</p>
            </>
          ) : (
            <p>❌ Localização não disponível</p>
          )}
        </div>

        <div className="debug-section">
          <h4>🚗 Localização do TukTuk</h4>
          <p>Latitude: {tuktukPosition.lat.toFixed(6)}</p>
          <p>Longitude: {tuktukPosition.lng.toFixed(6)}</p>
          <p>Localização: Vila Nova de Milfontes, Portugal</p>
        </div>

        <div className="debug-section">
          <h4>📏 Distância</h4>
          {distance ? (
            <>
              <p>Distância: {(distance / 1000).toFixed(1)} km</p>
              <p>Distância em metros: {Math.round(distance)}m</p>
            </>
          ) : (
            <p>❌ Não foi possível calcular a distância</p>
          )}
        </div>

        {error && (
          <div className="debug-section">
            <h4>❌ Erro</h4>
            <p>{error}</p>
          </div>
        )}

        <div className="debug-section">
          <h4>🔧 Variáveis de Ambiente</h4>
          <p>
            VITE_SUPABASE_URL:{" "}
            {import.meta.env.VITE_SUPABASE_URL
              ? "✅ Configurado"
              : "❌ Não configurado"}
          </p>
          <p>
            VITE_SUPABASE_ANON_KEY:{" "}
            {import.meta.env.VITE_SUPABASE_ANON_KEY
              ? "✅ Configurado"
              : "❌ Não configurado"}
          </p>
        </div>
      </div>

      <style>{`
        .location-debug-toggle {
          position: fixed;
          bottom: 20px;
          left: 20px;
          z-index: 1000;
        }

        .debug-toggle-button {
          background: #333;
          color: white;
          border: none;
          padding: 8px 12px;
          border-radius: 20px;
          font-size: 12px;
          cursor: pointer;
          opacity: 0.7;
          transition: opacity 0.3s;
        }

        .debug-toggle-button:hover {
          opacity: 1;
        }

        .location-debug-panel {
          position: fixed;
          bottom: 20px;
          left: 20px;
          background: white;
          border: 1px solid #ddd;
          border-radius: 8px;
          padding: 16px;
          max-width: 400px;
          max-height: 80vh;
          overflow-y: auto;
          z-index: 1001;
          box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
        }

        .debug-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 16px;
          border-bottom: 1px solid #eee;
          padding-bottom: 8px;
        }

        .debug-header h3 {
          margin: 0;
          font-size: 16px;
          color: #333;
        }

        .debug-close-button {
          background: none;
          border: none;
          font-size: 18px;
          cursor: pointer;
          color: #666;
          padding: 4px;
          border-radius: 4px;
        }

        .debug-close-button:hover {
          background: #f0f0f0;
        }

        .debug-content {
          font-size: 12px;
        }

        .debug-section {
          margin-bottom: 16px;
          padding: 12px;
          background: #f8f9fa;
          border-radius: 6px;
          border-left: 3px solid #007bff;
        }

        .debug-section h4 {
          margin: 0 0 8px 0;
          font-size: 14px;
          color: #333;
        }

        .debug-section p {
          margin: 4px 0;
          color: #666;
          font-family: monospace;
        }

        @media (max-width: 768px) {
          .location-debug-panel {
            left: 10px;
            right: 10px;
            max-width: none;
          }
        }
      `}</style>
    </div>
  );
};
