-- ========================================
-- 🎯 MIGRAÇÃO FINAL TUKTUK MILFONTES - SCRIPT DEFINITIVO
-- ========================================
-- Este é o ÚNICO script necessário para completar a migração dos users
-- Substitui todos os outros scripts de migração de users

-- ⚠️ IMPORTANTE: Execute no projeto DESTINO (iweurnqdomiqlohvaoat)
-- 📋 PRÉ-REQUISITOS: Schema migrado + dados migrados + users criados no Dashboard

-- ========================================
-- OPÇÃO 1: CRIAÇÃO AUTOMÁTICA DE USERS (EXPERIMENTAL)
-- ========================================

DO $$
DECLARE
    users_existing integer;
    user1_id uuid := gen_random_uuid();
    user2_id uuid := gen_random_uuid(); 
    user3_id uuid := gen_random_uuid();
BEGIN
    -- Verificar se users já existem
    SELECT count(*) INTO users_existing
    FROM auth.users 
    WHERE email IN (
        'carlosbarradas111@gmail.com',
        'sonia@tuktuk-milfontes.pt',
        'diogo@tuktuk-milfontes.pt'
    );
    
    IF users_existing = 0 THEN
        RAISE NOTICE 'Tentando criar users automaticamente...';
        
        BEGIN
            INSERT INTO auth.users (
                instance_id, id, aud, role, email, encrypted_password,
                email_confirmed_at, invited_at, confirmation_token, 
                confirmation_sent_at, raw_app_meta_data, raw_user_meta_data,
                is_super_admin, created_at, updated_at
            ) VALUES 
            (
                '00000000-0000-0000-0000-000000000000'::uuid, user1_id,
                'authenticated', 'authenticated', 'carlosbarradas111@gmail.com',
                crypt('TukTuk2025!', gen_salt('bf')), now(), now(), '', now(),
                '{"provider":"email","providers":["email"]}', '{}', true, now(), now()
            ),
            (
                '00000000-0000-0000-0000-000000000000'::uuid, user2_id,
                'authenticated', 'authenticated', 'sonia@tuktuk-milfontes.pt',
                crypt('TukTuk2025!', gen_salt('bf')), now(), now(), '', now(),
                '{"provider":"email","providers":["email"]}', '{}', false, now(), now()
            ),
            (
                '00000000-0000-0000-0000-000000000000'::uuid, user3_id,
                'authenticated', 'authenticated', 'diogo@tuktuk-milfontes.pt',
                crypt('TukTuk2025!', gen_salt('bf')), now(), now(), '', now(),
                '{"provider":"email","providers":["email"]}', '{}', false, now(), now()
            );
            
            RAISE NOTICE '✅ USERS CRIADOS AUTOMATICAMENTE!';
            
        EXCEPTION WHEN OTHERS THEN
            RAISE NOTICE '❌ Criação automática falhou: %', SQLERRM;
            RAISE NOTICE '👉 CRIE OS USERS VIA DASHBOARD:';
            RAISE NOTICE '   1. Acesse: https://supabase.com/dashboard/project/iweurnqdomiqlohvaoat';
            RAISE NOTICE '   2. Authentication → Users → Add User';
            RAISE NOTICE '   3. Email: carlosbarradas111@gmail.com | Password: TukTuk2025!';
            RAISE NOTICE '   4. Email: sonia@tuktuk-milfontes.pt | Password: TukTuk2025!';
            RAISE NOTICE '   5. Email: diogo@tuktuk-milfontes.pt | Password: TukTuk2025!';
            RAISE NOTICE '   6. Execute este script novamente após criar';
        END;
    ELSE
        RAISE NOTICE '✅ USERS JÁ EXISTEM (%)', users_existing;
    END IF;
END $$;

-- ========================================
-- MIGRAÇÃO COMPLETA: PROFILES + USER_ROLES + LINKAGEM
-- ========================================

-- PASSO 1: Criar profiles automaticamente
INSERT INTO public.profiles (id, email, full_name, role, admin_level, region, permissions, created_at, updated_at)
SELECT 
    u.id,
    u.email,
    CASE 
        WHEN u.email = 'carlosbarradas111@gmail.com' THEN 'Carlos Barradas (Super Admin)'
        WHEN u.email = 'sonia@tuktuk-milfontes.pt' THEN 'Sonia'
        WHEN u.email = 'diogo@tuktuk-milfontes.pt' THEN 'Diogo'
    END as full_name,
    CASE 
        WHEN u.email = 'carlosbarradas111@gmail.com' THEN 'super_admin'
        ELSE 'conductor'
    END as role,
    CASE 
        WHEN u.email = 'carlosbarradas111@gmail.com' THEN 'super_admin'
        ELSE 'admin_local'
    END as admin_level,
    'milfontes' as region,
    CASE 
        WHEN u.email = 'carlosbarradas111@gmail.com' THEN '{"super_admin": {"full_access": true}, "admin": {"manage_all": true}, "conductor": {"can_update_location": true}}'::jsonb
        ELSE '{"conductor": {"can_update_location": true}}'::jsonb
    END as permissions,
    now() as created_at,
    now() as updated_at
FROM auth.users u
WHERE u.email IN (
    'carlosbarradas111@gmail.com',
    'sonia@tuktuk-milfontes.pt',
    'diogo@tuktuk-milfontes.pt'
)
ON CONFLICT (id) DO NOTHING;

-- PASSO 2: Criar user_roles automaticamente
INSERT INTO public.user_roles (user_id, role, created_at, updated_at)
SELECT 
    u.id,
    CASE 
        WHEN u.email = 'carlosbarradas111@gmail.com' THEN 'super_admin'
        ELSE 'conductor'
    END as role,
    now() as created_at,
    now() as updated_at
FROM auth.users u
WHERE u.email IN (
    'carlosbarradas111@gmail.com',
    'sonia@tuktuk-milfontes.pt',
    'diogo@tuktuk-milfontes.pt'
)
AND u.id NOT IN (
    SELECT user_id FROM public.user_roles 
    WHERE user_id IS NOT NULL
);

-- PASSO 2B: Adicionar todos os roles para o super admin
INSERT INTO public.user_roles (user_id, role, created_at, updated_at)
SELECT 
    u.id,
    role_name,
    now() as created_at,
    now() as updated_at
FROM auth.users u
CROSS JOIN (VALUES ('admin_global'), ('admin_local'), ('conductor')) AS roles(role_name)
WHERE u.email = 'carlosbarradas111@gmail.com'
AND NOT EXISTS (
    SELECT 1 FROM public.user_roles ur 
    WHERE ur.user_id = u.id AND ur.role = roles.role_name
);

-- PASSO 3: Linkar conductors aos users
UPDATE public.conductors 
SET user_id = (
    SELECT u.id FROM auth.users u 
    WHERE u.email = 'carlosbarradas111@gmail.com'
)
WHERE id = 'c2b84b4e-ecbf-47d1-adc0-f3d7549829b3';

UPDATE public.conductors 
SET user_id = (
    SELECT u.id FROM auth.users u 
    WHERE u.email = 'sonia@tuktuk-milfontes.pt'
)
WHERE id = 'c4c9a172-92c2-410e-a671-56b443fc093d';

UPDATE public.conductors 
SET user_id = (
    SELECT u.id FROM auth.users u 
    WHERE u.email = 'diogo@tuktuk-milfontes.pt'
)
WHERE id = 'e4b3296c-13eb-4faa-aead-e246ddb2bf66';

-- ========================================
-- VERIFICAÇÃO FINAL AUTOMÁTICA
-- ========================================

-- Estatísticas da migração
SELECT 
    'ESTATÍSTICAS FINAIS' as secao,
    (SELECT count(*) FROM auth.users WHERE email IN ('carlosbarradas111@gmail.com','sonia@tuktuk-milfontes.pt','diogo@tuktuk-milfontes.pt')) as users_criados,
    (SELECT count(*) FROM public.profiles WHERE email IN ('carlosbarradas111@gmail.com','sonia@tuktuk-milfontes.pt','diogo@tuktuk-milfontes.pt')) as profiles_criados,
    (SELECT count(*) FROM public.user_roles ur JOIN auth.users u ON ur.user_id = u.id WHERE u.email IN ('carlosbarradas111@gmail.com','sonia@tuktuk-milfontes.pt','diogo@tuktuk-milfontes.pt')) as user_roles_criados,
    (SELECT count(*) FROM public.conductors WHERE user_id IS NOT NULL AND id IN ('c2b84b4e-ecbf-47d1-adc0-f3d7549829b3','c4c9a172-92c2-410e-a671-56b443fc093d','e4b3296c-13eb-4faa-aead-e246ddb2bf66')) as conductors_linkados;

-- Status detalhado por condutor
SELECT 
    'STATUS INDIVIDUAL' as secao,
    c.name as condutor,
    u.email as email_auth,
    p.full_name as profile_nome,
    ur.role as user_role,
    CASE 
        WHEN c.user_id IS NOT NULL AND p.id IS NOT NULL AND ur.user_id IS NOT NULL 
        THEN '✅ MIGRAÇÃO COMPLETA'
        ELSE '❌ MIGRAÇÃO INCOMPLETA'
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

-- Credenciais de acesso
SELECT 
    'CREDENCIAIS DE ACESSO' as info,
    u.email,
    'TukTuk2025!' as password_temporaria,
    'Solicitar redefinição no primeiro login' as instrucoes
FROM auth.users u
WHERE u.email IN (
    'carlosbarradas111@gmail.com',
    'sonia@tuktuk-milfontes.pt',
    'diogo@tuktuk-milfontes.pt'
)
ORDER BY u.email;

-- Resultado final
SELECT 
    CASE 
        WHEN (
            SELECT count(*) FROM auth.users 
            WHERE email IN ('carlosbarradas111@gmail.com','sonia@tuktuk-milfontes.pt','diogo@tuktuk-milfontes.pt')
        ) = 3
        AND (
            SELECT count(*) FROM public.profiles 
            WHERE email IN ('carlosbarradas111@gmail.com','sonia@tuktuk-milfontes.pt','diogo@tuktuk-milfontes.pt')
        ) = 3
        AND (
            SELECT count(*) FROM public.conductors 
            WHERE user_id IS NOT NULL 
            AND id IN ('c2b84b4e-ecbf-47d1-adc0-f3d7549829b3','c4c9a172-92c2-410e-a671-56b443fc093d','e4b3296c-13eb-4faa-aead-e246ddb2bf66')
        ) = 3
        THEN '🎉 MIGRAÇÃO 100% COMPLETA! SISTEMA PRONTO! 🎉'
        ELSE '⚠️ MIGRAÇÃO INCOMPLETA - VERIFIQUE STATUS ACIMA'
    END as resultado_final;

-- ========================================
-- PRÓXIMOS PASSOS PÓS-MIGRAÇÃO
-- ========================================

/*
🎯 MIGRAÇÃO COMPLETA! PRÓXIMOS PASSOS:

1. ✅ Testar login na aplicação:
   - carlosbarradas111@gmail.com / TukTuk2025! (SUPER ADMIN)
   - sonia@tuktuk-milfontes.pt / TukTuk2025!
   - diogo@tuktuk-milfontes.pt / TukTuk2025!

2. 📧 Enviar credenciais para condutores

3. 🔄 Implementar sistema de convites para novos condutores

4. 🧪 Testar todas as funcionalidades

5. 🗑️ Desativar projeto antigo após confirmação

6. 🔐 Solicitar redefinição de passwords no primeiro login
*/

-- Conteúdo do arquivo: sql/MIGRACAO-FINAL-DEFINITIVA.sql
