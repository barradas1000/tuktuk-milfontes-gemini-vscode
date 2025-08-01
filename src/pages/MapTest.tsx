import React from "react";
import { MapContainer, TileLayer, Marker } from "react-leaflet";
import L from "leaflet";
import "leaflet/dist/leaflet.css";

// Fix default Leaflet icon
const DefaultIcon = L.icon({
  iconUrl: "/leaflet/marker-icon.png",
  shadowUrl: "/leaflet/marker-shadow.png",
  iconSize: [25, 41],
  iconAnchor: [12, 41],
});
L.Marker.prototype.options.icon = DefaultIcon;

const MapTest = () => {
  return (
    <div className="min-h-screen bg-gray-100 p-4">
      <h1 className="text-2xl font-bold mb-4 text-center">Teste do Mapa Isolado</h1>
      <div className="mx-auto max-w-4xl">
        {/* Teste 1: Container com altura fixa */}
        <div className="mb-8">
          <h2 className="text-lg font-semibold mb-2">Teste 1: Container 400px altura fixa</h2>
          <div className="w-full h-[400px] border-2 border-red-500 rounded-lg overflow-hidden">
            <MapContainer
              center={[37.725, -8.782]}
              zoom={15}
              style={{ height: "100%", width: "100%" }}
              scrollWheelZoom={false}
              zoomControl={true}
              attributionControl={false}
            >
              <TileLayer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />
              <Marker position={[37.725, -8.782]} />
            </MapContainer>
          </div>
        </div>

        {/* Teste 2: Container com altura relativa */}
        <div className="mb-8">
          <h2 className="text-lg font-semibold mb-2">Teste 2: Container 50vh altura relativa</h2>
          <div className="w-full h-[50vh] border-2 border-blue-500 rounded-lg overflow-hidden">
            <MapContainer
              center={[37.725, -8.782]}
              zoom={15}
              style={{ height: "100%", width: "100%" }}
              scrollWheelZoom={false}
              zoomControl={true}
              attributionControl={false}
            >
              <TileLayer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />
              <Marker position={[37.725, -8.782]} />
            </MapContainer>
          </div>
        </div>

        {/* Teste 3: Container simples sem overflow */}
        <div className="mb-8">
          <h2 className="text-lg font-semibold mb-2">Teste 3: Container simples 500px</h2>
          <div className="w-full h-[500px] border-2 border-green-500 rounded-lg">
            <MapContainer
              center={[37.725, -8.782]}
              zoom={15}
              style={{ height: "100%", width: "100%" }}
              scrollWheelZoom={true}
              zoomControl={true}
              attributionControl={true}
            >
              <TileLayer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />
              <Marker position={[37.725, -8.782]} />
            </MapContainer>
          </div>
        </div>
      </div>
    </div>
  );
};

export default MapTest;
