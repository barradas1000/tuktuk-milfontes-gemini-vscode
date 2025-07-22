import React from "react";
import { Button } from "@/components/ui/button";
import { Trash2, RefreshCw } from "lucide-react";
import { toast } from "sonner";
import { useQueryClient } from "@tanstack/react-query";

/**
 * Componente de ajuda para limpar cache durante desenvolvimento
 * Deve ser usado apenas em páginas administrativas e em ambiente de desenvolvimento
 */
export const DevCacheHelper: React.FC = () => {
  const queryClient = useQueryClient();
  const isDev = process.env.NODE_ENV === "development";

  // Se não for ambiente de desenvolvimento, não renderiza nada
  if (!isDev) {
    return null;
  }

  const clearAllCache = async () => {
    try {
      // 1. Limpar React Query cache
      queryClient.clear();

      // 2. Limpar localStorage
      localStorage.clear();

      // 3. Limpar sessionStorage
      sessionStorage.clear();

      // 4. Limpar cache do browser (service workers, etc)
      if ("caches" in window) {
        const names = await caches.keys();
        await Promise.all(names.map((name) => caches.delete(name)));
      }

      // 5. Invalidar todas as queries
      await queryClient.invalidateQueries();

      toast.success("🧹 Cache limpo com sucesso!");

      // Se estiver na página de login, recarregar para garantir estado limpo
      if (window.location.pathname.includes("/login")) {
        setTimeout(() => window.location.reload(), 1000);
      }
    } catch (error) {
      console.error("Erro ao limpar cache:", error);
      toast.error("Erro ao limpar cache");
    }
  };

  const refreshData = async () => {
    try {
      // Invalidar todas as queries para forçar refresh dos dados
      await queryClient.invalidateQueries();
      toast.success("🔄 Dados atualizados!");
    } catch (error) {
      console.error("Erro ao atualizar dados:", error);
      toast.error("Erro ao atualizar dados");
    }
  };

  return (
    <div className="fixed bottom-4 right-4 flex flex-col gap-2 z-50">
      <Button
        size="sm"
        variant="destructive"
        className="flex items-center gap-2"
        onClick={clearAllCache}
      >
        <Trash2 className="h-4 w-4" />
        Limpar Cache
      </Button>

      <Button
        size="sm"
        variant="outline"
        className="flex items-center gap-2 bg-white"
        onClick={refreshData}
      >
        <RefreshCw className="h-4 w-4" />
        Atualizar Dados
      </Button>
    </div>
  );
};

export default DevCacheHelper;
