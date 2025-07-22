// Tipos para o sistema de gestão de condutores e frota

export type ConductorStatus = "active" | "blocked" | "expelled" | "inactive";
export type VehicleStatus = "operational" | "maintenance" | "out_of_service";
export type ApplicationStatus =
  | "link_created"
  | "submitted"
  | "approved"
  | "rejected"
  | "expired";

export interface TukTukVehicle {
  id: string;
  vehicle_number: number;
  vehicle_name: string;
  region: string;
  zone?: string;
  managed_by: string;
  is_available: boolean;
  is_active: boolean;
  current_conductor?: string;
  license_plate?: string;
  vehicle_info: {
    marca?: string;
    modelo?: string;
    ano?: number;
    cor?: string;
    [key: string]: string | number | boolean | undefined;
  };
  maintenance_status: VehicleStatus;
  created_at: string;
  updated_at: string;
  // Relacionamentos
  conductor?: ConductorProfile;
  manager?: AdminProfile;
}

export interface ConductorApplication {
  id: string;
  full_name: string;
  email: string;
  phone: string;
  whatsapp?: string;
  vehicle_info: {
    marca?: string;
    modelo?: string;
    ano?: number;
    matricula?: string;
    [key: string]: string | number | boolean | undefined;
  };
  license_number?: string;
  region: string;
  zone?: string;
  assigned_coordinates?: {
    center: [number, number];
    bounds?: [number, number][];
    radius?: number;
  };
  created_by: string;
  admin_level: "super_admin" | "admin_regional" | "admin_local";
  status: ApplicationStatus;
  documents: {
    driving_license?: string;
    insurance?: string;
    vehicle_registration?: string;
    [key: string]: string;
  };
  created_at: string;
  submitted_at?: string;
  reviewed_at?: string;
  approved_at?: string;
  registration_token: string;
  admin_notes?: string;
  rejection_reason?: string;
  // Relacionamentos
  creator?: AdminProfile;
}

export interface ConductorVehicleSession {
  id: string;
  conductor_id: string;
  vehicle_id: string;
  started_at: string;
  ended_at?: string;
  start_location?: [number, number];
  end_location?: [number, number];
  route_data?: [number, number][];
  total_distance?: number;
  total_time?: string; // PostgreSQL interval
  rides_completed: number;
  is_active: boolean;
  // Relacionamentos
  conductor?: ConductorProfile;
  vehicle?: TukTukVehicle;
}

export interface ConductorProfile {
  id: string;
  user_id?: string;
  name: string;
  email: string;
  whatsapp?: string;
  region: string;
  vehicle_info?: {
    marca?: string;
    modelo?: string;
    ano?: number;
    matricula?: string;
    [key: string]: string | number | boolean | undefined;
  };
  license_number?: string;
  is_active: boolean;
  status: ConductorStatus;
  assigned_vehicle?: string;
  blocked_by?: string;
  blocked_at?: string;
  block_reason?: string;
  restricted_zone?: {
    center: [number, number];
    bounds: [number, number][];
    name?: string;
    description?: string;
  };
  created_by?: string;
  created_at: string;
  updated_at: string;
  // Relacionamentos
  vehicle?: TukTukVehicle;
  blocker?: AdminProfile;
  active_session?: ConductorVehicleSession;
}

export interface AdminProfile {
  id: string;
  email: string;
  full_name: string;
  role: "admin";
  admin_level: "super_admin" | "admin_regional" | "admin_local";
  region: string;
  zone?: string;
  created_at: string;
  updated_at: string;
}

// Tipos para ações de gestão
export interface BlockConductorParams {
  conductorId: string;
  reason: string;
  duration?: "1day" | "3days" | "1week" | "1month" | "indefinite";
  details?: string;
}

export interface ExpelConductorParams {
  conductorId: string;
  reason: string;
  details: string;
}

export interface AssignVehicleParams {
  conductorId: string;
  vehicleId: string;
}

export interface CreateApplicationParams {
  region: string;
  zone?: string;
  coordinates?: {
    center: [number, number];
    bounds?: [number, number][];
  };
  adminNotes?: string;
}

export interface SubmitApplicationParams {
  token: string;
  personalInfo: {
    fullName: string;
    email: string;
    phone: string;
    whatsapp?: string;
  };
  vehicleInfo: {
    marca: string;
    modelo: string;
    ano: number;
    matricula: string;
  };
  licenseNumber: string;
  documents?: {
    drivingLicense?: File;
    insurance?: File;
    vehicleRegistration?: File;
  };
}

export interface UpdateApplicationStatusParams {
  applicationId: string;
  status: "approved" | "rejected";
  adminNotes?: string;
  rejectionReason?: string;
}

// Tipos para estatísticas e dashboards
export interface FleetStats {
  totalVehicles: number;
  operationalVehicles: number;
  maintenanceVehicles: number;
  activeVehicles: number; // Em uso no momento
  availableVehicles: number;
}

export interface ConductorStats {
  totalConductors: number;
  activeConductors: number;
  blockedConductors: number;
  expelledConductors: number;
  inactiveConductors: number;
}

export interface ApplicationStats {
  pendingApplications: number;
  submittedApplications: number;
  approvedApplications: number;
  rejectedApplications: number;
  expiredApplications: number;
}

export interface RegionalDashboard {
  region: string;
  fleetStats: FleetStats;
  conductorStats: ConductorStats;
  applicationStats: ApplicationStats;
  activeSessions: number;
  lastUpdated: string;
}

// Tipos para filtros e paginação
export interface ConductorFilters {
  status?: ConductorStatus[];
  region?: string[];
  hasVehicle?: boolean;
  searchTerm?: string;
}

export interface VehicleFilters {
  status?: VehicleStatus[];
  region?: string[];
  zone?: string[];
  isAvailable?: boolean;
  isActive?: boolean;
  searchTerm?: string;
}

export interface ApplicationFilters {
  status?: ApplicationStatus[];
  region?: string[];
  createdBy?: string[];
  dateRange?: {
    from: string;
    to: string;
  };
}

export interface PaginationParams {
  page: number;
  limit: number;
  sortBy?: string;
  sortOrder?: "asc" | "desc";
}

export interface PaginatedResponse<T> {
  data: T[];
  pagination: {
    page: number;
    limit: number;
    total: number;
    totalPages: number;
    hasNextPage: boolean;
    hasPreviousPage: boolean;
  };
}
