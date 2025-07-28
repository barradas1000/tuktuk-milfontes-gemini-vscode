import React from "react";
import { useGeolocation } from "@/hooks/useGeolocation";
import { useConductors } from "@/hooks/useConductors";
import { MapContainer, TileLayer, Marker, Popup } from "react-leaflet";
import L from "leaflet";
import userIconUrl from "@/assets/user-icon.png";
import tukTukIconUrl from "@/assets/tuktuk-icon.png";
import { LocationPermissionButton } from "@/components/LocationPermissionButton";
import { DistanceCalculator } from "@/components/DistanceCalculator";

const userIcon = new L.Icon({
  iconUrl: userIconUrl,
  iconSize: [40, 40],
  iconAnchor: [20, 20],
  popupAnchor: [0, -20],
});
const tukTukIcon = new L.Icon({
  iconUrl: tukTukIconUrl,
  iconSize: [40, 40],
  iconAnchor: [20, 40],
  popupAnchor: [0, -40],
});

function EmptyStateMessage() {
  return (
    <div className="flex flex-col items-center justify-center h-96 bg-gray-50 rounded-lg shadow-inner text-center mt-4">
      <div className="text-3xl mb-2">😢</div>
      <h3 className="text-lg font-semibold text-gray-700">
        Neste momento nenhum tuktuk disponível, faça uma reserva para outra
        hora.
      </h3>
    </div>
  );
}

export default function Tracking() {
  const { position, permission, error, isSupported } = useGeolocation();
  const { activeConductors, isLoading, activeError } = useConductors();

  // Centro do mapa: sempre Vila Nova de Milfontes
  const mapCenter = [37.722, -8.794];

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col items-center justify-center p-4">
      <h1 className="text-2xl font-bold mb-4 text-blue-700">
        Acompanhe seu TukTuk em tempo real
      </h1>
      <div className="w-full max-w-2xl h-[60vh] rounded-lg shadow-lg overflow-hidden relative">
        {/* Permissão negada ou erro de localização */}
        {!isSupported || permission === "denied" || error ? (
          <div className="flex flex-col items-center justify-center h-full">
            <LocationPermissionButton />
            <div className="mt-4 text-red-600 font-semibold">
              {error || "Permissão de localização negada ou não suportada."}
            </div>
          </div>
        ) : (
          <MapContainer
            center={mapCenter}
            zoom={15}
            style={{ height: "100%", width: "100%" }}
            whenCreated={(map) => map.setView(mapCenter, 15)}
          >
            <TileLayer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />
            {/* Marcador do usuário */}
            {position &&
              typeof position.coords.latitude === "number" &&
              typeof position.coords.longitude === "number" &&
              !isNaN(position.coords.latitude) &&
              !isNaN(position.coords.longitude) && (
                <Marker
                  position={[position.coords.latitude, position.coords.longitude]}
                  icon={userIcon}
                >
                  <Popup>
                    <div className="text-center">
                      <h3 className="font-bold text-blue-600">Você está aqui!</h3>
                      <p className="text-xs text-gray-500">
                        Lat: {position.coords.latitude.toFixed(5)}
                        <br />
                        Lng: {position.coords.longitude.toFixed(5)}
                      </p>
                    </div>
                  </Popup>
                </Marker>
              )}
            {/* Marcadores dos tuktuks ativos */}
            {activeConductors
              .filter(
                (condutor) =>
                  typeof condutor.latitude === "number" &&
                  typeof condutor.longitude === "number" &&
                  !isNaN(condutor.latitude) &&
                  !isNaN(condutor.longitude)
              )
              .map((condutor) => (
                <Marker
                  key={condutor.id}
                  position={[condutor.latitude, condutor.longitude]}
                  icon={tukTukIcon}
                >
                  <Popup>
                    <div className="text-center">
                      <h3 className="font-bold text-green-600">
                        {condutor.name}
                      </h3>
                      <p className="text-xs text-gray-500">
                        {condutor.whatsapp}
                      </p>
                      {/* Distância e tempo estimado */}
                      {position && (
                        <DistanceCalculator
                          userPosition={{
                            lat: position.coords.latitude,
                            lng: position.coords.longitude,
                          }}
                          tuktukPosition={{
                            lat: condutor.latitude,
                            lng: condutor.longitude,
                          }}
                          showDetails={true}
                        />
                      )}
                    </div>
                  </Popup>
                </Marker>
              ))}
          </MapContainer>
        )}
        {/* Estado vazio: nenhum tuktuk ativo */}
        {!isLoading && activeConductors.length === 0 && <EmptyStateMessage />}
      </div>
      {/* Botão flutuante de localização sempre visível */}
      <div className="mt-4">
        <LocationPermissionButton />
      </div>
    </div>
  );
}
