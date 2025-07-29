import React, { useState, useEffect, useMemo } from 'react';
import { MapContainer, TileLayer, Marker, Popup, useMap } from 'react-leaflet';
import L from 'leaflet';
import 'leaflet/dist/leaflet.css';
import { useTranslation } from 'react-i18next';
import { useGeolocation } from '../hooks/useGeolocation';
import userIconUrl from '../assets/user-icon.png';
import tukTukIconUrl from '../assets/tuktuk-icon.png';

// Tipos e Ícones
interface Coordinates {
  lat: number;
  lng: number;
}

const UserIcon = L.icon({
  iconUrl: userIconUrl,
  iconSize: [40, 40],
  iconAnchor: [20, 20],
  popupAnchor: [0, -20],
});

const TukTukIcon = L.icon({
  iconUrl: tukTukIconUrl,
  iconSize: [40, 40],
  iconAnchor: [20, 40],
  popupAnchor: [0, -40],
});

// Componente para o marcador do utilizador
const UserMarker: React.FC = () => {
  const map = useMap();
  const { position, error, isLoading, getLocation } = useGeolocation();

  const userPosition = useMemo(() => {
    if (!position) return null;
    return {
      lat: position.coords.latitude,
      lng: position.coords.longitude,
    };
  }, [position]);

  useEffect(() => {
    if (userPosition) {
      map.flyTo([userPosition.lat, userPosition.lng], 15);
    }
  }, [userPosition, map]);

  return (
    <>
      {userPosition && (
        <Marker position={[userPosition.lat, userPosition.lng]} icon={UserIcon}>
          <Popup>Você está aqui!</Popup>
        </Marker>
      )}
      <div className="leaflet-bottom leaflet-left">
        <div className="leaflet-control leaflet-bar">
          <button
            onClick={() => getLocation()}
            disabled={isLoading}
            style={{
              backgroundColor: 'white',
              border: '2px solid #ccc',
              borderRadius: '4px',
              padding: '5px 10px',
              cursor: 'pointer',
            }}
          >
            {isLoading ? 'A localizar...' : 'Onde estou?'}
          </button>
          {error && <p style={{ color: 'red' }}>{error}</p>}
        </div>
      </div>
    </>
  );
};

// Componente principal do mapa
const PassengerMap: React.FC = () => {
  const [tukTukLocation] = useState<Coordinates | null>({ lat: 37.721, lng: -8.785 });
  const { position: userPosition, error: geoError, isLoading: geoLoading, permission, isSupported, getLocation } = useGeolocation();
  const { t } = useTranslation();

  // Botão sempre visível e funcional
  const renderLocateButton = () => (
    <button
      onClick={getLocation}
      className={`bg-blue-600 text-white px-4 py-2 rounded shadow hover:bg-blue-700 transition ${geoLoading ? 'opacity-50 cursor-wait' : ''}`}
      disabled={geoLoading}
    >
      {geoLoading ? t("loading.tukTukLocation") : t("mapControls.locateMe")}
    </button>
  );

  return (
    <>
      <div className="relative w-full h-96 rounded-lg overflow-hidden shadow-lg">
        <MapContainer
          center={[37.725, -8.783]}
          zoom={13}
          style={{ height: '400px', width: '100%', borderRadius: '8px' }}
        >
          <TileLayer
            url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
            attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
          />
          {tukTukLocation && (
            <Marker position={[tukTukLocation.lat, tukTukLocation.lng]} icon={TukTukIcon}>
              <Popup>O TukTuk está aqui!</Popup>
            </Marker>
          )}
          <UserMarker />
        </MapContainer>
        {/* Botão de permissão sempre visível */}
        <div style={{ position: "absolute", left: 20, top: 20, zIndex: 1000 }}>
          {renderLocateButton()}
        </div>
        {/* Feedback de erro/permissão */}
        {geoError && (
          <div className="absolute top-4 left-1/2 -translate-x-1/2 bg-yellow-100 text-yellow-800 px-4 py-2 rounded shadow z-[2000]">
            {geoError}
          </div>
        )}
        {/* ...existing overlays... */}
      </div>
      {/* ...existing code... */}
    </>
  );
};

export default PassengerMap;
