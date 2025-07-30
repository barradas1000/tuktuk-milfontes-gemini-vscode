import React, { useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';

interface LocationPermissionButtonProps {
  onClick: () => void;
  isLoading: boolean;
  permission: 'granted' | 'prompt' | 'denied';
}

export const LocationPermissionButton: React.FC<LocationPermissionButtonProps> = ({ onClick, isLoading, permission }) => {
  const { t } = useTranslation();

  // Estado para arrastar
  const buttonRef = useRef<HTMLDivElement>(null);
  const [dragging, setDragging] = useState(false);
  const [pos, setPos] = useState({ x: 0, y: 0 });
  const [offset, setOffset] = useState({ x: 0, y: 0 });

  // Funções de drag
  function handleMouseDown(e: React.MouseEvent) {
    setDragging(true);
    setOffset({
      x: e.clientX - pos.x,
      y: e.clientY - pos.y,
    });
    document.body.style.userSelect = 'none';
  }
  function handleMouseMove(e: MouseEvent) {
    if (!dragging) return;
    setPos({
      x: e.clientX - offset.x,
      y: e.clientY - offset.y,
    });
  }
  function handleMouseUp() {
    setDragging(false);
    document.body.style.userSelect = '';
  }

  React.useEffect(() => {
    if (dragging) {
      window.addEventListener('mousemove', handleMouseMove);
      window.addEventListener('mouseup', handleMouseUp);
    } else {
      window.removeEventListener('mousemove', handleMouseMove);
      window.removeEventListener('mouseup', handleMouseUp);
    }
    return () => {
      window.removeEventListener('mousemove', handleMouseMove);
      window.removeEventListener('mouseup', handleMouseUp);
    };
    // eslint-disable-next-line
  }, [dragging, offset]);

  function getButtonText() {
    if (permission === 'granted') return t('mapControls.whereAmINow');
    if (isLoading) return t('loading.gettingLocation');
    return t('mapControls.locateMe');
  }

  const isDisabled = isLoading;

  return (
    <div
      ref={buttonRef}
      style={{ position: 'absolute', left: pos.x, top: pos.y, zIndex: 2000, cursor: dragging ? 'grabbing' : 'grab' }}
      onMouseDown={handleMouseDown}
      role="presentation"
    >
      <button
        onClick={onClick}
        disabled={isDisabled}
        className="flex items-center gap-2 bg-blue-600 text-white px-4 py-2 rounded shadow hover:bg-blue-700 transition disabled:bg-blue-400 disabled:cursor-not-allowed"
        style={{ minWidth: 180 }}
      >
        <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="none" viewBox="0 0 24 24"><path fill="currentColor" d="M12 2a1 1 0 0 1 1 1v2.07A8.001 8.001 0 0 1 20.93 11H23a1 1 0 1 1 0 2h-2.07A8.001 8.001 0 0 1 13 20.93V23a1 1 0 1 1-2 0v-2.07A8.001 8.001 0 0 1 3.07 13H1a1 1 0 1 1 0-2h2.07A8.001 8.001 0 0 1 11 3.07V1a1 1 0 0 1 1-1zm0 4a6 6 0 1 0 0 12A6 6 0 0 0 12 6z"/></svg>
        {getButtonText()}
      </button>
    </div>
  );
};