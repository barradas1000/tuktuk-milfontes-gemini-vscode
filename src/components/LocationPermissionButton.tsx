import React from 'react';
import { useTranslation } from 'react-i18next';

interface LocationPermissionButtonProps {
  onClick: () => void;
  isLoading: boolean;
  permission: 'granted' | 'prompt' | 'denied';
}

export const LocationPermissionButton: React.FC<LocationPermissionButtonProps> = ({ onClick, isLoading, permission }) => {
  const { t } = useTranslation();

    const buttonText = permission === 'granted' 
    ? t('mapControls.locationActive') 
    : isLoading 
      ? t('loading.gettingLocation') 
      : t('mapControls.locateMe');

  const isDisabled = isLoading || permission === 'granted';

  return (
    <button
      onClick={onClick}
            disabled={isDisabled}
      className="bg-blue-600 text-white px-4 py-2 rounded shadow hover:bg-blue-700 transition disabled:bg-blue-400 disabled:cursor-not-allowed"
    >
      {buttonText}
    </button>
  );
};