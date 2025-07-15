// src/components/PassengerMap.tsx
import React, { useEffect, useState, useRef } from 'react';
import { MapContainer, TileLayer, Marker, Popup, useMap } from 'react-leaflet';
import L from 'leaflet';
import 'leaflet/dist/leaflet.css';
import { useTranslation } from 'react-i18next';
import { supabase } from '../lib/supabase';
import { UserLocationMarker } from './UserLocationMarker';
import { LocationPermissionButton } from './LocationPermissionButton';
import { DistanceCalculator } from './DistanceCalculator';
import { LocationDebug } from './LocationDebug';
import { Coordinates } from '../utils/locationUtils';
import DraggableDistanceCard from './DraggableDistanceCard';

// Ícones Leaflet
import iconUrl from 'leaflet/dist/images/marker-icon.png';
import iconShadow from 'leaflet/dist/images/marker-shadow.png';
import tukTukIconUrl from '../assets/tuktuk-icon.png';
import userIconUrl from '../assets/user-icon.png';

const DefaultIcon = L.icon({
  iconUrl,
  shadowUrl: iconShadow,
  iconAnchor: [12, 41],
});
L.Marker.prototype.options.icon = DefaultIcon;

const TukTukIcon = L.icon({
  iconUrl: tukTukIconUrl,
  iconSize: [40, 40],
  iconAnchor: [20, 40],
  popupAnchor: [0, -40],
});

const UserIcon = L.icon({
  iconUrl: userIconUrl,
  iconSize: [40, 40],
  iconAnchor: [20, 40],
  popupAnchor: [0, -40],
});

interface DriverLocation {
  id: string;
  lat: number;
  lng: number;
  isActive: boolean;
  name: string;
}

const MapController: React.FC<{
  userPosition: Coordinates | null;
  driverLocation: DriverLocation | null;
  userInteracted: boolean;
}> = ({ userPosition, driverLocation, userInteracted }) => {
  const map = useMap();

  useEffect(() => {
    if (userPosition && driverLocation?.isActive && !userInteracted) {
      const bounds = L.latLngBounds([
        [userPosition.lat, userPosition.lng],
        [driverLocation.lat, driverLocation.lng],
      ]);
      map.fitBounds(bounds, { padding: [20, 20] });
    } else if (userPosition && !userInteracted) {
      map.setView([userPosition.lat, userPosition.lng], 15);
    } else if (driverLocation?.isActive && !userInteracted) {
      map.setView([driverLocation.lat, driverLocation.lng], 14);
    }
  }, [userPosition, driverLocation, map, userInteracted]);

  return null;
};

const DISTANCIA_ALERTA_METROS = 50;
const VELOCIDADE_MEDIA_KMH = 20;

const PassengerMap: React.FC = () => {
  const { t } = useTranslation();
  const [activeDrivers, setActiveDrivers] = useState<DriverLocation[]>([]);
  const [userPosition, setUserPosition] = useState<Coordinates | null>(null);
  const [loading, setLoading] = useState(true);
  const [showUserLocation, setShowUserLocation] = useState(false);
  const mapRef = useRef<L.Map | null>(null);
  const [userInteracted, setUserInteracted] = useState(false);
  const [cardPosition, setCardPosition] = useState(() => {
    const saved = localStorage.getItem('cardPos');
    return saved ? JSON.parse(saved) : { x: 16, y: 16 };
  });

  const calcularDistanciaMetros = (
    lat1: number,
    lng1: number,
    lat2: number,
    lng2: number
  ) => {
    const toRad = (x: number) => (x * Math.PI) / 180;
    const R = 6371000;
    const dLat = toRad(lat2 - lat1);
    const dLng = toRad(lng2 - lng1);
    const a =
      Math.sin(dLat / 2) ** 2 +
      Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) * Math.sin(dLng / 2) ** 2;
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c;
  };

  useEffect(() => {
    const fetchActiveDrivers = async () => {
      try {
        if (!import.meta.env.VITE_SUPABASE_URL || !import.meta.env.VITE_SUPABASE_ANON_KEY) {
          setActiveDrivers([]);
          setLoading(false);
          return;
        }
        const { data, error } = await supabase
          .from('drivers')
          .select('*')
          .eq('is_active', true);
        if (error) {
          setActiveDrivers([]);
        } else {
          setActiveDrivers(
            data.map((d: any) => ({
              id: d.id,
              lat: d.latitude || 37.725,
              lng: d.longitude || -8.783,
              isActive: d.is_active,
              name: d.name || 'TukTuk',
            }))
          );
        }
      } catch {
        setActiveDrivers([]);
      } finally {
        setLoading(false);
      }
    };
    fetchActiveDrivers();

    if (import.meta.env.VITE_SUPABASE_URL && import.meta.env.VITE_SUPABASE_ANON_KEY) {
      const channel = supabase
        .channel('driver_location')
        .on('postgres_changes', { event: 'UPDATE', schema: 'public', table: 'drivers' }, (payload) => {
          const newData = payload.new as any;
          setActiveDrivers((prev) => {
            const filtered = prev.filter((d) => d.id !== newData.id);
            if (newData.is_active) {
              return [
                ...filtered,
                {
                  id: newData.id,
                  lat: newData.latitude || 37.725,
                  lng: newData.longitude || -8.783,
                  isActive: true,
                  name: newData.name || 'TukTuk',
                },
              ];
            }
            return filtered;
          });
        })
        .subscribe();
      return () => supabase.removeChannel(channel);
    }
  }, []);

  const handleLocationGranted = (position: GeolocationPosition) => {
    setUserPosition({ lat: position.coords.latitude, lng: position.coords.longitude });
    setShowUserLocation(true);
  };

  const handleLocationDenied = () => {
    setShowUserLocation(false);
    setUserPosition(null);
  };

  const handleMapReady = (map: L.Map) => {
    mapRef.current = map;
  };

  const handleRecenter = () => setUserInteracted(false);

  if (loading) {
    return (
      <div className="flex items-center justify-center h-96">
        <div className="animate-spin h-8 w-8 border-b-2 border-blue-600 rounded-full"></div>
      </div>
    );
  }

  const distance =
    userPosition && activeDrivers[0]
      ? calcularDistanciaMetros(
          userPosition.lat,
          userPosition.lng,
          activeDrivers[0].lat,
          activeDrivers[0].lng
        )
      : null;

  const time =
    distance !== null
      ? Math.round(distance / ((VELOCIDADE_MEDIA_KMH * 1000) / 3600) / 60)
      : null;

  return (
    <>
      <div className="relative w-full h-96 rounded-lg overflow-hidden shadow-lg">
        <MapContainer
          center={[37.725, -8.783]}
          zoom={14}
          style={{ height: '100%', width: '100%' }}
          ref={handleMapReady}
        >
          <TileLayer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />

          {activeDrivers[0] && (
            <Marker position={[activeDrivers[0].lat, activeDrivers[0].lng]} icon={TukTukIcon}>
              <Popup>
                <div className="text-center">
                  <h3 className="font-bold text-blue-600">{activeDrivers[0].name}</h3>
                  <p className="text-sm text-gray-600">{t("mapControls.availableTukTuk")}</p>
                </div>
              </Popup>
            </Marker>
          )}

          {userPosition && (
            <Marker 
              position={[userPosition.lat, userPosition.lng]} 
              icon={L.divIcon({
                className: 'user-location-bounce',
                html: `
                  <div style="
                    width: 40px; 
                    height: 40px; 
                    background-image: url('${userIconUrl}');
                    background-size: contain;
                    background-repeat: no-repeat;
                    background-position: center;
                    animation: bounce 2s ease-in-out infinite;
                    transform: translate(-50%, -50%);
                  "></div>
                  
                  <style>
                    @keyframes bounce {
                      0%, 80%, 100% { 
                        transform: translate(-50%, -50%) translateY(0px);
                      }
                      40% { 
                        transform: translate(-50%, -50%) translateY(-15px);
                      }
                    }
                  </style>
                `,
                iconSize: [40, 40],
                iconAnchor: [20, 40],
              })}
            >
              <Popup>
                <div className="text-center">
                  <h3 className="font-bold text-green-600">👤 {t("mapControls.yourLocation")}</h3>
                  <p className="text-sm text-gray-600">{t("mapControls.youAreHere")}</p>
                </div>
              </Popup>
            </Marker>
          )}

          <MapController
            userPosition={userPosition}
            driverLocation={activeDrivers[0] || null}
            userInteracted={userInteracted}
          />

          {showUserLocation && mapRef.current && (
            <UserLocationMarker
              map={mapRef.current}
              onPositionChange={setUserPosition}
              onError={handleLocationDenied}
              autoCenter={false}
              showAccuracy={true}
            />
          )}
        </MapContainer>

        {/* Card arrastável com persistência */}
        <DraggableDistanceCard
          distance={distance}
          time={time}
          position={cardPosition}
          onDrop={(offset) => {
            setCardPosition((prev) => {
              const newPos = { x: prev.x + offset.x, y: prev.y + offset.y };
              localStorage.setItem('cardPos', JSON.stringify(newPos));
              return newPos;
            });
          }}
        />
      </div>

      <div className="mt-4 flex flex-col gap-2 items-start">
        <LocationPermissionButton
          onLocationGranted={handleLocationGranted}
          onLocationDenied={handleLocationDenied}
          showStatus={false}
        >
          {t("mapControls.locateMe")}
        </LocationPermissionButton>
        <button
          className="px-4 py-2 bg-blue-600 text-white rounded-lg font-semibold shadow hover:bg-blue-700 transition-colors"
          onClick={handleRecenter}
          type="button"
        >
          {t("mapControls.centerMap")}
        </button>
      </div>

      {import.meta.env.DEV && <LocationDebug />}
    </>
  );
};

export default PassengerMap;
