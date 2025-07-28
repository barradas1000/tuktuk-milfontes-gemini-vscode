-- ========================================
-- 🔍 VERIFICAÇÃO PRÉ-MIGRAÇÃO
-- ========================================
-- Execute estas queries ANTES da migração para verificar estado atual

-- 1. Verificar se users já existem
SELECT 
    'USERS EXISTENTES' as verificacao,
    email, 
    created_at,
    email_confirmed_at IS NOT NULL as email_confirmado
FROM auth.users 
WHERE email IN (
    'carlosbarradas111@gmail.com',
    'sonia@tuktuk-milfontes.pt',
    'diogo@tuktuk-milfontes.pt'
)
ORDER BY email;

-- 2. Verificar tabelas existentes
SELECT 
    'TABELAS EXISTENTES' as verificacao,
    schemaname, 
    tablename 
FROM pg_tables 
WHERE schemaname IN ('public', 'auth')
AND tablename IN (
    'profiles', 'user_roles', 'conductors', 
    'tour_types', 'reservations', 'tuktuks'
)
ORDER BY schemaname, tablename;

-- 3. Verificar conductors atuais
SELECT 
    'CONDUCTORS ATUAIS' as verificacao,
    id,
    name,
    user_id,
    user_id IS NOT NULL as tem_user_linkado
FROM public.conductors
WHERE id IN (
    'c2b84b4e-ecbf-47d1-adc0-f3d7549829b3',
    'c4c9a172-92c2-410e-a671-56b443fc093d',
    'e4b3296c-13eb-4faa-aead-e246ddb2bf66'
)
ORDER BY name;

-- 3B. Verificar estrutura da tabela conductors
SELECT 
    'ESTRUTURA CONDUCTORS' as verificacao,
    column_name,
    data_type,
    is_nullable
FROM information_schema.columns 
WHERE table_schema = 'public' 
AND table_name = 'conductors'
ORDER BY ordinal_position;

-- 4. Verificar dados migrados
SELECT 'TOUR_TYPES' as tabela, count(*) as registos FROM public.tour_types
UNION ALL
SELECT 'CONDUCTORS' as tabela, count(*) as registos FROM public.conductors  
UNION ALL
SELECT 'RESERVATIONS' as tabela, count(*) as registos FROM public.reservations
UNION ALL
SELECT 'PROFILES' as tabela, count(*) as registos FROM public.profiles
UNION ALL
SELECT 'USER_ROLES' as tabela, count(*) as registos FROM public.user_roles
ORDER BY tabela;
