import React from "react";
import { format } from "date-fns";
import { pt } from "date-fns/locale";
import { AlertCircle, CheckCircle, XCircle } from "lucide-react";

import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogClose,
} from "@/components/ui/dialog";
import { Badge } from "@/components/ui/badge";

import { useAdminCalendar } from "../AdminCalendarProvider";

interface QuickViewModalProps {
  quickViewOpen: boolean;
  setQuickViewOpen: (open: boolean) => void;
}

const QuickViewModal = ({ quickViewOpen, setQuickViewOpen }: QuickViewModalProps) => {
  const {
    quickViewDate,
    getReservationsByDate,
    getTourDisplayName,
    getStatusBadge,
  } = useAdminCalendar();

  return (
    <Dialog open={quickViewOpen} onOpenChange={setQuickViewOpen}>
      <DialogContent className="max-w-lg">
        <DialogHeader>
          <DialogTitle>
            Reservas em{" "}
            {quickViewDate
              ? format(quickViewDate, "dd/MM/yyyy", { locale: pt })
              : ""}
          </DialogTitle>
        </DialogHeader>
        <div className="space-y-4">
          {quickViewDate &&
            getReservationsByDate(format(quickViewDate, "yyyy-MM-dd"))
              .length === 0 && (
              <div className="text-center text-gray-500">
                Nenhuma reserva para este dia.
              </div>
            )}
          {quickViewDate &&
            getReservationsByDate(format(quickViewDate, "yyyy-MM-dd")).map(
              (reserva) => (
                <div
                  key={reserva.id}
                  className="p-3 rounded-lg border bg-white shadow flex flex-col gap-1"
                >
                  <div className="flex justify-between items-center">
                    <span className="font-semibold">
                      {reserva.customer_name}
                    </span>
                    {(() => {
                      const badgeProps = getStatusBadge(reserva.status);
                      const IconComponent = (() => {
                        switch (reserva.status) {
                          case "pending":
                            return AlertCircle;
                          case "confirmed":
                            return CheckCircle;
                          case "cancelled":
                            return XCircle;
                          case "completed":
                            return CheckCircle;
                          default:
                            return null;
                        }
                      })();
                      return (
                        <Badge
                          className={`${badgeProps.color} flex items-center gap-1`}
                        >
                          {IconComponent && (
                            <IconComponent className="h-3 w-3" />
                          )}
                          {badgeProps.text}
                        </Badge>
                      );
                    })()}
                  </div>
                  <div className="flex flex-wrap gap-2 text-sm mt-1">
                    <span>
                      <b>Pagamento:</b>{" "}
                      {reserva.total_price ? `€${reserva.total_price}` : "-"}
                    </span>
                    <span>
                      <b>Percurso:</b>{" "}
                      {getTourDisplayName(reserva.tour_type)}
                    </span>
                    <span>
                      <b>Hora:</b> {reserva.reservation_time}
                    </span>
                    <span>
                      <b>Pessoas:</b> {reserva.number_of_people}
                    </span>
                  </div>
                  {reserva.special_requests && (
                    <div className="text-xs text-gray-500 italic mt-1">
                      "{reserva.special_requests}"
                    </div>
                  )}
                </div>
              )
            )}
        </div>
        <DialogClose asChild>
          <Button variant="outline" className="mt-4 w-full">
            Fechar
          </Button>
        </DialogClose>
      </DialogContent>
    </Dialog>
  );
};

export default QuickViewModal;
