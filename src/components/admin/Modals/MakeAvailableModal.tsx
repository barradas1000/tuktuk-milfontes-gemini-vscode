import React from "react";
import { format } from "date-fns";
import { pt } from "date-fns/locale";

import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";

import { useAdminCalendar } from "../AdminCalendarProvider";

interface MakeAvailableModalProps {
  makeAvailableModalOpen: boolean;
  setMakeAvailableModalOpen: (open: boolean) => void;
}

const MakeAvailableModal = ({
  makeAvailableModalOpen,
  setMakeAvailableModalOpen,
}: MakeAvailableModalProps) => {
  const { slotToMakeAvailable, blockDate, makeTimeAvailable } = useAdminCalendar();

  return (
    <Dialog
      open={makeAvailableModalOpen}
      onOpenChange={setMakeAvailableModalOpen}
    >
      <DialogContent className="max-w-md">
        <DialogHeader>
          <DialogTitle>Tornar Horário Disponível</DialogTitle>
        </DialogHeader>
        <div className="space-y-4">
          <p className="text-sm">
            Deseja tornar o horário{" "}
            <strong>{slotToMakeAvailable}</strong> do dia{" "}
            <strong>
              {blockDate && format(blockDate, "dd/MM/yyyy", { locale: pt })}
            </strong>{" "}
            disponível?
          </p>
          <div className="flex justify-end gap-2">
            <Button
              variant="outline"
              onClick={() => setMakeAvailableModalOpen(false)}
            >
              Cancelar
            </Button>
            <Button
              onClick={() => {
                if (blockDate && slotToMakeAvailable) {
                  makeTimeAvailable(blockDate, slotToMakeAvailable);
                  setMakeAvailableModalOpen(false);
                }
              }}
            >
              Confirmar
            </Button>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
};

export default MakeAvailableModal;
