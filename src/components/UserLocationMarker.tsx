import React, { useEffect, useRef, useCallback, memo } from "react";
import L from "leaflet";
import { Coordinates } from "../utils/locationUtils";
import userIconUrl from "../assets/user-icon.png";

// Cache global para o ícone do usuário para evitar recriação frequente
const userIconCache: Record<string, L.Icon> = {};

interface UserLocationMarkerProps {
  map: L.Map;
  position: Coordinates;
  accuracy?: number;
  autoCenter?: boolean;
  showAccuracy?: boolean;
  cacheKey?: string; // Chave única para ajudar no cache
}

export const UserLocationMarker: React.FC<UserLocationMarkerProps> = memo(
  ({
    map,
    position,
    accuracy,
    autoCenter = true,
    showAccuracy = true,
    cacheKey = "default",
  }) => {
    const markerRef = useRef<L.Marker | null>(null);
    const accuracyCircleRef = useRef<L.Circle | null>(null);
    const lastPositionRef = useRef<Coordinates | null>(null);

    const createUserIcon = useCallback((): L.Icon => {
      // Usar ícone em cache se já existir
      if (userIconCache[cacheKey]) {
        return userIconCache[cacheKey];
      }

      // Criar novo ícone e armazenar em cache
      const icon = L.icon({
        iconUrl: userIconUrl,
        iconSize: [40, 40],
        iconAnchor: [20, 20],
        popupAnchor: [0, -20],
      });

      userIconCache[cacheKey] = icon;
      return icon;
    }, [cacheKey]);

    const addMarkerToMap = useCallback(() => {
      // Verificar se a posição realmente mudou para evitar atualizações desnecessárias
      if (
        lastPositionRef.current &&
        lastPositionRef.current.lat === position.lat &&
        lastPositionRef.current.lng === position.lng
      ) {
        return; // Evita recriar marcadores quando não há mudança real
      }

      if (markerRef.current) {
        map.removeLayer(markerRef.current);
      }
      if (accuracyCircleRef.current) {
        map.removeLayer(accuracyCircleRef.current);
      }

      const icon = createUserIcon();
      markerRef.current = L.marker([position.lat, position.lng], {
        icon,
      }).addTo(map);

      markerRef.current.bindPopup(`
      <div class="user-location-popup">
        <h4>📍 Você está aqui!</h4>
        <p>Latitude: ${position.lat.toFixed(6)}</p>
        <p>Longitude: ${position.lng.toFixed(6)}</p>
        ${accuracy ? `<p>Precisão: ±${Math.round(accuracy)}m</p>` : ""}
      </div>
    `);

      if (showAccuracy && accuracy) {
        accuracyCircleRef.current = L.circle([position.lat, position.lng], {
          radius: accuracy,
          color: "#4facfe",
          fillColor: "#4facfe",
          fillOpacity: 0.1,
          weight: 1,
        }).addTo(map);
      }

      if (autoCenter) {
        map.setView([position.lat, position.lng], map.getZoom());
      }

      // Atualizar referência da última posição
      lastPositionRef.current = { ...position };
    }, [map, position, accuracy, autoCenter, showAccuracy, createUserIcon]);

    useEffect(() => {
      // Uso de debounce para evitar múltiplas renderizações em rápida sucessão
      const timerId = setTimeout(() => {
        addMarkerToMap();
      }, 50); // pequeno delay para evitar renderizações excessivas

      return () => clearTimeout(timerId);
    }, [addMarkerToMap]);

    // Limpar marcadores quando o componente é desmontado
    useEffect(() => {
      return () => {
        if (markerRef.current) {
          map.removeLayer(markerRef.current);
          markerRef.current = null;
        }
        if (accuracyCircleRef.current) {
          map.removeLayer(accuracyCircleRef.current);
          accuracyCircleRef.current = null;
        }
      };
    }, [map]);

    return null;
  }
);
