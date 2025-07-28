-- ========================================
-- ENCONTRAR OS UUIDs DOS USERS CRIADOS
-- ========================================
-- Execute primeiro esta query para ver os UUIDs dos users:

SELECT 
    'USERS CRIADOS:' as info,
    id as uuid_real,
    email,
    created_at,
    'Copie este UUID!' as instrucao
FROM auth.users 
WHERE email IN (
    'motorista.teste@tuktuk-milfontes.pt',
    'sonia@tuktuk-milfontes.pt', 
    'diogo@tuktuk-milfontes.pt'
)
ORDER BY email;

-- ========================================
-- DEPOIS DE VER OS UUIDs, SUBSTITUA NO SCRIPT ABAIXO:
-- ========================================

-- TEMPLATE PARA COPIAR E SUBSTITUIR:
-- 
-- INSERT INTO public.profiles (id, email, full_name, role, admin_level, region, permissions, created_at, updated_at) VALUES
-- ('[UUID_DO_MOTORISTA_TESTE]', 'motorista.teste@tuktuk-milfontes.pt', 'Motorista Teste', 'conductor', 'admin_local', 'milfontes', '{"conductor": {"can_update_location": true}}', now(), now()),
-- ('[UUID_DA_SONIA]', 'sonia@tuktuk-milfontes.pt', 'Sonia', 'conductor', 'admin_local', 'milfontes', '{"conductor": {"can_update_location": true}}', now(), now()),
-- ('[UUID_DO_DIOGO]', 'diogo@tuktuk-milfontes.pt', 'Diogo', 'conductor', 'admin_local', 'milfontes', '{"conductor": {"can_update_location": true}}', now(), now());
-- 
-- INSERT INTO public.user_roles (user_id, role, created_at, updated_at) VALUES
-- ('[UUID_DO_MOTORISTA_TESTE]', 'conductor', now(), now()),
-- ('[UUID_DA_SONIA]', 'conductor', now(), now()),
-- ('[UUID_DO_DIOGO]', 'conductor', now(), now());
-- 
-- UPDATE public.conductors SET user_id = '[UUID_DO_MOTORISTA_TESTE]' WHERE id = 'c2b84b4e-ecbf-47d1-adc0-f3d7549829b3';
-- UPDATE public.conductors SET user_id = '[UUID_DA_SONIA]' WHERE id = 'c4c9a172-92c2-410e-a671-56b443fc093d';
-- UPDATE public.conductors SET user_id = '[UUID_DO_DIOGO]' WHERE id = 'e4b3296c-13eb-4faa-aead-e246ddb2bf66';
