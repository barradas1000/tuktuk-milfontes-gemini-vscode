import { defineConfig } from "vite";
import react from "@vitejs/plugin-react-swc";
import path from "path";

// https://vitejs.dev/config/
export default defineConfig(({ mode }) => ({
  server: {
    host: "::",
    port: 8080,
  },
  plugins: [react()].filter(Boolean),
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
  base: "/",
  build: {
    // Aumentar o limite de aviso para chunks (opcional)
    chunkSizeWarningLimit: 800,
    rollupOptions: {
      output: {
        // Estratégia de chunking manual para otimizar carregamento
        manualChunks: {
          // Vendor chunk para bibliotecas principais
          vendor: ["react", "react-dom", "react-router-dom"],

          // Query and state management
          query: ["@tanstack/react-query"],

          // UI Libraries chunk (Radix UI)
          radix: [
            "@radix-ui/react-alert-dialog",
            "@radix-ui/react-dialog",
            "@radix-ui/react-dropdown-menu",
            "@radix-ui/react-label",
            "@radix-ui/react-select",
            "@radix-ui/react-switch",
            "@radix-ui/react-tabs",
            "@radix-ui/react-toast",
            "@radix-ui/react-tooltip",
            "@radix-ui/react-accordion",
            "@radix-ui/react-avatar",
            "@radix-ui/react-checkbox",
            "@radix-ui/react-popover",
            "@radix-ui/react-progress",
            "@radix-ui/react-slider",
          ],

          // Animation
          animation: ["framer-motion"],

          // Maps & Location chunk
          maps: ["leaflet", "react-leaflet"],

          // Supabase & Auth chunk
          supabase: ["@supabase/supabase-js", "@supabase/auth-helpers-react"],

          // Icons chunk
          icons: ["lucide-react"],

          // Utilities chunk
          utils: ["clsx", "class-variance-authority", "tailwind-merge"],

          // i18n chunk
          i18n: [
            "react-i18next",
            "i18next",
            "i18next-browser-languagedetector",
          ],
        },

        // Naming strategy for chunks
        chunkFileNames: (chunkInfo) => {
          const facadeModuleId = chunkInfo.facadeModuleId
            ? chunkInfo.facadeModuleId
                .split("/")
                .pop()
                ?.replace(/\.[^/.]+$/, "")
            : "chunk";

          return `assets/${facadeModuleId}-[hash].js`;
        },
      },
    },

    // Otimizações adicionais
    minify: "esbuild",
    target: "es2015",

    // Source maps apenas em desenvolvimento
    sourcemap: mode === "development",
  },
}));
