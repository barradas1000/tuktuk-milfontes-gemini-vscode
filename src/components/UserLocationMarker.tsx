import React, { useEffect } from 'react';
import { Marker, Popup, useMap } from 'react-leaflet';
import L from 'leaflet';
import userIconUrl from '@/assets/user-icon.png';

const userIcon = new L.Icon({
  iconUrl: userIconUrl,
  iconSize: [40, 40],
  iconAnchor: [20, 20],
  popupAnchor: [0, -20],
});

interface UserLocationMarkerProps {
  position: { lat: number; lng: number };
  map: L.Map;
  autoCenter?: boolean;
  showAccuracy?: boolean;
}

export const UserLocationMarker: React.FC<UserLocationMarkerProps> = ({ position, map, autoCenter = true, showAccuracy = false }) => {
  useEffect(() => {
    if (autoCenter) {
      map.flyTo(position, 15);
    }
  }, [position, map, autoCenter]);

  return (
    <Marker position={position} icon={userIcon}>
      <Popup>
        <div className="text-center">
          <h3 className="font-bold text-blue-600">Você está aqui!</h3>
          {showAccuracy && (
            <p className="text-xs text-gray-500">
              Precisão de {position.accuracy.toFixed(0)} metros
            </p>
          )}
        </div>
      </Popup>
    </Marker>
  );
};