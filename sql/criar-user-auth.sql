-- ========================================
-- 🔧 CRIAR USER CARLOS BARRADAS VIA SQL
-- ========================================
-- Execute no SQL Editor do Supabase

-- 1. Verificar se user existe na tabela auth.users
SELECT 
    'AUTH USERS' as verificacao,
    id,
    email,
    email_confirmed_at IS NOT NULL as confirmado,
    created_at
FROM auth.users 
WHERE email = 'carlosbarradas111@gmail.com';

-- 2. Se não existir, deletar profile órfão primeiro
DELETE FROM public.profiles 
WHERE email = 'carlosbarradas111@gmail.com' 
AND id NOT IN (SELECT id FROM auth.users WHERE email = 'carlosbarradas111@gmail.com');

-- 3. Inserir user na tabela auth.users manualmente
INSERT INTO auth.users (
    instance_id,
    id,
    aud,
    role,
    email,
    encrypted_password,
    email_confirmed_at,
    invited_at,
    confirmation_token,
    confirmation_sent_at,
    recovery_token,
    recovery_sent_at,
    email_change_token_new,
    email_change,
    email_change_sent_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin,
    created_at,
    updated_at,
    phone,
    phone_confirmed_at,
    phone_change,
    phone_change_token,
    phone_change_sent_at,
    email_change_token_current,
    email_change_confirm_status,
    banned_until,
    reauthentication_token,
    reauthentication_sent_at
) VALUES (
    '00000000-0000-0000-0000-000000000000',
    '8b15366b-95c7-4be8-b2b9-ca57ae4fcfb4', -- Usar o ID que já existe no profiles
    'authenticated',
    'authenticated',
    'carlosbarradas111@gmail.com',
    crypt('TukTuk2025!', gen_salt('bf')), -- Password encriptada
    now(), -- Email confirmado
    now(),
    '',
    now(),
    '',
    null,
    '',
    '',
    null,
    null,
    '{"provider":"email","providers":["email"]}',
    '{}',
    true, -- Super admin
    now(),
    now(),
    null,
    null,
    '',
    '',
    null,
    '',
    0,
    null,
    '',
    null
)
ON CONFLICT (id) DO UPDATE SET
    email = EXCLUDED.email,
    encrypted_password = EXCLUDED.encrypted_password,
    email_confirmed_at = EXCLUDED.email_confirmed_at,
    is_super_admin = EXCLUDED.is_super_admin,
    updated_at = now();

-- 4. Verificar resultado final
SELECT 
    'RESULTADO FINAL' as verificacao,
    id,
    email,
    email_confirmed_at IS NOT NULL as confirmado,
    is_super_admin,
    created_at
FROM auth.users 
WHERE email = 'carlosbarradas111@gmail.com';

-- 5. Verificar se profile ainda existe e está correto
SELECT 
    'PROFILE FINAL' as verificacao,
    id,
    email,
    full_name,
    role,
    admin_level
FROM public.profiles 
WHERE email = 'carlosbarradas111@gmail.com';
