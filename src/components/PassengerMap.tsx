import React, { useState, useRef, useEffect } from "react";
import DraggableDistanceCard from "./DraggableDistanceCard";
import { useTranslation } from "react-i18next";
import {
  MapContainer,
  TileLayer,
  Marker,
  Popup,
} from "react-leaflet";
import L from "leaflet";
import { UserLocationMarker } from "./UserLocationMarker";
import { LocationPermissionButton } from "./LocationPermissionButton";
import { LocationDebug } from "./LocationDebug";
import { useActiveConductors } from "@/hooks/useActiveConductors";
import "leaflet/dist/leaflet.css";
import tukTukIcon from "../assets/tuktuk-icon.png";
import { useGeolocation } from "@/hooks/useGeolocation";

const TukTukIcon = new L.Icon({
  iconUrl: tukTukIcon,
  iconSize: [40, 40],
  iconAnchor: [20, 40],
  popupAnchor: [0, -40],
});

const PassengerMap: React.FC = () => {
  const { position: userPosition, error: geoError, isLoading: geoLoading, permission, isSupported, getLocation } = useGeolocation();
  const { t } = useTranslation();
  const { data: activeConductors = [], isLoading, error } = useActiveConductors();
  const [distanceCardPos, setDistanceCardPos] = useState({ x: 0, y: 0 });
  const mapRef = useRef<L.Map | null>(null);
  const [hasLocated, setHasLocated] = useState(false); // controla se o usuário clicou em localizar-me


  // Centraliza o mapa na posição do usuário após clicar em localizar-me
  useEffect(() => {
    if (hasLocated && userPosition && mapRef.current) {
      mapRef.current.setView([userPosition.lat, userPosition.lng], 16, { animate: true });
    }
  }, [userPosition, hasLocated]);

  const handleLocateMe = () => {
    setHasLocated(true);
    getLocation();
  };

  const handleRecenter = () => {
    if (mapRef.current) {
      mapRef.current.setView([37.722, -8.794], 15);
    }
  };

  function getNearestConductorInfo() {
    if (!userPosition || activeConductors.length === 0) return null;
    function haversine(lat1: number, lon1: number, lat2: number, lon2: number) {
      const R = 6371;
      const dLat = ((lat2 - lat1) * Math.PI) / 180;
      const dLon = ((lon2 - lon1) * Math.PI) / 180;
      const a =
        Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos((lat1 * Math.PI) / 180) *
          Math.cos((lat2 * Math.PI) / 180) *
          Math.sin(dLon / 2) * Math.sin(dLon / 2);
      const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
      return R * c;
    }
    let minDist = Infinity;
    let nearest = null;
    for (const c of activeConductors) {
      if (
        typeof c.latitude === "number" &&
        typeof c.longitude === "number" &&
        !isNaN(c.latitude) &&
        !isNaN(c.longitude)
      ) {
        const dist = haversine(userPosition.lat, userPosition.lng, c.latitude, c.longitude);
        if (dist < minDist) {
          minDist = dist;
          nearest = c;
        }
      }
    }
    if (!nearest) return null;
    const timeHours = minDist / 20;
    const timeMinutes = Math.round(timeHours * 60);
    return { distance: minDist, timeMinutes, conductor: nearest };
  }
  const nearestInfo = getNearestConductorInfo();

  const geolocationWarning = !isSupported ? (
    <div className="absolute inset-0 flex flex-col items-center justify-center pointer-events-none z-[2000] bg-white/80">
      <div className="text-3xl mb-2">⚠️</div>
      <h3 className="text-lg font-semibold text-gray-700">
        {t("errors.geolocationNotSupported")}
      </h3>
      <p className="text-sm text-gray-500 max-w-xs">
        {t("errors.geolocationNotSupportedMessage")}
      </p>
    </div>
  ) : null;

  const errorWarning = error ? (
    <div className="absolute inset-0 flex flex-col items-center justify-center pointer-events-none z-[2000] bg-white/80">
      <div className="text-3xl mb-2">⚠️</div>
      <h3 className="text-lg font-semibold text-gray-700">
        {t("errors.mapError")}
      </h3>
      <p className="text-sm text-gray-500 max-w-xs">{error.message}</p>
    </div>
  ) : null;

  const loadingOverlay = isLoading ? (
    <div className="absolute inset-0 flex flex-col items-center justify-center pointer-events-none z-[2000] bg-white/60">
      <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mb-2"></div>
      <p>{t ? t("loading.tukTukLocation") : "Carregando localização dos TukTuks..."}</p>
      <p className="text-sm text-gray-500 mt-2">{t ? t("loading.takingTooLong") : "Está demorando muito? Verifique sua conexão com a internet."}</p>
    </div>
  ) : null;

  return (
    <>
      {userPosition && nearestInfo && (
        <DraggableDistanceCard
          distance={nearestInfo.distance * 1000}
          time={nearestInfo.timeMinutes}
          position={distanceCardPos}
          onDrop={(offset) => {
            setDistanceCardPos((prev) => ({
              x: Math.max(0, prev.x + (offset?.x || 0)),
              y: Math.max(0, prev.y + (offset?.y || 0)),
            }));
          }}
        />
      )}
      <div className="relative w-full h-96 rounded-lg overflow-hidden shadow-lg">
        <MapContainer
          center={[37.725, -8.782]}
          zoom={15}
          style={{ height: "100%", width: "100%" }}
          ref={mapRef}
        >
          <TileLayer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />
          {activeConductors
            .filter(
              (conductor) =>
                typeof conductor.latitude === "number" &&
                typeof conductor.longitude === "number" &&
                !isNaN(conductor.latitude) &&
                !isNaN(conductor.longitude) &&
                Math.abs(conductor.latitude) <= 90 &&
                Math.abs(conductor.longitude) <= 180
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
          {/* Exibe o marcador do usuário apenas após clicar em localizar-me e conceder permissão */}
          {hasLocated && userPosition && mapRef.current && (
            <UserLocationMarker
              map={mapRef.current}
              position={userPosition}
              autoCenter={false}
              showAccuracy={true}
            />
          )}
        </MapContainer>
        <div
          style={{
            position: "absolute",
            left: 20,
            top: 20,
            zIndex: 1000,
          }}
        >
          <LocationPermissionButton
            onClick={handleLocateMe}
            isLoading={geoLoading}
            permission={permission}
          />
        </div>
        {geoError && hasLocated && (
          <div className="absolute top-4 left-1/2 -translate-x-1/2 bg-yellow-100 text-yellow-800 px-4 py-2 rounded shadow z-[2000]">
            {geoError}
          </div>
        )}
        <button
          onClick={handleRecenter}
          className="absolute bottom-4 right-4 z-[1000] bg-white p-2 rounded-full shadow-lg hover:bg-gray-100 transition"
          title={t("mapControls.recenter")}
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            className="h-6 w-6 text-gray-600"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth={2}
              d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.828 0l-4.243-4.243a8 8 0 1111.314 0z"
            />
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth={2}
              d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"
            />
          </svg>
        </button>
        {activeConductors.length === 0 && !isLoading && (
          <div className="absolute inset-0 flex flex-col items-center justify-center pointer-events-none">
            <div className="text-3xl mb-2">😢</div>
            <h3 className="text-lg font-semibold text-gray-700">
              {t("errors.noTukTuksTitle")}
            </h3>
            <p className="text-sm text-gray-500 max-w-xs">
              {t("errors.noTukTuksMessage")}
            </p>
          </div>
        )}
        {loadingOverlay}
        {errorWarning}
        {geolocationWarning}
      </div>
      {import.meta.env.DEV && <LocationDebug />}
    </>
  );
};

export default PassengerMap;