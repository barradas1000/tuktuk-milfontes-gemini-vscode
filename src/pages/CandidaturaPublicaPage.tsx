import React from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import {
  Users,
  MapPin,
  Clock,
  Euro,
  Car,
  Shield,
  CheckCircle,
  ArrowRight,
  Star,
  Phone,
  Mail,
} from "lucide-react";
import { CandidaturaPublicaForm } from "@/components/candidatura/CandidaturaPublicaForm";

const CandidaturaPublicaPage: React.FC = () => {
  const benefits = [
    {
      icon: Euro,
      title: "Rendimento Garantido",
      description:
        "Ganhe entre €800-€1500 por mês trabalhando no horário que preferir",
    },
    {
      icon: Clock,
      title: "Horário Flexível",
      description: "Defina os seus próprios horários e trabalhe quando quiser",
    },
    {
      icon: MapPin,
      title: "Zona de Trabalho",
      description: "Trabalhe na região que conhece melhor",
    },
    {
      icon: Shield,
      title: "Seguro Incluído",
      description: "Proteção completa durante todas as viagens",
    },
    {
      icon: Users,
      title: "Apoio 24/7",
      description: "Suporte técnico e operacional sempre disponível",
    },
    {
      icon: Car,
      title: "Veículo Próprio",
      description: "Use o seu próprio veículo ou alugue através de parceiros",
    },
  ];

  const requirements = [
    "Idade mínima de 23 anos",
    "Carta de condução válida há pelo menos 3 anos",
    "Registo criminal limpo",
    "Veículo em bom estado (próprio ou alugado)",
    "Telemóvel com GPS e internet",
    "Disponibilidade mínima de 20 horas/semana",
  ];

  const regions = [
    "Milfontes",
    "Odemira",
    "Zambujeira do Mar",
    "Almograve",
    "Vila Nova de Milfontes",
    "Porto Covo",
    "Sines",
  ];

  const testimonials = [
    {
      name: "João Silva",
      region: "Milfontes",
      rating: 5,
      comment:
        "Excelente oportunidade! Horários flexíveis e rendimento estável.",
    },
    {
      name: "Maria Santos",
      region: "Odemira",
      rating: 5,
      comment:
        "Trabalho há 6 meses e recomendo. Apoio da empresa é fantástico.",
    },
    {
      name: "Carlos Oliveira",
      region: "Zambujeira",
      rating: 5,
      comment:
        "Consegui complementar o meu rendimento trabalhando nos fins-de-semana.",
    },
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 via-white to-green-50">
      {/* Hero Section */}
      <div className="bg-gradient-to-r from-blue-600 to-green-600 text-white py-16">
        <div className="max-w-6xl mx-auto px-4">
          <div className="text-center">
            <h1 className="text-4xl md:text-6xl font-bold mb-6">
              Torne-se Condutor TukTuk
            </h1>
            <p className="text-xl md:text-2xl mb-8 opacity-90">
              Junte-se à nossa equipa e comece a ganhar dinheiro hoje mesmo!
            </p>
            <div className="flex flex-wrap justify-center gap-4 mb-8">
              <Badge className="bg-white text-blue-600 text-lg px-4 py-2">
                <Euro className="h-5 w-5 mr-2" />
                €800-€1500/mês
              </Badge>
              <Badge className="bg-white text-green-600 text-lg px-4 py-2">
                <Clock className="h-5 w-5 mr-2" />
                Horário Flexível
              </Badge>
              <Badge className="bg-white text-purple-600 text-lg px-4 py-2">
                <Users className="h-5 w-5 mr-2" />
                +200 Condutores
              </Badge>
            </div>
            <Button
              size="lg"
              className="bg-white text-blue-600 hover:bg-gray-100 text-lg px-8 py-4"
              onClick={() =>
                document
                  .getElementById("candidatura-form")
                  ?.scrollIntoView({ behavior: "smooth" })
              }
            >
              Candidatar-me Agora
              <ArrowRight className="h-5 w-5 ml-2" />
            </Button>
          </div>
        </div>
      </div>

      {/* Benefits Section */}
      <div className="py-16">
        <div className="max-w-6xl mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
              Porquê Ser Condutor TukTuk?
            </h2>
            <p className="text-lg text-gray-600 max-w-2xl mx-auto">
              Oferecemos as melhores condições do mercado para que possa ter
              sucesso como condutor profissional.
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {benefits.map((benefit, index) => (
              <Card
                key={index}
                className="text-center hover:shadow-lg transition-shadow duration-300"
              >
                <CardContent className="p-6">
                  <div className="bg-blue-100 rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-4">
                    <benefit.icon className="h-8 w-8 text-blue-600" />
                  </div>
                  <h3 className="text-xl font-semibold text-gray-900 mb-2">
                    {benefit.title}
                  </h3>
                  <p className="text-gray-600">{benefit.description}</p>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </div>

      {/* Requirements Section */}
      <div className="bg-gray-50 py-16">
        <div className="max-w-4xl mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
              Requisitos
            </h2>
            <p className="text-lg text-gray-600">
              Verifique se cumpre os requisitos mínimos para se tornar condutor
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {requirements.map((requirement, index) => (
              <div
                key={index}
                className="flex items-center gap-3 bg-white p-4 rounded-lg"
              >
                <CheckCircle className="h-5 w-5 text-green-600 flex-shrink-0" />
                <span className="text-gray-800">{requirement}</span>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Regions Section */}
      <div className="py-16">
        <div className="max-w-4xl mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
              Regiões Disponíveis
            </h2>
            <p className="text-lg text-gray-600">
              Estamos presentes em várias localidades da costa alentejana
            </p>
          </div>

          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4">
            {regions.map((region, index) => (
              <div
                key={index}
                className="bg-white border border-gray-200 rounded-lg p-4 text-center hover:border-blue-300 transition-colors"
              >
                <MapPin className="h-6 w-6 text-blue-600 mx-auto mb-2" />
                <span className="font-medium text-gray-900">{region}</span>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Testimonials Section */}
      <div className="bg-gray-50 py-16">
        <div className="max-w-6xl mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
              O Que Dizem Os Nossos Condutores
            </h2>
            <p className="text-lg text-gray-600">
              Testemunhos reais de quem já faz parte da família TukTuk
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            {testimonials.map((testimonial, index) => (
              <Card key={index} className="text-center">
                <CardContent className="p-6">
                  <div className="flex justify-center mb-4">
                    {[...Array(testimonial.rating)].map((_, i) => (
                      <Star
                        key={i}
                        className="h-5 w-5 text-yellow-400 fill-current"
                      />
                    ))}
                  </div>
                  <blockquote className="text-gray-600 italic mb-4">
                    "{testimonial.comment}"
                  </blockquote>
                  <div>
                    <div className="font-semibold text-gray-900">
                      {testimonial.name}
                    </div>
                    <div className="text-sm text-gray-500">
                      {testimonial.region}
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </div>

      {/* Application Form Section */}
      <div id="candidatura-form" className="py-16">
        <div className="max-w-4xl mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
              Candidatar-me Agora
            </h2>
            <p className="text-lg text-gray-600">
              Preencha o formulário abaixo e entraremos em contacto consigo
            </p>
          </div>

          <Card className="shadow-lg">
            <CardContent className="p-8">
              <CandidaturaPublicaForm />
            </CardContent>
          </Card>
        </div>
      </div>

      {/* Contact Section */}
      <div className="bg-blue-600 text-white py-16">
        <div className="max-w-4xl mx-auto px-4 text-center">
          <h2 className="text-3xl md:text-4xl font-bold mb-4">
            Ainda Tem Dúvidas?
          </h2>
          <p className="text-xl mb-8 opacity-90">
            A nossa equipa está disponível para esclarecer todas as suas
            questões
          </p>

          <div className="flex flex-col md:flex-row gap-8 justify-center items-center">
            <div className="flex items-center gap-3">
              <Phone className="h-6 w-6" />
              <div>
                <div className="font-semibold">Telefone</div>
                <div className="opacity-90">+351 123 456 789</div>
              </div>
            </div>

            <div className="flex items-center gap-3">
              <Mail className="h-6 w-6" />
              <div>
                <div className="font-semibold">Email</div>
                <div className="opacity-90">condutores@tuktuk-milfontes.pt</div>
              </div>
            </div>
          </div>

          <div className="mt-8">
            <Button
              size="lg"
              className="bg-white text-blue-600 hover:bg-gray-100"
              onClick={() =>
                document
                  .getElementById("candidatura-form")
                  ?.scrollIntoView({ behavior: "smooth" })
              }
            >
              Candidatar-me Agora
              <ArrowRight className="h-5 w-5 ml-2" />
            </Button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default CandidaturaPublicaPage;
