# 🔄 EXPORTAÇÃO MANUAL DE USERS - GUIA COMPLETO

## 📋 **OPÇÕES DE EXPORTAÇÃO MANUAL**

### **OPÇÃO 1: Via Dashboard Supabase (Mais Fácil)**

#### 🔍 **1.1 Extrair dados do projeto antigo:**
1. Aceder: https://supabase.com/dashboard/project/cqnahwnnqzraqcslljaz/auth/users
2. **Ver todos os users** existentes
3. **Copiar manualmente** os dados de cada user:
   - Email
   - Data de criação
   - Status de confirmação
   - Metadata (se existir)

#### ➕ **1.2 Criar users no projeto novo:**
1. Aceder: https://supabase.com/dashboard/project/iweurnqdomiqlohvaoat/auth/users
2. Para cada user, clicar **"Add user"**
3. **Preencher dados** copiados do projeto antigo
4. **Definir password temporária** (users podem alterar depois)

---

### **OPÇÃO 2: Via SQL Export/Import (Técnico)**

#### 🔍 **2.1 Exportar do projeto antigo:**
```sql
-- Execute no SQL Editor do projeto ANTIGO
-- https://supabase.com/dashboard/project/cqnahwnnqzraqcslljaz/sql

SELECT 
    id,
    email,
    encrypted_password,
    email_confirmed_at,
    created_at,
    updated_at,
    raw_user_meta_data,
    raw_app_meta_data,
    is_super_admin,
    role
FROM auth.users 
ORDER BY created_at;

-- Também exportar profiles associados
SELECT 
    id,
    email,
    full_name,
    role,
    admin_level,
    region,
    permissions,
    created_at,
    updated_at
FROM public.profiles 
ORDER BY created_at;
```

#### 📥 **2.2 Resultado esperado:**
- **Lista de todos os users** com dados completos
- **Profiles associados** (se existirem)
- **Metadata personalizada** preservada

---

### **OPÇÃO 3: Via API Supabase (Programático)**

#### 🔧 **3.1 Script para extrair users:**
```javascript
// Execute no console do browser no projeto antigo
const SUPABASE_URL = 'https://cqnahwnnqzraqcslljaz.supabase.co'
const SUPABASE_ANON_KEY = 'sua-anon-key-aqui'

fetch(`${SUPABASE_URL}/auth/v1/admin/users`, {
  headers: {
    'Authorization': `Bearer sua-service-key-aqui`,
    'Content-Type': 'application/json'
  }
})
.then(res => res.json())
.then(users => {
  console.log('Users encontrados:', users)
  // Copiar resultado para usar no projeto novo
})
```

---

### **OPÇÃO 4: Export via pgAdmin/psql (Avançado)**

#### 🛠️ **4.1 Conexão direta à base de dados:**
```bash
# Conectar ao projeto antigo
psql "postgresql://postgres:[password]@db.cqnahwnnqzraqcslljaz.supabase.co:5432/postgres"

# Exportar users
\copy (SELECT id, email, encrypted_password, email_confirmed_at, created_at, raw_user_meta_data FROM auth.users) TO 'users_export.csv' CSV HEADER;

# Exportar profiles  
\copy (SELECT id, email, full_name, role, admin_level, region FROM public.profiles) TO 'profiles_export.csv' CSV HEADER;
```

---

## 🎯 **RECOMENDAÇÃO: OPÇÃO 1 (Dashboard)**

### **Por que é a melhor:**
- ✅ **Mais segura** - Sem exposição de passwords
- ✅ **Mais simples** - Interface visual
- ✅ **Menos erros** - Validação automática
- ✅ **Auditável** - Histórico no dashboard

### **Passos detalhados:**

#### **PASSO 1: Inventariar users do projeto antigo**
1. Aceder: https://supabase.com/dashboard/project/cqnahwnnqzraqcslljaz/auth/users
2. **Anotar para cada user:**
   ```
   User 1:
   - Email: [copiar]
   - Created: [copiar data]
   - Confirmed: [sim/não]
   - Last sign in: [copiar data]
   
   User 2:
   - Email: [copiar]
   - Created: [copiar data]
   - Confirmed: [sim/não]
   - Last sign in: [copiar data]
   ```

#### **PASSO 2: Criar users no projeto novo**
1. Aceder: https://supabase.com/dashboard/project/iweurnqdomiqlohvaoat/auth/users
2. Para cada user anotado:
   - Clicar **"Add user"**
   - **Email:** [colar email copiado]
   - **Password:** `TukTuk2025!` (temporária)
   - **Confirm email:** ✅ true
   - **User metadata:** (copiar se existir)

#### **PASSO 3: Anotar novos UUIDs**
```
MAPEAMENTO:
Projeto Antigo → Projeto Novo
user-uuid-1   → novo-uuid-1
user-uuid-2   → novo-uuid-2  
user-uuid-3   → novo-uuid-3
```

#### **PASSO 4: Atualizar referências**
- Executar `MIGRATION-COMPLETE-SCRIPT.sql` com novos UUIDs
- Atualizar tabela `conductors` 
- Criar `profiles` e `user_roles`

---

## ⚡ **QUER FAZER AGORA?**

Posso ajudar a:
1. **🔍 Extrair dados** do projeto antigo via SQL
2. **📋 Criar checklist** personalizado  
3. **🤖 Automatizar** parte do processo
4. **✅ Validar** migração após execução

**Qual opção prefere tentar primeiro?**
