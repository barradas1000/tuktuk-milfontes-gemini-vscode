import React, { useRef, useEffect } from "react";
import { useTranslation } from "react-i18next";
import { MapContainer, TileLayer, Marker, Popup } from "react-leaflet";
import L from "leaflet";
import { useActiveConductors } from "../hooks/useActiveConductors";
import { useGeolocation } from "../hooks/useGeolocation";
import DraggableDistanceCard from "./DraggableDistanceCard";
import { LocationPermissionButton } from "./LocationPermissionButton";
import LocationBlockedMessage from "./LocationBlockedMessage";
import tukTukIcon from "../assets/tuktuk-icon.png";
import PassengerMapClean from "../components/PassengerMapClean";

const TukTukIcon = new L.Icon({
  iconUrl: tukTukIcon,
  iconSize: [40, 40],
  iconAnchor: [20, 40],
  popupAnchor: [0, -40],
});

const PassengerMap = () => {
// ...existing code...
export default TrackingWithTwoMaps;

// Exemplo de página com dois mapas de 500px
export const TrackingWithTwoMaps = () => {
  const { data: activeConductors = [] } = useActiveConductors();
  const { position: userPosition } = useGeolocation();
  return (
    <div className="flex flex-col gap-8 items-center w-full">
      <div className="w-full max-w-2xl p-4 bg-white rounded-lg shadow border border-gray-200">
        <h2 className="text-lg font-bold mb-2 text-blue-700">Mapa 1</h2>
        <PassengerMapClean userLocation={userPosition ? [userPosition.lat, userPosition.lng] : [37.725, -8.782]} conductors={activeConductors} />
      </div>
      <div className="w-full max-w-2xl p-4 bg-white rounded-lg shadow border border-gray-200">
        <h2 className="text-lg font-bold mb-2 text-blue-700">Mapa 2</h2>
        <PassengerMapClean userLocation={userPosition ? [userPosition.lat, userPosition.lng] : [37.725, -8.782]} conductors={activeConductors} />
      </div>
    </div>
  );
