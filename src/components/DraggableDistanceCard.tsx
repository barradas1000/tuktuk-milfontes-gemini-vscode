// src/components/DraggableDistanceCard.tsx
import { useDrag } from 'react-dnd';
import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';

interface Props {
  distance: number | null;
  time: number | null;
  position: { x: number; y: number };
  onDrop: (offset: { x: number; y: number }) => void;
}

const DraggableDistanceCard: React.FC<Props> = ({
  distance,
  time,
  position,
  onDrop,
}) => {
  const { t } = useTranslation();
  const [{ isDragging }, drag] = useDrag({
    type: 'distance-card',
    item: () => ({ startPos: position }),
    collect: (monitor) => ({
      isDragging: monitor.isDragging(),
      offset: monitor.getDifferenceFromInitialOffset(),
    }),
    end: (_item, monitor) => {
      const delta = monitor.getDifferenceFromInitialOffset();
      if (delta) onDrop(delta);
    },
  });

  return (
    <div
      ref={drag}
      className={`absolute z-[1000] bg-white rounded-lg shadow-lg p-3 cursor-grab select-none transition-opacity ${
        isDragging ? 'opacity-75' : 'opacity-100'
      }`}
      style={{
        top: position.y,
        left: position.x,
        touchAction: 'none',
      }}
    >
      <h4 className="font-bold text-blue-600 mb-1">{t("distanceCard.currentLocation")}</h4>
      {distance !== null && (
        <p className="text-sm text-gray-700">{t("distanceCard.distance")}: {distance.toFixed(0)} {t("distanceCard.meters")}</p>
      )}
      {time !== null && (
        <p className="text-sm text-gray-700">{t("distanceCard.estimatedTime")}: {time} {t("distanceCard.minutes")}</p>
      )}
    </div>
  );
};

export default DraggableDistanceCard;
