import React, { useRef, useEffect } from "react";
import { useTranslation } from "react-i18next";
import { MapContainer, TileLayer, Marker, Popup } from "react-leaflet";
import L from "leaflet";
import { useActiveConductors } from "../hooks/useActiveConductors";
import { useGeolocation } from "../hooks/useGeolocation";
import { LocationPermissionButton } from "./LocationPermissionButton";
import LocationBlockedMessage from "./LocationBlockedMessage";
import tukTukIcon from "../assets/tuktuk-icon.png";

// Configura o ícone do TukTuk
const TukTukIcon = new L.Icon({
  iconUrl: tukTukIcon,
  iconSize: [40, 40],
  iconAnchor: [20, 40],
  popupAnchor: [0, -40],
});

const PassengerMap = () => {
  const { t } = useTranslation();
  const mapRef = useRef<L.Map | null>(null);
  const { data: activeConductors = [], isLoading } = useActiveConductors();
  const {
    position: userPosition,
    permission,
    isSupported,
    error: geoError,
    isLoading: geoLoading,
    getLocation,
  } = useGeolocation();

  useEffect(() => {
    // Força a revalidação do tamanho do mapa após a montagem do componente.
    // Isso corrige problemas de renderização de tiles quando o container do mapa
    // tem seu tamanho definido dinamicamente por CSS (flex, grid, vh, etc).
    if (mapRef.current) {
      const timer = setTimeout(() => {
        mapRef.current?.invalidateSize();
      }, 100); // Pequeno delay para garantir que o DOM está estável
      return () => clearTimeout(timer);
    }
  }, [mapRef, activeConductors, userPosition]);

  return (
    <div className="relative h-[500px] w-full max-w-full rounded-lg bg-white shadow-md overflow-hidden">
      <MapContainer
        center={[37.725, -8.782]}
        zoom={15}
        style={{ height: "100%", width: "100%" }}
        ref={mapRef}
        scrollWheelZoom={true}
        zoomControl={true}
        attributionControl={true}
      >
        <TileLayer
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        />
        {activeConductors
          .filter(
            (c) =>
              typeof c.latitude === "number" &&
              typeof c.longitude === "number" &&
              !isNaN(c.latitude) &&
              !isNaN(c.longitude)
          )
          .map((conductor) => (
            <Marker
              key={conductor.id}
              position={[conductor.latitude!, conductor.longitude!]}
              icon={TukTukIcon}
            >
              <Popup>
                <div className="text-center">
                  <h3 className="font-bold text-blue-600">{conductor.name}</h3>
                  <p className="text-sm text-gray-600">
                    {t("map.tukTukAvailable")}
                  </p>
                  <p className="text-xs text-gray-500">
                    {t("map.lastUpdate")}: {new Date().toLocaleTimeString()}
                  </p>
                </div>
              </Popup>
            </Marker>
          ))}
        {userPosition && (
          <Marker
            position={[userPosition.lat, userPosition.lng]}
            icon={L.divIcon({ className: "user-marker" })}
          />
        )}
      </MapContainer>
      {/* Componentes sobrepostos */}
      <div className="absolute top-5 left-5 z-[1000]">
        <LocationPermissionButton
          onClick={getLocation}
          isLoading={geoLoading}
          permission={permission}
        />
      </div>
      {permission === "denied" && <LocationBlockedMessage />}
      {/* Feedback visual */}
      {geoError && (
        <div className="absolute top-4 left-1/2 -translate-x-1/2 bg-yellow-100 text-yellow-800 px-4 py-2 rounded shadow z-[2000]">
          {geoError}
        </div>
      )}
      {isLoading && (
        <div className="absolute inset-0 flex flex-col items-center justify-center pointer-events-none bg-white/60 z-[2000]">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mb-2"></div>
          <p>{t("loading.tukTukLocation")}</p>
        </div>
      )}
    </div>
  );
};

export default PassengerMap;