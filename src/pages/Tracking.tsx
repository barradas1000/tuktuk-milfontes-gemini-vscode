import React, { useEffect, useState } from "react";
import { useActiveConductors } from "../hooks/useActiveConductors";


export default function Tracking() {
  const [isTrackingEnabled, setIsTrackingEnabled] = useState(true);
  const { data: conductors = [], isLoading } = useActiveConductors();

  useEffect(() => {
    const tracking = localStorage.getItem("isTrackingEnabled") === "true";
    setIsTrackingEnabled(tracking);
  }, []);

  const hasActiveConductors = conductors.length > 0;

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col items-center justify-center p-4">
      <h1 className="text-2xl font-bold mb-4 text-blue-700">
        Acompanhe seu TukTuk em tempo real
      </h1>
      <div className="w-full max-w-4xl h-[70vh] rounded-lg shadow-lg overflow-hidden relative">
        {isTrackingEnabled && hasActiveConductors ? (
          <Mapa conductors={conductors} />
        ) : (
          <ConductorCard message="Nenhum TukTuk activo encontrado no momento." />
        )}
      </div>
    </div>
  );
}
