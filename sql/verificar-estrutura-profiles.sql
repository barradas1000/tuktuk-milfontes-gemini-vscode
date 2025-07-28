-- ========================================
-- 🔍 VERIFICAR ESTRUTURA TABELA PROFILES
-- ========================================

-- Verificar colunas da tabela profiles
SELECT 
    'ESTRUTURA PROFILES' as verificacao,
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_schema = 'public' 
AND table_name = 'profiles'
ORDER BY ordinal_position;

-- Verificar dados existentes
SELECT 
    'DADOS EXISTENTES' as verificacao,
    *
FROM public.profiles
LIMIT 5;
