// components/DraggableDistanceCard.tsx
import React from "react";

interface Props {
  distance: number; // em metros
  time: number; // em minutos
  position: { x: number; y: number };
  onDrop?: (offset: { x: number; y: number }) => void;
}

const DraggableDistanceCard: React.FC<Props> = ({ distance, time, position }) => {
  return (
    <div
      className="absolute bg-white shadow-xl rounded-md p-4 z-[1500] w-64"
      style={{
        transform: `translate(${position.x}px, ${position.y}px)`,
        top: 20,
        left: 20,
      }}
    >
      <h3 className="text-lg font-semibold mb-2 text-blue-600">Distância até ao TukTuk</h3>
      <p className="text-gray-700">
        {distance.toFixed(0)} metros
      </p>
      <p className="text-gray-500 text-sm">Chegada estimada em {time} min</p>
    </div>
  );
};

export default DraggableDistanceCard;
