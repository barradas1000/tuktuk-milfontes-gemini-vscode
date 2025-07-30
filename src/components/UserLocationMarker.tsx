import React, { useEffect } from 'react';
import { Marker, Popup } from 'react-leaflet';
import L from 'leaflet';
import userIconUrl from '@/assets/user-icon.png';

// Criação do ícone personalizado para representar o utilizador no mapa
const userIcon = new L.Icon({
  iconUrl: userIconUrl,
  iconSize: [60, 60],
  iconAnchor: [30, 60], // centro da base do ícone
  popupAnchor: [0, -60],
});

// Definimos a interface da localização do utilizador com `accuracy` opcional
interface UserLocation {
  lat: number;
  lng: number;
  accuracy?: number; // <-- adicionamos este campo opcional
}

interface UserLocationMarkerProps {
  position: UserLocation; // utilizamos a nova interface
  map: L.Map;
  autoCenter?: boolean;
  showAccuracy?: boolean;
}

export const UserLocationMarker: React.FC<UserLocationMarkerProps> = ({
  position,
  map,
  autoCenter = true,
  showAccuracy = false,
}) => {
  // Faz com que o mapa se mova automaticamente para a posição do utilizador
  useEffect(() => {
    if (autoCenter) {
      map.flyTo([position.lat, position.lng], 15); // Fly para as coordenadas
    }
  }, [position, map, autoCenter]);

  return (
    <Marker position={[position.lat, position.lng]} icon={userIcon}>
      <Popup>
        <div className="text-center">
          <h3 className="font-bold text-blue-600">Você está aqui!</h3>

          {/* Mostra a precisão se showAccuracy for true e se accuracy existir */}
          {showAccuracy && position.accuracy !== undefined && (
            <p className="text-xs text-gray-500">
              Precisão de {position.accuracy.toFixed(0)} metros
            </p>
          )}
        </div>
      </Popup>
    </Marker>
  );
};
