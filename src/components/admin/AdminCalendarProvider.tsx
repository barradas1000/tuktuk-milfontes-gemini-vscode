import React, {
  useState,
  useMemo,
  useCallback,
  useEffect,
  useRef,
  createContext,
  useContext,
  ReactNode,
} from "react";
import { format, eachDayOfInterval, isAfter, isToday, isPast } from "date-fns";
import { pt } from "date-fns/locale";
import { useSession } from "@supabase/auth-helpers-react";
import { useToast } from "@/components/ui/use-toast";
import { useTranslation } from "react-i18next";
import i18n from "../../i18n";
import { useAdminReservations } from "@/hooks/useAdminReservations";
import {
  fetchBlockedPeriods,
  createBlockedPeriod,
  deleteBlockedPeriodsByDate,
  deleteBlockedPeriodByReservationId,
  fetchConductors,
  cleanDuplicateBlockedPeriods,
} from "@/services/supabaseService";
import { useConductors } from "@/hooks/useConductors";
import { BlockedPeriod, AdminReservation } from "@/types/adminReservations";
import {
  getAvailabilityWithBlocks,
  generateDynamicTimeSlots,
  AvailabilitySlot,
} from "@/utils/reservationUtils";

// --- Helper Functions ---
const timeSlots = generateDynamicTimeSlots();

// --- Interfaces ---
interface AdminCalendarContextType {
  calendarDate: Date;
  setCalendarDate: React.Dispatch<React.SetStateAction<Date>>;
  quickViewOpen: boolean;
  setQuickViewOpen: React.Dispatch<React.SetStateAction<boolean>>;
  quickViewDate: Date | null;
  setQuickViewDate: React.Dispatch<React.SetStateAction<Date | null>>;
  blockedPeriods: BlockedPeriod[];
  blockedPeriodsLoading: boolean;
  blockModalOpen: boolean;
  setBlockModalOpen: React.Dispatch<React.SetStateAction<boolean>>;
  blockDate: Date | null;
  setBlockDate: React.Dispatch<React.SetStateAction<Date | null>>;
  blockTab: "day" | "hour" | null;
  setBlockTab: React.Dispatch<React.SetStateAction<"day" | "hour" | null>>;
  blockDayReason: string;
  setBlockDayReason: React.Dispatch<React.SetStateAction<string>>;
  blockDaysStart: string;
  setBlockDaysStart: React.Dispatch<React.SetStateAction<string>>;
  blockDaysEnd: string;
  setBlockDaysEnd: React.Dispatch<React.SetStateAction<string>>;
  blockHourStart: string;
  setBlockHourStart: React.Dispatch<React.SetStateAction<string>>;
  blockHourEnd: string;
  setBlockHourEnd: React.Dispatch<React.SetStateAction<string>>;
  blockTimeReason: { [key: string]: string };
  setBlockTimeReason: React.Dispatch<
    React.SetStateAction<{ [key: string]: string }>
  >;
  inactiveDays: string[];
  blockDayModalOpen: boolean;
  setBlockDayModalOpen: React.Dispatch<React.SetStateAction<boolean>>;
  blockHourModalOpen: boolean;
  setBlockHourModalOpen: React.Dispatch<React.SetStateAction<boolean>>;
  makeAvailableModalOpen: boolean;
  setMakeAvailableModalOpen: React.Dispatch<React.SetStateAction<boolean>>;
  slotToMakeAvailable: string | null;
  setSlotToMakeAvailable: React.Dispatch<React.SetStateAction<string | null>>;
  clearHoursModalOpen: boolean;
  setClearHoursModalOpen: React.Dispatch<React.SetStateAction<boolean>>;
  hoursToClear: number;
  setHoursToClear: React.Dispatch<React.SetStateAction<number>>;
  quickBlockInfo: string;
  setQuickBlockInfo: React.Dispatch<React.SetStateAction<string>>;
  showCancelReservation: boolean;
  setShowCancelReservation: React.Dispatch<React.SetStateAction<boolean>>;
  cancelledReservation: AdminReservation | null;
  setCancelledReservation: React.Dispatch<
    React.SetStateAction<AdminReservation | null>
  >;
  cancelReservationModalOpen: boolean;
  setCancelReservationModalOpen: React.Dispatch<React.SetStateAction<boolean>>;
  reservationToCancel: AdminReservation | null;
  setReservationToCancel: React.Dispatch<
    React.SetStateAction<AdminReservation | null>
  >;
  cancelReason: string;
  setCancelReason: React.Dispatch<React.SetStateAction<string>>;
  isCancelling: boolean;
  setIsCancelling: React.Dispatch<React.SetStateAction<boolean>>;
  whatsappMessageModalOpen: boolean;
  setWhatsappMessageModalOpen: React.Dispatch<React.SetStateAction<boolean>>;
  editableMessage: string;
  setEditableMessage: React.Dispatch<React.SetStateAction<string>>;
  messageType: "confirmed" | "cancelled" | "custom";
  setMessageType: React.Dispatch<
    React.SetStateAction<"confirmed" | "cancelled" | "custom">
  >;
  reservationForMessage: AdminReservation | null;
  setReservationForMessage: React.Dispatch<
    React.SetStateAction<AdminReservation | null>
  >;
  blockFilterDate: string;
  setBlockFilterDate: React.Dispatch<React.SetStateAction<string>>;
  blockFilterType: "all" | "days" | "hours";
  setBlockFilterType: React.Dispatch<
    React.SetStateAction<"all" | "days" | "hours">
  >;
  isCleaningDuplicates: boolean;
  setIsCleaningDuplicates: React.Dispatch<React.SetStateAction<boolean>>;
  sliderDays: Date[];
  setSliderDays: React.Dispatch<React.SetStateAction<Date[]>>;
  selectedSliderDate: Date;
  setSelectedSliderDate: React.Dispatch<React.SetStateAction<Date>>;
  selectedDriverId: string;
  setSelectedDriverId: React.Dispatch<React.SetStateAction<string>>;
  conductors: { id: string; name: string; whatsapp: string }[];
  // ✅ REMOVIDO: setConductors (agora vem do useConductors hook)
  activeConductors: string[];
  // ✅ REMOVIDO: setActiveConductors (agora vem do useConductors hook)
  isUpdating: boolean;
  setIsUpdating: React.Dispatch<React.SetStateAction<boolean>>;
  isUpdatingRef: React.MutableRefObject<boolean>;
  refetchBlockedPeriods: () => Promise<void>;
  tourTypes: { id: string; name: string }[];
  getTourDisplayName: (tourType: string) => string;
  getTourDisplayNameTranslated: (tourType: string, lang: string) => string;
  cancelReservation: (
    reservation: AdminReservation,
    reason?: string
  ) => Promise<void>;
  interpolateMessage: (
    message: string,
    variables: Record<string, string>
  ) => string;
  getClientLanguage: (reservation: AdminReservation) => string;
  getTranslatedMessage: (
    reservation: AdminReservation,
    messageKey: string,
    variables: Record<string, string>
  ) => string;
  openWhatsappMessageEditor: (
    reservation: AdminReservation,
    type?: "confirmed" | "cancelled" | "custom"
  ) => void;
  sendWhatsappMessage: () => void;
  getDayStatus: (
    date: Date
  ) => "inactive" | "empty" | "low" | "medium" | "full";
  isDayBlocked: (date: Date) => boolean;
  getDayBlockReason: (date: Date) => string;
  isTimeBlocked: (date: Date, time: string) => boolean;
  isBlockedByReservation: (date: Date, time: string) => boolean;
  isBlockedByAdmin: (date: Date, time: string) => boolean;
  getTimeBlockReason: (date: Date, time: string) => string;
  getAllDayBlocks: (date: Date) => BlockedPeriod[];
  getFilteredBlocks: () => BlockedPeriod[];
  blockDay: (date: Date, reason: string) => Promise<void>;
  unblockDay: (date: Date) => Promise<void>;
  blockTime: (date: Date, time: string, reason: string) => Promise<void>;
  unblockTime: (date: Date, time: string) => Promise<void>;
  makeTimeAvailable: (date: Date, time: string) => Promise<void>;
  handleBlockDaysRange: () => void;
  blockTimeRange: (
    date: Date,
    startTime: string,
    endTime: string,
    reason: string
  ) => Promise<void>;
  handleDateSelect: (date: Date | undefined) => void;
  handleDayClick: (date: Date | undefined) => void;
  openBlockModalForDate: (date: Date) => void;
  getDayLabel: (status: string) => string;
  getStatusBadge: (status: string) => { color: string; text: string };
  getCurrentWhatsapp: () => string;
  getWhatsappLink: (phone: string, message: string) => string;
  modifiers: {
    inactive: (date: Date) => boolean;
    empty: (date: Date) => boolean;
    low: (date: Date) => boolean;
    medium: (date: Date) => boolean;
    full: (date: Date) => boolean;
    blocked: (date: Date) => boolean;
  };
  modifiersClassNames: {
    inactive: string;
    empty: string;
    low: string;
    medium: string;
    full: string;
    blocked: string;
  };
  selectedDateReservations: AdminReservation[];
  availabilitySlots: AvailabilitySlot[];
  handleCleanDuplicates: () => Promise<void>;
  getReservationsByDate: (date: string) => AdminReservation[];
  timeSlots: string[];
}

const AdminCalendarContext = createContext<
  AdminCalendarContextType | undefined
>(undefined);

export const useAdminCalendar = () => {
  const context = useContext(AdminCalendarContext);
  if (!context) {
    throw new Error(
      "useAdminCalendar must be used within an AdminCalendarProvider"
    );
  }
  return context;
};

interface AdminCalendarProviderProps {
  children: ReactNode;
  selectedDate: string;
  onDateSelect: (date: string) => void;
}

export const AdminCalendarProvider = ({
  children,
  selectedDate,
  onDateSelect,
}: AdminCalendarProviderProps) => {
  console.log("AdminCalendarProvider rendered");
  // --- Estados do Componente ---
  const {
    getReservationsByDate,
    getAvailabilityForDate,
    updateReservation,
    refetch,
  } = useAdminReservations();
  const { toast } = useToast();
  const { t } = useTranslation();

  // ✅ MODERNIZADO: Usar hook profissional useConductors
  // ✅ Elimina: fetchActiveConductors manual + useState duplicado
  const {
    conductors: hookConductors,
    activeConductors: hookActiveConductors,
    isLoadingActive,
    updateStatus,
    isConductorActive,
  } = useConductors();

  const [calendarDate, setCalendarDate] = useState<Date>(() => {
    const date = new Date(selectedDate);
    return isNaN(date.getTime()) ? new Date() : date;
  });
  const [quickViewOpen, setQuickViewOpen] = useState(false);
  const [quickViewDate, setQuickViewDate] = useState<Date | null>(null);

  // Estados relacionados a bloqueios
  const [blockedPeriods, setBlockedPeriods] = useState<BlockedPeriod[]>([]);
  const [blockedPeriodsLoading, setBlockedPeriodsLoading] = useState(true);
  const [blockModalOpen, setBlockModalOpen] = useState(false);
  const [blockDate, setBlockDate] = useState<Date | null>(null);
  const [blockTab, setBlockTab] = useState<"day" | "hour" | null>("day");

  // Estados para bloqueio de dia inteiro/intervalo de dias
  const [blockDayReason, setBlockDayReason] = useState("");
  const [blockDaysStart, setBlockDaysStart] = useState<string>("");
  const [blockDaysEnd, setBlockDaysEnd] = useState<string>("");

  // Estados para bloqueio de horários específicos
  const [blockHourStart, setBlockHourStart] = useState("09:00");
  const [blockHourEnd, setBlockHourEnd] = useState("10:00");
  const [blockTimeReason, setBlockTimeReason] = useState<{
    [key: string]: string;
  }>({});

  // Mock de dias inativos
  const [inactiveDays] = useState<string[]>([
    "2025-07-10",
    "2025-07-11",
    "2025-07-12",
  ]);

  // Novos estados para modais separados
  const [blockDayModalOpen, setBlockDayModalOpen] = useState(false);
  const [blockHourModalOpen, setBlockHourModalOpen] = useState(false);
  const [makeAvailableModalOpen, setMakeAvailableModalOpen] = useState(false);
  const [slotToMakeAvailable, setSlotToMakeAvailable] = useState<string | null>(
    null
  );

  // Estado para modal de limpeza de horas
  const [clearHoursModalOpen, setClearHoursModalOpen] = useState(false);
  const [hoursToClear, setHoursToClear] = useState(0);

  // Estados para bloqueio rápido e anulação de reservas
  const [quickBlockInfo, setQuickBlockInfo] = useState("");
  const [showCancelReservation, setShowCancelReservation] = useState(false);
  const [cancelledReservation, setCancelledReservation] =
    useState<AdminReservation | null>(null);

  // Estados para modal de anulação de reserva
  const [cancelReservationModalOpen, setCancelReservationModalOpen] =
    useState(false);
  const [reservationToCancel, setReservationToCancel] =
    useState<AdminReservation | null>(null);
  const [cancelReason, setCancelReason] = useState("");
  const [isCancelling, setIsCancelling] = useState(false);

  // Estados para edição de mensagens do WhatsApp
  const [whatsappMessageModalOpen, setWhatsappMessageModalOpen] =
    useState(false);
  const [editableMessage, setEditableMessage] = useState("");
  const [messageType, setMessageType] = useState<
    "confirmed" | "cancelled" | "custom"
  >("confirmed");
  const [reservationForMessage, setReservationForMessage] =
    useState<AdminReservation | null>(null);

  // Estados para filtros de bloqueios
  const [blockFilterDate, setBlockFilterDate] = useState<string>("");
  const [blockFilterType, setBlockFilterType] = useState<
    "all" | "days" | "hours"
  >("all");
  const [isCleaningDuplicates, setIsCleaningDuplicates] = useState(false);
  const [sliderDays, setSliderDays] = useState<Date[]>([]);
  const [selectedSliderDate, setSelectedSliderDate] = useState<Date>(
    new Date()
  );
  const [selectedDriverId, setSelectedDriverId] = useState<string>("");

  // ✅ MODERNIZADO: conductors e activeConductors vem do useConductors hook
  // ✅ useMemo para otimização e evitar re-renders desnecessários
  const conductors = useMemo(() => {
    return hookConductors.length > 0
      ? hookConductors
      : [
          { id: "condutor1", name: "Condutor 1", whatsapp: "351963496320" },
          { id: "condutor2", name: "Condutor 2", whatsapp: "351968784043" },
        ];
  }, [hookConductors]);

  const activeConductors = useMemo(() => {
    return hookActiveConductors.map((c) => c.id);
  }, [hookActiveConductors]);

  const [isUpdating, setIsUpdating] = useState(false);
  const isUpdatingRef = useRef(false);

  // Função para recarregar os períodos bloqueados
  const refetchBlockedPeriods = useCallback(async () => {
    try {
      const data = await fetchBlockedPeriods();
      setBlockedPeriods(data);
    } catch (error) {
      console.error("Error refetching blocked periods:", error);
      toast({
        title: "Erro ao recarregar períodos bloqueados",
        description: "Tente novamente mais tarde.",
        variant: "destructive",
      });
    }
  }, [toast]);

  // Mapeamento de códigos de tour para nomes amigáveis
  const tourTypes = useMemo(
    () => [
      { id: "panoramic", name: "Passeio panorâmico pela vila" },
      { id: "furnas", name: "Vila Nova de Milfontes → Praia das Furnas" },
      { id: "bridge", name: "Travessia da ponte" },
      { id: "sunset", name: "Pôr do Sol Romântico" },
      { id: "night", name: "Passeio noturno" },
      { id: "fishermen", name: "Rota dos Pescadores" },
    ],
    []
  );

  /**
   * Função para converter código do tour em nome amigável
   */
  const getTourDisplayName = useCallback(
    (tourType: string): string => {
      const tour = tourTypes.find((t) => t.id === tourType);
      return tour ? tour.name : tourType;
    },
    [tourTypes]
  );

  /**
   * Função para obter o nome do tour traduzido no idioma do cliente
   */
  const getTourDisplayNameTranslated = useCallback(
    (tourType: string, lang: string): string => {
      const tourNames: Record<string, Record<string, string>> = {
        pt: {
          panoramic: "Passeio panorâmico pela vila",
          furnas: "Vila Nova de Milfontes → Praia das Furnas",
          bridge: "Travessia da ponte",
          sunset: "Pôr do Sol Romântico",
          night: "Passeio noturno",
          fishermen: "Rota dos Pescadores",
        },
        en: {
          panoramic: "Panoramic tour of the village",
          furnas: "Milfontes → Furnas Beach",
          bridge: "Bridge crossing",
          sunset: "Romantic Sunset",
          night: "Night tour",
          fishermen: "Fishermen's Route",
        },
        es: {
          panoramic: "Paseo panorámico por la villa",
          furnas: "Milfontes → Playa de Furnas",
          bridge: "Cruce del puente",
          sunset: "Puesta de sol romántica",
          night: "Paseo nocturno",
          fishermen: "Ruta de los Pescadores",
        },
        fr: {
          panoramic: "Visite panoramique du village",
          furnas: "Milfontes → Plage des Furnas",
          bridge: "Traversée du pont",
          sunset: "Coucher de soleil romantique",
          night: "Visite nocturne",
          fishermen: "Route des pêcheurs",
        },
        de: {
          panoramic: "Panoramatour durch das Dorf",
          furnas: "Milfontes → Strand von Furnas",
          bridge: "Brückenüberquerung",
          sunset: "Romantischer Sonnenuntergang",
          night: "Nachttour",
          fishermen: "Fischerroute",
        },
        it: {
          panoramic: "Tour panoramico del villaggio",
          furnas: "Milfontes → Spiaggia di Furnas",
          bridge: "Attraversamento del ponte",
          sunset: "Tramonto romantico",
          night: "Tour notturno",
          fishermen: "Rotta dei pescatori",
        },
        nl: {
          panoramic: "Panoramische tour door het dorp",
          furnas: "Milfontes → Furnas-strand",
          bridge: "Brugoversteek",
          sunset: "Romantische zonsondergang",
          night: "Nachttour",
          fishermen: "Vissersroute",
        },
      };
      return (
        tourNames[lang]?.[tourType] || tourNames["pt"][tourType] || tourType
      );
    },
    []
  );

  /**
   * Função para interpolar variáveis nas mensagens do WhatsApp
   */
  const interpolateMessage = useCallback(
    (message: string, variables: Record<string, string>): string => {
      return message.replace(/\\{\\{(\\w+)\\}\}/g, (match, key) => {
        return variables[key] || match;
      });
    },
    []
  );

  /**
   * Função para detectar o idioma do cliente
   */
  const getClientLanguage = useCallback(
    (reservation: AdminReservation): string => {
      if (
        reservation.language &&
        i18n.languages.includes(reservation.language)
      ) {
        return reservation.language;
      }
      return "pt";
    },
    []
  );

  /**
   * Função para obter mensagem traduzida no idioma do cliente
   */
  const getTranslatedMessage = useCallback(
    (
      reservation: AdminReservation,
      messageKey: string,
      variables: Record<string, string>
    ): string => {
      const clientLanguage = getClientLanguage(reservation);
      const currentLanguage = i18n.language;
      i18n.changeLanguage(clientLanguage);
      const template = i18n.t(`reservation.whatsappMessages.${messageKey}`);
      i18n.changeLanguage(currentLanguage);
      return interpolateMessage(template, variables);
    },
    [getClientLanguage, interpolateMessage]
  );

  /**
   * Função para abrir modal de edição de mensagem do WhatsApp
   */
  const openWhatsappMessageEditor = useCallback(
    (
      reservation: AdminReservation,
      type: "confirmed" | "cancelled" | "custom" = "confirmed"
    ) => {
      setReservationForMessage(reservation);
      setMessageType(type);
      let baseMessage = "";
      const clientLanguage = getClientLanguage(reservation);
      const variables = {
        name: reservation.customer_name,
        email: reservation.customer_email,
        phone: reservation.customer_phone,
        tour_type: getTourDisplayNameTranslated(
          reservation.tour_type,
          clientLanguage
        ),
        reservation_date: reservation.reservation_date,
        reservation_time: reservation.reservation_time,
        number_of_people: reservation.number_of_people?.toString() || "",
        message: reservation.special_requests || "",
        total_price: reservation.total_price?.toString() || "",
        created_at: reservation.created_at
          ? new Date(reservation.created_at).toLocaleString(clientLanguage)
          : "",
      };

      if (type === "confirmed") {
        baseMessage = getTranslatedMessage(reservation, "confirmed", variables);
      } else if (type === "cancelled") {
        baseMessage = getTranslatedMessage(reservation, "cancelled", variables);
      } else {
        const currentLanguage = i18n.language;
        i18n.changeLanguage(clientLanguage);
        let greeting = "Olá";
        if (clientLanguage === "en") greeting = "Hello";
        else if (clientLanguage === "es") greeting = "Hola";
        else if (clientLanguage === "fr") greeting = "Bonjour";
        else if (clientLanguage === "de") greeting = "Hallo";
        else if (clientLanguage === "it") greeting = "Ciao";
        else if (clientLanguage === "nl") greeting = "Hallo";
        i18n.changeLanguage(currentLanguage);
        baseMessage = `${greeting} ${reservation.customer_name}, `;
      }
      setEditableMessage(baseMessage);
      setWhatsappMessageModalOpen(true);
    },
    [
      setReservationForMessage,
      setMessageType,
      getClientLanguage,
      getTourDisplayNameTranslated,
      getTranslatedMessage,
      setEditableMessage,
      setWhatsappMessageModalOpen,
    ]
  );

  /**
   * Função para anular uma reserva
   */
  const cancelReservation = useCallback(
    async (reservation: AdminReservation, reason: string = "") => {
      setIsCancelling(true);
      try {
        await updateReservation({ ...reservation, status: "cancelled" });
        await deleteBlockedPeriodByReservationId(reservation.id);
        refetch();
        setCancelReservationModalOpen(false);
        setReservationToCancel(null);
        setCancelReason("");
        openWhatsappMessageEditor(reservation, "cancelled");
        toast({
          title: "Reserva anulada com sucesso",
          description: `A reserva de ${reservation.customer_name} foi anulada. Agora pode editar a mensagem para o cliente.`,
        });
      } catch (error) {
        console.error("Erro ao anular reserva:", error);
        toast({
          title: "Erro ao anular reserva",
          description: "Ocorreu um erro ao anular a reserva. Tente novamente.",
          variant: "destructive",
        });
      } finally {
        setIsCancelling(false);
      }
    },
    [
      updateReservation,
      refetch,
      setCancelReservationModalOpen,
      setReservationToCancel,
      setCancelReason,
      openWhatsappMessageEditor,
      toast,
      setIsCancelling,
    ]
  );

  /**
   * Função utilitária para gerar link do WhatsApp
   */
  const getWhatsappLink = useCallback((phone: string, message: string) => {
    let cleanPhone = phone.replace(/\D/g, "");
    if (cleanPhone.startsWith("0")) {
      cleanPhone = cleanPhone.substring(1);
    }
    if (!cleanPhone.startsWith("351")) {
      cleanPhone = "351" + cleanPhone;
    }
    return `https://wa.me/${cleanPhone}?text=${encodeURIComponent(message)}`;
  }, []);

  /**
   * Função para enviar mensagem do WhatsApp editada
   */
  const sendWhatsappMessage = useCallback(() => {
    if (reservationForMessage && editableMessage.trim()) {
      const whatsappLink = getWhatsappLink(
        reservationForMessage.customer_phone,
        editableMessage
      );
      window.open(whatsappLink, "_blank");
      setWhatsappMessageModalOpen(false);
      setReservationForMessage(null);
      setEditableMessage("");
      toast({
        title: "WhatsApp aberto",
        description: `A mensagem foi preparada e o WhatsApp do cliente (${reservationForMessage.customer_phone}) foi aberto.`,
      });
    }
  }, [
    reservationForMessage,
    editableMessage,
    getWhatsappLink,
    setWhatsappMessageModalOpen,
    setReservationForMessage,
    setEditableMessage,
    toast,
  ]);

  /**
   * Determina o status de um dia baseado nas reservas e dias inativos
   */
  const getDayStatus = useCallback(
    (date: Date) => {
      const dateString = format(date, "yyyy-MM-dd");
      if (inactiveDays.includes(dateString)) return "inactive";
      const reservas = getReservationsByDate(dateString);
      if (reservas.length === 0) return "empty";
      if (reservas.length <= 2) return "low";
      if (reservas.length <= 4) return "medium";
      return "full";
    },
    [getReservationsByDate, inactiveDays]
  );

  /**
   * Verifica se um dia inteiro está bloqueado
   */
  const isDayBlocked = useCallback(
    (date: Date) => {
      const dateString = format(date, "yyyy-MM-dd");
      return blockedPeriods.some(
        (b) => b.date === dateString && !b.startTime && !b.endTime
      );
    },
    [blockedPeriods]
  );

  /**
   * Obtém a razão para o bloqueio de um dia inteiro
   */
  const getDayBlockReason = useCallback(
    (date: Date) => {
      const dateString = format(date, "yyyy-MM-dd");
      const block = blockedPeriods.find(
        (b) => b.date === dateString && !b.startTime && !b.endTime
      );
      return block?.reason || "Dia bloqueado";
    },
    [blockedPeriods]
  );

  /**
   * Verifica se um horário específico está bloqueado
   */
  const isTimeBlocked = useCallback(
    (date: Date, time: string) => {
      const dateString = format(date, "yyyy-MM-dd");
      const adminBlocked = blockedPeriods.some(
        (b) => b.date === dateString && b.startTime === time
      );
      const hasConfirmedReservation = getReservationsByDate(dateString).some(
        (r) => r.reservation_time === time && r.status === "confirmed"
      );
      return adminBlocked || hasConfirmedReservation;
    },
    [blockedPeriods, getReservationsByDate]
  );

  /**
   * Verifica se um horário está bloqueado por reserva confirmada
   */
  const isBlockedByReservation = useCallback(
    (date: Date, time: string) => {
      const dateString = format(date, "yyyy-MM-dd");
      return getReservationsByDate(dateString).some(
        (r) => r.reservation_time === time && r.status === "confirmed"
      );
    },
    [getReservationsByDate]
  );

  /**
   * Verifica se um horário está bloqueado manualmente pelo admin
   */
  const isBlockedByAdmin = useCallback(
    (date: Date, time: string) => {
      const dateString = format(date, "yyyy-MM-dd");
      return blockedPeriods.some(
        (b) => b.date === dateString && b.startTime === time
      );
    },
    [blockedPeriods]
  );

  /**
   * Obtém a razão para o bloqueio de um horário
   */
  const getTimeBlockReason = useCallback(
    (date: Date, time: string) => {
      const dateString = format(date, "yyyy-MM-dd");
      const confirmedReservation = getReservationsByDate(dateString).find(
        (r) => r.reservation_time === time && r.status === "confirmed"
      );
      if (confirmedReservation) {
        return `Reserva confirmada: ${confirmedReservation.customer_name}`;
      }
      const adminBlock = blockedPeriods.find(
        (b) => b.date === dateString && b.startTime === time
      );
      if (adminBlock) {
        return adminBlock.reason || "Bloqueado pelo administrador";
      }
      return "Horário bloqueado";
    },
    [blockedPeriods, getReservationsByDate]
  );

  /**
   * Retorna todos os blocos para uma data específica
   */
  const getAllDayBlocks = useCallback(
    (date: Date) => {
      const dateString = format(date, "yyyy-MM-dd");
      return blockedPeriods.filter((b) => b.date === dateString);
    },
    [blockedPeriods]
  );

  /**
   * Filtra os bloqueios baseado nos filtros aplicados
   */
  const getFilteredBlocks = useCallback(() => {
    let filtered = blockedPeriods;
    if (blockFilterType === "days") {
      filtered = filtered.filter((b) => !b.startTime);
    } else if (blockFilterType === "hours") {
      filtered = filtered.filter((b) => b.startTime);
    }
    if (blockFilterDate) {
      filtered = filtered.filter((b) => b.date === blockFilterDate);
    }
    return filtered;
  }, [blockedPeriods, blockFilterType, blockFilterDate]);

  // --- Funções de Manipulação de Bloqueios ---
  const session = useSession();
  const userEmail = session?.user?.email || "admin";

  const blockDay = useCallback(
    async (date: Date, reason: string) => {
      const dateString = format(date, "yyyy-MM-dd");
      try {
        const alreadyBlocked = blockedPeriods.some(
          (b) => b.date === dateString && !b.startTime && !b.endTime
        );
        if (alreadyBlocked) {
          toast({
            title: "Dia já bloqueado",
            description: `O dia ${dateString} já está bloqueado.`,
            variant: "destructive",
          });
          return;
        }
        const newBlock = await createBlockedPeriod({
          date: dateString,
          reason,
          createdBy: userEmail,
        });
        setBlockedPeriods((prev) => [...prev, newBlock]);
        refetchBlockedPeriods();
        toast({
          title: "Dia bloqueado com sucesso",
          description: `O dia ${dateString} foi bloqueado.`,
          variant: "success",
        });
      } catch (error) {
        console.error("Erro ao bloquear dia:", error);
        toast({
          title: "Erro ao bloquear dia",
          description: "Não foi possível bloquear o dia. Tente novamente.",
          variant: "destructive",
        });
      }
    },
    [blockedPeriods, userEmail, refetchBlockedPeriods, toast]
  );

  const unblockDay = useCallback(
    async (date: Date) => {
      const dateString = format(date, "yyyy-MM-dd");
      try {
        await deleteBlockedPeriodsByDate(dateString);
        setBlockedPeriods((prev) =>
          prev.filter(
            (b) => !(b.date === dateString && !b.startTime && !b.endTime)
          )
        );
        refetchBlockedPeriods();
        setBlockDayModalOpen(false);
        toast({
          title: "Dia desbloqueado",
          description: `O dia ${dateString} foi desbloqueado com sucesso.`,
          variant: "success",
        });
      } catch (error) {
        console.error("Erro ao desbloquear dia:", error);
        toast({
          title: "Erro ao desbloquear dia",
          description: "Ocorreu um erro ao desbloquear o dia. Tente novamente.",
          variant: "destructive",
        });
      }
    },
    [refetchBlockedPeriods, toast, setBlockDayModalOpen]
  );

  const blockTime = useCallback(
    async (date: Date, time: string, reason: string) => {
      setIsUpdating(true);
      isUpdatingRef.current = true;
      const dateString = format(date, "yyyy-MM-dd");
      const now = new Date();
      const slotDateTime = new Date(`${dateString}T${time}`);
      if (isToday(date) && isPast(slotDateTime)) {
        toast({
          title: "Ação inválida",
          description: "Não é possível bloquear um horário que já passou.",
          variant: "destructive",
        });
        setIsUpdating(false);
        isUpdatingRef.current = false;
        return;
      }
      try {
        await createBlockedPeriod({
          date: dateString,
          startTime: time,
          endTime: time,
          reason,
          createdBy: userEmail,
        });
        await refetchBlockedPeriods();
        toast({
          title: `Horário ${time} bloqueado com sucesso!`,
          variant: "success",
        });
      } catch (error) {
        console.error("Error blocking time:", error);
        toast({
          title: "Erro ao bloquear",
          description: "Não foi possível guardar o bloqueio.",
          variant: "destructive",
        });
      } finally {
        setIsUpdating(false);
        isUpdatingRef.current = false;
      }
    },
    [userEmail, toast, refetchBlockedPeriods, setIsUpdating]
  );

  const unblockTime = useCallback(
    async (date: Date, time: string) => {
      setIsUpdating(true);
      isUpdatingRef.current = true;
      const dateString = format(date, "yyyy-MM-dd");
      const reservasNoHorario = getReservationsByDate(dateString).filter(
        (r) => r.reservation_time === time && r.status !== "cancelled"
      );
      if (reservasNoHorario.length > 0) {
        toast({
          title: `Não é possível desbloquear`,
          description: `Existe uma reserva para as ${time}. Cancele-a primeiro.`,
          variant: "destructive",
        });
        setIsUpdating(false);
        isUpdatingRef.current = false;
        return;
      }
      try {
        await deleteBlockedPeriodsByDate(dateString, time);
        await refetchBlockedPeriods();
        toast({
          title: `Horário ${time} desbloqueado com sucesso!`,
          variant: "success",
        });
      } catch (error) {
        console.error("Error unblocking time:", error);
        toast({
          title: "Erro ao desbloquear",
          description: "Ocorreu um erro ao remover o bloqueio.",
          variant: "destructive",
        });
      } finally {
        setIsUpdating(false);
        isUpdatingRef.current = false;
      }
    },
    [getReservationsByDate, toast, refetchBlockedPeriods, setIsUpdating]
  );

  const makeTimeAvailable = useCallback(
    async (date: Date, time: string) => {
      const dateString = format(date, "yyyy-MM-dd");
      try {
        await deleteBlockedPeriodsByDate(dateString, time);
        setBlockedPeriods((prev) =>
          prev.filter((b) => !(b.date === dateString && b.startTime === time))
        );
        toast({
          title: `Horário ${time} tornado disponível!`,
          variant: "success",
        });
        refetchBlockedPeriods();
      } catch (error) {
        console.error("Error making time available:", error);
        toast({
          title: "Erro ao tornar horário disponível",
          description: error instanceof Error ? error.message : String(error),
          variant: "destructive",
        });
      }
    },
    [toast, refetchBlockedPeriods]
  );

  const handleBlockDaysRange = useCallback(() => {
    if (!blockDaysStart || !blockDaysEnd) {
      toast({
        title: "Erro",
        description: "Selecione as datas de início e fim.",
        variant: "destructive",
      });
      return;
    }
    const start = new Date(blockDaysStart);
    const end = new Date(blockDaysEnd);
    if (isAfter(start, end)) {
      toast({
        title: "Erro",
        description: "A data de início não pode ser depois da data de fim.",
        variant: "destructive",
      });
      return;
    }
    const days = eachDayOfInterval({ start, end });
    days.forEach((day) => blockDay(day, blockDayReason));
  }, [blockDaysStart, blockDaysEnd, blockDayReason, blockDay, toast]);

  const blockTimeRange = useCallback(
    async (date: Date, startTime: string, endTime: string, reason: string) => {
      const dateString = format(date, "yyyy-MM-dd");
      try {
        const startIndex = timeSlots.indexOf(startTime);
        const endIndex = timeSlots.indexOf(endTime);
        if (startIndex === -1 || endIndex === -1) {
          toast({
            title: "Erro",
            description: "Horários não encontrados nos slots disponíveis.",
            variant: "destructive",
          });
          return;
        }
        if (startIndex > endIndex) {
          toast({
            title: "Erro",
            description:
              "Horário de início deve ser menor que o horário de fim.",
            variant: "destructive",
          });
          return;
        }
        for (let i = startIndex; i <= endIndex; i++) {
          const time = timeSlots[i];
          await blockTime(date, time, reason);
        }
        toast({
          title: "Intervalo bloqueado",
          description: `Horários de ${startTime} a ${endTime} bloqueados com sucesso.`,
          variant: "success",
        });
      } catch (error) {
        console.error("Error blocking time range:", error);
        toast({
          title: "Erro ao bloquear intervalo",
          description:
            "Ocorreu um erro ao bloquear o intervalo. Tente novamente.",
          variant: "destructive",
        });
      }
    },
    [blockTime, toast]
  );

  // --- Handlers de Eventos ---

  const handleDateSelect = useCallback(
    (date: Date | undefined) => {
      if (date) {
        const dateString = format(date, "yyyy-MM-dd");
        setCalendarDate(date);
        onDateSelect(dateString);
      }
    },
    [onDateSelect]
  );

  const handleDayClick = useCallback(
    (date: Date | undefined) => {
      if (!date) return;
      const dateString = format(date, "yyyy-MM-dd");
      const hasConfirmedReservations = getReservationsByDate(dateString).some(
        (r) => r.status === "confirmed"
      );
      if (isDayBlocked(date)) {
        if (hasConfirmedReservations) {
          toast({
            title: "Não é possível desbloquear",
            description:
              "Este dia tem reservas confirmadas. Cancele as reservas primeiro.",
            variant: "destructive",
          });
          return;
        }
        unblockDay(date);
        toast({
          title: "Dia desbloqueado",
          description: `O dia ${format(
            date,
            "dd/MM"
          )} foi desbloqueado com sucesso.`,
          variant: "success",
        });
        return;
      }
      if (hasConfirmedReservations) {
        toast({
          title: "Não é possível bloquear o dia",
          description:
            "Existem reservas confirmadas para este dia. Anule ou reagende as reservas antes de bloquear o dia inteiro.",
          variant: "destructive",
        });
        return;
      }
      const timeBlocksOnDay = blockedPeriods.filter(
        (b) => b.date === dateString && b.startTime
      ).length;
      setBlockDate(date);
      setBlockDayReason("");
      if (timeBlocksOnDay > 0) {
        setHoursToClear(timeBlocksOnDay);
        setClearHoursModalOpen(true);
      } else {
        setBlockDayModalOpen(true);
      }
    },
    [
      isDayBlocked,
      getReservationsByDate,
      unblockDay,
      toast,
      blockedPeriods,
      setBlockDate,
      setBlockDayReason,
      setHoursToClear,
      setClearHoursModalOpen,
      setBlockDayModalOpen,
    ]
  );

  const openBlockModalForDate = useCallback(
    (date: Date) => {
      setBlockDate(date);
      setBlockDaysStart(format(date, "yyyy-MM-dd"));
      setBlockDaysEnd(format(date, "yyyy-MM-dd"));
      setBlockTab("day");
      setBlockDayReason(getDayBlockReason(date));
      setBlockModalOpen(true);
    },
    [
      getDayBlockReason,
      setBlockDate,
      setBlockDaysStart,
      setBlockDaysEnd,
      setBlockTab,
      setBlockDayReason,
      setBlockModalOpen,
    ]
  );

  // --- Funções Auxiliares de UI/Renderização ---

  const getDayLabel = useCallback((status: string) => {
    switch (status) {
      case "inactive":
        return "Serviço não ativo";
      case "empty":
        return "Sem reservas";
      case "low":
        return "Poucas reservas";
      case "medium":
        return "Várias reservas";
      case "full":
        return "Cheio";
      default:
        return "";
    }
  }, []);

  const getStatusBadge = useCallback((status: string) => {
    const statusConfig = {
      pending: {
        color: "bg-yellow-100 text-yellow-800",
        text: "Pendente",
      },
      confirmed: {
        color: "bg-green-100 text-green-800",
        text: "Confirmada",
      },
      cancelled: {
        color: "bg-red-100 text-red-800",
        text: "Cancelada",
      },
      completed: {
        color: "bg-blue-100 text-blue-800",
        text: "Concluída",
      },
    };
    const config = statusConfig[status as keyof typeof statusConfig];
    return { color: config.color, text: config.text };
  }, []);

  // --- Função para determinar o WhatsApp responsável ---
  const getCurrentWhatsapp = useCallback(() => {
    if (activeConductors.length === 1) {
      const c = conductors.find((c) => c.id === activeConductors[0]);
      return c ? c.whatsapp : conductors[1]?.whatsapp || "351968784043";
    }
    return conductors[1]?.whatsapp || "351968784043";
  }, [activeConductors, conductors]);

  // --- Modificadores do DayPicker ---
  const modifiers = useMemo(
    () => ({
      inactive: (date: Date) => getDayStatus(date) === "inactive",
      empty: (date: Date) => getDayStatus(date) === "empty",
      low: (date: Date) => getDayStatus(date) === "low",
      medium: (date: Date) => getDayStatus(date) === "medium",
      full: (date: Date) => getDayStatus(date) === "full",
      blocked: isDayBlocked,
    }),
    [getDayStatus, isDayBlocked]
  );

  const modifiersClassNames = useMemo(
    () => ({
      inactive: "bg-blue-200 text-blue-900",
      empty: "bg-gray-100 text-gray-400",
      low: "bg-green-200 text-green-900",
      medium: "bg-yellow-200 text-yellow-900",
      full: "bg-red-300 text-red-900",
      blocked: "bg-gray-300 text-gray-400 cursor-not-allowed",
    }),
    []
  );

  // --- Dados Computados para Renderização ---
  const selectedDateReservations = useMemo(
    () => getReservationsByDate(format(calendarDate, "yyyy-MM-dd")),
    [calendarDate, getReservationsByDate]
  );

  const availabilitySlots = useMemo(() => {
    const slots = getAvailabilityWithBlocks(
      selectedDateReservations,
      blockedPeriods,
      format(calendarDate, "yyyy-MM-dd")
    );
    return slots;
  }, [selectedDateReservations, blockedPeriods, calendarDate]);

  // --- Efeitos ---
  useEffect(() => {
    const date = new Date(selectedDate);
    if (!isNaN(date.getTime())) {
      setCalendarDate(date);
    }
  }, [selectedDate]);

  useEffect(() => {
    const loadBlockedPeriods = async () => {
      console.log("Loading blocked periods...");
      try {
        setBlockedPeriodsLoading(true);
        const data = await fetchBlockedPeriods();
        setBlockedPeriods(data);
      } catch (error) {
        console.error("Error loading blocked periods:", error);
        toast({
          title: "Erro ao carregar períodos bloqueados",
          description: "Tente novamente mais tarde.",
          variant: "destructive",
        });
      } finally {
        setBlockedPeriodsLoading(false);
      }
    };
    loadBlockedPeriods();
  }, [calendarDate, toast]);

  useEffect(() => {
    const generateNextDays = () => {
      const today = new Date();
      const nextDays: Date[] = [];
      for (let i = 0; i < 10; i++) {
        const nextDay = new Date(today);
        nextDay.setDate(today.getDate() + i);
        nextDays.push(nextDay);
      }
      setSliderDays(nextDays);
      setSelectedSliderDate(today);
    };
    generateNextDays();
  }, []);

  // ✅ REMOVIDO: useEffect para loadActiveConductors
  // ✅ AGORA: useConductors hook faz isso automaticamente com cache inteligente

  // Função para limpar bloqueios duplicados
  const handleCleanDuplicates = useCallback(async () => {
    setIsCleaningDuplicates(true);
    try {
      const removedCount = await cleanDuplicateBlockedPeriods();
      if (removedCount > 0) {
        toast({
          title: "Limpeza concluída",
          description: `${removedCount} bloqueios duplicados foram removidos.`,
        });
        const updatedData = await fetchBlockedPeriods();
        setBlockedPeriods(updatedData);
      } else {
        toast({
          title: "Nenhum duplicado encontrado",
          description: "Todos os bloqueios já estão únicos.",
        });
      }
    } catch (error) {
      console.error("Error cleaning duplicates:", error);
      toast({
        title: "Erro na limpeza",
        description: "Ocorreu um erro ao limpar bloqueios duplicados.",
        variant: "destructive",
      });
    } finally {
      setIsCleaningDuplicates(false);
    }
  }, [toast, setBlockedPeriods, setIsCleaningDuplicates]);

  const contextValue = useMemo(
    () => ({
      calendarDate,
      setCalendarDate,
      quickViewOpen,
      setQuickViewOpen,
      quickViewDate,
      setQuickViewDate,
      blockedPeriods,
      blockedPeriodsLoading,
      blockModalOpen,
      setBlockModalOpen,
      blockDate,
      setBlockDate,
      blockTab,
      setBlockTab,
      blockDayReason,
      setBlockDayReason,
      blockDaysStart,
      setBlockDaysStart,
      blockDaysEnd,
      setBlockDaysEnd,
      blockHourStart,
      setBlockHourStart,
      blockHourEnd,
      setBlockHourEnd,
      blockTimeReason,
      setBlockTimeReason,
      inactiveDays,
      blockDayModalOpen,
      setBlockDayModalOpen,
      blockHourModalOpen,
      setBlockHourModalOpen,
      makeAvailableModalOpen,
      setMakeAvailableModalOpen,
      slotToMakeAvailable,
      setSlotToMakeAvailable,
      clearHoursModalOpen,
      setClearHoursModalOpen,
      hoursToClear,
      setHoursToClear,
      quickBlockInfo,
      setQuickBlockInfo,
      showCancelReservation,
      setShowCancelReservation,
      cancelledReservation,
      setCancelledReservation,
      cancelReservationModalOpen,
      setCancelReservationModalOpen,
      reservationToCancel,
      setReservationToCancel,
      cancelReason,
      setCancelReason,
      isCancelling,
      setIsCancelling,
      whatsappMessageModalOpen,
      setWhatsappMessageModalOpen,
      editableMessage,
      setEditableMessage,
      messageType,
      setMessageType,
      reservationForMessage,
      setReservationForMessage,
      blockFilterDate,
      setBlockFilterDate,
      blockFilterType,
      setBlockFilterType,
      isCleaningDuplicates,
      setIsCleaningDuplicates,
      sliderDays,
      setSliderDays,
      selectedSliderDate,
      setSelectedSliderDate,
      selectedDriverId,
      setSelectedDriverId,
      conductors,
      // ✅ REMOVIDO: setConductors (não mais necessário)
      activeConductors,
      // ✅ REMOVIDO: setActiveConductors (não mais necessário)
      isUpdating,
      setIsUpdating,
      isUpdatingRef,
      refetchBlockedPeriods,
      tourTypes,
      getTourDisplayName,
      getTourDisplayNameTranslated,
      cancelReservation,
      interpolateMessage,
      getClientLanguage,
      getTranslatedMessage,
      openWhatsappMessageEditor,
      sendWhatsappMessage,
      getDayStatus,
      isDayBlocked,
      getDayBlockReason,
      isTimeBlocked,
      isBlockedByReservation,
      isBlockedByAdmin,
      getTimeBlockReason,
      getAllDayBlocks,
      getFilteredBlocks,
      blockDay,
      unblockDay,
      blockTime,
      unblockTime,
      makeTimeAvailable,
      handleBlockDaysRange,
      blockTimeRange,
      handleDateSelect,
      handleDayClick,
      openBlockModalForDate,
      getDayLabel,
      getStatusBadge,
      getCurrentWhatsapp,
      getWhatsappLink,
      modifiers,
      modifiersClassNames,
      selectedDateReservations,
      availabilitySlots,
      handleCleanDuplicates,
      getReservationsByDate,
      timeSlots,
    }),
    [
      calendarDate,
      quickViewOpen,
      quickViewDate,
      blockedPeriods,
      blockedPeriodsLoading,
      blockModalOpen,
      blockDate,
      blockTab,
      blockDayReason,
      blockDaysStart,
      blockDaysEnd,
      blockHourStart,
      blockHourEnd,
      blockTimeReason,
      inactiveDays,
      blockDayModalOpen,
      blockHourModalOpen,
      makeAvailableModalOpen,
      slotToMakeAvailable,
      clearHoursModalOpen,
      hoursToClear,
      quickBlockInfo,
      showCancelReservation,
      cancelledReservation,
      cancelReservationModalOpen,
      reservationToCancel,
      cancelReason,
      isCancelling,
      whatsappMessageModalOpen,
      editableMessage,
      messageType,
      reservationForMessage,
      blockFilterDate,
      blockFilterType,
      isCleaningDuplicates,
      sliderDays,
      selectedSliderDate,
      selectedDriverId,
      conductors,
      activeConductors,
      isUpdating,
      isUpdatingRef,
      refetchBlockedPeriods,
      tourTypes,
      getTourDisplayName,
      getTourDisplayNameTranslated,
      cancelReservation,
      interpolateMessage,
      getClientLanguage,
      getTranslatedMessage,
      openWhatsappMessageEditor,
      sendWhatsappMessage,
      getDayStatus,
      isDayBlocked,
      getDayBlockReason,
      isTimeBlocked,
      isBlockedByReservation,
      isBlockedByAdmin,
      getTimeBlockReason,
      getAllDayBlocks,
      getFilteredBlocks,
      blockDay,
      unblockDay,
      blockTime,
      unblockTime,
      makeTimeAvailable,
      handleBlockDaysRange,
      blockTimeRange,
      handleDateSelect,
      handleDayClick,
      openBlockModalForDate,
      getDayLabel,
      getStatusBadge,
      getCurrentWhatsapp,
      getWhatsappLink,
      modifiers,
      modifiersClassNames,
      selectedDateReservations,
      availabilitySlots,
      handleCleanDuplicates,
      getReservationsByDate,
    ]
  );

  return (
    <AdminCalendarContext.Provider value={contextValue}>
      {children}
    </AdminCalendarContext.Provider>
  );
};
