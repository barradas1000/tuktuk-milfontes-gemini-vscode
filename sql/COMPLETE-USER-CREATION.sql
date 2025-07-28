-- ========================================
-- CRIAÇÃO COMPLETA DE USUÁRIOS - ESTRUTURA SUPABASE
-- ========================================

-- PASSO 1: Verificar estrutura atual da tabela
-- Execute debug-auth.sql para ver as colunas da tabela auth.users

-- PASSO 2: Criar usuários com estrutura completa
DO $$
DECLARE
    user1_id uuid := gen_random_uuid();
    user2_id uuid := gen_random_uuid();
    user3_id uuid := gen_random_uuid();
    password_hash text;
BEGIN
    -- Gerar hash da password provisória
    password_hash := crypt('TukTuk2025!', gen_salt('bf'));
    
    -- Desabilitar RLS temporariamente (se necessário)
    -- SET session_replication_role = replica;
    
    BEGIN
        -- User 1: Motorista Teste
        INSERT INTO auth.users (
            instance_id,
            id,
            aud,
            role,
            email,
            encrypted_password,
            email_confirmed_at,
            invited_at,
            confirmation_token,
            confirmation_sent_at,
            raw_app_meta_data,
            raw_user_meta_data,
            is_super_admin,
            created_at,
            updated_at
        ) VALUES (
            '00000000-0000-0000-0000-000000000000'::uuid,
            user1_id,
            'authenticated',
            'authenticated',
            'motorista.teste@tuktuk-milfontes.pt',
            password_hash,
            now(),
            now(),
            '',
            now(),
            '{"provider": "email", "providers": ["email"]}',
            '{}',
            false,
            now(),
            now()
        );

        -- User 2: Sonia  
        INSERT INTO auth.users (
            instance_id,
            id,
            aud,
            role,
            email,
            encrypted_password,
            email_confirmed_at,
            invited_at,
            confirmation_token,
            confirmation_sent_at,
            raw_app_meta_data,
            raw_user_meta_data,
            is_super_admin,
            created_at,
            updated_at
        ) VALUES (
            '00000000-0000-0000-0000-000000000000'::uuid,
            user2_id,
            'authenticated',
            'authenticated',
            'sonia@tuktuk-milfontes.pt',
            password_hash,
            now(),
            now(),
            '',
            now(),
            '{"provider": "email", "providers": ["email"]}',
            '{}',
            false,
            now(),
            now()
        );

        -- User 3: Diogo
        INSERT INTO auth.users (
            instance_id,
            id,
            aud,
            role,
            email,
            encrypted_password,
            email_confirmed_at,
            invited_at,
            confirmation_token,
            confirmation_sent_at,
            raw_app_meta_data,
            raw_user_meta_data,
            is_super_admin,
            created_at,
            updated_at
        ) VALUES (
            '00000000-0000-0000-0000-000000000000'::uuid,
            user3_id,
            'authenticated',
            'authenticated',
            'diogo@tuktuk-milfontes.pt',
            password_hash,
            now(),
            now(),
            '',
            now(),
            '{"provider": "email", "providers": ["email"]}',
            '{}',
            false,
            now(),
            now()
        );

        RAISE NOTICE 'USUÁRIOS CRIADOS COM SUCESSO!';
        RAISE NOTICE 'Password provisória: TukTuk2025!';
        
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'ERRO: %', SQLERRM;
    END;
    
    -- Reabilitar RLS
    -- SET session_replication_role = DEFAULT;
END $$;

-- PASSO 3: Verificar se funcionou
SELECT 
    'VERIFICAÇÃO DE USUÁRIOS:' as status,
    count(*) as total_criados
FROM auth.users 
WHERE email IN (
    'motorista.teste@tuktuk-milfontes.pt',
    'sonia@tuktuk-milfontes.pt', 
    'diogo@tuktuk-milfontes.pt'
);

-- PASSO 4: Ver detalhes dos usuários criados
SELECT 
    id,
    email,
    email_confirmed_at,
    created_at,
    'USUÁRIO CRIADO!' as status
FROM auth.users 
WHERE email IN (
    'motorista.teste@tuktuk-milfontes.pt',
    'sonia@tuktuk-milfontes.pt', 
    'diogo@tuktuk-milfontes.pt'
)
ORDER BY email;

-- ========================================
-- SE OS USUÁRIOS FORAM CRIADOS, EXECUTE A MIGRAÇÃO COMPLETA:
-- ========================================

-- Descomente e execute após confirmar que os users existem:

-- Criar profiles
INSERT INTO public.profiles (id, email, full_name, role, admin_level, region, permissions, created_at, updated_at)
SELECT 
    u.id,
    u.email,
    CASE 
        WHEN u.email = 'motorista.teste@tuktuk-milfontes.pt' THEN 'Motorista Teste'
        WHEN u.email = 'sonia@tuktuk-milfontes.pt' THEN 'Sonia'
        WHEN u.email = 'diogo@tuktuk-milfontes.pt' THEN 'Diogo'
    END as full_name,
    'conductor' as role,
    'admin_local' as admin_level,
    'milfontes' as region,
    '{"conductor": {"can_update_location": true}}'::jsonb as permissions,
    now() as created_at,
    now() as updated_at
FROM auth.users u
WHERE u.email IN (
    'motorista.teste@tuktuk-milfontes.pt',
    'sonia@tuktuk-milfontes.pt', 
    'diogo@tuktuk-milfontes.pt'
)
ON CONFLICT (id) DO NOTHING;

-- Criar user_roles  
INSERT INTO public.user_roles (user_id, role, created_at, updated_at)
SELECT 
    u.id,
    'conductor' as role,
    now() as created_at,
    now() as updated_at
FROM auth.users u
WHERE u.email IN (
    'motorista.teste@tuktuk-milfontes.pt',
    'sonia@tuktuk-milfontes.pt', 
    'diogo@tuktuk-milfontes.pt'
)
AND u.id NOT IN (
    SELECT user_id FROM public.user_roles WHERE role = 'conductor' AND user_id IS NOT NULL
);

-- Linkar conductors aos users
UPDATE public.conductors 
SET user_id = (SELECT u.id FROM auth.users u WHERE u.email = 'motorista.teste@tuktuk-milfontes.pt')
WHERE id = 'c2b84b4e-ecbf-47d1-adc0-f3d7549829b3';

UPDATE public.conductors 
SET user_id = (SELECT u.id FROM auth.users u WHERE u.email = 'sonia@tuktuk-milfontes.pt')
WHERE id = 'c4c9a172-92c2-410e-a671-56b443fc093d';

UPDATE public.conductors 
SET user_id = (SELECT u.id FROM auth.users u WHERE u.email = 'diogo@tuktuk-milfontes.pt')
WHERE id = 'e4b3296c-13eb-4faa-aead-e246ddb2bf66';

-- Verificação final
SELECT 'MIGRAÇÃO 100% COMPLETA!' as resultado;

-- Execute verificacao-corrigida.sql para confirmar que funcionou
