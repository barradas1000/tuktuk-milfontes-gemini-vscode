import type {
  ConductorStatus,
  VehicleStatus,
  ApplicationStatus,
} from "@/types/conductor-management";

// ==================== FORMATAÇÃO DE STATUS ====================

export const formatConductorStatus = (
  status: ConductorStatus
): { label: string; color: string; icon: string } => {
  switch (status) {
    case "active":
      return {
        label: "Ativo",
        color: "text-green-600 bg-green-50",
        icon: "✅",
      };
    case "blocked":
      return {
        label: "Bloqueado",
        color: "text-yellow-600 bg-yellow-50",
        icon: "🚫",
      };
    case "expelled":
      return { label: "Expulso", color: "text-red-600 bg-red-50", icon: "⛔" };
    case "inactive":
      return {
        label: "Inativo",
        color: "text-gray-600 bg-gray-50",
        icon: "😴",
      };
    default:
      return {
        label: "Desconhecido",
        color: "text-gray-600 bg-gray-50",
        icon: "❓",
      };
  }
};

export const formatVehicleStatus = (
  status: VehicleStatus
): { label: string; color: string; icon: string } => {
  switch (status) {
    case "operational":
      return {
        label: "Operacional",
        color: "text-green-600 bg-green-50",
        icon: "🚐",
      };
    case "maintenance":
      return {
        label: "Manutenção",
        color: "text-orange-600 bg-orange-50",
        icon: "🔧",
      };
    case "out_of_service":
      return {
        label: "Fora de Serviço",
        color: "text-red-600 bg-red-50",
        icon: "🚫",
      };
    default:
      return {
        label: "Desconhecido",
        color: "text-gray-600 bg-gray-50",
        icon: "❓",
      };
  }
};

export const formatApplicationStatus = (
  status: ApplicationStatus
): { label: string; color: string; icon: string } => {
  switch (status) {
    case "link_created":
      return {
        label: "Link Criado",
        color: "text-blue-600 bg-blue-50",
        icon: "🔗",
      };
    case "submitted":
      return {
        label: "Submetida",
        color: "text-purple-600 bg-purple-50",
        icon: "📝",
      };
    case "approved":
      return {
        label: "Aprovada",
        color: "text-green-600 bg-green-50",
        icon: "✅",
      };
    case "rejected":
      return {
        label: "Rejeitada",
        color: "text-red-600 bg-red-50",
        icon: "❌",
      };
    case "expired":
      return {
        label: "Expirada",
        color: "text-gray-600 bg-gray-50",
        icon: "⏰",
      };
    default:
      return {
        label: "Desconhecido",
        color: "text-gray-600 bg-gray-50",
        icon: "❓",
      };
  }
};

// ==================== FORMATAÇÃO DE DATAS ====================

export const formatDate = (dateString: string, includeTime = false): string => {
  const date = new Date(dateString);
  const options: Intl.DateTimeFormatOptions = {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
    ...(includeTime && {
      hour: "2-digit",
      minute: "2-digit",
    }),
  };

  return date.toLocaleDateString("pt-PT", options);
};

export const formatRelativeTime = (dateString: string): string => {
  const date = new Date(dateString);
  const now = new Date();
  const diffInMs = now.getTime() - date.getTime();
  const diffInMinutes = Math.floor(diffInMs / (1000 * 60));
  const diffInHours = Math.floor(diffInMinutes / 60);
  const diffInDays = Math.floor(diffInHours / 24);

  if (diffInMinutes < 1) return "agora mesmo";
  if (diffInMinutes < 60)
    return `há ${diffInMinutes} minuto${diffInMinutes > 1 ? "s" : ""}`;
  if (diffInHours < 24)
    return `há ${diffInHours} hora${diffInHours > 1 ? "s" : ""}`;
  if (diffInDays < 7) return `há ${diffInDays} dia${diffInDays > 1 ? "s" : ""}`;

  return formatDate(dateString);
};

export const formatDuration = (intervalString: string): string => {
  // PostgreSQL interval format: "01:30:00" ou "1 day 02:30:00"
  const match = intervalString.match(
    /(?:(\d+) day[s]?\s+)?(\d{2}):(\d{2}):(\d{2})/
  );

  if (!match) return intervalString;

  const [, days, hours, minutes] = match;
  const parts: string[] = [];

  if (days && parseInt(days) > 0) {
    parts.push(`${days} dia${parseInt(days) > 1 ? "s" : ""}`);
  }

  if (hours && parseInt(hours) > 0) {
    parts.push(`${parseInt(hours)}h`);
  }

  if (minutes && parseInt(minutes) > 0) {
    parts.push(`${parseInt(minutes)}m`);
  }

  return parts.length > 0 ? parts.join(" ") : "0m";
};

// ==================== FORMATAÇÃO DE NÚMEROS ====================

export const formatDistance = (distanceInKm?: number): string => {
  if (!distanceInKm) return "0 km";

  if (distanceInKm < 1) {
    return `${Math.round(distanceInKm * 1000)} m`;
  }

  return `${distanceInKm.toFixed(1)} km`;
};

export const formatPercentage = (value: number, total: number): string => {
  if (total === 0) return "0%";
  return `${Math.round((value / total) * 100)}%`;
};

// ==================== VALIDAÇÕES ====================

export const validateEmail = (email: string): boolean => {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
};

export const validatePhone = (phone: string): boolean => {
  // Formato português: +351 9XXXXXXXX ou 9XXXXXXXX
  const phoneRegex = /^(\+351\s?)?[9][0-9]{8}$/;
  return phoneRegex.test(phone.replace(/\s/g, ""));
};

export const validateLicensePlate = (plate: string): boolean => {
  // Formato português: XX-XX-XX ou novo formato
  const plateRegex =
    /^[A-Z]{2}-[0-9]{2}-[A-Z]{2}$|^[0-9]{2}-[A-Z]{2}-[0-9]{2}$/;
  return plateRegex.test(plate.toUpperCase());
};

// ==================== GEOLOCALIZAÇÃO ====================

export const calculateDistance = (
  point1: [number, number],
  point2: [number, number]
): number => {
  const [lat1, lon1] = point1;
  const [lat2, lon2] = point2;

  const R = 6371; // Raio da Terra em km
  const dLat = ((lat2 - lat1) * Math.PI) / 180;
  const dLon = ((lon2 - lon1) * Math.PI) / 180;

  const a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos((lat1 * Math.PI) / 180) *
      Math.cos((lat2 * Math.PI) / 180) *
      Math.sin(dLon / 2) *
      Math.sin(dLon / 2);

  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  return R * c;
};

export const isPointInPolygon = (
  point: [number, number],
  polygon: [number, number][]
): boolean => {
  const [x, y] = point;
  let inside = false;

  for (let i = 0, j = polygon.length - 1; i < polygon.length; j = i++) {
    const [xi, yi] = polygon[i];
    const [xj, yj] = polygon[j];

    if (yi > y !== yj > y && x < ((xj - xi) * (y - yi)) / (yj - yi) + xi) {
      inside = !inside;
    }
  }

  return inside;
};

// ==================== HELPERS PARA URLs ====================

export const generateApplicationUrl = (token: string): string => {
  const baseUrl =
    typeof window !== "undefined"
      ? window.location.origin
      : process.env.NEXT_PUBLIC_APP_URL || "http://localhost:3000";

  return `${baseUrl}/candidatura-condutor/${token}`;
};

export const generateWhatsAppUrl = (phone: string, message: string): string => {
  const cleanPhone = phone.replace(/[^\d]/g, "");
  const encodedMessage = encodeURIComponent(message);
  return `https://wa.me/${cleanPhone}?text=${encodedMessage}`;
};

// ==================== HELPERS PARA CORES DE STATUS ====================

export const getStatusColor = (
  status: string,
  type: "conductor" | "vehicle" | "application"
): string => {
  switch (type) {
    case "conductor":
      return formatConductorStatus(status as ConductorStatus).color;
    case "vehicle":
      return formatVehicleStatus(status as VehicleStatus).color;
    case "application":
      return formatApplicationStatus(status as ApplicationStatus).color;
    default:
      return "text-gray-600 bg-gray-50";
  }
};

// ==================== HELPERS PARA FILTROS ====================

export const buildFilterQuery = (
  filters: Record<string, string | string[] | number | boolean | undefined>
): string => {
  const params = new URLSearchParams();

  Object.entries(filters).forEach(([key, value]) => {
    if (value !== undefined && value !== null && value !== "") {
      if (Array.isArray(value) && value.length > 0) {
        params.append(key, value.join(","));
      } else if (!Array.isArray(value)) {
        params.append(key, String(value));
      }
    }
  });

  return params.toString();
};

export const parseFilterQuery = (
  queryString: string
): Record<string, string | string[]> => {
  const params = new URLSearchParams(queryString);
  const filters: Record<string, string | string[]> = {};

  params.forEach((value, key) => {
    if (value.includes(",")) {
      filters[key] = value.split(",");
    } else {
      filters[key] = value;
    }
  });

  return filters;
};

// ==================== HELPERS PARA DOCUMENTOS ====================

export const getFileIcon = (fileName: string): string => {
  const extension = fileName.split(".").pop()?.toLowerCase();

  switch (extension) {
    case "pdf":
      return "📄";
    case "jpg":
    case "jpeg":
    case "png":
    case "gif":
      return "🖼️";
    case "doc":
    case "docx":
      return "📝";
    default:
      return "📎";
  }
};

export const formatFileSize = (bytes: number): string => {
  if (bytes === 0) return "0 Bytes";

  const k = 1024;
  const sizes = ["Bytes", "KB", "MB", "GB"];
  const i = Math.floor(Math.log(bytes) / Math.log(k));

  return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + " " + sizes[i];
};

// ==================== CONSTANTS ====================

export const REGIONS = [
  { value: "milfontes", label: "Vila Nova de Milfontes" },
  { value: "odemira", label: "Odemira" },
  { value: "vila_nova", label: "Vila Nova" },
] as const;

export const ZONES = {
  milfontes: [
    { value: "centro", label: "Centro Histórico" },
    { value: "praia", label: "Zona da Praia" },
    { value: "porto", label: "Porto de Pesca" },
  ],
  odemira: [
    { value: "centro", label: "Centro" },
    { value: "industrial", label: "Zona Industrial" },
  ],
  vila_nova: [
    { value: "centro", label: "Centro" },
    { value: "residencial", label: "Zona Residencial" },
  ],
} as const;

export const BLOCK_DURATIONS = [
  { value: "1day", label: "1 dia" },
  { value: "3days", label: "3 dias" },
  { value: "1week", label: "1 semana" },
  { value: "1month", label: "1 mês" },
  { value: "indefinite", label: "Indefinido" },
] as const;

export const BLOCK_REASONS = [
  { value: "behavior", label: "Comportamento inadequado" },
  { value: "complaints", label: "Reclamações de clientes" },
  { value: "vehicle", label: "Problemas com veículo" },
  { value: "documents", label: "Documentação em falta" },
  { value: "safety", label: "Questões de segurança" },
  { value: "other", label: "Outro motivo" },
] as const;
