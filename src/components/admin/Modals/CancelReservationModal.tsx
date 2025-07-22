import React from "react";
import { XCircle } from "lucide-react";

import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";

import { useAdminCalendar } from "../AdminCalendarProvider";

interface CancelReservationModalProps {
  cancelReservationModalOpen: boolean;
  setCancelReservationModalOpen: (open: boolean) => void;
}

const CancelReservationModal = ({
  cancelReservationModalOpen,
  setCancelReservationModalOpen,
}: CancelReservationModalProps) => {
  const {
    reservationToCancel,
    cancelReason,
    setCancelReason,
    cancelReservation,
    isCancelling,
    getTourDisplayName,
    setReservationToCancel,
  } = useAdminCalendar();

  return (
    <Dialog
      open={cancelReservationModalOpen}
      onOpenChange={setCancelReservationModalOpen}
    >
      <DialogContent className="max-h-[80vh] overflow-hidden">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2">
            <XCircle className="h-5 w-5 text-red-500" />
            Anular Reserva
          </DialogTitle>
        </DialogHeader>
        {reservationToCancel && (
          <div className="space-y-4 overflow-y-auto max-h-[calc(80vh-120px)] pr-2">
            <div className="p-4 bg-red-50 border border-red-200 rounded-lg">
              <h4 className="font-semibold text-red-800 mb-2">
                Confirmar anulação da reserva:
              </h4>
              <div className="space-y-1 text-sm">
                <p>
                  <strong>Cliente:</strong>{" "}
                  {reservationToCancel.customer_name}
                </p>
                <p>
                  <strong>Telefone:</strong>{" "}
                  {reservationToCancel.customer_phone}
                </p>
                <p>
                  <strong>Tour:</strong>{" "}
                  {getTourDisplayName(reservationToCancel.tour_type)}
                </p>
                <p>
                  <strong>Data:</strong>{" "}
                  {reservationToCancel.reservation_date}
                </p>
                <p>
                  <strong>Hora:</strong>{" "}
                  {reservationToCancel.reservation_time}
                </p>
                <p>
                  <strong>Pessoas:</strong>{" "}
                  {reservationToCancel.number_of_people}
                </p>
                <p>
                  <strong>Valor:</strong> €{reservationToCancel.total_price}
                </p>
              </div>
            </div>
            <div className="space-y-2">
              <Label htmlFor="cancel-reason">
                Motivo da anulação (opcional):
              </Label>
              <Textarea
                id="cancel-reason"
                placeholder="Ex: Cliente solicitou cancelamento, condições meteorológicas, etc."
                value={cancelReason}
                onChange={(e) => setCancelReason(e.target.value)}
                rows={3}
              />
            </div>
            <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-3">
              <p className="text-sm text-yellow-800">
                <strong>Atenção:</strong> Esta ação irá:
              </p>
              <ul className="text-sm text-yellow-700 mt-1 list-disc list-inside">
                <li>Alterar o status da reserva para "Cancelada"</li>
                <li>Enviar uma mensagem automática via WhatsApp para o cliente</li>
                <li>Liberar o horário para novas reservas</li>
              </ul>
            </div>
          </div>
        )}
        <DialogFooter>
          <Button
            variant="destructive"
            onClick={() =>
              reservationToCancel &&
              cancelReservation(reservationToCancel, cancelReason)
            }
            disabled={isCancelling}
          >
            {isCancelling ? "Anulando..." : "Confirmar Anulação"}
          </Button>
          <Button
            variant="outline"
            onClick={() => {
              setCancelReservationModalOpen(false);
              setReservationToCancel(null);
              setCancelReason("");
            }}
            disabled={isCancelling}
          >
            Cancelar
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
};

export default CancelReservationModal;
