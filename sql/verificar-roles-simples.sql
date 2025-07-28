-- ========================================
-- 🔍 VERIFICAR ROLES PERMITIDAS
-- ========================================

-- Verificar valores únicos de role existentes
SELECT 
    'ROLES EXISTENTES' as info,
    role,
    count(*) as quantidade
FROM public.user_roles
GROUP BY role
ORDER BY role;

-- Verificar constraint específica do role
SELECT 
    conname as constraint_name,
    consrc as check_definition
FROM pg_constraint 
WHERE conrelid = 'public.user_roles'::regclass 
AND contype = 'c';
