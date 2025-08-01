import { DndProvider } from 'react-dnd';
import { HTML5Backend } from 'react-dnd-html5-backend';
import { Suspense, lazy, useEffect } from "react";
import { Routes, Route } from "react-router-dom";
import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { usePerformanceMonitoring } from "@/utils/performanceMonitor";
import { registerServiceWorker } from "@/utils/serviceWorkerManager";
import "./App.css"; // Importação do CSS do App

// Lazy loading para todas as páginas
const Index = lazy(() => import("./pages/Index"));
const Admin = lazy(() => import("./pages/Admin"));
const Auth = lazy(() => import("./pages/Auth"));
const NotFound = lazy(() => import("./pages/NotFound"));
const ResetPassword = lazy(() => import("./pages/ResetPassword"));
const Instrucoes = lazy(() => import("./pages/Instrucoes"));
const TermosCondicoes = lazy(() => import("./pages/TermosCondicoes"));
const PoliticaPrivacidade = lazy(() => import("./pages/PoliticaPrivacidade"));
const PoliticaCancelamento = lazy(() => import("./pages/PoliticaCancelamento"));
const PassengerView = lazy(() => import("./pages/PassengerView"));
const ConductorDashboard = lazy(() => import("./pages/ConductorDashboard"));
const AdminDashboard = lazy(() => import("./pages/AdminDashboard"));
const CandidaturaPublicaPage = lazy(
  () => import("./pages/CandidaturaPublicaPage")
);
const MapTest = lazy(() => import("./pages/MapTest"));
const ProtectedRoute = lazy(() => import("./components/ProtectedRoute"));

import "./i18n";

const queryClient = new QueryClient();

// Componente de fallback reutilizável
const LoadingFallback = ({
  message = "Carregando...",
}: {
  message?: string;
}) => (
  <div className="flex items-center justify-center min-h-screen">
    <div className="text-center py-8">
      <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary mx-auto mb-4"></div>
      {message}
    </div>
  </div>
);

// Componente principal da aplicação
const AppContent = () => {
  const { startMonitoring } = usePerformanceMonitoring();

  useEffect(() => {
    // Iniciar monitoramento de performance apenas em desenvolvimento
    if (import.meta.env.DEV) {
      startMonitoring();
    }

    // Registrar Service Worker em produção
    if (import.meta.env.PROD) {
      registerServiceWorker();
    }
  }, [startMonitoring]);

  return (
    <Routes>
      <Route
        path="/"
        element={
          <Suspense
            fallback={
              <LoadingFallback message="Carregando página inicial..." />
            }
          >
            <Index />
          </Suspense>
        }
      />
      <Route
        path="/admin"
        element={
          <Suspense
            fallback={
              <LoadingFallback message="Carregando painel administrativo..." />
            }
          >
            <Admin />
          </Suspense>
        }
      />
      <Route
        path="/instrucoes"
        element={
          <Suspense
            fallback={<LoadingFallback message="Carregando instruções..." />}
          >
            <Instrucoes />
          </Suspense>
        }
      />
      <Route
        path="/login"
        element={
          <Suspense
            fallback={
              <LoadingFallback message="Carregando página de login..." />
            }
          >
            <Auth />
          </Suspense>
        }
      />
      <Route
        path="/reset-password"
        element={
          <Suspense
            fallback={
              <LoadingFallback message="Carregando redefinição de senha..." />
            }
          >
            <ResetPassword />
          </Suspense>
        }
      />
      <Route
        path="/termos-condicoes"
        element={
          <Suspense
            fallback={
              <LoadingFallback message="Carregando termos e condições..." />
            }
          >
            <TermosCondicoes />
          </Suspense>
        }
      />
      <Route
        path="/PoliticaPrivacidade"
        element={
          <Suspense
            fallback={
              <LoadingFallback message="Carregando política de privacidade..." />
            }
          >
            <PoliticaPrivacidade />
          </Suspense>
        }
      />
      <Route
        path="/PoliticaCancelamento"
        element={
          <Suspense
            fallback={
              <LoadingFallback message="Carregando política de cancelamento..." />
            }
          >
            <PoliticaCancelamento />
          </Suspense>
        }
      />
      <Route
        path="/tracking"
        element={
          <Suspense
            fallback={
              <LoadingFallback message="Carregando mapa de tracking..." />
            }
          >
            <PassengerView />
          </Suspense>
        }
      />
      <Route
        path="/candidatura-condutor"
        element={
          <Suspense
            fallback={
              <LoadingFallback message="Carregando formulário de candidatura..." />
            }
          >
            <CandidaturaPublicaPage />
          </Suspense>
        }
      />
      <Route
        path="/map-test"
        element={
          <Suspense
            fallback={
              <LoadingFallback message="Carregando teste do mapa..." />
            }
          >
            <MapTest />
          </Suspense>
        }
      />
      <Route
        path="/condutor/dashboard/:conductorId?"
        element={
          <Suspense
            fallback={
              <LoadingFallback message="Carregando proteção de rota..." />
            }
          >
            <ProtectedRoute allowedRoles={["condutor", "admin"]}>
              <Suspense
                fallback={
                  <LoadingFallback message="Carregando painel do condutor..." />
                }
              >
                <ConductorDashboard />
              </Suspense>
            </ProtectedRoute>
          </Suspense>
        }
      />
      <Route
        path="/admin/dashboard"
        element={
          <Suspense
            fallback={
              <LoadingFallback message="Carregando proteção de rota..." />
            }
          >
            <ProtectedRoute allowedRoles={["admin"]}>
              <Suspense
                fallback={
                  <LoadingFallback message="Carregando painel do administrador..." />
                }
              >
                <AdminDashboard />
              </Suspense>
            </ProtectedRoute>
          </Suspense>
        }
      />
      <Route
        path="*"
        element={
          <Suspense fallback={<LoadingFallback />}>
            <NotFound />
          </Suspense>
        }
      />
    </Routes>
  );
};

const App = () => (
  <QueryClientProvider client={queryClient}>
    <TooltipProvider>
      <Toaster />
      <Sonner />
      <DndProvider backend={HTML5Backend}>
        <AppContent />
      </DndProvider>
    </TooltipProvider>
  </QueryClientProvider>
);

export default App;