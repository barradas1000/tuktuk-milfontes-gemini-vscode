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

    if (isSupported) {
      navigator.permissions.query({ name: 'geolocation' }).then(status => {
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
        setState(prevState => ({
          ...prevState,
          error: err.message,
          isLoading: false,
        }));
      },
      { enableHighAccuracy: true, timeout: 10000, maximumAge: 0 }
    );
  }, [state.isSupported]);

  return { ...state, getLocation };
};