import React, { useState, useEffect } from 'react';
import { getAssignedReservations } from '../services/conductorService';
import { AdminReservation } from '@/types/adminReservations'; // Importar AdminReservation

interface ConductorReservationsListProps {
  conductorId?: string;
}

function ConductorReservationsList({ conductorId }: ConductorReservationsListProps) {
  const [reservations, setReservations] = useState<AdminReservation[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    async function fetchReservations() {
      setLoading(true);
      try {
        const data = await getAssignedReservations(conductorId);
        setReservations(data);
      } catch (err: unknown) {
        setError(err instanceof Error ? err.message : String(err));
      } finally {
        setLoading(false);
      }
    }
    fetchReservations();
  }, [conductorId]);

  if (loading) return <div className="reservations-list-card loading"><p>A carregar reservas...</p></div>;
  if (error) return <div className="reservations-list-card error"><p>Erro: {error}</p></div>;
  if (reservations.length === 0) return <div className="reservations-list-card"><p>Nenhuma reserva atribuída a você.</p></div>;

  return (
    <div className="reservations-list-card">
      <h3>Minhas Reservas</h3>
      <table>
        <thead>
          <tr>
            <th>Data</th>
            <th>Hora</th>
            <th>Tipo de Tour</th>
            <th>Cliente</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          {reservations.map(res => (
            <tr key={res.id}>
              <td>{res.reservation_date}</td>
              <td>{res.reservation_time}</td>
              <td>{res.tour_type}</td>
              <td>{res.customer_name}</td>
              <td>{res.status}</td>
            </tr>
          ))
          }
        </tbody>
      </table>
    </div>
  );
}

export default ConductorReservationsList;
