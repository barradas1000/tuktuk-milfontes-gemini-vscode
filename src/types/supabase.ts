export interface Coordinates {
  lat: number;
  lng: number;
}

export interface ConductorLocation {
  id: string;
  lat: number;
  lng: number;
  isActive: boolean;
  name: string;
}

export interface Reservation {
  id: number;
  created_at: string;
  user_id: string;
  assigned_conductor_id: string; // Nome correto da coluna na base de dados
  start_time: string;
  end_time: string;
  start_location: string;
  end_location: string;
  status: "pending" | "confirmed" | "cancelled" | "completed";
  num_passengers: number;
  total_price: number;
  notes?: string;
}

export interface BlockedPeriod {
  id: number;
  date: string;
  start_time?: string;
  end_time?: string;
  reason?: string;
  created_by: string; // Nome do condutor que criou o bloqueio
}
