-- EXECUÇÃO MANUAL PARA CRIAR USER AUTH CARLOS BARRADAS
-- Execute este SQL no painel SQL do Supabase: https://supabase.com/dashboard/project/iweurnqdomiqlohvaoat/sql

-- 1. Criar user no auth.users (como service_role)
INSERT INTO auth.users (
    id,
    aud,
    role,
    email,
    encrypted_password,
    email_confirmed_at,
    created_at,
    updated_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin,
    confirmation_token,
    email_change,
    email_change_token_new,
    recovery_token
) VALUES (
    gen_random_uuid(),
    'authenticated',
    'authenticated',
    'carlosbarradas111@gmail.com',
    crypt('TukTuk2025!', gen_salt('bf')),  -- Password hash usando bcrypt
    NOW(),
    NOW(),
    NOW(),
    NOW(),
    '{"provider": "email", "providers": ["email"]}',
    '{"full_name": "Carlos Barradas"}',
    false,
    '',
    '',
    '',
    ''
);

-- 2. Verificar se o user foi criado
SELECT 
    id, 
    email, 
    created_at,
    email_confirmed_at,
    raw_user_meta_data
FROM auth.users 
WHERE email = 'carlosbarradas111@gmail.com';

-- 3. Confirmar que o profile já existe e está correto
SELECT 
    id,
    full_name,
    email,
    role,
    admin_level,
    active
FROM profiles 
WHERE email = 'carlosbarradas111@gmail.com';
