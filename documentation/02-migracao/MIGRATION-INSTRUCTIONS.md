# 🔄 COMANDOS DE MIGRAÇÃO GERADOS AUTOMATICAMENTE

## 📋 PASSO 1: CRIAR USERS NO DASHBOARD
Acesse: https://supabase.com/dashboard/project/iweurnqdomiqlohvaoat/auth/users

### 👤 User 1: Motorista Teste
- **Email:** motorista.teste@tuktuk-milfontes.pt
- **Password:** TukTuk2025!
- **Email Confirmed:** ✅ true
- **User Metadata:** {"full_name": "Motorista Teste", "role": "conductor"}

### 👤 User 2: Sonia  
- **Email:** sonia@tuktuk-milfontes.pt
- **Password:** TukTuk2025!
- **Email Confirmed:** ✅ true
- **User Metadata:** {"full_name": "Sonia", "role": "conductor"}

### 👤 User 3: Diogo
- **Email:** diogo@tuktuk-milfontes.pt
- **Password:** TukTuk2025!
- **Email Confirmed:** ✅ true  
- **User Metadata:** {"full_name": "Diogo", "role": "conductor"}

---

## 📝 PASSO 2: ANOTAR NOVOS UUIDs

Após criar cada user no dashboard, copie os UUIDs gerados e substitua abaixo:

```javascript
const newId1 = 'NOVO_UUID_MOTORISTA_TESTE_AQUI';
const newId2 = 'NOVO_UUID_SONIA_AQUI'; 
const newId3 = 'NOVO_UUID_DIOGO_AQUI';
```

---

## 📊 PASSO 3: EXECUTAR SQL NO PROJETO NOVO

Execute este SQL no SQL Editor do projeto **iweurnqdomiqlohvaoat**:

```sql
-- SUBSTITUIR pelos UUIDs reais gerados no dashboard
-- const newId1 = 'NOVO_UUID_MOTORISTA_TESTE_AQUI';
-- const newId2 = 'NOVO_UUID_SONIA_AQUI';
-- const newId3 = 'NOVO_UUID_DIOGO_AQUI';

-- Criar profiles
INSERT INTO public.profiles (id, email, full_name, role, admin_level, region, permissions, created_at, updated_at) VALUES
('NOVO_UUID_MOTORISTA_TESTE_AQUI', 'motorista.teste@tuktuk-milfontes.pt', 'Motorista Teste', 'conductor', 'admin_local', 'milfontes', '{"conductor": {"can_update_location": true, "can_accept_rides": true}}', now(), now()),
('NOVO_UUID_SONIA_AQUI', 'sonia@tuktuk-milfontes.pt', 'Sonia', 'conductor', 'admin_local', 'milfontes', '{"conductor": {"can_update_location": true, "can_accept_rides": true}}', now(), now()),
('NOVO_UUID_DIOGO_AQUI', 'diogo@tuktuk-milfontes.pt', 'Diogo', 'conductor', 'admin_local', 'milfontes', '{"conductor": {"can_update_location": true, "can_accept_rides": true}}', now(), now());

-- Criar user_roles
INSERT INTO public.user_roles (user_id, role, created_at, updated_at) VALUES
('NOVO_UUID_MOTORISTA_TESTE_AQUI', 'conductor', now(), now()),
('NOVO_UUID_SONIA_AQUI', 'conductor', now(), now()),
('NOVO_UUID_DIOGO_AQUI', 'conductor', now(), now());

-- Atualizar conductors com novos user_ids
UPDATE public.conductors SET user_id = 'NOVO_UUID_MOTORISTA_TESTE_AQUI' WHERE id = 'c2b84b4e-ecbf-47d1-adc0-f3d7549829b3';
UPDATE public.conductors SET user_id = 'NOVO_UUID_SONIA_AQUI' WHERE id = 'c4c9a172-92c2-410e-a671-56b443fc093d';
UPDATE public.conductors SET user_id = 'NOVO_UUID_DIOGO_AQUI' WHERE id = 'e4b3296c-13eb-4faa-aead-e246ddb2bf66';
```

---

## 🧪 PASSO 4: VALIDAR MIGRAÇÃO

Execute para verificar se tudo funcionou:

```sql
SELECT 
    c.name as conductor_name,
    c.whatsapp, 
    u.email as auth_email,
    p.full_name as profile_name,
    ur.role as user_role,
    c.is_active
FROM public.conductors c
LEFT JOIN auth.users u ON c.user_id = u.id
LEFT JOIN public.profiles p ON c.user_id = p.id  
LEFT JOIN public.user_roles ur ON c.user_id = ur.user_id
WHERE c.is_active = true
ORDER BY c.name;
```

---

## ✅ RESULTADO ESPERADO:

| conductor_name | whatsapp | auth_email | profile_name | user_role | is_active |
|---|---|---|---|---|---|
| Diogo | 351963496320 | diogo@tuktuk-milfontes.pt | Diogo | conductor | true |
| Motorista Teste | 351965748022 | motorista.teste@tuktuk-milfontes.pt | Motorista Teste | conductor | true |
| Sonia | 351968784043 | sonia@tuktuk-milfontes.pt | Sonia | conductor | true |

---

## 🎉 MIGRAÇÃO COMPLETA!

Após executar todos os passos:
- ✅ 3 auth.users criados
- ✅ 3 profiles criados  
- ✅ 3 user_roles definidos
- ✅ 3 conductors linkados aos novos users
- ✅ Sistema pronto para login

**Tempo estimado total: 10-15 minutos** ⏱️
