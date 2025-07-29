import React from 'react';
import { useDrag } from '@use-gesture/react';

interface DraggableDistanceCardProps {
  distance: number;
  time: number;
  position: { x: number; y: number };
  onDrop: (offset: { x: number; y: number }) => void;
}

const DraggableDistanceCard: React.FC<DraggableDistanceCardProps> = ({ distance, time, position, onDrop }) => {
  const bind = useDrag(({ offset: [x, y], down }) => {
    if (!down) {
      onDrop({ x, y });
    }
  });

  return (
    <div
      {...bind()}
      style={{ position: 'absolute', top: position.y, left: position.x, touchAction: 'none' }}
      className="bg-white p-4 rounded-lg shadow-lg z-10 cursor-grab"
    >
      <p className="font-bold">TukTuk mais próximo:</p>
      <p>{(distance / 1000).toFixed(2)} km</p>
      <p>~{time} min</p>
    </div>
  );
};

export default DraggableDistanceCard;