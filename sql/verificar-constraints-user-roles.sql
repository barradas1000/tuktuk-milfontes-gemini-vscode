-- ========================================
-- 🔍 VERIFICAR CONSTRAINTS DA TABELA USER_ROLES
-- ========================================

-- Verificar constraints da tabela user_roles
SELECT 
    'CONSTRAINTS' as verificacao,
    tc.constraint_name,
    tc.constraint_type,
    cc.check_clause
FROM information_schema.table_constraints tc
LEFT JOIN information_schema.check_constraints cc ON tc.constraint_name = cc.constraint_name
WHERE tc.table_schema = 'public' 
AND tc.table_name = 'user_roles';

-- Verificar valores únicos de role existentes
SELECT 
    'ROLES EXISTENTES' as verificacao,
    role,
    count(*) as quantidade
FROM public.user_roles
GROUP BY role
ORDER BY role;

-- Verificar definição da tabela
SELECT 
    'DEFINICAO TABELA' as verificacao,
    column_name,
    data_type,
    column_default,
    is_nullable
FROM information_schema.columns 
WHERE table_schema = 'public' 
AND table_name = 'user_roles'
ORDER BY ordinal_position;
