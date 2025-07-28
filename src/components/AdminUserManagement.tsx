import React, { useState, useEffect } from "react";
import { useAuth } from "../hooks/useAuth";
import { useNavigate } from "react-router-dom";
import {
  getAllProfiles,
  getAllConductors,
  assignConductorRole,
  removeConductorRole,
} from "../services/adminService";

interface Profile {
  id: string;
  full_name: string | null;
  email: string;
  role: string;
}

interface Conductor {
  id: string;
  name: string;
  user_id: string | null; // Nova relação
}

function AdminUserManagement() {
  console.log("[AdminUserManagement] Componente montado");
  const { profile, refreshProfile } = useAuth();
  const navigate = useNavigate();
  const [profiles, setProfiles] = useState<Profile[]>([]);
  const [conductors, setConductors] = useState<Conductor[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [selectedConductorId, setSelectedConductorId] = useState<string | null>(
    null
  );

  const fetchAllData = async () => {
    console.log("[AdminUserManagement] Iniciando fetch de perfis e condutores");
    try {
      setLoading(true);
      const [profilesData, conductorsData] = await Promise.all([
        getAllProfiles(),
        getAllConductors(),
      ]);
      console.log("[AdminUserManagement] Perfis carregados:", profilesData);
      console.log(
        "[AdminUserManagement] Condutores carregados:",
        conductorsData
      );
      setProfiles(profilesData);
      setConductors(conductorsData);
      setError(null);
    } catch (err: unknown) {
      console.error("[AdminUserManagement] Erro ao carregar dados:", err);
      setError(err instanceof Error ? err.message : "Erro desconhecido");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchAllData();
  }, []);

  const handleAssignConductorRole = async (userId: string) => {
    console.log(
      `[AdminUserManagement] Iniciando atribuição de papel de condutor para usuário: ${userId}, condutor: ${selectedConductorId}`
    );
    if (!selectedConductorId) {
      alert("Por favor, selecione um condutor para atribuir.");
      return;
    }
    try {
      setLoading(true);
      await assignConductorRole(userId, selectedConductorId);
      console.log(
        `[AdminUserManagement] Papel de condutor atribuído para usuário: ${userId}`
      );
      await fetchAllData(); // Recarrega os dados
      alert("Papel de condutor atribuído com sucesso!");
      // Se o usuário logado mudou seu próprio papel
      if (profile?.id === userId) {
        console.log(
          "[AdminUserManagement] Usuário logado mudou seu próprio papel para condutor, atualizando perfil e redirecionando"
        );
        await refreshProfile();
        navigate("/condutor/dashboard");
      }
    } catch (err: unknown) {
      console.error(
        `[AdminUserManagement] Erro ao atribuir papel de condutor para usuário: ${userId}`,
        err
      );
      setError(
        `Erro ao atribuir papel: ${
          err instanceof Error ? err.message : "Erro desconhecido"
        }`
      );
    } finally {
      setLoading(false);
    }
  };

  const handleRemoveConductorRole = async (userId: string) => {
    console.log(
      `[AdminUserManagement] Iniciando remoção de papel de condutor para usuário: ${userId}`
    );
    if (
      !window.confirm(
        "Tem certeza que deseja remover o papel de condutor deste usuário?"
      )
    ) {
      return;
    }
    try {
      setLoading(true);
      await removeConductorRole(userId);
      console.log(
        `[AdminUserManagement] Papel de condutor removido para usuário: ${userId}`
      );
      await fetchAllData(); // Recarrega os dados
      alert("Papel de condutor removido com sucesso!");
      // Se o usuário logado mudou seu próprio papel
      if (profile?.id === userId) {
        console.log(
          "[AdminUserManagement] Usuário logado mudou seu próprio papel para admin, atualizando perfil e redirecionando"
        );
        await refreshProfile();
        navigate("/admin");
      }
    } catch (err: unknown) {
      console.error(
        `[AdminUserManagement] Erro ao remover papel de condutor para usuário: ${userId}`,
        err
      );
      setError(
        `Erro ao remover papel: ${
          err instanceof Error ? err.message : "Erro desconhecido"
        }`
      );
    } finally {
      setLoading(false);
    }
  };

  if (loading)
    return (
      <div className="admin-card loading">
        <p>A carregar gestão de usuários...</p>
      </div>
    );
  if (error)
    return (
      <div className="admin-card error">
        <p>Erro: {error}</p>
      </div>
    );

  return (
    <div className="admin-card user-management-card">
      <h3>Gestão de Usuários</h3>
      <div className="filter-controls">
        <label htmlFor="conductor-select">Atribuir Condutor:</label>
        <select
          id="conductor-select"
          value={selectedConductorId || ""}
          onChange={(e) => setSelectedConductorId(e.target.value)}
        >
          <option value="">Selecione um Condutor</option>
          {conductors.map((conductor) => (
            <option key={conductor.id} value={conductor.id}>
              {conductor.name}
            </option>
          ))}
        </select>
      </div>
      <table>
        <thead>
          <tr>
            <th>Nome Completo</th>
            <th>Email</th>
            <th>Papel</th>
            <th>Condutor Associado</th>
            <th>Ações</th>
          </tr>
        </thead>
        <tbody>
          {profiles.map((profile) => (
            <tr key={profile.id}>
              <td>{profile.full_name || "N/A"}</td>
              <td>{profile.email}</td>
              <td>{profile.role}</td>
              <td>
                {/* Nova lógica: buscar condutor pelo user_id */}
                {(() => {
                  const associatedConductor = conductors.find(
                    (c) => c.user_id === profile.id
                  );
                  return associatedConductor
                    ? associatedConductor.name
                    : "Nenhum";
                })()}
              </td>
              <td>
                {profile.role !== "condutor" && (
                  <button
                    onClick={() => handleAssignConductorRole(profile.id)}
                    disabled={loading || !selectedConductorId}
                    className="action-button assign"
                  >
                    Atribuir Condutor
                  </button>
                )}
                {profile.role === "condutor" && (
                  <button
                    onClick={() => handleRemoveConductorRole(profile.id)}
                    disabled={loading}
                    className="action-button remove"
                  >
                    Remover Papel
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

export default AdminUserManagement;
