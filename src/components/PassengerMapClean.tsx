import React, { useRef, useEffect } from "react";
import { MapContainer, TileLayer, Marker } from "react-leaflet";
import L from "leaflet";

// Props: userLocation: [lat, lng], conductors: [{ id, latitude, longitude }]

const PassengerMapClean = ({ userLocation, conductors }) => {
  const mapRef = useRef(null);

  useEffect(() => {
    const handleResize = () => {
      if (mapRef.current) {
        mapRef.current.invalidateSize();
      }
    };
    window.addEventListener("resize", handleResize);
    // Corrige renderização inicial (ex: tabs/modais)
    setTimeout(() => {
      if (mapRef.current) {
        mapRef.current.invalidateSize();
      }
    }, 200);
    return () => window.removeEventListener("resize", handleResize);
  }, []);

  return (
    <div className="w-full rounded-lg overflow-hidden h-[350px] sm:h-[400px] md:h-[500px]">
      <MapContainer
        center={userLocation || [37.725, -8.782]}
        zoom={15}
        style={{ height: "100%", width: "100%" }}
        scrollWheelZoom={true}
        ref={mapRef}
      >
        <TileLayer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />
        {conductors?.map((c) =>
          c.latitude && c.longitude ? (
            <Marker
              key={c.id}
              position={[c.latitude, c.longitude]}
              icon={L.divIcon({ className: "tuktuk-marker" })}
            />
          ) : null
        )}
        {userLocation && (
          <Marker
            position={userLocation}
            icon={L.divIcon({ className: "user-marker" })}
          />
        )}
      </MapContainer>
    </div>
  );
};

export default PassengerMapClean;
