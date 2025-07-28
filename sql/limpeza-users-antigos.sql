-- ========================================
-- 🧹 LIMPEZA DE USERS ANTIGOS
-- ========================================
-- Remove users antigos e dados associados

-- ⚠️ EXECUTE ANTES DA MIGRAÇÃO FINAL

-- 1. Verificar users existentes (incluindo antigos)
SELECT 
    'TODOS OS USERS' as verificacao,
    email, 
    created_at,
    email_confirmed_at IS NOT NULL as email_confirmado,
    id
FROM auth.users 
ORDER BY email;

-- 2. Identificar user antigo para remoção
SELECT 
    'USER ANTIGO PARA REMOVER' as verificacao,
    email,
    id
FROM auth.users 
WHERE email = 'motorista.teste@tuktuk-milfontes.pt';

-- 3. Remover dados associados ao user antigo
-- (Execute apenas se o user existir)

-- 3A. Remover roles do user antigo
DELETE FROM public.user_roles 
WHERE user_id IN (
    SELECT id FROM auth.users 
    WHERE email = 'motorista.teste@tuktuk-milfontes.pt'
);

-- 3B. Remover profile do user antigo  
DELETE FROM public.profiles
WHERE id IN (
    SELECT id FROM auth.users 
    WHERE email = 'motorista.teste@tuktuk-milfontes.pt'
);

-- 3C. Atualizar conductors que referenciam o user antigo
UPDATE public.conductors 
SET user_id = NULL
WHERE user_id IN (
    SELECT id FROM auth.users 
    WHERE email = 'motorista.teste@tuktuk-milfontes.pt'
);

-- 3D. Remover o user antigo da tabela auth.users
DELETE FROM auth.users 
WHERE email = 'motorista.teste@tuktuk-milfontes.pt';

-- 4. Verificação final - deve mostrar apenas os 3 users corretos
SELECT 
    'USERS FINAIS' as verificacao,
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

-- 5. Verificar se não há mais nenhum user antigo
SELECT 
    'VERIFICACAO COMPLETA' as status,
    count(*) as total_users
FROM auth.users;
