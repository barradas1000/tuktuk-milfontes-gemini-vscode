import React from 'react';
import { useGeolocation } from '@/hooks/useGeolocation';

export const LocationDebug: React.FC = () => {
  const { position, error, isLoading, permission, isSupported } = useGeolocation();

  return (
    <div className="bg-gray-100 p-4 rounded-lg shadow-md mt-4">
      <h3 className="font-bold text-lg mb-2">Debug de Geolocalização</h3>
      <p><strong>Suportado:</strong> {isSupported ? 'Sim' : 'Não'}</p>
      <p><strong>Permissão:</strong> {permission}</p>
      <p><strong>Carregando:</strong> {isLoading ? 'Sim' : 'Não'}</p>
      <p><strong>Erro:</strong> {error || 'Nenhum'}</p>
      {position && (
        <p>
          <strong>Posição:</strong> Lat: {position.lat.toFixed(5)}, Lng: {position.lng.toFixed(5)}
        </p>
      )}
    </div>
  );
};