-- ========================================
-- 🔍 VERIFICAR ESTRUTURA TABELA USER_ROLES
-- ========================================

-- Verificar colunas da tabela user_roles
SELECT 
    'ESTRUTURA USER_ROLES' as verificacao,
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_schema = 'public' 
AND table_name = 'user_roles'
ORDER BY ordinal_position;

-- Verificar dados existentes
SELECT 
    'DADOS EXISTENTES' as verificacao,
    *
FROM public.user_roles
LIMIT 5;
