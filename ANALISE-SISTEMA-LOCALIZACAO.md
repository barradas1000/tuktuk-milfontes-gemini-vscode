🎯 Objetivo Geral
Desenvolver um componente moderno, funcional e amigável de localização em tempo real para um site/app, onde:

O usuário pode ver a sua posição no mapa

Ver os tuktuks ativos no momento

Ver distância e tempo estimado de chegada

E se não houver tuktuks disponíveis, mostrar mensagem amigável com sugestão para reservar para mais tarde.

🗺️ Funcionalidade a Desenvolver
Nome do módulo: PassengerTrackingMap

Descrição resumida:
Um mapa interativo com geolocalização que exibe a posição atual do usuário e os tuktuks disponíveis em tempo real. Fornece feedback visual e interativo sobre distância e tempo estimado de chegada.

📌 Requisitos Funcionais
1. Geolocalização do Usuário
Detecção automática da localização do usuário.

Se o navegador bloquear, exibir botão para solicitar manualmente.

Mensagens claras em caso de erro ou permissão negada.

Mostrar ícone azul com marcador personalizado.

2. Botão “Localiza-me”
Botão flutuante (draggable no mobile) que reposiciona o mapa para o local atual do usuário.

Ícone visual intuitivo (ex: ícone de alvo ou localização).

3. Tuktuks Ativos
Exibir todos os tuktuks ativos (com posição em tempo real) no mapa.

Mostrar marcadores diferenciados com ícones personalizados.

Se nenhum tuktuk ativo, mostrar:

“Neste momento nenhum tuktuk disponível, faça uma reserva para outra hora.”

4. Distância e Tempo Estimado
Para cada tuktuk ativo, calcular:

Distância até o usuário (fórmula Haversine).

Tempo estimado de chegada com base em velocidade média de 20 km/h.

Exibir essa informação em tooltip, popup ou pequena etiqueta sobre o marcador.

5. Auto-center inteligente
Se houver tuktuks ativos, auto-ajustar o mapa para mostrar usuário + tuktuks ativos.

Se não houver tuktuks, focar apenas no usuário.

6. Desempenho
Atualizações em tempo real via WebSocket (ex: Supabase Realtime).

Usar debounce e memoização onde aplicável para evitar re-renders.

Suporte a fallbacks de precisão e cache local da última posição.

📱 Requisitos de UX/UI
Design moderno e responsivo, especialmente adaptado para mobile.

Cores suaves e profissionais (compatíveis com terapeuta espiritual de 60 anos).

Ícones SVG amigáveis e de fácil compreensão.

Mensagens claras e em tom acolhedor.

Botões acessíveis com feedback visual (hover/click).

🧪 Estados de Interface
✔️ Quando tudo está OK:
Mapa mostra usuário + tuktuks ativos

Marcadores bem posicionados

Distância e tempo aparecem corretamente

⚠️ Quando sem permissão de localização:
Exibir botão: "Permitir Localização"

Mostrar instruções para desbloquear

❌ Quando sem tuktuks disponíveis:
Mostrar apenas o usuário no mapa

Exibir mensagem:

“Neste momento nenhum tuktuk disponível, faça uma reserva para outra hora.”

💡 Tecnologias Recomendadas
Leaflet.js (biblioteca de mapas)

React + Vite + TailwindCSS (stack da aplicação)

Supabase Realtime (para localização dos tuktuks)

Custom Hook useGeolocation (já existente)

Hook useConductors (para dados dos condutores ativos)

🧩 Arquitetura Modular Sugerida
PassengerTrackingMap.tsx → componente principal

UserLocationMarker.tsx → marcador do cliente

ConductorMarkers.tsx → marcadores de tuktuk ativos

LocationPermissionButton.tsx → botão solicitar localização

EmptyStateMessage.tsx → componente da mensagem "sem tuktuks"

useGeolocation.ts → hook para geolocalização do cliente

useConductors.ts → hook para dados em tempo real dos tuktuks

✅ Critérios de Aceitação
 Localização do usuário detectada e exibida corretamente

 Tuktuks ativos visíveis em tempo real

 Mensagem exibida corretamente quando sem tuktuks

 Tempo e distância estimados calculados com precisão

 Mapa responsivo e funcional em mobile e desktop

 Boa performance e ausência de erros