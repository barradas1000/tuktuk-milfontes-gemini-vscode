-- Adiciona o usuário Carlos Barradas à tabela profiles com o id correto do Auth
insert into profiles (
  id,
  full_name,
  email,
  role,
  created_at,
  updated_at
) values (
  'a7e33286-0dd7-4021-b104-383c08777f4a',
  'Carlos Barradas',
  'carlosbarradas1@gmail.com',
  'super_admin',
  now(),
  now()
);
