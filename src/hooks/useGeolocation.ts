import { useState, useCallback, useEffect, useRef } from "react";

export interface GeolocationPosition {
  coords: {
    latitude: number;
    longitude: number;
    accuracy?: number;
    altitude?: number | null;
    altitudeAccuracy?: number | null;
    heading?: number | null;
    speed?: number | null;
  };
  timestamp: number;
}

export interface GeolocationError {
  code: number;
  message: string;
}

export type PermissionStatus = "granted" | "denied" | "prompt";

export const useGeolocation = () => {
  const [position, setPosition] = useState<GeolocationPosition | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [permission, setPermission] = useState<PermissionStatus>("prompt");
  const [isLoading, setIsLoading] = useState(false);
  const isSupported = typeof navigator !== "undefined" && "geolocation" in navigator;
  const watchIdRef = useRef<number | null>(null);

  useEffect(() => {
    if (!isSupported) {
      setPermission("denied");
      setError("Geolocalização não é suportada neste navegador");
      return;
    }

    let cleanup: (() => void) | undefined;

    if ("permissions" in navigator) {
      navigator.permissions.query({ name: "geolocation" }).then((result) => {
        setPermission(result.state as PermissionStatus);
        const handleChange = () => setPermission(result.state as PermissionStatus);
        result.addEventListener("change", handleChange);
        cleanup = () => result.removeEventListener("change", handleChange);
      }).catch((err) => {
        setPermission("prompt");
        setError("Erro ao verificar permissões de geolocalização");
        console.error("Error checking geolocation permission:", err);
      });
    } else {
      setPermission("prompt");
    }

    return () => {
      if (cleanup) {
        cleanup();
      }
    };
  }, [isSupported]);

  const getLocation = useCallback(
    async (options?: PositionOptions, retries = 2): Promise<void> => {
      if (!isSupported) {
        setError("Geolocalização não é suportada neste navegador");
        return;
      }

      setIsLoading(true);
      setError(null);

      const defaultOptions: PositionOptions = {
        enableHighAccuracy: true,
        timeout: 10000,
        maximumAge: 0,
        ...options,
      };

      const attemptGetLocation = async (attempt: number): Promise<void> => {
        try {
          const pos = await new Promise<GeolocationPosition>((resolve, reject) => {
            navigator.geolocation.getCurrentPosition(resolve, reject, defaultOptions);
          });
          setPosition(pos);
          setPermission("granted");
        } catch (err) {
          if (attempt < retries) {
            return attemptGetLocation(attempt + 1);
          }

          const geoError = err as GeolocationPositionError;

          let errorMessage = `Erro ao obter localização (código: ${geoError.code})`;

          switch (geoError.code) {
            case geoError.PERMISSION_DENIED:
              errorMessage = "Permissão de localização negada pelo usuário";
              setPermission("denied");
              break;
            case geoError.POSITION_UNAVAILABLE:
              errorMessage = "Informação de localização indisponível";
              break;
            case geoError.TIMEOUT:
              errorMessage = "Tempo limite excedido ao obter localização";
              break;
            default:
              errorMessage = geoError.message || "Erro desconhecido ao obter localização";
          }
          setError(errorMessage);
        } finally {
          setIsLoading(false);
        }
      };

      return attemptGetLocation(0);
    },
    [isSupported]
  );

  const watchPosition = useCallback((options?: PositionOptions) => {
    if (!isSupported) {
      setError("Geolocalização não é suportada neste navegador");
      return null;
    }

    const defaultOptions: PositionOptions = {
      enableHighAccuracy: true,
      timeout: 10000,
      maximumAge: 0,
      ...options,
    };

    const id = navigator.geolocation.watchPosition(
      (pos) => {
        setPosition(pos);
        setPermission("granted");
      },
      (err) => {
        const geoError = err as GeolocationPositionError;

        let errorMessage = `Erro ao monitorar localização (código: ${geoError.code})`;

        switch (geoError.code) {
          case geoError.PERMISSION_DENIED:
            errorMessage = "Permissão de localização negada pelo usuário";
            setPermission("denied");
            break;
          case geoError.POSITION_UNAVAILABLE:
            errorMessage = "Informação de localização indisponível";
            break;
            case geoError.TIMEOUT:
            errorMessage = "Tempo limite excedido ao obter localização";
            break;
          default:
            errorMessage = geoError.message || "Erro desconhecido ao monitorar localização";
        }
        setError(errorMessage);
      },
      defaultOptions
    );
    watchIdRef.current = id;
    return id;
  }, [isSupported]);

  const clearPosition = useCallback(() => {
    setPosition(null);
    setError(null);
  }, []);

  const clearWatch = useCallback(() => {
    if (watchIdRef.current !== null) {
      navigator.geolocation.clearWatch(watchIdRef.current);
      watchIdRef.current = null;
    }
  }, []);

  return {
    position,
    error,
    permission,
    isLoading,
    isSupported,
    getLocation,
    watchPosition,
    clearPosition,
    clearWatch,
  };
};
