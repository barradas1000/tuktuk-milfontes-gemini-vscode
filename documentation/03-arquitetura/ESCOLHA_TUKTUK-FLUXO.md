# Plano de Implementação: Escolha de TukTuk e Múltiplos Papéis

## Objetivo

Permitir que administradores possam também ser condutores, escolher qual TukTuk vão conduzir ao iniciar atividade, e garantir rastreamento correto e seguro, com interface intuitiva e fácil manutenção.

---

## 1. Funcionalidades a Implementar

- Gestão de múltiplos papéis por utilizador (admin, condutor, ambos)
- Seleção de TukTuk ao iniciar atividade
- Associação dinâmica entre condutor e TukTuk
- Prevenção de conflitos (um TukTuk só pode estar com um condutor ativo)
- Rastreamento em tempo real do TukTuk selecionado
- Interface para admins editarem papéis dos utilizadores
- Histórico de quem conduziu cada TukTuk
- Fluxo de autenticação robusto e seguro

---

## 2. Estrutura de Dados e Tabelas Supabase

### Tabela: `profiles`

- `id` (UUID, PK): id do utilizador Supabase Auth
- `email` (string)
- `full_name` (string)
- `created_at` (timestamp)
- `updated_at` (timestamp)

### Tabela: `user_roles`

- `id` (PK)
- `user_id` (FK para profiles.id)
- `role` (string: 'admin', 'condutor', ...)

### Tabela: `conductors`

- `id` (UUID, PK)
- `user_id` (FK para profiles.id)
- `tuktuk_id` (FK para tuktuks.id, pode ser null)
- `is_active` (boolean)
- `latitude` (float)
- `longitude` (float)
- `updated_at` (timestamp)

### Tabela: `tuktuks`

- `id` (UUID, PK)
- `nome` (string)
- `identificador` (string ou matrícula)
- `ativo` (boolean)
- `created_at` (timestamp)

### Tabela: `conductor_locations`

- `id` (PK)
- `conductor_id` (FK para conductors.id)
- `latitude` (float)
- `longitude` (float)
- `timestamp` (datetime)

---

## 3. Queries SQL de Criação

```sql
-- user_roles
create table user_roles (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references profiles(id),
  role text check (role in ('admin', 'condutor'))
);

-- tuktuks
create table tuktuks (
  id uuid primary key default uuid_generate_v4(),
  nome text not null,
  identificador text unique not null,
  ativo boolean default true,
  created_at timestamp default now()
);

-- conductors (adaptação)
alter table conductors
  add column user_id uuid references profiles(id),
  add column tuktuk_id uuid references tuktuks(id);

-- conductor_locations (já existente)
```

---

## 4. Regras RLS (Row Level Security) Exemplo

```sql
-- Exemplo: só o próprio utilizador ou admin pode ver/editar o seu condutor
create policy "Conductor owner or admin"
  on conductors
  for select using (
    exists (
      select 1 from user_roles
      where user_id = auth.uid() and role = 'admin'
    )
    or user_id = auth.uid()
  );
```

---

## 5. Fluxo de Autenticação e Atividade

1. **Login:**

   - Utilizador faz login (Supabase Auth).
   - App carrega perfil e papéis (`user_roles`).

2. **Escolha de Papel:**

   - Se for admin e condutor, pode escolher qual dashboard aceder.
   - Se condutor, pode iniciar atividade.

3. **Escolha de TukTuk:**

   - Ao iniciar atividade, condutor vê lista de TukTuks disponíveis (não atribuídos a outro condutor ativo).
   - Seleciona TukTuk → sistema associa `tuktuk_id` ao condutor e marca TukTuk como ocupado.

4. **Iniciar Rastreamento:**

   - App ativa geolocalização e começa a enviar localização para tabela `conductors` (posição atual) e `conductor_locations` (histórico).
   - `is_active` fica `true` enquanto atividade decorre.

5. **Visualização no Mapa:**

   - Passageiros veem todos os TukTuks ativos no mapa (query por `conductors.is_active = true`).

6. **Logout ou Fim de Atividade:**
   - Condutor pode terminar atividade, desassociando o TukTuk e ficando offline.

---

## 6. Adaptação da Interface

- **Admin:**
  - Dashboard com listagem de utilizadores e papéis (checkboxes para editar).
  - Gestão de TukTuks (adicionar, editar, ativar/desativar).
- **Condutor:**
  - Ao iniciar turno, aparece seletor de TukTuk (dropdown).
  - Botão para iniciar/finalizar rastreamento.
  - Feedback visual de qual TukTuk está a conduzir.
- **Geral:**
  - Mensagens claras de erro e sucesso.
  - Prevenção de seleção de TukTuk já ocupado.

---

## 7. Exemplo de Fluxo no Frontend

- Após login, buscar papéis do utilizador:
  ```js
  const { data: roles } = await supabase
    .from("user_roles")
    .select("role")
    .eq("user_id", user.id);
  ```
- Se for condutor, buscar TukTuks disponíveis:
  ```js
  const { data: tuktuks } = await supabase
    .from("tuktuks")
    .select("*")
    .eq("ativo", true)
    .is("id", null); // ou lógica para filtrar não atribuídos
  ```
- Ao selecionar TukTuk, atualizar `conductors.tuktuk_id` e `is_active`:
  ```js
  await supabase
    .from("conductors")
    .update({ tuktuk_id: tuktukSelecionado, is_active: true })
    .eq("user_id", user.id);
  ```

---

## 8. Considerações de Manutenção

- Separar lógica de papéis e permissões para fácil evolução.
- Garantir integridade referencial entre utilizadores, condutores e TukTuks.
- Documentar bem as relações e fluxos.
- Testar todos os fluxos: admin, condutor, seleção de TukTuk, rastreamento, logout.

---

## 9. Resumo

Este plano permite:

- Múltiplos admins e condutores.
- Escolha dinâmica de TukTuk.
- Rastreamento seguro e auditável.
- Interface intuitiva e fácil de manter.

---
plano de ação :

Criação/alteração das tabelas no Supabase

Executar os comandos SQL para criar as tabelas user_roles e tuktuks, e adaptar a tabela conductors.
Ativar RLS e criar as policies básicas.

Atualizar o modelo de dados no backend

Atualizar os serviços e tipos TypeScript para refletir as novas tabelas e relações.
Ajustar o fluxo de autenticação

Modificar o AuthContext para buscar e armazenar os papéis do utilizador (user_roles).
Interface de escolha de papel e TukTuk

Adicionar no dashboard do condutor a seleção de TukTuk (dropdown).
No dashboard admin, permitir editar papéis dos utilizadores.
Fluxo de rastreamento

Garantir que, ao iniciar atividade, o condutor só possa escolher TukTuks disponíveis e que o rastreamento só inicie após a escolha.