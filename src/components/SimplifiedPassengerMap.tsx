import React from "react";
import { MapContainer, TileLayer, Marker, Popup } from "react-leaflet";
import L from "leaflet";
import { useConductors } from "@/hooks/useConductors";
import tukTukIcon from "../assets/tuktuk-icon.png";
import "leaflet/dist/leaflet.css";

const TukTukIcon = new L.Icon({
  iconUrl: tukTukIcon,
  iconSize: [40, 40],
  iconAnchor: [20, 40],
  popupAnchor: [0, -40],
});

const SimplifiedPassengerMap: React.FC = () => {
  // 🎯 MODERNIZAÇÃO: Usar hook profissional useConductors
  // ✅ Elimina: useState + useEffect + fetchActiveConductors manual
  // ✅ Adiciona: Cache unificado + optimistic updates + error recovery
  const {
    conductors, // ← Todos os condutores (cache React Query)
    isLoading, // ← Estado centralizado
    error, // ← Error handling automático
    isConductorActive, // ← Helper function
  } = useConductors();

  // 🎯 CONDUTORES ATIVOS: Calculado automaticamente do cache
  // ✅ Substitui: useState([]) + manual real-time subscriptions
  const activeConductors = conductors
    .filter((c) => isConductorActive(c.id) && c.latitude && c.longitude)
    .map((c) => ({
      id: c.id,
      name: c.name || "TukTuk",
      latitude: c.latitude || 37.889, // ← 📍 CORRIGIDO: Coordenadas reais Vila Nova de Milfontes
      longitude: c.longitude || -8.785, // ← 📍 CORRIGIDO: Próximo dos condutores ativos
    }));

  // 🎯 MODERNIZADO: Usar isLoading do useConductors hook
  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-96">
        <div className="text-center">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto mb-2"></div>
          <p>A carregar mapa...</p>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex flex-col items-center justify-center h-96 bg-gray-50 rounded-lg">
        <div className="text-3xl mb-2">⚠️</div>
        <h3 className="text-lg font-semibold text-gray-700">Erro no Mapa</h3>
        <p className="text-sm text-gray-500">{error.message}</p>
      </div>
    );
  }

  // 🎯 CONDUTORES ATIVOS: Agora calculado do cache React Query
  if (activeConductors.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center h-96 bg-gray-50 rounded-lg">
        <div className="text-3xl mb-2">😴</div>
        <h3 className="text-lg font-semibold text-gray-700">TukTuk Offline</h3>
        <p className="text-sm text-gray-500">Nenhum TukTuk ativo no momento</p>
      </div>
    );
  }

  return (
    <div className="relative w-full h-96 rounded-lg overflow-hidden shadow-lg">
      <MapContainer
        center={[37.889, -8.785]} // 📍 CORRIGIDO: Centro próximo aos condutores reais
        zoom={14}
        style={{ height: "100%", width: "100%" }}
      >
        <TileLayer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />

        {activeConductors.map((conductor) => (
          <Marker
            key={conductor.id}
            position={[conductor.latitude, conductor.longitude]}
            icon={TukTukIcon}
          >
            <Popup>
              <div className="text-center">
                <h3 className="font-bold text-blue-600">{conductor.name}</h3>
                <p className="text-sm text-gray-600">TukTuk Disponível</p>
                <p className="text-xs text-gray-500">
                  Última atualização: {new Date().toLocaleTimeString()}
                </p>
              </div>
            </Popup>
          </Marker>
        ))}
      </MapContainer>
    </div>
  );
};

export default SimplifiedPassengerMap;
