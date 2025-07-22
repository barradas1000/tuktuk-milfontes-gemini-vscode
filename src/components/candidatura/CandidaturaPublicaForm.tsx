import React, { useState, useEffect } from "react";
import { useSearchParams } from "react-router-dom";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Badge } from "@/components/ui/badge";
import {
  AlertTriangle,
  CheckCircle,
  MapPin,
  User,
  Phone,
  Car,
} from "lucide-react";
import { toast } from "sonner";

interface CandidaturaFormData {
  full_name: string;
  email: string;
  phone: string;
  whatsapp?: string;
  region: string;
  zone?: string;
  license_number?: string;
  vehicle_info: {
    marca?: string;
    modelo?: string;
    ano?: number;
    matricula?: string;
  };
  experience: string;
  motivation: string;
}

const REGIONS = [
  { value: "milfontes", label: "Vila Nova de Milfontes" },
  { value: "zambujeira", label: "Zambujeira do Mar" },
  { value: "almograve", label: "Almograve" },
];

const ZONES = {
  milfontes: [
    { value: "centro", label: "Centro Histórico" },
    { value: "praia", label: "Zona da Praia" },
    { value: "residencial", label: "Zona Residencial" },
  ],
  zambujeira: [
    { value: "centro", label: "Centro" },
    { value: "praia", label: "Praia" },
  ],
  almograve: [
    { value: "vila", label: "Vila" },
    { value: "praia", label: "Praia" },
  ],
};

export const CandidaturaPublicaForm: React.FC = () => {
  const [searchParams] = useSearchParams();
  const [formData, setFormData] = useState<CandidaturaFormData>({
    full_name: "",
    email: "",
    phone: "",
    whatsapp: "",
    region: "",
    zone: "",
    license_number: "",
    vehicle_info: {
      marca: "",
      modelo: "",
      ano: undefined,
      matricula: "",
    },
    experience: "",
    motivation: "",
  });

  const [isSubmitting, setIsSubmitting] = useState(false);
  const [isSubmitted, setIsSubmitted] = useState(false);

  // Pré-preencher formulário com parâmetros da URL (convites de admin)
  useEffect(() => {
    const urlParams = {
      name: searchParams.get("name"),
      email: searchParams.get("email"),
      phone: searchParams.get("phone"),
      whatsapp: searchParams.get("whatsapp"),
      region: searchParams.get("region"),
      invite_token: searchParams.get("invite_token"),
      invited_by: searchParams.get("invited_by"),
    };

    // Se há parâmetros, pré-preencher o formulário
    if (urlParams.name || urlParams.email || urlParams.phone) {
      setFormData((prev) => ({
        ...prev,
        full_name: urlParams.name || prev.full_name,
        email: urlParams.email || prev.email,
        phone: urlParams.phone || prev.phone,
        whatsapp: urlParams.whatsapp || prev.whatsapp,
        region: urlParams.region || prev.region,
      }));

      // Mostrar toast de boas-vindas se foi convidado por admin
      if (urlParams.invited_by === "admin_local") {
        toast.success("Bem-vindo!", {
          description:
            "Este formulário foi preparado especialmente para si por um administrador.",
          duration: 5000,
        });
      }
    }
  }, [searchParams]);

  const handleInputChange = (
    field: keyof CandidaturaFormData,
    value: string
  ) => {
    setFormData((prev) => ({
      ...prev,
      [field]: value,
    }));
  };

  const handleVehicleInfoChange = (
    field: keyof CandidaturaFormData["vehicle_info"],
    value: string | number
  ) => {
    setFormData((prev) => ({
      ...prev,
      vehicle_info: {
        ...prev.vehicle_info,
        [field]: value,
      },
    }));
  };

  const validateForm = (): boolean => {
    const required = ["full_name", "email", "phone", "region"];
    const missing = required.filter(
      (field) => !formData[field as keyof CandidaturaFormData]
    );

    if (missing.length > 0) {
      toast.error(`Campos obrigatórios em falta: ${missing.join(", ")}`);
      return false;
    }

    // Validar email
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(formData.email)) {
      toast.error("Por favor, insira um email válido");
      return false;
    }

    // Validar telemóvel
    const phoneRegex = /^[0-9+\s-()]{9,}$/;
    if (!phoneRegex.test(formData.phone)) {
      toast.error("Por favor, insira um número de telemóvel válido");
      return false;
    }

    return true;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!validateForm()) return;

    setIsSubmitting(true);

    try {
      // Aqui seria a chamada ao serviço
      // await candidaturaService.submitApplication(formData);

      // Simulação por agora
      await new Promise((resolve) => setTimeout(resolve, 2000));

      setIsSubmitted(true);
      toast.success("Candidatura enviada com sucesso!");
    } catch (error) {
      toast.error("Erro ao enviar candidatura. Tente novamente.");
      console.error("Erro:", error);
    } finally {
      setIsSubmitting(false);
    }
  };

  if (isSubmitted) {
    return (
      <div className="max-w-2xl mx-auto p-6">
        <Card className="border-green-200 bg-green-50">
          <CardContent className="p-8 text-center">
            <CheckCircle className="h-16 w-16 text-green-600 mx-auto mb-4" />
            <h2 className="text-2xl font-bold text-green-800 mb-2">
              Candidatura Enviada!
            </h2>
            <p className="text-green-700 mb-4">
              Obrigado pelo seu interesse em juntar-se à nossa equipa de
              condutores TukTuk.
            </p>
            <div className="bg-white p-4 rounded-lg border border-green-200">
              <h3 className="font-semibold text-green-800 mb-2">
                Próximos Passos:
              </h3>
              <ul className="text-sm text-green-700 space-y-1 text-left">
                <li>• A sua candidatura será revista por um administrador</li>
                <li>
                  • Receberá uma resposta no email fornecido em 24-48 horas
                </li>
                <li>• Se aprovado, será contactado para próximos passos</li>
                <li>• Guarde este email para referência futura</li>
              </ul>
            </div>
            <Button className="mt-6" onClick={() => window.location.reload()}>
              Fazer Nova Candidatura
            </Button>
          </CardContent>
        </Card>
      </div>
    );
  }

  return (
    <div className="max-w-4xl mx-auto p-6">
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2 text-2xl">
            <Car className="h-6 w-6 text-blue-600" />
            Candidatura para Condutor TukTuk
          </CardTitle>
          <p className="text-gray-600">
            Junte-se à nossa equipa e torne-se um condutor oficial TukTuk em
            Vila Nova de Milfontes
          </p>
        </CardHeader>

        <CardContent>
          <form onSubmit={handleSubmit} className="space-y-8">
            {/* Informações Pessoais */}
            <div className="space-y-4">
              <div className="flex items-center gap-2 mb-4">
                <User className="h-5 w-5 text-blue-600" />
                <h3 className="text-lg font-semibold">Informações Pessoais</h3>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="full_name">Nome Completo *</Label>
                  <Input
                    id="full_name"
                    value={formData.full_name}
                    onChange={(e) =>
                      handleInputChange("full_name", e.target.value)
                    }
                    placeholder="Digite o seu nome completo"
                    required
                  />
                </div>

                <div>
                  <Label htmlFor="email">Email *</Label>
                  <Input
                    id="email"
                    type="email"
                    value={formData.email}
                    onChange={(e) => handleInputChange("email", e.target.value)}
                    placeholder="seuemail@exemplo.com"
                    required
                  />
                </div>

                <div>
                  <Label htmlFor="phone">Telemóvel *</Label>
                  <Input
                    id="phone"
                    type="tel"
                    value={formData.phone}
                    onChange={(e) => handleInputChange("phone", e.target.value)}
                    placeholder="+351 9XX XXX XXX"
                    required
                  />
                </div>

                <div>
                  <Label htmlFor="whatsapp">WhatsApp (opcional)</Label>
                  <Input
                    id="whatsapp"
                    type="tel"
                    value={formData.whatsapp}
                    onChange={(e) =>
                      handleInputChange("whatsapp", e.target.value)
                    }
                    placeholder="+351 9XX XXX XXX"
                  />
                </div>
              </div>
            </div>

            {/* Localização */}
            <div className="space-y-4">
              <div className="flex items-center gap-2 mb-4">
                <MapPin className="h-5 w-5 text-blue-600" />
                <h3 className="text-lg font-semibold">
                  Localização de Trabalho
                </h3>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="region">Região de Trabalho *</Label>
                  <Select
                    value={formData.region}
                    onValueChange={(value) =>
                      handleInputChange("region", value)
                    }
                  >
                    <SelectTrigger>
                      <SelectValue placeholder="Selecione a região" />
                    </SelectTrigger>
                    <SelectContent>
                      {REGIONS.map((region) => (
                        <SelectItem key={region.value} value={region.value}>
                          {region.label}
                        </SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>

                {formData.region && (
                  <div>
                    <Label htmlFor="zone">Zona Preferencial (opcional)</Label>
                    <Select
                      value={formData.zone}
                      onValueChange={(value) =>
                        handleInputChange("zone", value)
                      }
                    >
                      <SelectTrigger>
                        <SelectValue placeholder="Selecione a zona" />
                      </SelectTrigger>
                      <SelectContent>
                        {ZONES[formData.region as keyof typeof ZONES]?.map(
                          (zone) => (
                            <SelectItem key={zone.value} value={zone.value}>
                              {zone.label}
                            </SelectItem>
                          )
                        )}
                      </SelectContent>
                    </Select>
                  </div>
                )}
              </div>
            </div>

            {/* Informações do Veículo */}
            <div className="space-y-4">
              <div className="flex items-center gap-2 mb-4">
                <Car className="h-5 w-5 text-blue-600" />
                <h3 className="text-lg font-semibold">
                  Informações do Veículo (se já possuir)
                </h3>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="license_number">Carta de Condução</Label>
                  <Input
                    id="license_number"
                    value={formData.license_number}
                    onChange={(e) =>
                      handleInputChange("license_number", e.target.value)
                    }
                    placeholder="Número da carta de condução"
                  />
                </div>

                <div>
                  <Label htmlFor="marca">Marca do Veículo</Label>
                  <Input
                    id="marca"
                    value={formData.vehicle_info.marca}
                    onChange={(e) =>
                      handleVehicleInfoChange("marca", e.target.value)
                    }
                    placeholder="Ex: Piaggio, Bajaj"
                  />
                </div>

                <div>
                  <Label htmlFor="modelo">Modelo</Label>
                  <Input
                    id="modelo"
                    value={formData.vehicle_info.modelo}
                    onChange={(e) =>
                      handleVehicleInfoChange("modelo", e.target.value)
                    }
                    placeholder="Ex: Ape 50, Maxima"
                  />
                </div>

                <div>
                  <Label htmlFor="ano">Ano</Label>
                  <Input
                    id="ano"
                    type="number"
                    value={formData.vehicle_info.ano || ""}
                    onChange={(e) =>
                      handleVehicleInfoChange("ano", parseInt(e.target.value))
                    }
                    placeholder="2020"
                    min="1990"
                    max={new Date().getFullYear()}
                  />
                </div>

                <div className="md:col-span-2">
                  <Label htmlFor="matricula">Matrícula</Label>
                  <Input
                    id="matricula"
                    value={formData.vehicle_info.matricula}
                    onChange={(e) =>
                      handleVehicleInfoChange("matricula", e.target.value)
                    }
                    placeholder="XX-XX-XX"
                  />
                </div>
              </div>
            </div>

            {/* Experiência e Motivação */}
            <div className="space-y-4">
              <div>
                <Label htmlFor="experience">Experiência Prévia</Label>
                <Textarea
                  id="experience"
                  value={formData.experience}
                  onChange={(e) =>
                    handleInputChange("experience", e.target.value)
                  }
                  placeholder="Descreva a sua experiência como condutor profissional, turismo, ou trabalho com público..."
                  rows={3}
                />
              </div>

              <div>
                <Label htmlFor="motivation">Motivação</Label>
                <Textarea
                  id="motivation"
                  value={formData.motivation}
                  onChange={(e) =>
                    handleInputChange("motivation", e.target.value)
                  }
                  placeholder="Por que quer ser condutor TukTuk? O que o motiva a trabalhar no turismo local?"
                  rows={3}
                />
              </div>
            </div>

            {/* Aviso Legal */}
            <div className="bg-yellow-50 border border-yellow-200 p-4 rounded-lg">
              <div className="flex items-start gap-2">
                <AlertTriangle className="h-5 w-5 text-yellow-600 mt-0.5" />
                <div>
                  <h4 className="font-semibold text-yellow-800">
                    Informação Importante
                  </h4>
                  <p className="text-sm text-yellow-700 mt-1">
                    Ao submeter esta candidatura, aceita que os seus dados sejam
                    processados para avaliação da candidatura. Os dados são
                    tratados com confidencialidade e de acordo com o RGPD.
                    Apenas administradores autorizados terão acesso às suas
                    informações.
                  </p>
                </div>
              </div>
            </div>

            {/* Botão de Envio */}
            <div className="flex justify-center pt-6">
              <Button
                type="submit"
                size="lg"
                disabled={isSubmitting}
                className="px-8"
              >
                {isSubmitting ? (
                  <>
                    <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white mr-2"></div>
                    Enviando...
                  </>
                ) : (
                  "Enviar Candidatura"
                )}
              </Button>
            </div>
          </form>
        </CardContent>
      </Card>
    </div>
  );
};

export default CandidaturaPublicaForm;
