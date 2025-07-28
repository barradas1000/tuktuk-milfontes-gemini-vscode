-- ========================================
-- VERIFICAÇÃO COMPLETA PÓS-MIGRAÇÃO (SEM EMOJIS)
-- ========================================

-- Execute este script no projeto Supabase de DESTINO para verificar se a migração foi bem-sucedida

-- 1. Verificar auth.users
SELECT 
    'AUTH_USERS' as secao,
    id,
    email,
    created_at,
    'OK' as status
FROM auth.users 
WHERE email IN (
    'motorista.teste@tuktuk-milfontes.pt',
    'sonia@tuktuk-milfontes.pt', 
    'diogo@tuktuk-milfontes.pt'
)
ORDER BY email;

-- 2. Verificar profiles
SELECT 
    'PROFILES' as secao,
    p.id,
    p.email,
    p.full_name,
    p.role,
    p.admin_level,
    p.region,
    'OK' as status
FROM public.profiles p
JOIN auth.users u ON p.id = u.id
WHERE u.email IN (
    'motorista.teste@tuktuk-milfontes.pt',
    'sonia@tuktuk-milfontes.pt', 
    'diogo@tuktuk-milfontes.pt'
)
ORDER BY p.email;

-- 3. Verificar user_roles
SELECT 
    'USER_ROLES' as secao,
    ur.user_id,
    u.email,
    ur.role,
    ur.created_at,
    'OK' as status
FROM public.user_roles ur
JOIN auth.users u ON ur.user_id = u.id
WHERE u.email IN (
    'motorista.teste@tuktuk-milfontes.pt',
    'sonia@tuktuk-milfontes.pt', 
    'diogo@tuktuk-milfontes.pt'
)
ORDER BY u.email;

-- 4. Verificar conductors linkados
SELECT 
    'CONDUCTORS' as secao,
    c.id as conductor_id,
    c.name,
    c.user_id,
    u.email as auth_email,
    CASE 
        WHEN c.user_id = u.id THEN 'LINKADO'
        ELSE 'NAO_LINKADO'
    END as link_status
FROM public.conductors c
LEFT JOIN auth.users u ON c.user_id = u.id
WHERE c.id IN (
    'c2b84b4e-ecbf-47d1-adc0-f3d7549829b3',
    'c4c9a172-92c2-410e-a671-56b443fc093d',
    'e4b3296c-13eb-4faa-aead-e246ddb2bf66'
)
ORDER BY c.name;

-- 5. Verificação final integrada
SELECT 
    'VERIFICACAO_FINAL' as secao,
    c.name as condutor,
    u.email as email_auth,
    p.full_name as nome_profile,
    ur.role as role_user,
    CASE 
        WHEN c.user_id IS NOT NULL 
         AND p.id IS NOT NULL 
         AND ur.user_id IS NOT NULL 
         AND c.user_id = u.id 
         AND p.id = u.id 
         AND ur.user_id = u.id THEN 'MIGRACAO_COMPLETA'
        ELSE 'MIGRACAO_INCOMPLETA'
    END as status_final
FROM public.conductors c
LEFT JOIN auth.users u ON c.user_id = u.id
LEFT JOIN public.profiles p ON c.user_id = p.id
LEFT JOIN public.user_roles ur ON c.user_id = ur.user_id
WHERE c.id IN (
    'c2b84b4e-ecbf-47d1-adc0-f3d7549829b3',
    'c4c9a172-92c2-410e-a671-56b443fc093d',
    'e4b3296c-13eb-4faa-aead-e246ddb2bf66'
)
ORDER BY c.name;

-- 6. Contadores finais
SELECT 
    'ESTATISTICAS' as secao,
    'AUTH_USERS' as tabela,
    count(*) as registros
FROM auth.users 
WHERE email IN (
    'motorista.teste@tuktuk-milfontes.pt',
    'sonia@tuktuk-milfontes.pt', 
    'diogo@tuktuk-milfontes.pt'
)

UNION ALL

SELECT 
    'ESTATISTICAS' as secao,
    'PROFILES' as tabela,
    count(*) as registros
FROM public.profiles p
JOIN auth.users u ON p.id = u.id
WHERE u.email IN (
    'motorista.teste@tuktuk-milfontes.pt',
    'sonia@tuktuk-milfontes.pt', 
    'diogo@tuktuk-milfontes.pt'
)

UNION ALL

SELECT 
    'ESTATISTICAS' as secao,
    'USER_ROLES' as tabela,
    count(*) as registros
FROM public.user_roles ur
JOIN auth.users u ON ur.user_id = u.id
WHERE u.email IN (
    'motorista.teste@tuktuk-milfontes.pt',
    'sonia@tuktuk-milfontes.pt', 
    'diogo@tuktuk-milfontes.pt'
)

UNION ALL

SELECT 
    'ESTATISTICAS' as secao,
    'CONDUCTORS_LINKADOS' as tabela,
    count(*) as registros
FROM public.conductors c
WHERE c.user_id IS NOT NULL 
AND c.id IN (
    'c2b84b4e-ecbf-47d1-adc0-f3d7549829b3',
    'c4c9a172-92c2-410e-a671-56b443fc093d',
    'e4b3296c-13eb-4faa-aead-e246ddb2bf66'
);

-- Resultado esperado: 3 registros em cada tabela para migração completa
