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

interface ClearHoursModalProps {
  clearHoursModalOpen: boolean;
  setClearHoursModalOpen: (open: boolean) => void;
}

const ClearHoursModal = ({
  clearHoursModalOpen,
  setClearHoursModalOpen,
}: ClearHoursModalProps) => {
  const {
    hoursToClear,
    blockDate,
    blockDay,
    blockDayReason,
    setBlockDayModalOpen,
    toast,
    deleteBlockedPeriodsByDate,
    setBlockedPeriods,
  } = useAdminCalendar();

  return (
    <Dialog open={clearHoursModalOpen} onOpenChange={setClearHoursModalOpen}>
      <DialogContent className="max-w-md">
        <DialogHeader>
          <DialogTitle>Limpar Horários Bloqueados</DialogTitle>
        </DialogHeader>
        <div className="space-y-4">
          <p className="text-sm">
            Existem <strong>{hoursToClear}</strong> horários bloqueados para o
            dia{" "}
            <strong>
              {blockDate && format(blockDate, "dd/MM/yyyy", { locale: pt })}
            </strong>
            . Para bloquear o dia inteiro, todos os horários bloqueados
            precisam ser removidos.
          </p>
          <div className="flex justify-end gap-2">
            <Button
              variant="outline"
              onClick={() => setClearHoursModalOpen(false)}
            >
              Cancelar
            </Button>
            <Button
              onClick={async () => {
                if (blockDate) {
                  await deleteBlockedPeriodsByDate(
                    format(blockDate, "yyyy-MM-dd")
                  );
                  setBlockedPeriods((prev) =>
                    prev.filter(
                      (b) => b.date !== format(blockDate, "yyyy-MM-dd")
                    )
                  );
                  blockDay(blockDate, blockDayReason);
                  setClearHoursModalOpen(false);
                  setBlockDayModalOpen(false);
                  toast({
                    title: "Dia bloqueado",
                    description: `O dia ${format(
                      blockDate,
                      "dd/MM"
                    )} foi bloqueado com sucesso.`,
                    variant: "success",
                  });
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

export default ClearHoursModal;
