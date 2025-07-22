/**
 * Utilitário para monitoramento de performance no browser
 * Adiciona métricas de Web Vitals e carregamento de chunks
 */

// Interfaces para tipos de performance
interface LayoutShiftEntry extends PerformanceEntry {
  value: number;
  hadRecentInput: boolean;
}

interface LargestContentfulPaintEntry extends PerformanceEntry {
  renderTime: number;
  loadTime: number;
}

interface FirstInputEntry extends PerformanceEntry {
  processingStart: number;
}

interface PerformanceResourceTiming extends PerformanceEntry {
  transferSize: number;
  responseEnd: number;
}

// Estender Navigator para propriedades experimentais
declare global {
  interface Navigator {
    deviceMemory?: number;
    connection?: {
      effectiveType?: string;
    };
  }
}

// Função para medir Web Vitals
export const measureWebVitals = () => {
  if (typeof window !== "undefined" && "performance" in window) {
    // Medir First Contentful Paint (FCP)
    const paintEntries = performance.getEntriesByType("paint");
    const fcp = paintEntries.find(
      (entry) => entry.name === "first-contentful-paint"
    );

    if (fcp) {
      console.log(`🎨 First Contentful Paint: ${Math.round(fcp.startTime)}ms`);
    }

    // Medir Largest Contentful Paint (LCP)
    const observer = new PerformanceObserver((list) => {
      const entries = list.getEntries() as LargestContentfulPaintEntry[];
      const lastEntry = entries[entries.length - 1];
      console.log(
        `🖼️ Largest Contentful Paint: ${Math.round(lastEntry.startTime)}ms`
      );
    });

    try {
      observer.observe({ entryTypes: ["largest-contentful-paint"] });
    } catch (e) {
      console.log("LCP não suportado neste browser");
    }

    // Medir Cumulative Layout Shift (CLS)
    let clsValue = 0;
    const clsObserver = new PerformanceObserver((list) => {
      for (const entry of list.getEntries() as LayoutShiftEntry[]) {
        if (!entry.hadRecentInput) {
          clsValue += entry.value;
        }
      }
      console.log(`📐 Cumulative Layout Shift: ${clsValue.toFixed(4)}`);
    });

    try {
      clsObserver.observe({ entryTypes: ["layout-shift"] });
    } catch (e) {
      console.log("CLS não suportado neste browser");
    }

    // Medir First Input Delay (FID)
    const fidObserver = new PerformanceObserver((list) => {
      for (const entry of list.getEntries() as FirstInputEntry[]) {
        console.log(
          `⚡ First Input Delay: ${Math.round(
            entry.processingStart - entry.startTime
          )}ms`
        );
      }
    });

    try {
      fidObserver.observe({ entryTypes: ["first-input"] });
    } catch (e) {
      console.log("FID não suportado neste browser");
    }
  }
};

// Função para monitorar carregamento de chunks
export const trackChunkLoading = () => {
  if (typeof window !== "undefined" && "performance" in window) {
    const resourceObserver = new PerformanceObserver((list) => {
      const entries = list.getEntries() as PerformanceResourceTiming[];
      entries.forEach((entry) => {
        if (entry.name.includes(".js") && entry.name.includes("chunk-")) {
          const chunkName = entry.name.split("/").pop();
          const loadTime = Math.round(entry.responseEnd - entry.startTime);
          const size = entry.transferSize
            ? Math.round(entry.transferSize / 1024)
            : "N/A";

          console.log(
            `📦 Chunk carregado: ${chunkName} - ${loadTime}ms (${size}KB)`
          );
        }
      });
    });

    try {
      resourceObserver.observe({ entryTypes: ["resource"] });
    } catch (e) {
      console.log("Resource timing não suportado neste browser");
    }
  }
};

// Função para análise de bundle em runtime
export const analyzeBundleRuntime = () => {
  if (typeof window !== "undefined") {
    console.log("🚀 ANÁLISE DE PERFORMANCE EM RUNTIME");
    console.log("=====================================");

    // Informações do navegador
    console.log(`🌐 User Agent: ${navigator.userAgent}`);
    console.log(`💾 Memória disponível: ${navigator.deviceMemory || "N/A"}GB`);
    console.log(`🔌 Conexão: ${navigator.connection?.effectiveType || "N/A"}`);

    // Informações de performance
    if (performance.timing) {
      const timing = performance.timing;
      const domContentLoaded =
        timing.domContentLoadedEventEnd - timing.navigationStart;
      const fullyLoaded = timing.loadEventEnd - timing.navigationStart;

      console.log(`⚡ DOM Content Loaded: ${domContentLoaded}ms`);
      console.log(`🏁 Página totalmente carregada: ${fullyLoaded}ms`);
    }

    // Recursos carregados
    const resources = performance.getEntriesByType(
      "resource"
    ) as PerformanceResourceTiming[];
    const jsResources = resources.filter((r) => r.name.includes(".js"));
    const cssResources = resources.filter((r) => r.name.includes(".css"));

    console.log(`📄 Arquivos JS carregados: ${jsResources.length}`);
    console.log(`🎨 Arquivos CSS carregados: ${cssResources.length}`);

    const totalJsSize = jsResources.reduce(
      (acc, r) => acc + (r.transferSize || 0),
      0
    );
    const totalCssSize = cssResources.reduce(
      (acc, r) => acc + (r.transferSize || 0),
      0
    );

    console.log(`📊 Tamanho total JS: ${Math.round(totalJsSize / 1024)}KB`);
    console.log(`📊 Tamanho total CSS: ${Math.round(totalCssSize / 1024)}KB`);

    console.log("=====================================");
  }
};

// Hook personalizado para React
export const usePerformanceMonitoring = () => {
  const startMonitoring = () => {
    console.log("🔍 Iniciando monitoramento de performance...");
    measureWebVitals();
    trackChunkLoading();
    analyzeBundleRuntime();
  };

  return { startMonitoring };
};
