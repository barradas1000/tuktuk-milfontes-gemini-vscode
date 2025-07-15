import React from "react";
import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import PassengerMap from "../components/PassengerMap";
import LanguageSelector from "@/components/LanguageSelector";
import { DndProvider, useDrag, useDrop } from "react-dnd";
import { HTML5Backend } from "react-dnd-html5-backend";

const DraggableCard: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const [{ isDragging }, drag] = useDrag(() => ({
    type: "CARD",
    collect: (monitor) => ({
      isDragging: !!monitor.isDragging(),
    }),
  }));

  return (
    <div
      ref={drag}
      style={{
        opacity: isDragging ? 0.5 : 1,
        cursor: "move",
      }}
    >
      {children}
    </div>
  );
};

const PassengerView: React.FC = () => {
  const { t } = useTranslation();
  return (
    <div className="min-h-screen bg-gray-50">
      {/* Language Selector */}
      <LanguageSelector />

      {/* Header */}
      <div className="bg-white shadow-sm border-b">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="py-6">
            <h1 className="text-3xl font-bold text-gray-900 text-center">
              {t("tuktukTracking.pageTitle")}
            </h1>
            <p className="text-center text-gray-600 mt-2">
              {t("tuktukTracking.pageDescription")}
            </p>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <DndProvider backend={HTML5Backend}>
          <DraggableCard>
            <Card>
              <CardHeader>
                <CardTitle className="flex items-center gap-2">
                  {t("tuktukTracking.currentLocation")}
                </CardTitle>
              </CardHeader>
              <CardContent>
                <PassengerMap />
              </CardContent>
            </Card>
          </DraggableCard>
        </DndProvider>

        {/* Informações */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mt-8">
          <Card>
            <CardHeader>
              <CardTitle className="text-lg">{t("tuktukTracking.howItWorks")}</CardTitle>
            </CardHeader>
            <CardContent className="space-y-3 text-sm text-gray-600">
              <div>• {t("tuktukTracking.howItWorksItems.blueDot")}</div>
              <div>• {t("tuktukTracking.howItWorksItems.autoUpdate")}</div>
              <div>• {t("tuktukTracking.howItWorksItems.offline")}</div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="text-lg">{t("tuktukTracking.locationSetup.title")}</CardTitle>
            </CardHeader>
            <CardContent className="space-y-3 text-sm text-gray-600">
              <div className="font-medium">{t("tuktukTracking.locationSetup.chrome.title")}</div>
              <div>1. {t("tuktukTracking.locationSetup.chrome.steps.0")}</div>
              <div>2. {t("tuktukTracking.locationSetup.chrome.steps.1")}</div>
              <div>3. {t("tuktukTracking.locationSetup.chrome.steps.2")}</div>
              <div>4. {t("tuktukTracking.locationSetup.chrome.steps.3")}</div>
              <div>5. {t("tuktukTracking.locationSetup.chrome.steps.4")}</div>
              <div>6. {t("tuktukTracking.locationSetup.chrome.steps.5")}</div>
              <div>7. {t("tuktukTracking.locationSetup.chrome.steps.6")}</div>

              <div className="font-medium mt-3">{t("tuktukTracking.locationSetup.samsung.title")}</div>
              <div>1. {t("tuktukTracking.locationSetup.samsung.steps.0")}</div>
              <div>2. {t("tuktukTracking.locationSetup.samsung.steps.1")}</div>
              <div>3. {t("tuktukTracking.locationSetup.samsung.steps.2")}</div>
              <div>4. {t("tuktukTracking.locationSetup.samsung.steps.3")}</div>
              <div>5. {t("tuktukTracking.locationSetup.samsung.steps.4")}</div>

              <div className="font-medium mt-3">{t("tuktukTracking.locationSetup.firefox.title")}</div>
              <div>1. {t("tuktukTracking.locationSetup.firefox.steps.0")}</div>
              <div>2. {t("tuktukTracking.locationSetup.firefox.steps.1")}</div>
              <div>3. {t("tuktukTracking.locationSetup.firefox.steps.2")}</div>
              <div>4. {t("tuktukTracking.locationSetup.firefox.steps.3")}</div>

              <div className="font-medium mt-3">{t("tuktukTracking.locationSetup.alternative.title")}</div>
              <div className="mb-2 text-xs italic">{t("tuktukTracking.locationSetup.alternative.description")}</div>
              <div>1. {t("tuktukTracking.locationSetup.alternative.steps.0")}</div>
              <div>2. {t("tuktukTracking.locationSetup.alternative.steps.1")}</div>
              <div>3. {t("tuktukTracking.locationSetup.alternative.steps.2")}</div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <CardTitle className="text-lg">{t("tuktukTracking.contact")}</CardTitle>
            </CardHeader>
            <CardContent className="space-y-3 text-sm text-gray-600">
              <div>• {t("tuktukTracking.contactItems.phone")}</div>
              <div>• {t("tuktukTracking.contactItems.whatsapp")}</div>
              <div>• {t("tuktukTracking.contactItems.email")}</div>
            </CardContent>
          </Card>
        </div>

        {/* Link para reserva */}
        <div className="text-center mt-8">
          <a
            href="/"
            className="inline-flex items-center px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition-colors"
          >
            ← {t("tuktukTracking.backToMain")}
          </a>
        </div>
      </div>
    </div>
  );
};

export default PassengerView;
