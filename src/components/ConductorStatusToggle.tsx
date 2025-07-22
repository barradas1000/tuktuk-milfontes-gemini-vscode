import React, { useState, useEffect } from 'react';
import { getConductorActiveStatus, updateConductorActiveStatus } from '../services/conductorService';

interface ConductorStatusToggleProps {
  conductorId?: string;
}

function ConductorStatusToggle({ conductorId }: ConductorStatusToggleProps) {
  const [isActive, setIsActive] = useState(false);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    async function fetchStatus() {
      setLoading(true);
      try {
        const status = await getConductorActiveStatus(conductorId);
        setIsActive(status);
      } catch (err: unknown) {
        setError(err instanceof Error ? err.message : String(err));
      } finally {
        setLoading(false);
      }
    }
    fetchStatus();
  }, [conductorId]);

  const handleToggle = async () => {
    try {
      setLoading(true);
      const newStatus = !isActive;
      await updateConductorActiveStatus(newStatus, conductorId);
      setIsActive(newStatus);
      setError(null);
    } catch (err: unknown) {
      setError(`Erro ao atualizar status: ${err instanceof Error ? err.message : String(err)}`);
    } finally {
      setLoading(false);
    }
  };

  if (loading) return <div className="status-toggle-card loading"><p>A carregar status...</p></div>;
  if (error) return <div className="status-toggle-card error"><p>Erro: {error}</p></div>;

  return (
    <div className="status-toggle-card">
      <h3>Meu Status</h3>
      <p>Você está: <strong className={isActive ? 'status-active' : 'status-inactive'}>{isActive ? 'Ativo' : 'Inativo'}</strong></p>
      <button
        onClick={handleToggle}
        disabled={loading}
        className={`toggle-button ${isActive ? 'active' : 'inactive'}`}
      >
        {isActive ? 'Desativar' : 'Ativar'}
      </button>
    </div>
  );
}

export default ConductorStatusToggle;
