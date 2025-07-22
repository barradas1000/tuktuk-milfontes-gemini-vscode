# Sumário do Processo: Gestão de Papéis e Dados no TukTuk Milfontes com Supabase

Este documento detalha o processo de clarificação e implementação da gestão de papéis (`user`, `admin`, `condutor`) e a sua interação com as tabelas do Supabase na aplicação TukTuk Milfontes.

## 1. Ideia Conceptual e Problema Inicial

**Problema:** A necessidade de gerir diferentes papéis (utilizador comum, administrador, condutor) para a mesma pessoa, onde um condutor é também um utilizador autenticado, e um administrador pode ser um condutor ou um utilizador. A confusão residia em como diferenciar e gerir o acesso aos dados para cada papel, especialmente no contexto do Supabase.

**Solução Conceptual:**
A abordagem adotada foi centralizar a gestão de papéis na tabela `public.profiles`, que já está ligada aos utilizadores de autenticação do Supabase (`auth.users`).
*   A coluna `role` na tabela `profiles` seria usada para definir o papel principal do utilizador (`user`, `admin`, `condutor`).
*   Para condutores, seria adicionada uma coluna `conductor_id` na tabela `profiles`, ligando o perfil do utilizador a uma entrada na tabela `public.conductors`. Isso permite que um utilizador autenticado seja reconhecido como um condutor específico.
*   A tabela `public.reservations` seria modificada para incluir um `assigned_conductor_id`, permitindo que as reservas sejam atribuídas a condutores específicos.
*   A segurança seria garantida através de **Row Level Security (RLS)** no Supabase, assegurando que cada papel só possa aceder e manipular os dados para os quais tem permissão.

## 2. Alterações no Esquema da Base de Dados (Migrações SQL)

Para implementar a ideia conceptual, foram criadas e aplicadas as seguintes migrações SQL:

### 2.1. Adição de Novas Colunas

**Objetivo:** Ligar perfis de utilizadores a condutores e reservas a condutores.

**Queries SQL:**
```sql
-- supabase/migrations/YYYYMMDDHHMMSS_add_conductor_columns.sql

-- Adiciona conductor_id à tabela profiles
ALTER TABLE public.profiles
ADD COLUMN conductor_id UUID REFERENCES public.conductors(id);

-- Adiciona assigned_conductor_id à tabela reservations
ALTER TABLE public.reservations
ADD COLUMN assigned_conductor_id UUID REFERENCES public.conductors(id);
```
*   **`conductor_id` na `public.profiles`**: Permite associar um utilizador autenticado (que tem um perfil) a um registo específico na tabela `public.conductors`. Isso é crucial para identificar qual condutor corresponde a um utilizador logado.
*   **`assigned_conductor_id` na `public.reservations`**: Permite que as reservas sejam explicitamente atribuídas a um condutor, facilitando a gestão e a visualização por parte dos condutores.

### 2.2. Ajuste das Políticas de Row Level Security (RLS)

**Objetivo:** Reforçar a segurança e garantir que cada papel tem o acesso adequado aos dados.

**Queries SQL:**

**Remoção de Políticas Amplas (Reservations):**
Inicialmente, a tabela `reservations` tinha políticas de RLS muito permissivas (`USING (true)`). Estas foram removidas para implementar um controlo de acess  mais granular.
```sql
-- supabase/migrations/YYYYMMDDHHMMSS_remove_broad_reservation_policies.sql

DROP POLICY IF EXISTS "Enable read access for all users" ON reservations;
DROP POLICY IF EXISTS "Enable insert for all users" ON reservations;
DROP POLICY IF EXISTS "Enable update for all users" ON reservations;
```

**Definição de Políticas Específicas para Condutores:**
Foram criadas políticas de RLS para permitir que os condutores acedam apenas aos seus próprios dados e às reservas que lhes são atribuídas.

```sql
-- supabase/migrations/YYYYMMDDHHMMSS_add_conductor_rls_policies.sql

-- Políticas para public.conductors (Condutores podem ver o seu próprio perfil de condutor)
CREATE POLICY "Conductors can view their own conductor profile"
  ON public.conductors
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role = 'condutor'
      AND profiles.conductor_id = conductors.id
    )
  );

-- Políticas para public.active_conductors (Condutores podem ver, inserir e atualizar o seu próprio status ativo)
CREATE POLICY "Conductors can view their own active status"
  ON public.active_conductors
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role = 'condutor'
      AND profiles.conductor_id = active_conductors.conductor_id
    )
  );

CREATE POLICY "Conductors can insert their own active status"
  ON public.active_conductors
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role = 'condutor'
      AND profiles.conductor_id = active_conductors.conductor_id
    )
  );

CREATE POLICY "Conductors can update their own active status"
  ON public.active_conductors
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role = 'condutor'
      AND profiles.conductor_id = active_conductors.conductor_id
    )
  );

-- Políticas para public.blocked_periods (Condutores podem ver, inserir e eliminar os seus próprios períodos bloqueados)
CREATE POLICY "Conductors can view their own blocked periods"
  ON public.blocked_periods
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role = 'condutor'
      AND blocked_periods.created_by = (SELECT name FROM public.conductors WHERE id = (SELECT conductor_id FROM public.profiles WHERE id = auth.uid()))
    )
  );

CREATE POLICY "Conductors can insert their own blocked periods"
  ON public.blocked_periods
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role = 'condutor'
      AND blocked_periods.created_by = (SELECT name FROM public.conductors WHERE id = (SELECT conductor_id FROM public.profiles WHERE id = auth.uid()))
    )
  );

CREATE POLICY "Conductors can delete their own blocked periods"
  ON public.blocked_periods
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role = 'condutor'
      AND blocked_periods.created_by = (SELECT name FROM public.conductors WHERE id = (SELECT conductor_id FROM public.profiles WHERE id = auth.uid()))
    )
  );

-- Políticas para public.reservations (Condutores podem ver as reservas que lhes são atribuídas)
CREATE POLICY "Conductors can view reservations assigned to them"
  ON public.reservations
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role = 'condutor'
      AND reservations.assigned_conductor_id = profiles.conductor_id
    )
  );
```
*   **`admin`**: Mantêm acesso completo a todas as tabelas relevantes (`conductors`, `active_conductors`, `blocked_periods`, `profiles`, `reservations`). Isso permite que os administradores tenham uma visão geral e controlo total sobre a operação.
*   **`condutor`**: Têm acesso restrito aos seus próprios dados. Por exemplo, um condutor só pode ver o seu próprio perfil de condutor, o seu status ativo, os seus períodos bloqueados e as reservas que lhe foram atribuídas. Isso é crucial para a segurança e para simplificar a interface do condutor.
*   **`user` (cliente)**: Não precisam de fazer login para fazer reservas. Se fizerem login, podem ver e atualizar o seu próprio perfil.

**Ação Necessária:** Para aplicar estas alterações ao seu banco de dados Supabase, execute o comando `supabase db push` no terminal, na raiz do seu projeto Supabase.

## 3. Implementação do Código da Aplicação (Funções de Serviço)

Para interagir com o esquema da base de dados e as políticas de RLS, foram criadas funções de serviço em TypeScript.

### 3.1. Inicialização do Cliente Supabase (`src/lib/supabase.ts`)

O cliente Supabase é inicializado num ficheiro central, `src/lib/supabase.ts`, garantindo uma única instância para toda a aplicação e a configuração de variáveis de ambiente.

```typescript
// src/lib/supabase.ts
import { createClient } from "@supabase/supabase-js";

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

export const supabase = createClient(supabaseUrl, supabaseAnonKey, {
  // ... configurações de realtime, auth, global ...
});

if (!supabaseUrl || !supabaseAnonKey) {
  console.warn('⚠️ Variáveis de ambiente do Supabase não configuradas!');
  console.warn('VITE_SUPABASE_URL e VITE_SUPABASE_ANON_KEY são necessárias.');
}
```

### 3.2. Funções de Serviço para Administradores (`src/services/adminService.ts`)

Este ficheiro contém funções que permitem aos administradores gerir utilizadores, condutores e reservas.

```typescript
// src/services/adminService.ts
import { supabase } from '../lib/supabase';

// Atribui o papel de 'condutor' a um utilizador e associa-o a um condutor existente.
export async function assignConductorRole(userId: string, conductorId: string) { /* ... */ }

// Remove o papel de 'condutor' de um utilizador e desassocia-o.
export async function removeConductorRole(userId: string) { /* ... */ }

// Atribui um condutor a uma reserva específica.
export async function assignConductorToReservation(reservationId: string, conductorId: string) { /* ... */ }

// Obtém todos os condutores.
export async function getAllConductors() { /* ... */ }

// Obtém todos os perfis de utilizadores.
export async function getAllProfiles() { /* ... */ }

// Obtém todas as reservas.
export async function getAllReservations() { /* ... */ }
```
*   **`assignConductorRole(userId, conductorId)`**: Usada para mudar o `role` de um utilizador para 'condutor' e preencher o `conductor_id` no seu perfil.
*   **`removeConductorRole(userId)`**: Usada para reverter o `role` de um utilizador para 'user' e remover a associação do `conductor_id`.
*   **`assignConductorToReservation(reservationId, conductorId)`**: Usada para definir o `assigned_conductor_id` de uma reserva.
*   **`getAllConductors()`**: Permite ao admin listar todos os condutores registados.
*   **`getAllProfiles()`**: Permite ao admin listar todos os perfis de utilizadores, essencial para a gestão de papéis.
*   **`getAllReservations()`**: Permite ao admin listar todas as reservas, independentemente do condutor atribuído.

### 3.3. Funções de Serviço para Condutores (`src/services/conductorService.ts`)

Este ficheiro contém funções que permitem aos condutores aceder e gerir os seus próprios dados.

```typescript
// src/services/conductorService.ts
import { supabase } from '../lib/supabase';

// Obtém as reservas atribuídas ao condutor autenticado.
export async function getAssignedReservations() { /* ... */ }

// Obtém o status ativo atual do condutor autenticado.
export async function getConductorActiveStatus() { /* ... */ }

// Atualiza o status ativo do condutor autenticado.
export async function updateConductorActiveStatus(isActive: boolean) { /* ... */ }

// Obtém todos os períodos bloqueados para o condutor autenticado.
export async function getBlockedPeriods() { /* ... */ }

// Adiciona um novo período bloqueado para o condutor autenticado.
export async function addBlockedPeriod(date: string, startTime?: string, endTime?: string, reason?: string) { /* ... */ }

// Exclui um período bloqueado específico para o condutor autenticado.
export async function deleteBlockedPeriod(blockedPeriodId: string) { /* ... */ }
```
*   **`getAssignedReservations()`**: Retorna apenas as reservas onde o `assigned_conductor_id` corresponde ao `conductor_id` do condutor autenticado.
*   **`getConductorActiveStatus()` / `updateConductorActiveStatus()`**: Permitem ao condutor ver e alterar o seu status de atividade.
*   **`getBlockedPeriods()` / `addBlockedPeriod()` / `deleteBlockedPeriod()`**: Permitem ao condutor gerir os seus próprios períodos de indisponibilidade.

## 4. Integração na Interface de Utilizador (UI) - Conceitual

As funções de serviço criadas servem como a ponte entre a UI e o banco de dados.

### 4.1. Interface de Administrador (Admin UI)

*   **Localização:** Dentro da área de administração existente da aplicação.
*   **Funcionalidades:**
    *   **Gestão de Utilizadores:** Uma página onde o admin pode ver todos os perfis (`getAllProfiles()`), e para cada um, ter botões para `assignConductorRole()` ou `removeConductorRole()`.
    *   **Gestão de Reservas:** Uma página com todas as reservas (`getAllReservations()`), onde o admin pode ver detalhes e usar `assignConductorToReservation()` para atribuir condutores.
    *   **Visão Geral de Condutores:** Uma página para listar todos os condutores (`getAllConductors()`) e ver os seus detalhes.
*   **Acesso:** Ambos os administradores têm acesso completo a todas estas funcionalidades e a todos os dados, garantindo que podem "se inteirar da situação de forma simples".

### 4.2. Interface de Condutor (Conductor UI)

*   **Localização:** Uma área dedicada e protegida da aplicação, acessível apenas após o login como `condutor`.
*   **Funcionalidades:**
    *   **Painel Principal:** Exibe as reservas atribuídas ao condutor (`getAssignedReservations()`).
    *   **Gestão de Disponibilidade:** Um componente com um "toggle" para o status ativo (`getConductorActiveStatus()`, `updateConductorActiveStatus()`) e uma secção para gerir períodos bloqueados (`getBlockedPeriods()`, `addBlockedPeriod()`, `deleteBlockedPeriod()`).
*   **Acesso:** Cada condutor só vê e interage com os seus próprios dados, conforme imposto pelas políticas de RLS.

## 5. Próximos Passos para o Desenvolvimento

1.  **Executar Migrações:** Certifique-se de que executou `supabase db push` na raiz do seu projeto Supabase para aplicar todas as alterações de esquema e RLS ao seu banco de dados.
2.  **Implementar UI:** Comece a construir os componentes da interface de utilizador (React, Vue, Angular, etc.) que chamarão as funções de serviço criadas (`adminService.ts` e `conductorService.ts`) para exibir e manipular os dados.
3.  **Testes:** Teste exaustivamente as funcionalidades para cada papel (admin, condutor, utilizador não logado) para garantir que o acesso aos dados está correto e seguro.

---
