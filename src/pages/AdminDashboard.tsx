import React from "react";
import AdminUserManagement from "../components/AdminUserManagement";
import AdminReservationManagement from "../components/AdminReservationManagement";
import AdminConductorOverview from "../components/AdminConductorOverview";
import DevCacheHelper from "@/components/DevCacheHelper";
import "../styles/AdminDashboard.css"; // Importa o CSS para esta página e seus componentes

function AdminDashboard() {
  return (
    <div className="admin-dashboard-container">
      <header className="dashboard-header">
        <h2>Painel de Administração</h2>
        <p>Gerencie usuários, condutores e reservas da aplicação.</p>
      </header>

      <div className="dashboard-content">
        <section className="dashboard-section user-management-section">
          <AdminUserManagement />
        </section>

        <section className="dashboard-section reservation-management-section">
          <AdminReservationManagement />
        </section>

        <section className="dashboard-section conductor-overview-section">
          <AdminConductorOverview />
        </section>
      </div>

      {/* Helper de cache para desenvolvimento */}
      <DevCacheHelper />
    </div>
  );
}

export default AdminDashboard;
