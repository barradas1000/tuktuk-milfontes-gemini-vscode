-- ========================================
-- 🔄 CONFIGURAR CARLOS BARRADAS - SCRIPT SIMPLES
-- ========================================
-- Usa apenas roles que existem: 'conductor' e possivelmente 'admin'

-- 1. VERIFICAR ESTADO ATUAL
SELECT 'ANTES' as momento, email, is_super_admin 
FROM auth.users 
WHERE email = 'carlosbarradas111@gmail.com';

-- 2. CONFIGURAR COMO SUPER ADMIN
UPDATE auth.users 
SET 
    is_super_admin = true,
    updated_at = now()
WHERE email = 'carlosbarradas111@gmail.com';

-- 3. ATUALIZAR PROFILE
UPDATE public.profiles 
SET 
    full_name = 'Carlos Barradas',
    admin_level = 'super_admin',
    updated_at = now()
WHERE email = 'carlosbarradas111@gmail.com';

-- 4. REMOVER ROLES EXISTENTES
DELETE FROM public.user_roles 
WHERE user_id IN (
    SELECT id FROM auth.users 
    WHERE email = 'carlosbarradas111@gmail.com'
);

-- 5. INSERIR ROLE CONDUCTOR (sabemos que existe)
INSERT INTO public.user_roles (user_id, role, created_at, updated_at)
SELECT 
    u.id,
    'conductor',
    now(),
    now()
FROM auth.users u
WHERE u.email = 'carlosbarradas111@gmail.com';

-- 6. VERIFICAR RESULTADO
SELECT 
    'DEPOIS' as momento,
    email, 
    is_super_admin
FROM auth.users 
WHERE email = 'carlosbarradas111@gmail.com';

-- 7. VERIFICAR PROFILE
SELECT 
    'PROFILE' as tipo,
    email,
    full_name,
    role,
    admin_level
FROM public.profiles
WHERE email = 'carlosbarradas111@gmail.com';

-- 8. VERIFICAR ROLE
SELECT 
    'ROLE' as tipo,
    ur.role
FROM public.user_roles ur
JOIN auth.users u ON ur.user_id = u.id
WHERE u.email = 'carlosbarradas111@gmail.com';
