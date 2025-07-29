import React from "react";
import PassengerMap from "@/components/PassengerMap";

export default function Tracking() {
  return (
    <div className="min-h-screen bg-gray-50 flex flex-col items-center justify-center p-4">
      <h1 className="text-2xl font-bold mb-4 text-blue-700">
        Acompanhe seu TukTuk em tempo real
      </h1>
      <div className="w-full max-w-4xl h-[70vh] rounded-lg shadow-lg overflow-hidden relative">
        <PassengerMap />
      </div>
    </div>
  );
}