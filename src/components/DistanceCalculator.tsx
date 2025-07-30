import React, { useEffect, useState } from "react";
import {
  Coordinates,
  calculateDistanceAndTime,
  formatDistance,
  formatEstimatedTime,
} from "../utils/locationUtils";

interface DistanceCalculatorProps {
  userPosition: Coordinates | null;
  tuktukPosition: Coordinates | null;
  className?: string;
  showDetails?: boolean;
  updateInterval?: number;
}

export const DistanceCalculator: React.FC<DistanceCalculatorProps> = ({
  userPosition,
  tuktukPosition,
  className = "",
  showDetails = true,
  updateInterval = 5000,
}) => {
  const [distanceInfo, setDistanceInfo] = useState<{
    distance: number;
    distanceKm: number;
    estimatedTime: number;
  } | null>(null);

  const [isNearby, setIsNearby] = useState(false);

  // Função reutilizável para mostrar mensagens de status
  const renderStatusMessage = (icon: string, message: string, classNameExtra = "") => (
    <div className={`distance-calculator ${className}`}>
      <div className={`distance-status ${classNameExtra}`}>
        <span className="status-icon">{icon}</span>
        <span className="status-text">{message}</span>
      </div>
    </div>
  );

  // Cálculo de distância e tempo
  const calculateDistance = () => {
    if (!userPosition || !tuktukPosition) {
      setDistanceInfo(null);
      setIsNearby(false);
      return;
    }

    const result = calculateDistanceAndTime(userPosition, tuktukPosition);
    setDistanceInfo(result);
    setIsNearby(result.distance <= 100); // menos de 100 metros
  };

  // Atualiza o cálculo periodicamente
  useEffect(() => {
    calculateDistance();
    const interval = setInterval(calculateDistance, updateInterval);
    return () => clearInterval(interval);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [userPosition, tuktukPosition, updateInterval]);

  // Notificação do navegador se estiver próximo
  useEffect(() => {
    if (
      isNearby &&
      userPosition &&
      tuktukPosition &&
      "Notification" in window &&
      Notification.permission === "granted"
    ) {
      new Notification("🚖 Seu tuk-tuk chegou!", {
        body: "O tuk-tuk está a menos de 100m de você!",
        icon: "/favicon.ico",
        tag: "tuktuk-nearby",
      });
    }
  }, [isNearby, userPosition, tuktukPosition]);

  // Verificações iniciais
  if (!userPosition) return renderStatusMessage("📍", "Aguardando localização...");
  if (!tuktukPosition) return renderStatusMessage("🛺", "Nenhum tuk-tuk está online no momento.", "text-red-600 font-semibold");
  if (!distanceInfo) return renderStatusMessage("⚠️", "Erro ao calcular distância");

  return (
    <div className={`distance-calculator ${isNearby ? "nearby" : ""} ${className}`}>
      <div className="distance-main">
        <div className="distance-icon">{isNearby ? "🚖" : "📍"}</div>
        <div className="distance-info">
          <div className="distance-value">
            {formatDistance(distanceInfo.distance)}
          </div>
          <div className="distance-label">
            {isNearby ? "Tuk-tuk próximo!" : "Distância até o tuk-tuk"}
          </div>
        </div>
      </div>

      {showDetails && (
        <div className="distance-details">
          <div className="detail-item">
            <span className="detail-label">Tempo estimado:</span>
            <span className="detail-value">
              {formatEstimatedTime(distanceInfo.estimatedTime)}
            </span>
          </div>
          <div className="detail-item">
            <span className="detail-label">Velocidade média:</span>
            <span className="detail-value">30 km/h</span>
          </div>
        </div>
      )}

      {/* CSS no estilo inline JSX */}
      <style>{`
        .distance-calculator {
          background: white;
          border-radius: 12px;
          padding: 1rem;
          box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
          border: 2px solid transparent;
          transition: all 0.3s ease;
          max-width: 300px;
        }

        .distance-calculator.nearby {
          border-color: #28a745;
          background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
          animation: pulse-green 2s infinite;
        }

        .distance-main {
          display: flex;
          align-items: center;
          gap: 1rem;
          margin-bottom: 0.5rem;
        }

        .distance-icon {
          font-size: 2rem;
          animation: bounce 2s infinite;
        }

        .distance-info {
          flex: 1;
        }

        .distance-value {
          font-size: 1.5rem;
          font-weight: bold;
          color: #333;
          line-height: 1;
        }

        .distance-label {
          font-size: 0.85rem;
          color: #666;
          margin-top: 0.25rem;
        }

        .distance-details {
          border-top: 1px solid #eee;
          padding-top: 0.75rem;
          margin-top: 0.75rem;
        }

        .detail-item {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 0.5rem;
        }

        .detail-item:last-child {
          margin-bottom: 0;
        }

        .detail-label {
          font-size: 0.8rem;
          color: #666;
        }

        .detail-value {
          font-size: 0.8rem;
          font-weight: 600;
          color: #333;
        }

        .distance-status {
          display: flex;
          align-items: center;
          gap: 0.5rem;
          color: #666;
        }

        .status-icon {
          font-size: 1.2rem;
        }

        .status-text {
          font-size: 0.9rem;
        }

        @keyframes bounce {
          0%, 20%, 50%, 80%, 100% {
            transform: translateY(0);
          }
          40% {
            transform: translateY(-5px);
          }
          60% {
            transform: translateY(-3px);
          }
        }

        @keyframes pulse-green {
          0% {
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.2);
          }
          50% {
            box-shadow: 0 4px 25px rgba(40, 167, 69, 0.4);
          }
          100% {
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.2);
          }
        }

        @media (max-width: 768px) {
          .distance-calculator {
            padding: 0.75rem;
            max-width: 100%;
          }

          .distance-value {
            font-size: 1.25rem;
          }

          .distance-icon {
            font-size: 1.5rem;
          }
        }
      `}</style>
    </div>
  );
};
