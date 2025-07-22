import React from "react";
import { format } from "date-fns";
import { Clock, Users } from "lucide-react";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import {
  Tooltip,
  TooltipTrigger,
  TooltipContent,
} from "@/components/ui/tooltip";

import { useAdminCalendar } from "./AdminCalendarProvider";

const AvailabilityCard = () => {
  const {
    availabilitySlots,
    calendarDate,
    isBlockedByReservation,
    getTimeBlockReason,
    getReservationsByDate,
    setBlockDate,
    setBlockHourStart,
    setBlockHourModalOpen,
    setSlotToMakeAvailable,
    setMakeAvailableModalOpen,
    isUpdating,
  } = useAdminCalendar();

  return (
    <Card className="mb-6">
      <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
        <CardTitle className="flex items-center gap-2">
          <Clock className="h-5 w-5" />
          Disponibilidade por Horário
        </CardTitle>
        <Button
          size="sm"
          variant="outline"
          onClick={() => setBlockHourModalOpen(true)}
          className="text-xs"
        >
          Gerir Horários
        </Button>
      </CardHeader>
      <CardContent>
        <div className="flex justify-between items-center mb-3">
          <div className="text-sm text-gray-600">
            Clique em um horário para bloquear/desbloquear
          </div>
        </div>
        <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6 gap-2">
          {availabilitySlots.map((slot) => (
            <Tooltip key={slot.time}>
              <TooltipTrigger asChild>
                <Button
                  variant={slot.isAvailable ? "outline" : "destructive"}
                  className={`text-xs h-10 w-full relative ${
                    slot.isAvailable
                      ? "border-green-300 hover:bg-green-50"
                      : isBlockedByReservation(calendarDate, slot.time)
                      ? "bg-red-400 text-white cursor-not-allowed"
                      : "bg-red-100 text-red-800 hover:bg-red-200"
                  }`}
                  onClick={() => {
                    if (slot.isAvailable) {
                      setBlockDate(calendarDate);
                      setBlockHourStart(slot.time);
                      setBlockHourModalOpen(true);
                    } else if (!isBlockedByReservation(calendarDate, slot.time)) {
                      setSlotToMakeAvailable(slot.time);
                      setMakeAvailableModalOpen(true);
                    }
                  }}
                  disabled={isBlockedByReservation(calendarDate, slot.time) || isUpdating}
                >
                  {slot.time}
                  {isBlockedByReservation(calendarDate, slot.time) && (
                    <span className="absolute -top-1 -right-1 bg-green-500 text-white rounded-full h-4 w-4 flex items-center justify-center">
                      <Users className="h-2.5 w-2.5" />
                    </span>
                  )}
                </Button>
              </TooltipTrigger>
              <TooltipContent>
                {slot.isAvailable
                  ? "Horário disponível. Clique para bloquear."
                  : isBlockedByReservation(calendarDate, slot.time)
                  ? `Reserva confirmada: ${
                      getReservationsByDate(format(calendarDate, "yyyy-MM-dd")).find(
                        (r) => r.reservation_time === slot.time
                      )?.customer_name
                    }`
                  : `Horário bloqueado: ${getTimeBlockReason(calendarDate, slot.time)}`}
              </TooltipContent>
            </Tooltip>
          ))}
        </div>
      </CardContent>
    </Card>
  );
};

export default AvailabilityCard;
