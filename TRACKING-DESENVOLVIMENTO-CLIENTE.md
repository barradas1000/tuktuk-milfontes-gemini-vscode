# TRACKING-DESENVOLVIMENTO-CLIENTE

## Estado Atual da Funcionalidade: Mapa de Rastreamento para Cliente

### Objetivo

- O cliente acessa a página `/tracking` e vê sempre o mapa da cidade, sua própria localização (se permitido) e os TukTuks ativos.
- Se não houver condutores ativos, o mapa é exibido normalmente, mas uma mensagem amigável aparece: “Tuktuk offline neste momento!”

### Componentes e Hooks Envolvidos

#### 1. `useActiveConductors.ts`

- Hook customizado que consulta o Supabase para buscar condutores com `is_active = true` e localização válida (`latitude` e `longitude` preenchidos).
- Retorna apenas condutores que estão realmente ativos e com dados de localização completos.

#### 2. `PassengerMap.tsx`

- Componente principal do mapa.
- Sempre renderiza o mapa (`MapContainer` do Leaflet), independentemente do número de condutores ativos.
- Exibe marcadores para cada condutor ativo (usando dados do hook).
- Exibe o marcador da localização do usuário, se permitido.
- Se não houver condutores ativos, mostra uma mensagem amigável sobre o mapa, sem ocultar o mapa.
- Botão para pedir permissão de localização e botão para recentralizar o mapa.
- Não depende de perfil de admin ou condutor.

#### 3. `Tracking.tsx`

- Página que utiliza o `PassengerMap` e o botão de permissão de localização.
- Foco total na experiência do cliente.

### Fluxo de Dados

- O hook `useActiveConductors` faz a consulta ao Supabase e retorna os condutores ativos.
- O componente `PassengerMap` consome esses dados e renderiza os marcadores.
- Se a lista de condutores ativos estiver vazia, apenas a mensagem “Tuktuk offline neste momento!” aparece sobre o mapa.
- A localização do usuário é sempre mostrada se disponível.

### Tratamento de Erros e Estados

- O mapa nunca fica em branco: sempre é renderizado, mesmo sem condutores.
- Mensagem amigável para ausência de TukTuks.
- Erros de permissão de localização são tratados pelo botão de permissão.
- Não há dependência de perfil de admin ou condutor para renderização.

### Arquitetura

- Modular, seguindo o padrão descrito em `ANALISE-SISTEMA-LOCALIZACAO.md`.
- Componentes desacoplados e reutilizáveis.
- Uso de React Query para cache e atualização dos dados dos condutores.

---

Se precisar restaurar esta configuração, basta garantir:

- O hook `useActiveConductors` filtra corretamente os condutores ativos e com localização válida.
- O componente `PassengerMap` sempre renderiza o mapa e a localização do usuário, mostrando a mensagem amigável se não houver condutores.
- A página `/tracking` utiliza apenas componentes voltados para o cliente, sem dependências de admin.
