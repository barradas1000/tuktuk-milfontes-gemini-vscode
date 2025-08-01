import React, { useEffect, useRef, useCallback } from "react";
import L from "leaflet";
import { useGeolocation } from "../hooks/useGeolocation";
import { Coordinates } from "../utils/locationUtils";
import userIconUrl from "../assets/user-icon.png";
import { MapContainer, TileLayer, useMap } from "react-leaflet";
import "leaflet/dist/leaflet.css";

// Ícone personalizado do utilizador
const userIcon = new L.Icon({
  iconUrl: userIconUrl,
  iconSize: [40, 40],
  iconAnchor: [20, 20],
  popupAnchor: [0, -20],
});

// Props esperadas no componente
interface TrackingMapProps {
  onPositionChange?: (position: Coordinates) => void;
  onError?: (error: string) => void;
  autoCenter?: boolean;
  showAccuracy?: boolean;
}

// Componente para exibir o marcador da localização do utilizador
export const UserLocationMarker: React.FC<TrackingMapProps> = ({
  onPositionChange,
  onError,
  autoCenter = true,
  showAccuracy = true,
}) => {
  const map = useMap();
  const { position, error } = useGeolocation();
  const markerRef = useRef<L.Marker | null>(null);
  const accuracyCircleRef = useRef<L.Circle | null>(null);

  // Adiciona marcador e círculo de precisão ao mapa
  const addMarkerToMap = useCallback(
    (lat: number, lng: number, accuracy?: number) => {
      // Remove marcador e círculo anteriores
      markerRef.current?.remove();
      accuracyCircleRef.current?.remove();

      // Cria e adiciona novo marcador
      const marker = L.marker([lat, lng], { icon: userIcon }).addTo(map);
      marker.bindPopup(`
        <div class="user-location-popup">
          <h4>📍 Você está aqui!</h4>
          <p>Latitude: ${lat.toFixed(6)}</p>
          <p>Longitude: ${lng.toFixed(6)}</p>
          ${accuracy ? `<p>Precisão: ±${Math.round(accuracy)}m</p>` : ""}
        </div>
      `);
      markerRef.current = marker;

      // Adiciona círculo de precisão, se necessário
      if (showAccuracy && accuracy) {
        const circle = L.circle([lat, lng], {
          radius: accuracy,
          color: "#4facfe",
          fillColor: "#4facfe",
          fillOpacity: 0.1,
          weight: 1,
        }).addTo(map);
        accuracyCircleRef.current = circle;
      }

      // Centraliza no mapa, se autoCenter estiver ativado
      if (autoCenter) {
        map.setView([lat, lng], map.getZoom());
      }

      // Notifica componente pai
      onPositionChange?.({ lat, lng });
    },
    [map, showAccuracy, autoCenter, onPositionChange]
  );

  // Quando a posição muda
  useEffect(() => {
    if (position) {
      const { latitude, longitude, accuracy } = ((position as unknown) as GeolocationPosition).coords;
      addMarkerToMap(latitude, longitude, accuracy);
    }
  }, [position, addMarkerToMap]);

  // Quando há erro na geolocalização
  useEffect(() => {
    if (error) onError?.(error);
  }, [error, onError]);

  // Limpeza ao desmontar o componente
  useEffect(() => {
    return () => {
      markerRef.current?.remove();
      accuracyCircleRef.current?.remove();
    };
  }, []);

  return null;
};

// Inicializa o mapa com posição padrão
const MapInitializer: React.FC<{ position: [number, number]; zoom: number }> = ({ position, zoom }) => {
  const map = useMap();
  useEffect(() => {
    map.setView(position, zoom);
  }, [map, position, zoom]);
  return null;
};

// Componente principal do mapa de rastreamento
const TrackingMap: React.FC<TrackingMapProps> = (props) => {
  const defaultPosition: [number, number] = [37.7749, -122.4194]; // Posição padrão

  return (
    <MapContainer style={{ height: "100vh", width: "100%" }}>
      <TileLayer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />
      <MapInitializer position={defaultPosition} zoom={13} />
      <UserLocationMarker {...props} />
    </MapContainer>
  );
};

export default TrackingMap;
