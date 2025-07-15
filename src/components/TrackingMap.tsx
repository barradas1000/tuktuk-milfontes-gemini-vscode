import React, { useEffect, useRef } from "react";
import L from "leaflet";
import { useGeolocation } from "../hooks/useGeolocation";
import { Coordinates } from "../utils/locationUtils";
import userIconUrl from "../assets/user-icon.png";
import { MapContainer, TileLayer, useMap } from "react-leaflet";

interface TrackingMapProps {
  onPositionChange?: (position: Coordinates) => void;
  onError?: (error: string) => void;
  autoCenter?: boolean;
  showAccuracy?: boolean;
}

const UserLocationMarker: React.FC<TrackingMapProps> = ({
  onPositionChange,
  onError,
  autoCenter = true,
  showAccuracy = true,
}) => {
  const map = useMap();
  const { position, error, isLoading } = useGeolocation();
  const markerRef = useRef<L.Marker | null>(null);
  const accuracyCircleRef = useRef<L.Circle | null>(null);

  const createUserIcon = (): L.Icon => {
    return L.icon({
      iconUrl: userIconUrl,
      iconSize: [40, 40],
      iconAnchor: [20, 20],
      popupAnchor: [0, -20],
    });
  };

  const addMarkerToMap = (lat: number, lng: number, accuracy?: number) => {
    if (markerRef.current) {
      map.removeLayer(markerRef.current);
    }
    if (accuracyCircleRef.current) {
      map.removeLayer(accuracyCircleRef.current);
    }

    const icon = createUserIcon();
    markerRef.current = L.marker([lat, lng], { icon }).addTo(map);

    markerRef.current.bindPopup(`
      <div class="user-location-popup">
        <h4>📍 Você está aqui!</h4>
        <p>Latitude: ${lat.toFixed(6)}</p>
        <p>Longitude: ${lng.toFixed(6)}</p>
        ${accuracy ? `<p>Precisão: ±${Math.round(accuracy)}m</p>` : ""}
      </div>
    `);

    if (showAccuracy && accuracy) {
      accuracyCircleRef.current = L.circle([lat, lng], {
        radius: accuracy,
        color: "#4facfe",
        fillColor: "#4facfe",
        fillOpacity: 0.1,
        weight: 1,
      }).addTo(map);
    }

    if (autoCenter) {
      map.setView([lat, lng], map.getZoom());
    }

    onPositionChange?.({ lat, lng });
  };

  useEffect(() => {
    if (position) {
      const { latitude, longitude, accuracy } = position.coords;
      addMarkerToMap(latitude, longitude, accuracy);
    }
  }, [position, map, autoCenter, showAccuracy, onPositionChange]);

  useEffect(() => {
    if (error) {
      onError?.(error);
    }
  }, [error, onError]);

  useEffect(() => {
    return () => {
      if (markerRef.current) {
        map.removeLayer(markerRef.current);
      }
      if (accuracyCircleRef.current) {
        map.removeLayer(accuracyCircleRef.current);
      }
    };
  }, [map]);

  return null;
};

const TrackingMap: React.FC<TrackingMapProps> = (props) => {
  const defaultPosition: [number, number] = [37.7749, -122.4194]; // Posição padrão (ex: São Francisco)

  return (
    <MapContainer center={defaultPosition} zoom={13} style={{ height: "100vh", width: "100%" }}>
      <TileLayer
        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
      />
      <UserLocationMarker {...props} />
    </MapContainer>
  );
};

export default TrackingMap;