-- Criação da tabela user_roles
create table if not exists user_roles (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references profiles(id) on delete cascade,
  role text check (role in ('admin', 'condutor')) not null
);

-- Criação da tabela tuktuks
create table if not exists tuktuks (
  id uuid primary key default uuid_generate_v4(),
  nome text not null,
  identificador text unique not null,
  ativo boolean default true,
  created_at timestamp default now()
);

alter table conductors
  add column if not exists user_id uuid references profiles(id) on delete cascade;
alter table conductors
  add column if not exists tuktuk_id uuid references tuktuks(id);
-- Exemplo de ativação de RLS
drop policy if exists "Conductor owner or admin" on conductors;
alter table conductors enable row level security;
create policy "Conductor owner or admin"
  on conductors
  for select using (
    exists (
      select 1 from user_roles
      where user_id = auth.uid() and role = 'admin'
    )
    or user_id = auth.uid()
  );
