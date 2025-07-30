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
import { Coordinates } from "../utils/locationUtils";

// Configura o ícone do TukTuk
const TukTukIcon = new L.Icon({
  iconUrl: tukTukIcon,
  iconSize: [40, 40],
  iconAnchor: [20, 40],
  popupAnchor: [0, -40],
});

interface PassengerMapProps {
  onLocate?: (userPosition: Coordinates, tuktukPosition: Coordinates) => void;
}

const PassengerMap: React.FC<PassengerMapProps> = ({ onLocate }) => {
  const { t } = useTranslation();

  // Geolocalização do usuário
  const {
    position: userPosition,
    error: geoError,
    isLoading: geoLoading,
    permission,
    isSupported,
    getLocation,
  } = useGeolocation();

  const { data: activeConductors = [], isLoading, error } = useActiveConductors();
  const [distanceCardPos, setDistanceCardPos] = useState({ x: 0, y: 0 });
  const [noTukTukMsgPos, setNoTukTukMsgPos] = useState({ x: 0, y: 120 });
  const mapRef = useRef<L.Map | null>(null);
  const [hasLocated, setHasLocated] = useState(false);

  // Centraliza o mapa na localização do usuário
  useEffect(() => {
    if (hasLocated && userPosition && mapRef.current) {
      mapRef.current.setView([userPosition.lat, userPosition.lng], 16, { animate: true });
    }
  }, [userPosition, hasLocated]);

  const handleLocateMe = () => {
    setHasLocated(true);
    getLocation(); // ativa o pedido de localização
    // Mostra o cartão sempre que o botão for clicado, mesmo sem tuk-tuks
    setTimeout(() => {
      if (onLocate && userPosition) {
        onLocate(userPosition, nearestInfo?.conductor
          ? { lat: nearestInfo.conductor.latitude, lng: nearestInfo.conductor.longitude }
          : null);
      }
    }, 500);
  };

  const handleRecenter = () => {
    if (mapRef.current) {
      mapRef.current.setView([37.722, -8.794], 15);
    }
  };

  // Calcula o condutor mais próximo com base na posição do usuário
  function getNearestConductorInfo() {
    if (!userPosition || activeConductors.length === 0) return null;

    function haversine(lat1: number, lon1: number, lat2: number, lon2: number) {
      const R = 6371; // Raio da Terra em km
      const dLat = ((lat2 - lat1) * Math.PI) / 180;
      const dLon = ((lon2 - lon1) * Math.PI) / 180;
      const a =
        Math.sin(dLat / 2) ** 2 +
        Math.cos(lat1 * Math.PI / 180) *
        Math.cos(lat2 * Math.PI / 180) *
        Math.sin(dLon / 2) ** 2;
      return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a)); // distância em km
    }

    let nearest = null;
    let minDist = Infinity;

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
    const timeMinutes = Math.round((minDist / 20) * 60); // 20 km/h
    return { distance: minDist, timeMinutes, conductor: nearest };
  }

  const nearestInfo = getNearestConductorInfo();

  return (
    <>


      {userPosition && nearestInfo?.conductor && (
        <div
          style={{ position: 'absolute', left: distanceCardPos.x, top: distanceCardPos.y, zIndex: 1500, touchAction: 'none', cursor: 'grab' }}
          onTouchStart={(e) => {
            e.currentTarget.dataset.dragging = 'true';
            e.currentTarget.dataset.startX = String(e.touches[0].clientX);
            e.currentTarget.dataset.startY = String(e.touches[0].clientY);
            e.currentTarget.dataset.origX = String(distanceCardPos.x);
            e.currentTarget.dataset.origY = String(distanceCardPos.y);
          }}
          onTouchMove={(e) => {
            if (e.currentTarget.dataset.dragging === 'true') {
              const dx = e.touches[0].clientX - Number(e.currentTarget.dataset.startX);
              const dy = e.touches[0].clientY - Number(e.currentTarget.dataset.startY);
              setDistanceCardPos({
                x: Math.max(0, Number(e.currentTarget.dataset.origX) + dx),
                y: Math.max(0, Number(e.currentTarget.dataset.origY) + dy),
              });
            }
          }}
          onTouchEnd={(e) => {
            e.currentTarget.dataset.dragging = 'false';
          }}
          onMouseDown={(e) => {
            e.currentTarget.dataset.dragging = 'true';
            e.currentTarget.dataset.startX = String(e.clientX);
            e.currentTarget.dataset.startY = String(e.clientY);
            e.currentTarget.dataset.origX = String(distanceCardPos.x);
            e.currentTarget.dataset.origY = String(distanceCardPos.y);
            document.body.style.userSelect = 'none';
          }}
          onMouseMove={(e) => {
            if (e.currentTarget.dataset.dragging === 'true') {
              const dx = e.clientX - Number(e.currentTarget.dataset.startX);
              const dy = e.clientY - Number(e.currentTarget.dataset.startY);
              setDistanceCardPos({
                x: Math.max(0, Number(e.currentTarget.dataset.origX) + dx),
                y: Math.max(0, Number(e.currentTarget.dataset.origY) + dy),
              });
            }
          }}
          onMouseUp={(e) => {
            e.currentTarget.dataset.dragging = 'false';
            document.body.style.userSelect = '';
          }}
        >
          <DraggableDistanceCard
            distance={nearestInfo?.distance ? nearestInfo.distance * 1000 : 0}
            time={nearestInfo?.timeMinutes ?? 0}
            position={{ x: 0, y: 0 }}
            onDrop={() => {}}
          />
        </div>
      )}

      {userPosition && !nearestInfo?.conductor && (
        <div
          style={{ position: 'absolute', left: noTukTukMsgPos.x, top: noTukTukMsgPos.y, zIndex: 1500, touchAction: 'none', cursor: 'grab' }}
          onTouchStart={(e) => {
            e.currentTarget.dataset.dragging = 'true';
            e.currentTarget.dataset.startX = String(e.touches[0].clientX);
            e.currentTarget.dataset.startY = String(e.touches[0].clientY);
            e.currentTarget.dataset.origX = String(noTukTukMsgPos.x);
            e.currentTarget.dataset.origY = String(noTukTukMsgPos.y);
          }}
          onTouchMove={(e) => {
            if (e.currentTarget.dataset.dragging === 'true') {
              const dx = e.touches[0].clientX - Number(e.currentTarget.dataset.startX);
              const dy = e.touches[0].clientY - Number(e.currentTarget.dataset.startY);
              setNoTukTukMsgPos({
                x: Math.max(0, Number(e.currentTarget.dataset.origX) + dx),
                y: Math.max(0, Number(e.currentTarget.dataset.origY) + dy),
              });
            }
          }}
          onTouchEnd={(e) => {
            e.currentTarget.dataset.dragging = 'false';
          }}
          onMouseDown={(e) => {
            e.currentTarget.dataset.dragging = 'true';
            e.currentTarget.dataset.startX = String(e.clientX);
            e.currentTarget.dataset.startY = String(e.clientY);
            e.currentTarget.dataset.origX = String(noTukTukMsgPos.x);
            e.currentTarget.dataset.origY = String(noTukTukMsgPos.y);
            document.body.style.userSelect = 'none';
          }}
          onMouseMove={(e) => {
            if (e.currentTarget.dataset.dragging === 'true') {
              const dx = e.clientX - Number(e.currentTarget.dataset.startX);
              const dy = e.clientY - Number(e.currentTarget.dataset.startY);
              setNoTukTukMsgPos({
                x: Math.max(0, Number(e.currentTarget.dataset.origX) + dx),
                y: Math.max(0, Number(e.currentTarget.dataset.origY) + dy),
              });
            }
          }}
          onMouseUp={(e) => {
            e.currentTarget.dataset.dragging = 'false';
            document.body.style.userSelect = '';
          }}
        >
          <div className="bg-yellow-100 border border-yellow-300 text-yellow-700 p-4 rounded-md shadow-lg">
            Nenhum TukTuk ativo encontrado no momento.
          </div>
        </div>
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
            .filter((c) =>
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
                    <p className="text-sm text-gray-600">{t("map.tukTukAvailable")}</p>
                    <p className="text-xs text-gray-500">
                      {t("map.lastUpdate")}: {new Date().toLocaleTimeString()}
                    </p>
                  </div>
                </Popup>
              </Marker>
            ))}

          {hasLocated && userPosition && (
            <UserLocationMarker
              map={mapRef.current!}
              position={userPosition}
              autoCenter={false}
              showAccuracy={true}
            />
          )}
        </MapContainer>

        <div className="absolute top-5 left-5 z-[1000]">
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
          <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6 text-gray-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.828 0l-4.243-4.243a8 8 0 1111.314 0z" />
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
          </svg>
        </button>


        {/* Exibe mensagem imediatamente se não houver tuk-tuks ativos, sem loading infinito */}
        {activeConductors.length === 0 && !isLoading && (
          <div className="absolute inset-0 flex flex-col items-center justify-center pointer-events-none bg-white/80">
            <div className="text-3xl mb-2">😢</div>
            <h3 className="text-lg font-semibold text-gray-700">{t("errors.noTukTuksTitle")}</h3>
            <p className="text-sm text-gray-500 max-w-xs text-center">{t("errors.noTukTuksMessage")}</p>
          </div>
        )}

        {/* Loading só aparece se está carregando E há pelo menos 1 tuk-tuk ativo */}
        {isLoading && activeConductors.length > 0 && (
          <div className="absolute inset-0 flex flex-col items-center justify-center pointer-events-none bg-white/60 z-[2000]">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mb-2"></div>
            <p>{t("loading.tukTukLocation")}</p>
            <p className="text-sm text-gray-500 mt-2">{t("loading.takingTooLong")}</p>
          </div>
        )}

        {!isSupported && (
          <div className="absolute inset-0 flex flex-col items-center justify-center pointer-events-none bg-white/80 z-[2000]">
            <div className="text-3xl mb-2">⚠️</div>
            <h3 className="text-lg font-semibold text-gray-700">{t("errors.geolocationNotSupported")}</h3>
            <p className="text-sm text-gray-500 max-w-xs text-center">{t("errors.geolocationNotSupportedMessage")}</p>
          </div>
        )}
      </div>

      {import.meta.env.DEV && <LocationDebug />}
    </>
  );
};

export default PassengerMap;
