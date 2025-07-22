import React, { useState, useEffect } from 'react';
import { getAllConductors } from '../services/adminService';

interface Conductor {
  id: string;
  name: string;
  whatsapp: string;
  is_active: boolean;
  created_at: string;
}

function AdminConductorOverview() {
  const [conductors, setConductors] = useState<Conductor[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fetchConductors = async () => {
    try {
      setLoading(true);
      const data = await getAllConductors();
      setConductors(data);
      setError(null);
    } catch (err: Error) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchConductors();
  }, []);

  if (loading) return <div className="admin-card loading"><p>A carregar visão geral dos condutores...</p></div>;
  if (error) return <div className="admin-card error"><p>Erro: {error}</p></div>;

  return (
    <div className="admin-card conductor-overview-card">
      <h3>Visão Geral dos Condutores</h3>
      <table>
        <thead>
          <tr>
            <th>Nome</th>
            <th>WhatsApp</th>
            <th>Ativo (Status Mestre)</th>
            <th>Criado Em</th>
          </tr>
        </thead>
        <tbody>
          {conductors.map(conductor => (
            <tr key={conductor.id}>
              <td>{conductor.name}</td>
              <td>{conductor.whatsapp}</td>
              <td>{conductor.is_active ? 'Sim' : 'Não'}</td>
              <td>{new Date(conductor.created_at).toLocaleDateString()}</td>
            </tr>
          ))}
        </tbody>
      </table>
      <p className="note">
        * O status "Ativo" acima refere-se ao registro mestre do condutor.
        A disponibilidade diária é gerenciada individualmente por cada condutor em seu próprio painel.
      </p>
    </div>
  );
}

export default AdminConductorOverview;