import React from 'react';
import { useTranslation } from 'react-i18next';

// A prop 'permission' indica o estado atual da permissão de localização do navegador:
// - 'granted': O usuário já autorizou o acesso à localização. O app pode obter a posição sem pedir novamente.
// - 'prompt': O navegador ainda não pediu permissão, ou o usuário não respondeu. O app pode mostrar um botão para solicitar a autorização.
// - 'denied': O usuário recusou o acesso à localização, ou o navegador bloqueou. O app deve informar que não é possível obter a posição e pode sugerir alterar as configurações.
// Esse valor normalmente vem da API de permissões do navegador (navigator.permissions.query({ name: 'geolocation' })). Ele permite que o botão e o app adaptem o texto e o comportamento conforme o status real da permissão.
interface LocationPermissionButtonProps {
  onClick: () => void;
  isLoading: boolean;
  permission: 'granted' | 'prompt' | 'denied';
}

export const LocationPermissionButton: React.FC<LocationPermissionButtonProps> = ({ onClick, isLoading, permission }) => {
  const { t } = useTranslation();


  // Compute button text inside render to react to language changes
  function getButtonText() {
    if (permission === 'granted') return t('mapControls.whereAmINow');
    if (isLoading) return t('loading.gettingLocation');
    return t('mapControls.locateMe');
  }

  const isDisabled = isLoading;

  return (
    <button
      onClick={onClick}
      disabled={isDisabled}
      className="bg-blue-600 text-white px-4 py-2 rounded shadow hover:bg-blue-700 transition disabled:bg-blue-400 disabled:cursor-not-allowed"
    >
      {getButtonText()}
    </button>
  );
};