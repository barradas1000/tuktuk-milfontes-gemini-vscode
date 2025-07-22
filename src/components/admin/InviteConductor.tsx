import React, { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  UserPlus,
  Send,
  Copy,
  CheckCircle,
  MessageSquare,
  Mail,
  Phone,
  Link as LinkIcon,
} from "lucide-react";
import { toast } from "sonner";

interface InviteConductorProps {
  region?: string;
  adminLevel: "super_admin" | "admin_regional" | "admin_local";
}

export const InviteConductor: React.FC<InviteConductorProps> = ({
  region,
  adminLevel,
}) => {
  const [isOpen, setIsOpen] = useState(false);
  const [inviteMethod, setInviteMethod] = useState<
    "link" | "whatsapp" | "email" | "sms"
  >("link");
  const [candidateInfo, setCandidateInfo] = useState({
    name: "",
    phone: "",
    email: "",
    whatsapp: "",
    notes: "",
  });
  const [generatedLink, setGeneratedLink] = useState("");
  const [isGenerating, setIsGenerating] = useState(false);

  // Gerar link personalizado de candidatura
  const generateCandidatureLink = async () => {
    setIsGenerating(true);

    try {
      // Simular geração de token único
      const inviteToken = `invite_${Date.now()}_${Math.random()
        .toString(36)
        .substr(2, 9)}`;

      // URL da candidatura com parâmetros pré-preenchidos
      const baseUrl = window.location.origin;
      const params = new URLSearchParams();

      if (candidateInfo.name) params.set("name", candidateInfo.name);
      if (candidateInfo.email) params.set("email", candidateInfo.email);
      if (candidateInfo.phone) params.set("phone", candidateInfo.phone);
      if (candidateInfo.whatsapp)
        params.set("whatsapp", candidateInfo.whatsapp);
      if (region) params.set("region", region);
      params.set("invite_token", inviteToken);
      params.set("invited_by", "admin_local");

      const link = `${baseUrl}/candidatura-condutor?${params.toString()}`;
      setGeneratedLink(link);

      toast.success("Link de candidatura gerado com sucesso!");
    } catch (error) {
      toast.error("Erro ao gerar link de candidatura");
      console.error("Erro:", error);
    } finally {
      setIsGenerating(false);
    }
  };

  // Copiar link para clipboard
  const copyToClipboard = async () => {
    try {
      await navigator.clipboard.writeText(generatedLink);
      toast.success("Link copiado para a área de transferência!");
    } catch (error) {
      toast.error("Erro ao copiar link");
    }
  };

  // Enviar via WhatsApp
  const sendViaWhatsApp = () => {
    if (!candidateInfo.whatsapp) {
      toast.error("Número de WhatsApp é obrigatório");
      return;
    }

    const message = `Olá ${candidateInfo.name || ""}! 🛺
Confirme os dados para se tornar condutor TukTuk em ${region || "nossa região"}.

Clique no link abaixo:
${generatedLink}

Qualquer dúvida, estamos aqui para ajudar!

Equipa TukTuk Milfontes`;

    const whatsappUrl = `https://wa.me/${candidateInfo.whatsapp.replace(
      /\D/g,
      ""
    )}?text=${encodeURIComponent(message)}`;
    window.open(whatsappUrl, "_blank");

    toast.success("WhatsApp aberto com a mensagem!");
  };

  // Enviar via Email (abre cliente de email)
  const sendViaEmail = () => {
    if (!candidateInfo.email) {
      toast.error("Email é obrigatório");
      return;
    }

    const subject = "Convite para se tornar Condutor TukTuk";
    const body = `Olá ${candidateInfo.name || ""}!

Temos uma excelente oportunidade para se tornar condutor TukTuk em ${
      region || "nossa região"
    }.

Para se candidatar, clique no link abaixo:
${generatedLink}

Se tiver dúvidas, pode contactar-nos diretamente.

Cumprimentos,
Equipa TukTuk Milfontes`;

    const mailtoUrl = `mailto:${
      candidateInfo.email
    }?subject=${encodeURIComponent(subject)}&body=${encodeURIComponent(body)}`;
    window.location.href = mailtoUrl;

    toast.success("Cliente de email aberto!");
  };

  // Resetar formulário
  const resetForm = () => {
    setCandidateInfo({
      name: "",
      phone: "",
      email: "",
      whatsapp: "",
      notes: "",
    });
    setGeneratedLink("");
    setInviteMethod("link");
  };

  return (
    <Dialog open={isOpen} onOpenChange={setIsOpen}>
      <DialogTrigger asChild>
        <Button className="flex items-center gap-2">
          <UserPlus className="h-4 w-4" />
          Convidar Novo Condutor
        </Button>
      </DialogTrigger>

      <DialogContent className="max-w-2xl max-h-[80vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2">
            <UserPlus className="h-5 w-5" />
            Convidar Novo Condutor
          </DialogTitle>
        </DialogHeader>

        <div className="space-y-6">
          {/* Informações do Candidato */}
          <Card>
            <CardHeader>
              <CardTitle className="text-lg">
                Informações do Candidato
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="candidate-name">Nome *</Label>
                  <Input
                    id="candidate-name"
                    value={candidateInfo.name}
                    onChange={(e) =>
                      setCandidateInfo((prev) => ({
                        ...prev,
                        name: e.target.value,
                      }))
                    }
                    placeholder="Nome completo do candidato"
                  />
                </div>
                <div>
                  <Label htmlFor="candidate-phone">Telemóvel *</Label>
                  <Input
                    id="candidate-phone"
                    value={candidateInfo.phone}
                    onChange={(e) =>
                      setCandidateInfo((prev) => ({
                        ...prev,
                        phone: e.target.value,
                      }))
                    }
                    placeholder="+351 9XX XXX XXX"
                  />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="candidate-email">Email</Label>
                  <Input
                    id="candidate-email"
                    type="email"
                    value={candidateInfo.email}
                    onChange={(e) =>
                      setCandidateInfo((prev) => ({
                        ...prev,
                        email: e.target.value,
                      }))
                    }
                    placeholder="email@exemplo.com"
                  />
                </div>
                <div>
                  <Label htmlFor="candidate-whatsapp">WhatsApp</Label>
                  <Input
                    id="candidate-whatsapp"
                    value={candidateInfo.whatsapp}
                    onChange={(e) =>
                      setCandidateInfo((prev) => ({
                        ...prev,
                        whatsapp: e.target.value,
                      }))
                    }
                    placeholder="+351 9XX XXX XXX"
                  />
                </div>
              </div>

              <div>
                <Label htmlFor="candidate-notes">Notas (opcional)</Label>
                <Textarea
                  id="candidate-notes"
                  value={candidateInfo.notes}
                  onChange={(e) =>
                    setCandidateInfo((prev) => ({
                      ...prev,
                      notes: e.target.value,
                    }))
                  }
                  placeholder="Informações adicionais sobre o candidato..."
                  rows={3}
                />
              </div>
            </CardContent>
          </Card>

          {/* Método de Envio */}
          <Card>
            <CardHeader>
              <CardTitle className="text-lg">Método de Envio</CardTitle>
            </CardHeader>
            <CardContent>
              <Select
                value={inviteMethod}
                onValueChange={(value: "link" | "whatsapp" | "email" | "sms") =>
                  setInviteMethod(value)
                }
              >
                <SelectTrigger>
                  <SelectValue placeholder="Selecione como enviar o convite" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="link">
                    <div className="flex items-center gap-2">
                      <LinkIcon className="h-4 w-4" />
                      Apenas gerar link (copiar e colar)
                    </div>
                  </SelectItem>
                  <SelectItem value="whatsapp">
                    <div className="flex items-center gap-2">
                      <MessageSquare className="h-4 w-4" />
                      Enviar via WhatsApp
                    </div>
                  </SelectItem>
                  <SelectItem value="email">
                    <div className="flex items-center gap-2">
                      <Mail className="h-4 w-4" />
                      Enviar via Email
                    </div>
                  </SelectItem>
                  <SelectItem value="sms">
                    <div className="flex items-center gap-2">
                      <Phone className="h-4 w-4" />
                      Enviar via SMS (futuro)
                    </div>
                  </SelectItem>
                </SelectContent>
              </Select>
            </CardContent>
          </Card>

          {/* Ações */}
          <div className="space-y-4">
            {!generatedLink ? (
              <Button
                onClick={generateCandidatureLink}
                disabled={
                  isGenerating || !candidateInfo.name || !candidateInfo.phone
                }
                className="w-full"
              >
                {isGenerating ? "Gerando..." : "Gerar Link de Candidatura"}
              </Button>
            ) : (
              <div className="space-y-4">
                {/* Link gerado */}
                <div className="p-4 bg-green-50 rounded-lg border border-green-200">
                  <div className="flex items-center gap-2 mb-2">
                    <CheckCircle className="h-5 w-5 text-green-600" />
                    <span className="font-medium text-green-800">
                      Link gerado com sucesso!
                    </span>
                  </div>
                  <div className="flex items-center gap-2">
                    <Input
                      value={generatedLink}
                      readOnly
                      className="flex-1 bg-white"
                    />
                    <Button
                      variant="outline"
                      size="sm"
                      onClick={copyToClipboard}
                    >
                      <Copy className="h-4 w-4" />
                    </Button>
                  </div>
                </div>

                {/* Botões de envio */}
                <div className="grid grid-cols-2 gap-4">
                  {inviteMethod === "whatsapp" && (
                    <Button
                      onClick={sendViaWhatsApp}
                      disabled={!candidateInfo.whatsapp}
                      className="bg-green-600 hover:bg-green-700"
                    >
                      <MessageSquare className="h-4 w-4 mr-2" />
                      Enviar WhatsApp
                    </Button>
                  )}

                  {inviteMethod === "email" && (
                    <Button
                      onClick={sendViaEmail}
                      disabled={!candidateInfo.email}
                      className="bg-blue-600 hover:bg-blue-700"
                    >
                      <Mail className="h-4 w-4 mr-2" />
                      Enviar Email
                    </Button>
                  )}

                  <Button variant="outline" onClick={resetForm}>
                    Novo Convite
                  </Button>
                </div>
              </div>
            )}
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
};

export default InviteConductor;
