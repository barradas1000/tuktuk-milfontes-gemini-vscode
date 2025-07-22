import React from "react";
import { format } from "date-fns";

import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Select, SelectTrigger, SelectContent, SelectItem, SelectValue } from "@/components/ui/select";

import { useAdminCalendar } from "../AdminCalendarProvider";

const BlockHourModal = () => {
  const {
    blockHourModalOpen,
    setBlockHourModalOpen,
    blockDate,
    setBlockDate,
    blockHourStart,
    setBlockHourStart,
    blockHourEnd,
    setBlockHourEnd,
    blockTimeReason,
    setBlockTimeReason,
    timeSlots,
    blockTime,
    blockTimeRange,
    getAllDayBlocks,
    unblockTime,
  } = useAdminCalendar();

  return (
    <Dialog open={blockHourModalOpen} onOpenChange={setBlockHourModalOpen}>
      <DialogContent className="max-w-lg max-h-[80vh] overflow-hidden">
        <DialogHeader>
          <DialogTitle>Bloquear/Desbloquear Horas</DialogTitle>
        </DialogHeader>
        <div className="space-y-4 overflow-y-auto max-h-[calc(80vh-120px)] pr-2">
          <div className="space-y-2">
            <label className="font-semibold text-sm" htmlFor="block-hour-date">
              Data:
            </label>
            <input
              id="block-hour-date"
              name="block-hour-date"
              type="date"
              value={blockDate ? format(blockDate, "yyyy-MM-dd") : ""}
              onChange={(e) => setBlockDate(new Date(e.target.value))}
              className="border rounded p-2 w-full"
            />
          </div>
          <div className="space-y-2 border-t pt-4">
            <h4 className="font-semibold text-sm">
              Bloquear horário individual:
            </h4>
            <div className="flex items-center gap-2">
              <Select
                value={blockHourStart}
                onValueChange={(value) => setBlockHourStart(value)}
              >
                <SelectTrigger className="flex-1">
                  <SelectValue placeholder="Selecione um horário" />
                </SelectTrigger>
                <SelectContent>
                  {timeSlots.map((slot) => (
                    <SelectItem key={slot} value={slot}>
                      {slot}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
              <Button
                size="sm"
                variant="default"
                onClick={() =>
                  blockDate &&
                  blockTime(
                    blockDate,
                    blockHourStart,
                    blockTimeReason[blockHourStart] || ""
                  )
                }
                disabled={!blockDate}
              >
                Bloquear
              </Button>
            </div>
            <input
              id="block-hour-reason"
              name="block-hour-reason"
              type="text"
              placeholder="Motivo (opcional)"
              className="border rounded p-2 text-sm w-full"
              value={blockTimeReason[blockHourStart] || ""}
              onChange={(e) =>
                setBlockTimeReason((prev) => ({
                  ...prev,
                  [blockHourStart]: e.target.value,
                }))
              }
            />
          </div>
          <div className="space-y-2 border-t pt-4">
            <h4 className="font-semibold text-sm">
              Bloquear intervalo de horários:
            </h4>
            <div className="flex items-center gap-2">
              <span className="text-sm">De:</span>
              <Select
                value={blockHourStart}
                onValueChange={(value) => setBlockHourStart(value)}
              >
                <SelectTrigger className="flex-1">
                  <SelectValue placeholder="Selecione um horário" />
                </SelectTrigger>
                <SelectContent>
                  {timeSlots.map((slot) => (
                    <SelectItem key={slot} value={slot}>
                      {slot}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
              <span className="text-sm">Até:</span>
              <Select
                value={blockHourEnd}
                onValueChange={(value) => setBlockHourEnd(value)}
              >
                <SelectTrigger className="flex-1">
                  <SelectValue placeholder="Selecione um horário" />
                </SelectTrigger>
                <SelectContent>
                  {timeSlots.map((slot) => (
                    <SelectItem key={slot} value={slot}>
                      {slot}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
              <Button
                size="sm"
                variant="default"
                onClick={() =>
                  blockDate &&
                  blockTimeRange(
                    blockDate,
                    blockHourStart,
                    blockHourEnd,
                    blockTimeReason[`${blockHourStart}-${blockHourEnd}`] || ""
                  )
                }
                disabled={!blockDate}
              >
                Bloquear
              </Button>
            </div>
            <input
              id="block-hour-range-reason"
              name="block-hour-range-reason"
              type="text"
              placeholder="Motivo (opcional)"
              className="border rounded p-2 text-sm w-full"
              value={blockTimeReason[`${blockHourStart}-${blockHourEnd}`] || ""}
              onChange={(e) =>
                setBlockTimeReason((prev) => ({
                  ...prev,
                  [`${blockHourStart}-${blockHourEnd}`]: e.target.value,
                }))
              }
            />
          </div>
          <div className="space-y-2 border-t pt-4">
            <div className="flex justify-between items-center">
              <h4 className="font-semibold text-sm">
                Horários bloqueados:
              </h4>
              {blockDate &&
                getAllDayBlocks(blockDate).filter((b) => b.startTime).length >
                  3 && (
                  <span className="text-xs text-gray-500">
                    (Role para ver mais)
                  </span>
                )}
            </div>
            {blockDate &&
            getAllDayBlocks(blockDate).filter((b) => b.startTime).length ===
              0 ? (
              <div className="text-gray-500 text-sm text-center py-4">
                Nenhum horário bloqueado neste dia.
              </div>
            ) : (
              <div className="space-y-2 max-h-48 overflow-y-auto border rounded p-2 bg-gray-25">
                {blockDate &&
                  [
                    ...new Map(
                      getAllDayBlocks(blockDate)
                        .filter((b) => b.startTime)
                        .map((block) => [
                          block.date + "-" + block.startTime,
                          block,
                        ])
                    ).values(),
                  ].map((block) => (
                    <div
                      key={block.id}
                      className="flex items-center justify-between p-2 bg-white rounded border shadow-sm hover:shadow-md transition-shadow"
                    >
                      <div className="flex-1">
                        <span className="font-medium text-sm">
                          {block.startTime}
                        </span>
                        {block.reason && (
                          <span className="text-xs text-gray-500 ml-2">
                            ({block.reason})
                          </span>
                        )}
                      </div>
                      <Button
                        size="sm"
                        variant="destructive"
                        onClick={() =>
                          blockDate && unblockTime(blockDate, block.startTime!)
                        }
                      >
                        Desbloquear
                      </Button>
                    </div>
                  ))}
              </div>
            )}
          </div>
          <div className="flex justify-end pt-4 border-t">
            <Button
              variant="secondary"
              onClick={() => setBlockHourModalOpen(false)}
            >
              Fechar
            </Button>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
};

export default BlockHourModal;
