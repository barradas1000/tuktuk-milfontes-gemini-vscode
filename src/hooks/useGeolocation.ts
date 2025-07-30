import React, { useState, useEffect, useCallback } from 'react';

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
  'Não foi possível aceder à sua localização porque a permissão foi negada. Para continuar, ative a localização para este site nas definições do navegador. Em Android, certifique-se de que não há outros aplicativos com janelas flutuantes abertas (ex: Messenger, gravador de ecrã) e tente novamente.';

// Componente de mensagem de erro de localização com botão de fechar
export function LocationErrorMessage({ error }: { error: string | null }) {
  const [visible, setVisible] = useState(true);
  if (!error || !visible) return null;
  return React.createElement(
    'div',
    {
      style: {
        position: 'absolute',
        top: 120,
        left: 20,
        zIndex: 2000,
        background: '#fff3cd',
        color: '#856404',
        border: '1px solid #ffeeba',
        borderRadius: 8,
        padding: '1rem 2.5rem 1rem 1rem',
        maxWidth: 340,
        boxShadow: '0 2px 8px rgba(0,0,0,0.08)',
        fontSize: '1em'
      }
    },
    [
      React.createElement(
        'button',
        {
          key: 'close',
          onClick: () => setVisible(false),
          style: {
            position: 'absolute',
            top: 8,
            right: 8,
            background: 'transparent',
            border: 'none',
            fontSize: '1.2em',
            color: '#856404',
            cursor: 'pointer'
          },
          'aria-label': 'Fechar',
          title: 'Fechar'
        },
        '×'
      ),
      error
    ]
  );
}

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
