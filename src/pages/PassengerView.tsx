import React, { Suspense } from "react";
import { useTranslation } from "react-i18next";
import { Link } from "react-router-dom";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import PassengerMap from "../components/PassengerMap";
import LanguageSelector from "@/components/LanguageSelector";

const StepList = ({ title, steps }: { title: string; steps: string[] }) => (
  <>
    <div className="font-medium mt-3">{title}</div>
    {steps.map((step, idx) => (
      <div key={idx}>
        {idx + 1}. {step}
      </div>
    ))}
  </>
);

const PassengerView: React.FC = () => {
  const { t } = useTranslation();

  // Dados estruturados para cada secção de passos
  const setupSections = [
    {
      title: t("tuktukTracking.locationSetup.chrome.title"),
      steps: [
        t("tuktukTracking.locationSetup.chrome.steps.0"),
        t("tuktukTracking.locationSetup.chrome.steps.1"),
        t("tuktukTracking.locationSetup.chrome.steps.2"),
        t("tuktukTracking.locationSetup.chrome.steps.3"),
        t("tuktukTracking.locationSetup.chrome.steps.4"),
        t("tuktukTracking.locationSetup.chrome.steps.5"),
        t("tuktukTracking.locationSetup.chrome.steps.6"),
      ],
    },
    {
      title: t("tuktukTracking.locationSetup.samsung.title"),
      steps: [
        t("tuktukTracking.locationSetup.samsung.steps.0"),
        t("tuktukTracking.locationSetup.samsung.steps.1"),
        t("tuktukTracking.locationSetup.samsung.steps.2"),
        t("tuktukTracking.locationSetup.samsung.steps.3"),
        t("tuktukTracking.locationSetup.samsung.steps.4"),
      ],
    },
    {
      title: t("tuktukTracking.locationSetup.firefox.title"),
      steps: [
        t("tuktukTracking.locationSetup.firefox.steps.0"),
        t("tuktukTracking.locationSetup.firefox.steps.1"),
        t("tuktukTracking.locationSetup.firefox.steps.2"),
        t("tuktukTracking.locationSetup.firefox.steps.3"),
      ],
    },
    {
      title: t("tuktukTracking.locationSetup.alternative.title"),
      description: t("tuktukTracking.locationSetup.alternative.description"),
      steps: [
        t("tuktukTracking.locationSetup.alternative.steps.0"),
        t("tuktukTracking.locationSetup.alternative.steps.1"),
        t("tuktukTracking.locationSetup.alternative.steps.2"),
      ],
    },
  ];

  return (
    <div className="min-h-screen bg-gray-50">
      <LanguageSelector />

      {/* Cabeçalho */}
      <header className="bg-white shadow-sm border-b">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6 text-center">
          <h1 className="text-3xl font-bold text-gray-900">
            {t("tuktukTracking.pageTitle")}
          </h1>
          <p className="text-gray-600 mt-2">{t("tuktukTracking.pageDescription")}</p>
        </div>
      </header>

      {/* Conteúdo principal */}
      <main className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {/* Mapa */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              {t("tuktukTracking.currentLocation")}
            </CardTitle>
          </CardHeader>
          <CardContent>
            <Suspense fallback={<div className="text-center">{t('loading.tukTukLocation')}</div>}>
              <PassengerMap />
            </Suspense>
          </CardContent>
        </Card>

        {/* Cartões informativos */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mt-8">
          {/* Como funciona */}
          <Card>
            <CardHeader>
              <CardTitle className="text-lg">{t("tuktukTracking.howItWorks")}</CardTitle>
            </CardHeader>
            <CardContent className="space-y-3 text-sm text-gray-600">
              {["blueDot", "autoUpdate", "offline"].map((itemKey) => (
                <div key={itemKey}>• {t(`tuktukTracking.howItWorksItems.${itemKey}`)}</div>
              ))}
            </CardContent>
          </Card>

          {/* Configuração de localização */}
          <Card>
            <CardHeader>
              <CardTitle className="text-lg">{t("tuktukTracking.locationSetup.title")}</CardTitle>
            </CardHeader>
            <CardContent className="space-y-3 text-sm text-gray-600">
              {setupSections.map((section, idx) => (
                <div key={idx}>
                  <StepList title={section.title} steps={section.steps} />
                  {section.description && (
                    <div className="mb-2 text-xs italic">{section.description}</div>
                  )}
                </div>
              ))}
            </CardContent>
          </Card>

          {/* Contacto */}
          <Card>
            <CardHeader>
              <CardTitle className="text-lg">{t("tuktukTracking.contact")}</CardTitle>
            </CardHeader>
            <CardContent className="space-y-3 text-sm text-gray-600">
              {["phone tâm", "whatsapp", "email"].map((itemKey) => (
                <div key={itemKey}>• {t(`tuktukTracking.contactItems.${itemKey}`)}</div>
              ))}
            </CardContent>
          </Card>
        </div>

        {/* Botão de voltar */}
        <div className="text-center mt-8">
          <Link
            to="/"
            className="inline-flex items-center px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition-colors"
          >
            ← {t("tuktukTracking.backToMain")}
          </Link>
        </div>
      </main>
    </div>
  );
};

export default PassengerView;
