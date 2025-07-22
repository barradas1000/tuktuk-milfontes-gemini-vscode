import React from "react";
import { format } from "date-fns";
import { pt } from "date-fns/locale";
import { Calendar as CalendarIcon, Lock } from "lucide-react";

import { Calendar } from "@/components/ui/calendar";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import {
  Tooltip,
  TooltipTrigger,
  TooltipContent,
} from "@/components/ui/tooltip";

import { useAdminCalendar } from "./AdminCalendarProvider";

const CalendarDisplay = () => {
  const {
    calendarDate,
    handleDayClick,
    getDayStatus,
    isDayBlocked,
    getDayBlockReason,
    getDayLabel,
    modifiers,
    modifiersClassNames,
  } = useAdminCalendar();

  return (
    <Card className="lg:col-span-1">
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <CalendarIcon className="h-5 w-5" />
          Calendário
        </CardTitle>
      </CardHeader>
      <CardContent>
        <div className="rounded-2xl shadow-xl bg-white p-2">
          <Calendar
            mode="single"
            selected={calendarDate}
            onSelect={handleDayClick}
            className="rounded-2xl border-0"
            locale={pt}
            modifiers={modifiers}
            modifiersClassNames={modifiersClassNames}
            components={{
              Day: (props) => {
                const status = getDayStatus(props.date);
                const isSelected =
                  format(props.date, "yyyy-MM-dd") ===
                  format(calendarDate, "yyyy-MM-dd");
                const isToday =
                  format(props.date, "yyyy-MM-dd") ===
                  format(new Date(), "yyyy-MM-dd");
                const blocked = isDayBlocked(props.date);
                const textColor = blocked ? "text-gray-400" : "text-black";

                return (
                  <Tooltip>
                    <TooltipTrigger asChild>
                      <button
                        type="button"
                        className={
                          `h-10 w-10 flex items-center justify-center rounded-full transition-all duration-150 ` +
                          (isSelected
                            ? "ring-2 ring-blue-500 bg-blue-100 font-bold "
                            : "") +
                          (isToday
                            ? "ring-2 ring-purple-600 ring-offset-2 "
                            : "") +
                          (blocked
                            ? "bg-gray-300 cursor-pointer hover:bg-gray-400 "
                            : modifiersClassNames[
                                status as keyof typeof modifiersClassNames
                              ] + " ") +
                          textColor +
                          " hover:scale-110 hover:shadow-lg focus:outline-none"
                        }
                        onClick={() => handleDayClick(props.date)}
                      >
                        {blocked ? (
                          <Lock className="w-4 h-4" />
                        ) : (
                          props.date.getDate()
                        )}
                      </button>
                    </TooltipTrigger>
                    <TooltipContent>
                      {blocked
                        ? `${getDayBlockReason(
                            props.date
                          )} - Clique para desbloquear`
                        : `${getDayLabel(status)} - Clique para bloquear`}
                    </TooltipContent>
                  </Tooltip>
                );
              },
            }}
          />
        </div>
        <div className="mt-4 space-y-2">
          <h4 className="font-semibold text-sm">Legenda:</h4>
          <div className="flex flex-wrap gap-2 text-xs">
            <div className="flex items-center gap-1">
              <div className="w-3 h-3 bg-gray-300 rounded"></div>
              <span>Sem reservas</span>
            </div>
            <div className="flex items-center gap-1">
              <div className="w-3 h-3 bg-green-400 rounded"></div>
              <span>Poucas reservas</span>
            </div>
            <div className="flex items-center gap-1">
              <div className="w-3 h-3 bg-yellow-300 rounded"></div>
              <span>Várias reservas</span>
            </div>
            <div className="flex items-center gap-1">
              <div className="w-3 h-3 bg-red-400 rounded"></div>
              <span>Cheio</span>
            </div>
            <div className="flex items-center gap-1">
              <div className="w-3 h-3 bg-blue-300 rounded"></div>
              <span>Serviço não ativo</span>
            </div>
            <div className="flex items-center gap-1">
              <div className="w-3 h-3 bg-gray-300 rounded flex items-center justify-center">
                <Lock className="w-2 h-2" />
              </div>
              <span>Dia bloqueado (clique para desbloquear)</span>
            </div>
            <div className="flex items-center gap-1">
              <div className="w-3 h-3 bg-white border border-gray-300 rounded flex items-center justify-center">
                <span className="text-xs">+</span>
              </div>
              <span>Dia disponível (clique para bloquear)</span>
            </div>
          </div>
        </div>
      </CardContent>
    </Card>
  );
};

export default CalendarDisplay;
