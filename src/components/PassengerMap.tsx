import React, { useState, useEffect, useRef } from "react";
import { useTranslation } from "react-i18next";
import {
  MapContainer,
  TileLayer,
  Marker,
  Popup,
  useMapEvents,
} from "react-leaflet";
import L from "leaflet";
import { UserLocationMarker } from "./UserLocationMarker";
import { LocationPermissionButton } from "./LocationPermissionButton";
import { LocationDebug } from "./LocationDebug";
import { useConductorsWithPermissions } from "@/hooks/useConductorsWithPermissions";
import { Coordinates } from "../types/supabase";
import "leaflet/dist/leaflet.css";
import tukTukIcon from "../assets/tuktuk-icon.png";

const TukTukIcon = new L.Icon({
  iconUrl: tukTukIcon,
  iconSize: [40, 40],
  iconAnchor: [20, 40],
  popupAnchor: [0, -40],
});

const PassengerMap: React.FC = () => {
  const { t } = useTranslation();

  // 🎯 MODERNIZAÇÃO: Usar hook profissional useConductorsWithPermissions
  // ✅ Elimina: useState + useEffect + fetchActiveConductors manual
  // ✅ Adiciona: Cache unificado + optimistic updates + error recovery
  const {
    conductors, // ← Todos os condutores (cache React Query)
    isLoading, // ← Estado centralizado
    error, // ← Error handling automático
    isConductorActive, // ← Helper function
  } = useConductorsWithPermissions();

  // 🎯 CONDUTORES ATIVOS: Calculado automaticamente do cache
  // ✅ Substitui: useState([]) + setActiveConductors manual
  const activeConductors = conductors
    .filter((c) => isConductorActive(c.id) && c.latitude && c.longitude)
    .map((c) => ({
      id: c.id,
      lat: c.latitude || 37.889, // ← 📍 CORRIGIDO: Coordenadas reais Vila Nova de Milfontes
      lng: c.longitude || -8.785, // ← 📍 CORRIGIDO: Próximo dos condutores ativos
      isActive: true,
      name: c.name || "TukTuk",
    }));

  const [userPosition, setUserPosition] = useState<Coordinates | null>(null);
  const [showUserLocation, setShowUserLocation] = useState(false);
  const mapRef = useRef<L.Map | null>(null);
  const [userInteracted, setUserInteracted] = useState(false);
  const [buttonPosition, setButtonPosition] = useState({ x: 20, y: 20 });
  const [dragging, setDragging] = useState(false);
  const dragOffset = useRef({ x: 0, y: 0 });

  const isGeolocationSupported =
    typeof navigator !== "undefined" && "geolocation" in navigator;

  // 🎯 REMOVIDO: fetchActiveConductors + useEffect + real-time manual
  // ✅ AGORA: useConductorsWithPermissions hook faz tudo automaticamente
  // - Cache inteligente via React Query
  // - Real-time via background refresh (60s)
  // - Optimistic updates + error recovery
  // - Invalidação automática quando necessário

  // Center map based on user position or conductors
  useEffect(() => {
    if (!userInteracted && mapRef.current) {
      if (userPosition && activeConductors.length > 0) {
        const bounds = L.latLngBounds([
          [userPosition.lat, userPosition.lng] as L.LatLngTuple,
          ...activeConductors.map((c) => [c.lat, c.lng] as L.LatLngTuple),
        ]);
        mapRef.current.fitBounds(bounds, { padding: [50, 50] });
      } else if (userPosition) {
        mapRef.current.setView([userPosition.lat, userPosition.lng], 15);
      } else if (activeConductors.length > 0) {
        const bounds = L.latLngBounds(
          activeConductors.map((c) => [c.lat, c.lng] as L.LatLngTuple)
        );
        mapRef.current.fitBounds(bounds, { padding: [50, 50] });
      }
    }
  }, [userPosition, activeConductors, userInteracted]);

  const MapEvents = () => {
    useMapEvents({
      dragstart: () => setUserInteracted(true),
    });
    return null;
  };

  const handleLocationGranted = (position: GeolocationPosition) => {
    setUserPosition({
      lat: position.coords.latitude,
      lng: position.coords.longitude,
    });
    setShowUserLocation(true);
    setUserInteracted(false);
  };

  const handleLocationDenied = () => {
    setShowUserLocation(false);
    setUserPosition(null);
    // ✅ MODERNIZADO: Usar error do useConductorsWithPermissions se necessário
    // setError(t("errors.locationDenied")); // Removido estado local
  };

  const handleDragStart = (e: React.MouseEvent | React.TouchEvent) => {
    setDragging(true);
    const clientX = "touches" in e ? e.touches[0].clientX : e.clientX;
    const clientY = "touches" in e ? e.touches[0].clientY : e.clientY;
    dragOffset.current = {
      x: clientX - buttonPosition.x,
      y: clientY - buttonPosition.y,
    };
  };

  const handleDrag = (e: React.MouseEvent | React.TouchEvent) => {
    if (dragging) {
      const clientX = "touches" in e ? e.touches[0].clientX : e.clientX;
      const clientY = "touches" in e ? e.touches[0].clientY : e.clientY;
      const buttonWidth = 100; // Ajuste conforme o tamanho do botão
      const buttonHeight = 40;
      setButtonPosition({
        x: Math.max(
          0,
          Math.min(
            window.innerWidth - buttonWidth,
            clientX - dragOffset.current.x
          )
        ),
        y: Math.max(
          0,
          Math.min(
            window.innerHeight - buttonHeight,
            clientY - dragOffset.current.y
          )
        ),
      });
    }
  };

  const handleDragEnd = () => {
    setDragging(false);
  };

  const handleRecenter = () => {
    setUserInteracted(false);
  };

  if (!isGeolocationSupported) {
    return (
      <div className="flex flex-col items-center justify-center h-96 bg-gray-50 rounded-lg shadow-inner text-center">
        <div className="text-3xl mb-2">⚠️</div>
        <h3 className="text-lg font-semibold text-gray-700">
          {t("errors.geolocationNotSupported")}
        </h3>
        <p className="text-sm text-gray-500 max-w-xs">
          {t("errors.geolocationNotSupportedMessage")}
        </p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex flex-col items-center justify-center h-96 bg-gray-50 rounded-lg shadow-inner text-center">
        <div className="text-3xl mb-2">⚠️</div>
        <h3 className="text-lg font-semibold text-gray-700">
          {t("errors.mapError")}
        </h3>
        <p className="text-sm text-gray-500 max-w-xs">{error.message}</p>
      </div>
    );
  }

  // 🎯 MODERNIZADO: Usar isLoading do useConductorsWithPermissions hook
  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-96">
        <div className="text-center">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto mb-2"></div>
          <p>{t("loading.tukTukLocation")}</p>
          <p className="text-sm text-gray-500 mt-2">
            {t("loading.takingTooLong")}
          </p>
        </div>
      </div>
    );
  }

  // 🎯 CONDUTORES ATIVOS: Agora calculado do cache React Query
  if (activeConductors.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center h-96 bg-gray-50 rounded-lg shadow-inner text-center">
        <div className="text-3xl mb-2">😢</div>
        <h3 className="text-lg font-semibold text-gray-700">
          {t("errors.noTukTuksTitle")}
        </h3>
        <p className="text-sm text-gray-500 max-w-xs">
          {t("errors.noTukTuksMessage")}
        </p>
      </div>
    );
  }

  return (
    <>
      <div className="relative w-full h-96 rounded-lg overflow-hidden shadow-lg">
        <MapContainer
          center={[37.889, -8.785]} // 📍 CORRIGIDO: Centro próximo aos condutores reais
          zoom={14}
          style={{ height: "100%", width: "100%" }}
          ref={mapRef}
        >
          <TileLayer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />
          <MapEvents />
          {activeConductors.map((conductor) => (
            <Marker
              key={conductor.id}
              position={[conductor.lat, conductor.lng]}
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
          {showUserLocation && userPosition && mapRef.current && (
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
            left: buttonPosition.x,
            top: buttonPosition.y,
            zIndex: 1000,
            touchAction: "none",
            cursor: dragging ? "grabbing" : "grab",
          }}
          onMouseDown={handleDragStart}
          onMouseMove={handleDrag}
          onMouseUp={handleDragEnd}
          onTouchStart={handleDragStart}
          onTouchMove={handleDrag}
          onTouchEnd={handleDragEnd}
        >
          <LocationPermissionButton
            onLocationGranted={handleLocationGranted}
            onLocationDenied={handleLocationDenied}
            showStatus={false}
          >
            {t("mapControls.locateMe")}
          </LocationPermissionButton>
        </div>
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
      </div>
      {import.meta.env.DEV && <LocationDebug />}
    </>
  );
};

export default PassengerMap;
