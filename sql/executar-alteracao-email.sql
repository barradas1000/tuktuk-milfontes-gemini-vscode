-- ========================================
-- 🔄 ALTERAÇÃO EMAIL - SCRIPT FINAL SIMPLIFICADO
-- ========================================

-- 1. Verificar user atual
SELECT 'ANTES' as momento, email, is_super_admin 
FROM auth.users 
WHERE email = 'motorista.teste@tuktuk-milfontes.pt';

-- 2. ALTERAR EMAIL E CONFIGURAR SUPER ADMIN
UPDATE auth.users 
SET 
    email = 'carlosbarradas111@gmail.com',
    is_super_admin = true,
    updated_at = now()
WHERE email = 'motorista.teste@tuktuk-milfontes.pt';

-- 3. ATUALIZAR PROFILE
UPDATE public.profiles 
SET 
    full_name = 'Carlos Barradas',
    email = 'carlosbarradas111@gmail.com',
    role = 'super_admin',
    admin_level = 'super_admin',
    updated_at = now()
WHERE id IN (
    SELECT id FROM auth.users 
    WHERE email = 'carlosbarradas111@gmail.com'
);

-- 4. REMOVER ROLES EXISTENTES
DELETE FROM public.user_roles 
WHERE user_id IN (
    SELECT id FROM auth.users 
    WHERE email = 'carlosbarradas111@gmail.com'
);

-- 5. INSERIR NOVAS ROLES
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

-- 6. VERIFICAR RESULTADO FINAL
SELECT 
    'DEPOIS' as momento,
    email, 
    is_super_admin,
    id
FROM auth.users 
WHERE email = 'carlosbarradas111@gmail.com';

-- 7. VERIFICAR ROLES CRIADAS
SELECT 
    'ROLES' as tipo,
    ur.role
FROM public.user_roles ur
JOIN auth.users u ON ur.user_id = u.id
WHERE u.email = 'carlosbarradas111@gmail.com'
ORDER BY ur.role;

-- 8. VERIFICAR PROFILE
SELECT 
    'PROFILE' as tipo,
    p.email,
    p.full_name,
    p.role,
    p.admin_level,
    p.updated_at
FROM public.profiles p
JOIN auth.users u ON p.id = u.id
WHERE u.email = 'carlosbarradas111@gmail.com';
