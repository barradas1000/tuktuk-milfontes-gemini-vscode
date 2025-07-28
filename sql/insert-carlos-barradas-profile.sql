-- Adiciona o usuário Carlos Barradas à tabela profiles
insert into profiles (
  id, -- UUID, pode ser gerado pelo Supabase ou fornecido manualmente
  full_name,
  email,
  role,
  created_at,
  updated_at
) values (
  gen_random_uuid(),
  'Carlos Barradas',
  'carlosbarradas1@gmail.com',
  'super_admin',
  now(),
  now()
);
