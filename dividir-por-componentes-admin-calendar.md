# Plano de Refatoração para `AdminCalendar.tsx`

## Objetivo
Decompor o componente `AdminCalendar.tsx` em componentes menores e mais focados, melhorando a legibilidade, manutenção e reusabilidade, mantendo a funcionalidade global.

## Análise do Componente Atual
O `AdminCalendar.tsx` atual é um componente monolítico que gerencia:
*   **Gestão de Estado:** Múltiplos `useState` e `useRef` para controlar o estado do calendário, modais, bloqueios, reservas, etc.
*   **Lógica de Negócio:** Funções para bloquear/desbloquear dias e horários, cancelar reservas, enviar mensagens de WhatsApp, calcular disponibilidade, etc.
*   **Interação com API:** Chamadas para `supabaseService` (fetch, create, delete, update).
*   **Renderização de UI:** Componentes complexos como o `DayPicker` customizado, cards de disponibilidade, modais para diferentes ações (bloqueio de dia, bloqueio de hora, cancelamento de reserva, mensagem WhatsApp, etc.), e a seção de visualização de bloqueios.
*   **Internacionalização:** Uso de `react-i18next` para traduções.
*   **Estilos:** CSS inline e classes Tailwind.

## Componentes Propostos

1.  **`AdminCalendarProvider.tsx` (Novo Context/Hook):**
    *   **Responsabilidade:** Centralizar a maior parte da lógica de estado e funções de manipulação de dados (bloqueios, reservas, condutores).
    *   **Exposição:** Exporá um contexto ou um hook (`useAdminCalendar`) que fornecerá os estados e as funções necessárias para os componentes filhos.
    *   **Conteúdo a Mover:**
        *   Todos os `useState` e `useEffect` relacionados a `calendarDate`, `blockedPeriods`, `conductors`, `activeConductors`, `quickViewOpen`, `quickViewDate`, `blockModalOpen`, `blockDate`, `blockTab`, `blockDayReason`, `blockDaysStart`, `blockDaysEnd`, `blockHourStart`, `blockHourEnd`, `blockTimeReason`, `inactiveDays`, `blockDayModalOpen`, `blockHourModalOpen`, `makeAvailableModalOpen`, `slotToMakeAvailable`, `clearHoursModalOpen`, `hoursToClear`, `quickBlockInfo`, `showCancelReservation`, `cancelledReservation`, `cancelReservationModalOpen`, `reservationToCancel`, `cancelReason`, `isCancelling`, `whatsappMessageModalOpen`, `editableMessage`, `messageType`, `reservationForMessage`, `blockFilterDate`, `blockFilterType`, `isCleaningDuplicates`, `sliderDays`, `selectedSliderDate`, `selectedDriverId`, `isUpdating`.
        *   Funções de `fetch` e `update` relacionadas a `blockedPeriods` e `conductors` (`refetchBlockedPeriods`, `loadActiveConductors`, `handleCleanDuplicates`).
        *   Funções de lógica de negócio: `cancelReservation`, `blockDay`, `unblockDay`, `blockTime`, `unblockTime`, `makeTimeAvailable`, `handleBlockDaysRange`, `blockTimeRange`.
        *   Funções auxiliares: `interpolateMessage`, `getClientLanguage`, `getTranslatedMessage`, `openWhatsappMessageEditor`, `sendWhatsappMessage`, `getDayStatus`, `isDayBlocked`, `getDayBlockReason`, `isTimeBlocked`, `isBlockedByReservation`, `isBlockedByAdmin`, `getTimeBlockReason`, `getAllDayBlocks`, `getFilteredBlocks`, `getTourDisplayName`, `getTourDisplayNameTranslated`, `getCurrentWhatsapp`, `getWhatsappLink`.
        *   `useMemo` para `selectedDateReservations`, `availabilitySlots`, `modifiers`.

2.  **`CalendarDisplay.tsx` (Componente de UI):**
    *   **Responsabilidade:** Renderização do `DayPicker` e sua lógica de interação visual.
    *   **Props/Contexto:** Receberá dados e funções do `AdminCalendarProvider` (via `useAdminCalendar` hook).
    *   **Conteúdo a Mover:**
        *   A seção do `DayPicker` e a legenda.
        *   Lógica de renderização dos dias do calendário (`components.Day`).
        *   `handleDayClick` (que chamará funções do contexto/hook).

3.  **`AvailabilityCard.tsx` (Componente de UI):**
    *   **Responsabilidade:** Exibir a disponibilidade por horário.
    *   **Props/Contexto:** Receberá `availabilitySlots`, `calendarDate`, `isBlockedByReservation`, `getTimeBlockReason`, `getReservationsByDate`, `setBlockDate`, `setBlockHourStart`, `setBlockHourModalOpen`, `setSlotToMakeAvailable`, `setMakeAvailableModalOpen`, `isUpdating` via props/contexto.
    *   **Conteúdo a Mover:**
        *   O `Card` de "Disponibilidade por Horário".
        *   O mapeamento e renderização dos `Tooltip` e `Button` para cada slot de horário.

4.  **`BlockManagementSection.tsx` (Componente de UI):**
    *   **Responsabilidade:** Gerenciar a visualização e filtragem de bloqueios.
    *   **Props/Contexto:** Receberá `blockedPeriods`, `blockFilterType`, `setBlockFilterType`, `blockFilterDate`, `setBlockFilterDate`, `getFilteredBlocks`, `unblockDay`, `unblockTime`, `handleCleanDuplicates`, `isCleaningDuplicates` via props/contexto.
    *   **Conteúdo a Mover:**
        *   A seção de "Visualização de Bloqueios".
        *   Os filtros de tipo e data.
        *   A listagem dos dias e horários bloqueados.
        *   Os botões de "Desbloquear" e "Limpar Duplicados".

5.  **`Modals/` (Diretório para Componentes de Modal):**
    *   Cada modal será um componente separado dentro deste diretório.
    *   **`BlockDayModal.tsx`:** Para bloquear um dia inteiro.
        *   **Props/Contexto:** `blockDayModalOpen`, `setBlockDayModalOpen`, `blockDate`, `blockDayReason`, `setBlockDayReason`, `blockDay`, `toast`, `format`, `pt`, `hoursToClear`, `setClearHoursModalOpen`, `deleteBlockedPeriodsByDate`, `setBlockedPeriods`.
    *   **`BlockHourModal.tsx`:** Para bloquear/desbloquear horários específicos ou intervalos.
        *   **Props/Contexto:** `blockHourModalOpen`, `setBlockHourModalOpen`, `blockDate`, `setBlockDate`, `blockHourStart`, `setBlockHourStart`, `blockHourEnd`, `setBlockHourEnd`, `blockTimeReason`, `setBlockTimeReason`, `timeSlots`, `blockTime`, `blockTimeRange`, `getAllDayBlocks`, `unblockTime`, `format`, `pt`.
    *   **`CancelReservationModal.tsx`:** Para anular reservas.
        *   **Props/Contexto:** `cancelReservationModalOpen`, `setCancelReservationModalOpen`, `reservationToCancel`, `cancelReason`, `setCancelReason`, `cancelReservation`, `isCancelling`, `getTourDisplayName`.
    *   **`WhatsappMessageModal.tsx`:** Para editar e enviar mensagens de WhatsApp.
        *   **Props/Contexto:** `whatsappMessageModalOpen`, `setWhatsappMessageModalOpen`, `editableMessage`, `setEditableMessage`, `sendWhatsappMessage`.
    *   **`MakeAvailableModal.tsx`:** Para tornar um horário bloqueado disponível.
        *   **Props/Contexto:** `makeAvailableModalOpen`, `setMakeAvailableModalOpen`, `slotToMakeAvailable`, `blockDate`, `makeTimeAvailable`, `format`, `pt`.
    *   **`ClearHoursModal.tsx`:** Modal de confirmação para limpar horários antes de bloquear um dia.
        *   **Props/Contexto:** `clearHoursModalOpen`, `setClearHoursModalOpen`, `hoursToClear`, `blockDate`, `deleteBlockedPeriodsByDate`, `setBlockedPeriods`, `blockDay`, `blockDayReason`, `setBlockDayModalOpen`, `toast`, `format`, `pt`.
    *   **`QuickViewModal.tsx`:** Para visualização rápida de reservas em um dia.
        *   **Props/Contexto:** `quickViewOpen`, `setQuickViewOpen`, `quickViewDate`, `getReservationsByDate`, `getStatusBadge`, `getTourDisplayName`, `format`, `pt`.

## Passos da Implementação

1.  **Criar `AdminCalendarProvider.tsx`:**
    *   Mover todos os `useState`, `useEffect` e funções de lógica de negócio para este novo arquivo.
    *   Criar um `React.Context` e um hook `useAdminCalendar` para expor os estados e funções.
    *   O componente `AdminCalendar` original será o provedor deste contexto.

2.  **Criar `CalendarDisplay.tsx`:**
    *   Mover a seção do `DayPicker` e a legenda para este componente.
    *   Utilizar o `useAdminCalendar` hook para acessar os dados e funções necessários.

3.  **Criar `AvailabilityCard.tsx`:**
    *   Mover a seção de "Disponibilidade por Horário" para este componente.
    *   Utilizar o `useAdminCalendar` hook.

4.  **Criar `BlockManagementSection.tsx`:**
    *   Mover a seção de "Visualização de Bloqueios" para este componente.
    *   Utilizar o `useAdminCalendar` hook.

5.  **Criar os componentes de Modal:**
    *   Criar um diretório `Modals` dentro de `src/components/admin/`.
    *   Mover a lógica e UI de cada modal para seu próprio arquivo.
    *   Cada modal receberá as props necessárias do `AdminCalendarProvider` (via `useAdminCalendar` ou diretamente como props, dependendo da complexidade e reusabilidade).

6.  **Atualizar `AdminCalendar.tsx`:**
    *   Transformá-lo no componente principal que renderiza o `AdminCalendarProvider` e, dentro dele, os novos componentes filhos.
    *   Remover toda a lógica e estado que foram movidos para o provedor e os componentes filhos.

7.  **Ajustar Importações:**
    *   Atualizar todas as importações nos arquivos afetados.

8.  **Testar:**
    *   Verificar se todas as funcionalidades continuam a operar corretamente.

## Considerações

*   **Dependências:** Manter as dependências externas (date-fns, lucide-react, shadcn/ui, supabase, react-router-dom, react-i18next) no `AdminCalendarProvider` ou nos componentes que realmente as utilizam.
*   **Performance:** O uso de `useMemo` e `useCallback` já está presente e deve ser mantido para otimização.
*   **Tipagem:** Garantir que todas as interfaces e tipos (`BlockedPeriod`, `AdminReservation`, etc.) sejam corretamente importados e utilizados nos novos componentes.
