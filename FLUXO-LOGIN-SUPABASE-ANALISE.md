# Análise de Problemas de Carregamento e Conexão Supabase

## 1. Problemas de Carregamento após Login/Refresh

### Sintomas

- Após login, ao dar refresh (F5) a página pode ficar presa em "Carregando..." ou não carregar o perfil.
- O utilizador pode ser redirecionado para login mesmo estando autenticado.
- O mapa ou dashboards não carregam dados.

### Causas Possíveis

- **Falta de registo na tabela `profiles`** para o utilizador autenticado.
- **Erro na query ao Supabase** (problemas de rede, CORS, endpoint, permissões, etc).
- **Sessão não restaurada corretamente** após refresh (problemas de persistência local ou cookies).
- **Campo `role` ou `conductor_id` ausente ou incorreto** no perfil.
- **Problemas de sincronização entre Auth e Profile** (ex: utilizador autenticado mas sem perfil válido).
- **Erros silenciosos no bloco try/catch** do contexto de autenticação.

### Soluções e Boas Práticas

- Garantir que todos os utilizadores têm registo válido em `profiles` ao criar conta.
- Validar e sincronizar o campo `role` sempre que o utilizador faz login.
- Garantir que todos os condutores têm `conductor_id` válido.
- Adicionar logs detalhados no contexto de autenticação para depuração.
- Mostrar mensagens de erro claras ao utilizador quando o perfil não é encontrado.
- Testar o fluxo completo de login/logout/refresh em localhost e produção.
- Verificar e garantir que as variáveis de ambiente `.env` estão corretas e disponíveis no frontend.

---

## 2. Análise dos Códigos de Conexão com Supabase

### a) Instanciação do Cliente Supabase

- **Ficheiro:** `src/lib/supabase.ts`
- **Função:** Cria e exporta o cliente Supabase usando as variáveis de ambiente `VITE_SUPABASE_URL` e `VITE_SUPABASE_ANON_KEY`.
- **Ponto Crítico:** Se as variáveis não estiverem definidas, o cliente não conecta e todas as queries falham.

### b) Contexto de Autenticação

- **Ficheiro:** `src/hooks/AuthContext.tsx`
- **Função:**
  - Recupera sessão com `supabase.auth.getSession()` ao iniciar.
  - Escuta mudanças de autenticação com `supabase.auth.onAuthStateChange`.
  - Busca o perfil do utilizador na tabela `profiles` usando o id do utilizador autenticado.
  - Mantém estados: `user`, `session`, `profile`, `loading`, `isAdmin`.
- **Ponto Crítico:**
  - Se a query ao Supabase falhar ou não houver perfil, o loading pode ficar preso e o utilizador não navega.
  - Se o perfil não existir, o utilizador não tem acesso ao dashboard.

### c) Fluxo de Login/Logout

- **Ficheiro:** `src/pages/Auth.tsx`, `src/pages/Admin.tsx`, `src/pages/ConductorDashboard.tsx`
- **Função:**
  - O utilizador faz login, o contexto autentica e carrega o perfil.
  - O logout limpa o contexto e redireciona para login.
- **Ponto Crítico:**
  - O botão de logout deve garantir que o contexto é limpo e o utilizador redirecionado.

---

## 3. Recomendações para Estabilidade

- **Criação automática de perfil:** Após signup, criar sempre um registo em `profiles` com o id do utilizador.
- **Sincronização de roles:** Validar e atualizar o campo `role` no perfil sempre que o utilizador faz login.
- **Tratamento de erros:** Adicionar logs e mensagens de erro visíveis para debugging.
- **Fallbacks e mensagens claras:** Se não houver perfil, mostrar mensagem e botão para login.
- **Testes em localhost e produção:** Garantir que o fluxo funciona em ambos ambientes, com variáveis de ambiente e rewrites corretos.
- **Verificar permissões e CORS no Supabase:** O domínio do frontend deve estar autorizado.

---

## 4. Resumo dos Ficheiros Críticos

- `src/lib/supabase.ts` — Instanciação do cliente Supabase
- `src/hooks/AuthContext.tsx` — Gestão de sessão, perfil, roles, loading
- `src/pages/Auth.tsx` — Login/signup UI
- `src/pages/Admin.tsx` — Painel admin, logout
- `src/pages/ConductorDashboard.tsx` — Painel condutor, rastreamento
- `src/services/conductorService.ts` — Query de perfis de condutores

---

> **Nota:** A estabilidade do login e carregamento depende de garantir que o utilizador tem sempre um perfil válido, que as queries ao Supabase não falham, e que o contexto de autenticação lida corretamente com todos os estados (incluindo erros).
