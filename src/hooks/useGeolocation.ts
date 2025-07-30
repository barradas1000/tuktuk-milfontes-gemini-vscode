import { useState, useEffect, useCallback } from 'react';

export interface GeolocationPosition {
  lat: number;
  lng: number;
  accuracy?: number;
}

export type GeolocationPermission = 'granted' | 'prompt' | 'denied';

export interface GeolocationState {
  isSupported: boolean;
  permission: GeolocationPermission;
  position: GeolocationPosition | null;
  error: string | null;
  isLoading: boolean;
}

// Mensagem de orientação para permissão negada
export const GEOLOCATION_DENIED_HELP =
  'Permissão de localização negada.\nPara ativar, vá às configurações do navegador > Permissões > Localização e permita o acesso para este site. Em Android, pode ser necessário fechar apps com balões/flutuantes (ex: Messenger, gravador de ecrã) antes de tentar novamente.';

export const useGeolocation = () => {
  const [state, setState] = useState<GeolocationState>({
    isSupported: false,
    permission: 'prompt',
    position: null,
    error: null,
    isLoading: false,
  });

  useEffect(() => {
    const isSupported = typeof navigator !== 'undefined' && 'geolocation' in navigator;
    setState(prevState => ({ ...prevState, isSupported }));

    if (isSupported && navigator.permissions) {
      navigator.permissions.query({ name: 'geolocation' as PermissionName }).then(status => {
        setState(prevState => ({ ...prevState, permission: status.state }));
        status.onchange = () => {
          setState(prevState => ({ ...prevState, permission: status.state }));
        };
      });
    }
  }, []);

  const getLocation = useCallback(() => {
    if (!state.isSupported) {
      setState(prevState => ({ ...prevState, error: 'Geolocation is not supported by this browser.' }));
      return;
    }

    setState(prevState => ({ ...prevState, isLoading: true, error: null }));

    navigator.geolocation.getCurrentPosition(
      pos => {
        setState(prevState => ({
          ...prevState,
          position: {
            lat: pos.coords.latitude,
            lng: pos.coords.longitude,
            accuracy: pos.coords.accuracy,
          },
          isLoading: false,
        }));
      },
      err => {
        let errorMessage = 'Erro ao obter localização.';
        switch (err.code) {
          case err.PERMISSION_DENIED:
            errorMessage = GEOLOCATION_DENIED_HELP;
            break;
          case err.POSITION_UNAVAILABLE:
            errorMessage = 'Localização indisponível.';
            break;
          case err.TIMEOUT:
            errorMessage = 'Tempo limite para obter localização excedido.';
            break;
          default:
            errorMessage = err.message;
        }

        setState(prevState => ({
          ...prevState,
          error: errorMessage,
          isLoading: false,
        }));
      },
      {
        enableHighAccuracy: true,
        timeout: 10000,
        maximumAge: 0,
      }
    );
  }, [state.isSupported]);

  return { ...state, getLocation };
};
