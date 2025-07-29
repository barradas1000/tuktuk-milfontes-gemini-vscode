// Service Worker para cache avançado da aplicação TukTuk
const CACHE_NAME = "tuktuk-milfontes-v1.0";
const STATIC_CACHE = "tuktuk-static-v1.0";
const DYNAMIC_CACHE = "tuktuk-dynamic-v1.0";

// Recursos para cache estático (sempre em cache)
const STATIC_ASSETS = [
  "/",
  "/android-chrome-192x192.png",
  "/android-chrome-512x512.png",
  "/apple-touch-icon.png",
  "/favicon.ico",
  "/placeholder.svg",
];

// Recursos para cache dinâmico (cachear conforme uso)
const DYNAMIC_ASSETS = ["/tracking", "/login", "/instrucoes"];

// Recursos que devem sempre vir da rede (não cachear)
const NETWORK_ONLY = ["/api/", "/supabase/", "supabase.co"];

// Instalar Service Worker
self.addEventListener("install", (event) => {
  console.log("🔧 Service Worker instalando...");

  event.waitUntil(
    Promise.all([
      // Cache estático
      caches.open(STATIC_CACHE).then((cache) => {
        console.log("📦 Cacheando recursos estáticos...");
        return cache.addAll(STATIC_ASSETS);
      }),

      // Pular espera para ativar imediatamente
      self.skipWaiting(),
    ])
  );
});

// Ativar Service Worker
self.addEventListener("activate", (event) => {
  console.log("✅ Service Worker ativado!");

  event.waitUntil(
    Promise.all([
      // Limpar caches antigos
      caches.keys().then((cacheNames) => {
        return Promise.all(
          cacheNames.map((cacheName) => {
            if (
              cacheName !== STATIC_CACHE &&
              cacheName !== DYNAMIC_CACHE &&
              cacheName !== CACHE_NAME
            ) {
              console.log("🗑️ Removendo cache antigo:", cacheName);
              return caches.delete(cacheName);
            }
          })
        );
      }),

      // Assumir controle de todas as páginas
      self.clients.claim(),
    ])
  );
});

// Interceptar requests
self.addEventListener("fetch", (event) => {
  const request = event.request;
  const url = new URL(request.url);

  // Apenas interceptar requests GET
  if (request.method !== "GET") {
    return;
  }

  // Aplicar cacheFirstStrategy apenas para tiles do OpenStreetMap
  if (url.hostname.includes('tile.openstreetmap.org')) {
    event.respondWith(cacheFirstStrategy(request));
    return;
  }

  // Recursos que devem sempre vir da rede
  if (NETWORK_ONLY.some((pattern) => url.href.includes(pattern))) {
    event.respondWith(fetch(request));
    return;
  }

  // Estratégia de cache baseada no tipo de recurso
  if (request.destination === "document") {
    // HTML: Network First com fallback para cache
    event.respondWith(networkFirstStrategy(request));
  } else if (
    request.destination === "script" ||
    request.destination === "style"
  ) {
    // JS/CSS: Cache First com fallback para network
    event.respondWith(cacheFirstStrategy(request));
  } else if (request.destination === "image") {
    // Imagens: Cache First
    event.respondWith(cacheFirstStrategy(request));
  } else {
    // Outros recursos: Stale While Revalidate
    event.respondWith(staleWhileRevalidateStrategy(request));
  }
});

// Estratégia Network First (para HTML)
async function networkFirstStrategy(request) {
  try {
    // Tentar buscar da rede primeiro
    const networkResponse = await fetch(request);

    if (networkResponse.ok) {
      // Cachear resposta se for bem-sucedida
      const cache = await caches.open(DYNAMIC_CACHE);
      cache.put(request, networkResponse.clone());
      return networkResponse;
    }

    throw new Error("Network response not ok");
  } catch (error) {
    console.log("🌐 Network falhou, buscando do cache:", request.url);

    // Buscar do cache se rede falhar
    const cachedResponse = await caches.match(request);
    if (cachedResponse) {
      return cachedResponse;
    }

    // Fallback para página offline se existir
    if (request.destination === "document") {
      const offlinePage = await caches.match("/offline.html");
      if (offlinePage) {
        return offlinePage;
      }
    }

    throw error;
  }
}

// Estratégia Cache First (para JS/CSS/Imagens)
async function cacheFirstStrategy(request) {
  // Buscar do cache primeiro
  const cachedResponse = await caches.match(request);
  if (cachedResponse) {
    return cachedResponse;
  }

  try {
    // Se não estiver em cache, buscar da rede
    const networkResponse = await fetch(request);

    if (networkResponse.ok) {
      // Determinar cache apropriado
      const cacheName =
        request.destination === "script" || request.destination === "style"
          ? STATIC_CACHE
          : DYNAMIC_CACHE;

      const cache = await caches.open(cacheName);
      cache.put(request, networkResponse.clone());
      return networkResponse;
    }

    throw new Error("Network response not ok");
  } catch (error) {
    console.log("❌ Falha ao buscar recurso:", request.url);
    throw error;
  }
}

// Estratégia Stale While Revalidate
async function staleWhileRevalidateStrategy(request) {
  const cache = await caches.open(DYNAMIC_CACHE);
  const cachedResponse = await cache.match(request);

  // Buscar da rede em background
  const fetchPromise = fetch(request)
    .then((networkResponse) => {
      if (networkResponse.ok) {
        cache.put(request, networkResponse.clone());
      }
      return networkResponse;
    })
    .catch(() => {
      // Ignorar erros de rede silenciosamente
    });

  // Retornar cache imediatamente se disponível, senão esperar rede
  return cachedResponse || fetchPromise;
}

// Listener para mensagens do cliente
self.addEventListener("message", (event) => {
  if (event.data && event.data.type === "GET_CACHE_STATUS") {
    // Enviar status do cache para o cliente
    getCacheStatus().then((status) => {
      event.ports[0].postMessage(status);
    });
  }

  if (event.data && event.data.type === "CLEAR_CACHE") {
    // Limpar cache quando solicitado
    clearAllCaches().then(() => {
      event.ports[0].postMessage({ success: true });
    });
  }
});

// Obter status do cache
async function getCacheStatus() {
  const cacheNames = await caches.keys();
  const status = {};

  for (const cacheName of cacheNames) {
    const cache = await caches.open(cacheName);
    const keys = await cache.keys();
    status[cacheName] = {
      count: keys.length,
      urls: keys.map((req) => req.url),
    };
  }

  return status;
}

// Limpar todos os caches
async function clearAllCaches() {
  const cacheNames = await caches.keys();
  await Promise.all(cacheNames.map((cacheName) => caches.delete(cacheName)));
  console.log("🗑️ Todos os caches foram limpos");
}
