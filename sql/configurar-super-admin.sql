-- ========================================
-- 🔄 CONFIGURAR CARLOS BARRADAS COMO SUPER ADMIN
-- ========================================
-- Já existe user carlosbarradas111@gmail.com, vamos apenas configurar como super admin

-- 1. VERIFICAR ESTADO ATUAL
SELECT 'ESTADO ATUAL' as verificacao, email, is_super_admin 
FROM auth.users 
WHERE email = 'carlosbarradas111@gmail.com';

-- 2. CONFIGURAR COMO SUPER ADMIN
UPDATE auth.users 
SET 
    is_super_admin = true,
    updated_at = now()
WHERE email = 'carlosbarradas111@gmail.com';

-- 3. ATUALIZAR PROFILE PARA SUPER ADMIN
UPDATE public.profiles 
SET 
    full_name = 'Carlos Barradas',
    role = 'admin',
    admin_level = 'super_admin',
    updated_at = now()
WHERE email = 'carlosbarradas111@gmail.com';

-- 4. REMOVER ROLES EXISTENTES
DELETE FROM public.user_roles 
WHERE user_id IN (
    SELECT id FROM auth.users 
    WHERE email = 'carlosbarradas111@gmail.com'
);

-- 5. INSERIR ROLES VÁLIDAS (SEM super_admin que não é permitido)
INSERT INTO public.user_roles (user_id, role, created_at, updated_at)
SELECT 
    u.id,
    role_data.role,
    now(),
    now()
FROM auth.users u,
LATERAL (VALUES 
    ('admin'),
    ('conductor')
) AS role_data(role)
WHERE u.email = 'carlosbarradas111@gmail.com';

-- 6. VERIFICAR CONFIGURAÇÃO FINAL
SELECT 
    'USER FINAL' as tipo,
    email, 
    is_super_admin,
    id
FROM auth.users 
WHERE email = 'carlosbarradas111@gmail.com';

-- 7. VERIFICAR PROFILE FINAL
SELECT 
    'PROFILE FINAL' as tipo,
    email,
    full_name,
    role,
    admin_level
FROM public.profiles
WHERE email = 'carlosbarradas111@gmail.com';

-- 8. VERIFICAR TODAS AS ROLES
SELECT 
    'ROLES FINAIS' as tipo,
    ur.role
FROM public.user_roles ur
JOIN auth.users u ON ur.user_id = u.id
WHERE u.email = 'carlosbarradas111@gmail.com'
ORDER BY ur.role;

-- 9. VERIFICAR SE HÁ CONDUCTOR LINKADO
SELECT 
    'CONDUCTOR LINKADO' as tipo,
    c.name,
    c.id,
    c.user_id IS NOT NULL as tem_ligacao
FROM public.conductors c
JOIN auth.users u ON c.user_id = u.id
WHERE u.email = 'carlosbarradas111@gmail.com';
