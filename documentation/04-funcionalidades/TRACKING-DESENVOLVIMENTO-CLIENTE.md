# TRACKING-DESENVOLVIMENTO-CLIENTE

## Estado Atual da Funcionalidade: Mapa de Rastreamento para Cliente

### Objetivo

- O cliente acessa a página `/tracking` e vê sempre o mapa da cidade, sua própria localização (se permitido) e os TukTuks ativos.
- Se não houver condutores ativos, o mapa é exibido normalmente, mas uma mensagem amigável aparece: “Tuktuk offline neste momento!”


## Plano de Ação para Funcionalidade Completa

### O que já está criado

- O hook `useActiveConductors` já filtra condutores ativos com localização válida.
- O componente `PassengerMap.tsx` já renderiza o mapa, marcadores dos condutores e mensagem amigável se não houver condutores.
- O mapa nunca fica em branco, sempre é renderizado.
- O botão de permissão de localização está presente na interface.
- Não há dependência de perfil de admin ou condutor para renderização.
- Página `/tracking` utiliza o `PassengerMap`.

### O que falta implementar

1. **Obtenção da localização do usuário:**
   - Implementar um hook ou efeito (`useUserGeolocation`) que chama a API de geolocalização do browser (`navigator.geolocation.getCurrentPosition`) e atualiza o estado `userPosition` ao clicar no botão de permissão.
   - Tratar erros de permissão e mostrar feedback amigável.
2. **Integração do botão de permissão:**
   - Garantir que o botão "localizar-me" realmente dispara a função de obtenção da localização.
3. **Testar fluxo completo:**
   - Verificar se o marcador do usuário aparece corretamente após conceder permissão.
   - Garantir que o mapa nunca some, mesmo sem condutores ou sem permissão.
4. **Atualizar documentação:**
   - A localização do usuário **só será exibida após o cliente clicar no botão "Localizar-me" e conceder permissão de localização no navegador**.
   - O botão de permissão dispara a função do hook `useGeolocation`, que trata loading, permissão e erros de forma amigável.
   - O marcador do usuário só aparece após a permissão ser concedida e a localização obtida.
   - Caso a permissão seja negada ou ocorra erro, uma mensagem amigável é exibida acima do mapa, mas o mapa nunca some.
   - O hook `useGeolocation` é modular e pode ser reutilizado em outros fluxos, mantendo o código desacoplado e fácil de manter.

---

### Componentes e Hooks Envolvidos

#### 1. `useActiveConductors.ts`

- Hook customizado que consulta o Supabase para buscar condutores com `is_active = true` e localização válida (`latitude` e `longitude` preenchidos).
- Retorna apenas condutores que estão realmente ativos e com dados de localização completos.

#### 2. `PassengerMap.tsx`

- Componente principal do mapa.
- Sempre renderiza o mapa (`MapContainer` do Leaflet), independentemente do número de condutores ativos.
- Exibe marcadores para cada condutor ativo (usando dados do hook).
- Exibe o marcador da localização do usuário, se permitido e se a localização for obtida via browser.
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
- A localização do usuário é mostrada **apenas se o cliente clicar no botão de permissão e conceder acesso à localização**. Caso contrário, o marcador do usuário não aparece.


### Tratamento de Erros e Estados

- O mapa nunca fica em branco: sempre é renderizado, mesmo sem condutores.
- Mensagem amigável para ausência de TukTuks.
- Erros de permissão de localização devem ser tratados pelo botão de permissão e pelo hook/efeito de geolocalização, mostrando feedback amigável ao usuário.
- Não há dependência de perfil de admin ou condutor para renderização.


### Arquitetura

- Modular, seguindo o padrão descrito em `ANALISE-SISTEMA-LOCALIZACAO.md`.
- Componentes desacoplados e reutilizáveis.
- Uso de React Query para cache e atualização dos dados dos condutores.

---

Se precisar restaurar esta configuração, basta garantir:

  - O hook `useActiveConductors` filtra corretamente os condutores ativos e com localização válida.
  - O componente `PassengerMap` sempre renderiza o mapa e, se o usuário conceder permissão, mostra sua localização.
  - O botão de permissão de localização dispara a obtenção da localização do usuário.
  - A página `/tracking` utiliza apenas componentes voltados para o cliente, sem dependências de admin.
  - O novo hook/efeito de geolocalização deve ser documentado e mantido desacoplado para fácil manutenção.
