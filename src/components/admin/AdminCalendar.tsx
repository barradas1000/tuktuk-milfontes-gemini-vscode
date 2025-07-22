// tuktuk-milfontes-gemini/src/components/admin/AdminCalendar.tsx
import React from "react";
import ErrorBoundary from "../ErrorBoundary"; // Importe o ErrorBoundary
import { AdminCalendarProvider, useAdminCalendar } from "./AdminCalendarProvider";
import ActiveConductorsPanel from "./ActiveConductorsPanel";
import CalendarDisplay from "./CalendarDisplay";
import AvailabilityCard from "./AvailabilityCard";
import BlockManagementSection from "./BlockManagementSection";
import QuickViewModal from "./Modals/QuickViewModal";
import BlockDayModal from "./Modals/BlockDayModal";
import BlockHourModal from "./Modals/BlockHourModal";
import CancelReservationModal from "./Modals/CancelReservationModal";
import WhatsappMessageModal from "./Modals/WhatsappMessageModal";
import MakeAvailableModal from "./Modals/MakeAvailableModal";
import ClearHoursModal from "./Modals/ClearHoursModal";

// CSS personalizado para esconder scrollbar
import "./AdminCalendar.css"; // Importe o arquivo CSS

// --- Interfaces ---
interface AdminCalendarProps {
  selectedDate: string;
  onDateSelect: (date: string) => void;
}

const AdminCalendar = ({ selectedDate, onDateSelect }: AdminCalendarProps) => {
  console.log("AdminCalendar rendered");
  return (
    <ErrorBoundary>
      <AdminCalendarProvider selectedDate={selectedDate} onDateSelect={onDateSelect}>
        <AdminCalendarContent />
      </AdminCalendarProvider>
    </ErrorBoundary>
  );
};

const AdminCalendarContent = () => {
  console.log("AdminCalendarContent rendered");
  const {
    quickViewOpen,
    setQuickViewOpen,
    cancelReservationModalOpen,
    setCancelReservationModalOpen,
    whatsappMessageModalOpen,
    setWhatsappMessageModalOpen,
    makeAvailableModalOpen,
    setMakeAvailableModalOpen,
    clearHoursModalOpen,
    setClearHoursModalOpen,
  } = useAdminCalendar();

  return (
    <div>
      <ActiveConductorsPanel />
      <AvailabilityCard />
      <CalendarDisplay />
      <BlockManagementSection />
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Modals */}
        <QuickViewModal
          quickViewOpen={quickViewOpen}
          setQuickViewOpen={setQuickViewOpen}
        />
        <BlockDayModal />
        <BlockHourModal />
        <CancelReservationModal
          cancelReservationModalOpen={cancelReservationModalOpen}
          setCancelReservationModalOpen={setCancelReservationModalOpen}
        />
        <WhatsappMessageModal
          whatsappMessageModalOpen={whatsappMessageModalOpen}
          setWhatsappMessageModalOpen={setWhatsappMessageModalOpen}
        />
        <MakeAvailableModal
          makeAvailableModalOpen={makeAvailableModalOpen}
          setMakeAvailableModalOpen={setMakeAvailableModalOpen}
        />
        <ClearHoursModal
          clearHoursModalOpen={clearHoursModalOpen}
          setClearHoursModalOpen={setClearHoursModalOpen}
        />
      </div>
    </div>
  );
};

export default AdminCalendar;
