import React, { useState, useEffect } from 'react';
import {
  getBlockedPeriods,
  addBlockedPeriod,
  deleteBlockedPeriod
} from '../services/conductorService';
import { AdminReservation, BlockedPeriod } from '@/types/adminReservations'; // Importar BlockedPeriod

interface ConductorBlockedPeriodsProps {
  conductorId?: string;
}

function ConductorBlockedPeriods({ conductorId }: ConductorBlockedPeriodsProps) {
  const [blockedPeriods, setBlockedPeriods] = useState<BlockedPeriod[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [newBlockDate, setNewBlockDate] = useState('');
  const [newBlockReason, setNewBlockReason] = useState('');
  const [newBlockStartTime, setNewBlockStartTime] = useState('');
  const [newBlockEndTime, setNewBlockEndTime] = useState('');

  const fetchBlockedPeriods = async () => {
    try {
      setLoading(true);
      const data = await getBlockedPeriods(conductorId);
      setBlockedPeriods(data);
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : String(err));
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchBlockedPeriods();
  }, [conductorId]);

  const handleAddBlockedPeriod = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      setLoading(true);
      await addBlockedPeriod(
        newBlockDate,
        newBlockStartTime || undefined,
        newBlockEndTime || undefined,
        newBlockReason || undefined,
        conductorId
      );
      setNewBlockDate('');
      setNewBlockReason('');
      setNewBlockStartTime('');
      setNewBlockEndTime('');
      setError(null);
      await fetchBlockedPeriods(); // Recarrega a lista
    } catch (err: unknown) {
      setError(`Erro ao adicionar bloqueio: ${err instanceof Error ? err.message : String(err)}`);
    } finally {
      setLoading(false);
    }
  };

  const handleDeleteBlockedPeriod = async (id: string) => {
    try {
      setLoading(true);
      await deleteBlockedPeriod(id, conductorId);
      setError(null);
      await fetchBlockedPeriods(); // Recarrega a lista
    } catch (err: unknown) {
      setError(`Erro ao remover bloqueio: ${err instanceof Error ? err.message : String(err)}`);
    } finally {
      setLoading(false);
    }
  };

  if (loading) return <div className="blocked-periods-card loading"><p>A carregar períodos bloqueados...</p></div>;
  if (error) return <div className="blocked-periods-card error"><p>Erro: {error}</p></div>;

  return (
    <div className="blocked-periods-card">
      <h3>Meus Períodos Bloqueados</h3>
      <form onSubmit={handleAddBlockedPeriod} className="add-block-form">
        <input
          type="date"
          value={newBlockDate}
          onChange={(e) => setNewBlockDate(e.target.value)}
          required
        />
        <input
          type="time"
          value={newBlockStartTime}
          onChange={(e) => setNewBlockStartTime(e.target.value)}
          placeholder="Início (HH:mm)"
        />
        <input
          type="time"
          value={newBlockEndTime}
          onChange={(e) => setNewBlockEndTime(e.target.value)}
          placeholder="Fim (HH:mm)"
        />
        <input
          type="text"
          placeholder="Motivo (opcional)"
          value={newBlockReason}
          onChange={(e) => setNewBlockReason(e.target.value)}
        />
        <button type="submit" disabled={loading}>Adicionar Bloqueio</button>
      </form>

      {blockedPeriods.length === 0 ? (
        <p>Nenhum período bloqueado.</p>
      ) : (
        <ul className="blocked-periods-list">
          {blockedPeriods.map(period => (
            <li key={period.id}>
              <span>
                {period.date} {period.startTime && period.endTime ? `(${period.startTime} - ${period.endTime})` : '(Dia todo)'}
                {period.reason && ` - ${period.reason}`}
              </span>
              <button onClick={() => handleDeleteBlockedPeriod(period.id)} disabled={loading}>Remover</button>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}

export default ConductorBlockedPeriods;
