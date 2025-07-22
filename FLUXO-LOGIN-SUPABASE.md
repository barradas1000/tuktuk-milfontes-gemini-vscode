# FLUXO DE LOGIN SUPABASE

## Visão Geral

O fluxo de login da aplicação utiliza o Supabase para autenticação de administradores e motoristas (condutores). O sistema diferencia os perfis pelo campo `role` na tabela `profiles`.

---

## 1. Ficheiros Envolvidos

- **src/hooks/AuthContext.tsx**
  - Contexto de autenticação, gestão de sessão, login, logout, carregamento do perfil.
- **src/pages/Auth.tsx**
  - Página de login/signup, utiliza o contexto de autenticação.
- **src/pages/Admin.tsx**
  - Painel de administração, acesso restrito a utilizadores com `role: "admin"`.
- **src/pages/ConductorDashboard.tsx**
  - Painel do condutor, acesso restrito a utilizadores com `role: "condutor"`.
- **src/components/ToggleConductorTrackingButton.tsx**
  - Ativa/desativa rastreamento em tempo real do condutor.
- **src/components/PassengerMap.tsx**
  - Mostra os TukTuks ativos no mapa para passageiros.
- **src/services/conductorService.ts**
  - Funções para buscar e atualizar perfis de condutores.
- **src/lib/supabase.ts**
  - Instancia o cliente Supabase.

---

## 2. Tabelas e Colunas Supabase

### Tabela: `profiles`

- `id` (UUID, PK): igual ao id do utilizador Supabase
- `email` (string): email do utilizador
- `full_name` (string): nome completo
- `role` (string): 'admin' ou 'condutor'
- `created_at` (timestamp): data de criação do perfil
- `updated_at` (timestamp): data da última atualização

### Tabela: `conductors`

- `id` (UUID, PK): identificador único do condutor
- `user_id` (UUID, FK para profiles.id): referência ao utilizador ✅ NOVA RELAÇÃO
- `tuktuk_id` (UUID, FK para tuktuks.id): referência ao tuk-tuk associado ✅ NOVA
- `name` (string): nome do condutor
- `whatsapp` (string): contacto WhatsApp
- `latitude` (float): latitude atual
- `longitude` (float): longitude atual
- `is_active` (boolean): status online/offline (visível no mapa se true)
- `updated_at` (timestamp): última atualização
- `created_at` (timestamp): data de criação

**Resumo da relação (ATUALIZADA):**

- `profiles`: dados do utilizador com role e autenticação
- `conductors`: estado atual do condutor, ligado ao utilizador via `user_id`
- `conductor_locations`: histórico detalhado de todas as posições enviadas

- **Problema RESOLVIDO:** ✅ A relação entre `profiles` e `conductors` foi corrigida
- **Nova estrutura:** `profiles.id` → `conductors.user_id` (relação limpa, sem IDs duplicados)
- **Campo removido:** `profiles.conductor_id` foi removido da base de dados
- **Código atualizado:** `conductorService.ts` e `types/supabase.ts` foram atualizados

### b) Login de Condutor

- O utilizador faz login na página `/login`.
- O AuthContext verifica o perfil na tabela `profiles`.
- Se `role === "condutor"`, acesso ao `/conductor-dashboard`.
- O condutor pode ativar/desativar rastreamento (atualiza `is_active` e localização na tabela `conductors`).

---

## 4. Erros e Pontos de Melhoria

### ✅ **PROBLEMAS CORRIGIDOS:**

- ~~**Problema:** O campo `conductor_id` pode estar ausente para condutores.~~
  - ✅ **Solução:** Nova relação `profiles.id → conductors.user_id` implementada
- ~~**Problema:** IDs duplicados entre `profiles.id` e `conductors.id`.~~
  - ✅ **Solução:** Relação limpa sem confusão de IDs
- ~~**Problema:** Políticas RLS em falta para `profiles` e `active_conductors`.~~
  - ✅ **Solução:** Todas as políticas RLS implementadas

### ⚠️ **PROBLEMAS RESTANTES:**

- **Problema:** O campo `profile` pode ser `null` após login/refresh se não existir registo na tabela `profiles` para o utilizador.
  - _Solução:_ Garantir que todos os utilizadores têm um registo válido em `profiles` ao criar conta.
- **Problema:** O campo `role` pode estar desatualizado ou incorreto.
  - _Solução:_ Validar e sincronizar o campo `role` entre autenticação e perfil.
- **Problema:** O botão de logout pode não funcionar se o contexto não for atualizado corretamente.
- **Problema:** O mapa de passageiros não mostra TukTuks se não houver condutores ativos (`is_active = true`).
- **Problema:** Após refresh, o loading pode ficar preso se a query ao Supabase falhar ou não houver profile.

## 5. Últimas Atualizações (2024)

### 🔐 **Implementação Completa de Segurança RLS**

- **Data:** Dezembro 2024
- **Alterações:**
  - Criadas **13+ políticas RLS** para 6 tabelas principais
  - Removido `conductor_id` da tabela `profiles`
  - Implementada nova relação `profiles.id → conductors.user_id`
  - Configurado MCP Server para gestão direta da base de dados

### 📋 **Políticas RLS por Tabela:**

- **profiles:** 4 políticas (select/insert/update público + admin update)
- **active_conductors:** 5 políticas (público select, conductor insert/update/delete, admin all)
- **conductor_locations:** 3 políticas (público select, conductor update, admin all)
- **conductors:** 1 política (público select)
- **user_roles:** 2 políticas (admin select/insert)
- **tuktuks:** 2 políticas (público select, admin all)

### 🔧 **Código Atualizado:**

- **conductorService.ts:** Reescrito para nova relação `user_id`
- **adminService.ts:** Atualizado `assign/removeConductorRole`
- **ConductorDashboard.tsx:** Implementado `getConductorIdByUserId()`
- **AdminUserManagement.tsx:** Interfaces TypeScript atualizadas

### ✅ **Estado Atual:**

- Base de dados reestruturada e segura
- Todas as vulnerabilidades de segurança corrigidas
- Aplicação compilando sem erros
- Pronta para testes completos

---

## 5. Considerações para Localhost e Produção (Vercel)

- **Localhost:**
  - O Vite já faz fallback para SPA, refresh funciona normalmente.
  - Verifique se as variáveis de ambiente `.env` estão corretas.
- **Produção (Vercel):**
  - O ficheiro `vercel.json` deve garantir rewrite de todas as rotas para `index.html`.
  - As variáveis de ambiente devem estar configuradas no painel da Vercel.
  - Certifique-se de que as regras de CORS do Supabase permitem o domínio de produção.

---

## 6. Implementações Necessárias

✅ **CONCLUÍDO:** Estrutura de base de dados corrigida

- ✅ Tabela `conductors` atualizada com `user_id` e `tuktuk_id`
- ✅ Campo `conductor_id` removido de `profiles`
- ✅ Políticas RLS atualizadas para nova relação
- ✅ Código do `conductorService.ts` atualizado

✅ **CONCLUÍDO:** Políticas RLS Implementadas

### 🔒 **Políticas RLS por Tabela:**

#### **`profiles` (4 políticas):**

- `Users can view own profile` - usuários veem apenas seu perfil
- `Users can update own profile` - usuários editam apenas seu perfil
- `Admins can view all profiles` - admins veem todos os perfis
- `Admins can update all profiles` - admins editam todos os perfis

#### **`conductors` (1 política):**

- `Conductor owner or admin` - condutor vê próprios dados OU admin vê todos
  - ✅ **ATUALIZADA** para usar `conductors.user_id = auth.uid()`

#### **`active_conductors` (5 políticas):**

- `Conductors can view their own active status` - condutor vê próprio status
- `Conductors can insert their own active status` - condutor pode se ativar
- `Conductors can update their own active status` - condutor pode atualizar status
- `Admins can manage all active conductors` - admin gerencia todos
- `Public can view active conductors` - público vê condutores ativos (mapa)

#### **`conductor_locations` (3 políticas):**

- `Admins can manage conductor locations` - admin gerencia localizações
- `Conductors can update their own location` - condutor atualiza própria localização
  - ✅ **ATUALIZADA** para usar nova relação `user_id`
- `Public can view conductor location` - público vê localizações (mapa)

#### **`user_roles` (2 políticas):**

- `Admins can manage all user roles` - admin gerencia todos os roles
- `Users can view own role` - usuário vê próprio role

#### **`tuktuks` (2 políticas):**

- `Public can view active tuktuks` - público vê tuk-tuks ativos
- `Admins can manage all tuktuks` - admin gerencia todos os tuk-tuks

### 🛡️ **Segurança Implementada:**

- ✅ **RLS ativado** em todas as tabelas principais
- ✅ **Controle de acesso** por role (admin/condutor/público)
- ✅ **Nova relação** `profiles.id → conductors.user_id` implementada
- ✅ **Isolamento de dados** - cada usuário vê apenas seus dados
- ✅ **Acesso público controlado** - apenas dados necessários para o mapa

🔄 **PRÓXIMOS PASSOS:**

- Garantir criação automática de perfil em `profiles` após signup
- Validar e sincronizar o campo `role` sempre que o utilizador faz login
- Atualizar `AuthContext.tsx` para usar nova relação (se necessário)
- Melhorar tratamento de erros e feedback ao utilizador
- Adicionar logs e mensagens de erro visíveis para debugging
- Testar o fluxo completo de login/logout/rastreamento em localhost e produção

---

## 7. Resumo do Fluxo

1. Utilizador faz login (email/senha) → Supabase Auth
2. App busca perfil em `profiles` (por id do utilizador)
3. Se perfil existe e role válido:
   - Admin: acesso ao painel admin
   - Condutor: acesso ao dashboard condutor
4. Condutor pode ativar/desativar rastreamento (atualiza localização e visibilidade no mapa dos passageiros)
5. Logout limpa sessão e redireciona para login

---

## 8. Segurança RLS (Row Level Security)

### 📊 **Resumo das Políticas Implementadas:**

| **Tabela**            | **Políticas** | **RLS Status** | **Descrição**                          |
| --------------------- | ------------- | -------------- | -------------------------------------- |
| `profiles`            | 4 políticas   | ✅ Ativo       | Acesso controlado por owner/admin      |
| `conductors`          | 1 política    | ✅ Ativo       | Nova relação `user_id` implementada    |
| `active_conductors`   | 5 políticas   | ✅ Ativo       | Controle de status de ativação         |
| `conductor_locations` | 3 políticas   | ✅ Ativo       | Localização controlada por owner/admin |
| `user_roles`          | 2 políticas   | ✅ Ativo       | Gestão de roles administrativos        |
| `tuktuks`             | 2 políticas   | ✅ Ativo       | Visibilidade pública controlada        |
| `reservations`        | Múltiplas     | ✅ Ativo       | Acesso público + admin                 |
| `blocked_periods`     | 1 política    | ✅ Ativo       | Acesso público total                   |

### 🔐 **Tipos de Acesso Implementados:**

#### **👤 Utilizador Normal:**

- Pode ver e editar **apenas seu próprio perfil**
- Pode ver seu próprio role em `user_roles`
- **Não tem acesso** a dados de outros utilizadores

#### **🚗 Condutor:**

- Tudo do utilizador normal **+**
- Pode ver e editar **próprios dados de condutor**
- Pode ativar/desativar **próprio status** no mapa
- Pode atualizar **própria localização**
- **Não vê dados de outros condutores**

#### **👨‍💼 Admin:**

- **Acesso total** a todas as tabelas
- Pode **gerir todos os perfis** e roles
- Pode **ver e editar todos os condutores**
- Pode **gerir tuk-tuks** e reservas
- **Controle completo** do sistema

#### **🌍 Público (não autenticado):**

- Pode **ver condutores ativos** no mapa
- Pode **ver localizações** para rastreamento
- Pode **fazer reservas**
- Pode **ver tuk-tuks ativos**
- **Sem acesso** a dados pessoais

### ⚠️ **Avisos de Segurança Restantes:**

- Functions com `search_path` mutável (WARNING)
- OTP expiry > 1 hora (WARNING)
- Leaked password protection desativada (WARNING)

### 🛠️ **Nova Relação Implementada:**

```
ANTES: profiles.conductor_id → conductors.id  ❌ (IDs duplicados)
AGORA: profiles.id → conductors.user_id       ✅ (relação limpa)
```

**Benefícios da nova estrutura:**

- ✅ Elimina confusão de IDs duplicados
- ✅ Relação mais clara e intuitiva
- ✅ Flexibilidade para expansão futura
- ✅ Debugging mais fácil
- ✅ Políticas RLS mais simples

---

> **Nota:** Se algum destes passos falhar, a aplicação pode ficar presa em loading ou não mostrar dados corretos. Use os painéis de diagnóstico e logs para depurar.

Nas tabelas profiles.id e conductors.id,estão a usar os mesmos valor de ID!
Usar o mesmo UUID para profiles.id e conductors.id, tecnicamente não há problema de funcionamento, desde que a lógica do sistema sempre utilize os campos corretos para cada tabela e mantenha a relação clara (por exemplo, profiles.conductor_id referenciando conductors.id).
O mesmo valor de ID representará entidades diferentes (um utilizador e um condutor).
Se no futuro quiser permitir que um utilizador tenha múltiplos condutores, ou vice-versa, essa abordagem limita a flexibilidade.
Pode gerar dúvidas ao ler logs, fazer queries ou debugar, já que o mesmo UUID aparece em tabelas distintas com significados diferentes.
Recomendação: Mesmo que use o mesmo valor, mantenha sempre a relação explícita via conductor_id em profiles e documente bem essa decisão. Para maior clareza e flexibilidade futura, normalmente é melhor deixar os IDs independentes.
