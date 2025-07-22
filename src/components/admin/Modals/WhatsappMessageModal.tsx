import React from "react";
import { Phone } from "lucide-react";

import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Textarea } from "@/components/ui/textarea";

import { useAdminCalendar } from "../AdminCalendarProvider";

interface WhatsappMessageModalProps {
  whatsappMessageModalOpen: boolean;
  setWhatsappMessageModalOpen: (open: boolean) => void;
}

const WhatsappMessageModal = ({
  whatsappMessageModalOpen,
  setWhatsappMessageModalOpen,
}: WhatsappMessageModalProps) => {
  const { editableMessage, setEditableMessage, sendWhatsappMessage } = useAdminCalendar();

  return (
    <Dialog
      open={whatsappMessageModalOpen}
      onOpenChange={setWhatsappMessageModalOpen}
    >
      <DialogContent className="max-w-2xl max-h-[80vh] overflow-hidden">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2">
            <Phone className="h-5 w-5" />
            Editar Mensagem do WhatsApp
          </DialogTitle>
        </DialogHeader>
        <div className="space-y-4">
          <Textarea
            value={editableMessage}
            onChange={(e) => setEditableMessage(e.target.value)}
            rows={6}
            placeholder="Digite a mensagem a ser enviada..."
            className="w-full"
          />
          <div className="flex justify-end gap-2">
            <Button
              variant="outline"
              onClick={() => setWhatsappMessageModalOpen(false)}
            >
              Cancelar
            </Button>
            <Button onClick={sendWhatsappMessage}>Enviar Mensagem</Button>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
};

export default WhatsappMessageModal;
