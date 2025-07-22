import React, { useState, useEffect } from 'react';
import { getAllReservations, getAllConductors, assignConductorToReservation } from '../services/adminService';

interface Reservation {
  id: string;
  reservation_date: string;
  reservation_time: string;
  customer_name: string;
  tour_type: string;
  status: string;
  assigned_conductor_id: string | null;
}

interface Conductor {
  id: string;
  name: string;
}

function AdminReservationManagement() {
  const [reservations, setReservations] = useState<Reservation[]>([]);
  const [conductors, setConductors] = useState<Conductor[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [selectedConductorId, setSelectedConductorId] = useState<string | null>(null);
  const [editingReservationId, setEditingReservationId] = useState<string | null>(null);

  const fetchAllData = async () => {
    try {
      setLoading(true);
      const [reservationsData, conductorsData] = await Promise.all([
        getAllReservations(),
        getAllConductors()
      ]);
      setReservations(reservationsData);
      setConductors(conductorsData);
      setError(null);
    } catch (err: Error) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchAllData();
  }, []);

  const handleAssignConductor = async (reservationId: string) => {
    if (!selectedConductorId) {
      alert('Por favor, selecione um condutor para atribuir.');
      return;
    }
    try {
      setLoading(true);
      await assignConductorToReservation(reservationId, selectedConductorId);
      await fetchAllData(); // Recarrega os dados
      setEditingReservationId(null); // Sai do modo de edição
      alert('Condutor atribuído à reserva com sucesso!');
    } catch (err: any) {
      setError(`Erro ao atribuir condutor: ${err.message}`);
    } finally {
      setLoading(false);
    }
  };

  if (loading) return <div className="admin-card loading"><p>A carregar gestão de reservas...</p></div>;
  if (error) return <div className="admin-card error"><p>Erro: {error}</p></div>;

  return (
    <div className="admin-card reservation-management-card">
      <h3>Gestão de Reservas</h3>
      <table>
        <thead>
          <tr>
            <th>Data</th>
            <th>Hora</th>
            <th>Cliente</th>
            <th>Tipo de Tour</th>
            <th>Status</th>
            <th>Condutor Atribuído</th>
            <th>Ações</th>
          </tr>
        </thead>
        <tbody>
          {reservations.map(reservation => (
            <tr key={reservation.id}>
              <td>{reservation.reservation_date}</td>
              <td>{reservation.reservation_time}</td>
              <td>{reservation.customer_name}</td>
              <td>{reservation.tour_type}</td>
              <td>{reservation.status}</td>
              <td>
                {reservation.assigned_conductor_id ?
                  (conductors.find(c => c.id === reservation.assigned_conductor_id)?.name || 'Desconhecido')
                  : 'Nenhum'}
              </td>
              <td>
                {editingReservationId === reservation.id ? (
                  <>
                    <select
                      value={selectedConductorId || ''}
                      onChange={(e) => setSelectedConductorId(e.target.value)}
                    >
                      <option value="">Selecione</option>
                      {conductors.map(conductor => (
                        <option key={conductor.id} value={conductor.id}>
                          {conductor.name}
                        </option>
                      ))}
                    </select>
                    <button
                      onClick={() => handleAssignConductor(reservation.id)}
                      disabled={loading || !selectedConductorId}
                      className="action-button save"
                    >
                      Salvar
                    </button>
                    <button
                      onClick={() => setEditingReservationId(null)}
                      className="action-button cancel"
                    >
                      Cancelar
                    </button>
                  </>
                ) : (
                  <button
                    onClick={() => {
                      setEditingReservationId(reservation.id);
                      setSelectedConductorId(reservation.assigned_conductor_id || null);
                    }}
                    disabled={loading}
                    className="action-button edit"
                  >
                    Atribuir/Alterar
                  </button>
                )}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default AdminReservationManagement;