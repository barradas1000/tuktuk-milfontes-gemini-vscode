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

  // Função auxiliar para formatar a data
  const formatDate = (date: string) =>
    new Date(date).toLocaleDateString('pt-PT');

  // Buscar condutores da API
  const fetchConductors = async () => {
    try {
      const data = await getAllConductors();
      setConductors(data);
      setError(null);
    } catch (err: unknown) {
      const message = err instanceof Error ? err.message : 'Erro desconhecido.';
      setError(message);
    } finally {
      setLoading(false);
    }
  };

  // Carregar os dados quando o componente for montado
  useEffect(() => {
    fetchConductors();
  }, []);

  // Estado de carregamento
  if (loading) {
    return (
      <div className="admin-card loading">
        <p>A carregar visão geral dos condutores...</p>
      </div>
    );
  }

  // Estado de erro
  if (error) {
    return (
      <div className="admin-card error">
        <p>Erro: {error}</p>
      </div>
    );
  }

  // Renderização principal da tabela
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
          {conductors.map(({ id, name, whatsapp, is_active, created_at }) => (
            <tr key={id}>
              <td>{name}</td>
              <td>{whatsapp}</td>
              <td>{is_active ? 'Sim' : 'Não'}</td>
              <td>{formatDate(created_at)}</td>
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
