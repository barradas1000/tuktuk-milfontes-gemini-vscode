-- ========================================
-- 🔄 ALTERAÇÃO DE EMAIL DO USER EXISTENTE
-- ========================================
-- Substitui 'motorista.teste@tuktuk-milfontes.pt' por 'carlosbarradas111@gmail.com'
-- Mantém todos os dados, vínculos e histórico

-- ⚠️ IMPORTANTE: Execute no projeto Supabase (iweurnqdomiqlohvaoat)

-- 1. Verificar user atual antes da alteração
SELECT 
    'USER ANTES DA ALTERACAO' as verificacao,
    id,
    email, 
    created_at,
    email_confirmed_at IS NOT NULL as email_confirmado,
    is_super_admin
FROM auth.users 
WHERE email = 'motorista.teste@tuktuk-milfontes.pt';

-- 2. Verificar dados associados ao user
SELECT 
    'DADOS ASSOCIADOS' as verificacao,
    'profiles' as tabela,
    count(*) as registos
FROM public.profiles p
JOIN auth.users u ON p.id = u.id
WHERE u.email = 'motorista.teste@tuktuk-milfontes.pt'

UNION ALL

SELECT 
    'DADOS ASSOCIADOS' as verificacao,
    'user_roles' as tabela,
    count(*) as registos
FROM public.user_roles ur
JOIN auth.users u ON ur.user_id = u.id
WHERE u.email = 'motorista.teste@tuktuk-milfontes.pt'

UNION ALL

SELECT 
    'DADOS ASSOCIADOS' as verificacao,
    'conductors' as tabela,
    count(*) as registos
FROM public.conductors c
JOIN auth.users u ON c.user_id = u.id
WHERE u.email = 'motorista.teste@tuktuk-milfontes.pt';

-- 3. ALTERAÇÃO DO EMAIL
-- Atualizar o email na tabela auth.users
UPDATE auth.users 
SET 
    email = 'carlosbarradas111@gmail.com',
    raw_user_meta_data = jsonb_set(
        COALESCE(raw_user_meta_data, '{}'),
        '{email}',
        '"carlosbarradas111@gmail.com"'
    ),
    is_super_admin = true,
    updated_at = now()
WHERE email = 'motorista.teste@tuktuk-milfontes.pt';

-- 4. Atualizar profile com os dados do Carlos Barradas
UPDATE public.profiles 
SET 
    name = 'Carlos Barradas',
    email = 'carlosbarradas111@gmail.com',
    updated_at = now()
WHERE id IN (
    SELECT id FROM auth.users 
    WHERE email = 'carlosbarradas111@gmail.com'
);

-- 5. Configurar roles do Carlos Barradas (super admin + admin + condutor)
-- Primeiro, remover roles existentes
DELETE FROM public.user_roles 
WHERE user_id IN (
    SELECT id FROM auth.users 
    WHERE email = 'carlosbarradas111@gmail.com'
);

-- Inserir todas as roles do Carlos Barradas
INSERT INTO public.user_roles (user_id, role, created_at, updated_at)
SELECT 
    u.id,
    role_data.role,
    now(),
    now()
FROM auth.users u,
LATERAL (VALUES 
    ('super_admin'),
    ('admin_global'),
    ('admin_local'),
    ('conductor')
) AS role_data(role)
WHERE u.email = 'carlosbarradas111@gmail.com';

-- 6. Verificar alterações realizadas
SELECT 
    'USER APOS ALTERACAO' as verificacao,
    id,
    email, 
    created_at,
    email_confirmed_at IS NOT NULL as email_confirmado,
    is_super_admin
FROM auth.users 
WHERE email = 'carlosbarradas111@gmail.com';

-- 7. Verificar profile atualizado
SELECT 
    'PROFILE ATUALIZADO' as verificacao,
    p.name,
    p.email,
    p.updated_at
FROM public.profiles p
JOIN auth.users u ON p.id = u.id
WHERE u.email = 'carlosbarradas111@gmail.com';

-- 8. Verificar roles configuradas
SELECT 
    'ROLES CONFIGURADAS' as verificacao,
    ur.role
FROM public.user_roles ur
JOIN auth.users u ON ur.user_id = u.id
WHERE u.email = 'carlosbarradas111@gmail.com'
ORDER BY ur.role;

-- 9. Verificar se conductor mantém ligação
SELECT 
    'CONDUCTOR LINKADO' as verificacao,
    c.id,
    c.name,
    c.user_id IS NOT NULL as tem_user_linkado
FROM public.conductors c
JOIN auth.users u ON c.user_id = u.id
WHERE u.email = 'carlosbarradas111@gmail.com';

-- 10. Verificação final - confirmar que não existe o email antigo
SELECT 
    'VERIFICACAO FINAL' as verificacao,
    count(*) as users_com_email_antigo
FROM auth.users 
WHERE email = 'motorista.teste@tuktuk-milfontes.pt';
