# 🧪 TESTE DE LOGIN - VERIFICAÇÃO DA MIGRAÇÃO

## 🎯 Objetivo
Verificar se os 3 condutores migrados conseguem fazer login na aplicação com as credenciais definidas.

## 🔑 Credenciais para Teste

### 👨‍💼 Super Admin - Carlos Barradas
```
📧 Email: carlosbarradas111@gmail.com
🔐 Password: TukTuk2025!
🎭 Role: super_admin (com todos os roles)
📍 Região: milfontes
⚡ Permissões: Acesso total ao sistema
```

### 👩‍💼 Condutor 2 - Sonia
```
📧 Email: sonia@tuktuk-milfontes.pt
🔐 Password: TukTuk2025!
🎭 Role: conductor
📍 Região: milfontes
```

### 👨‍💼 Condutor 3 - Diogo
```
📧 Email: diogo@tuktuk-milfontes.pt
🔐 Password: TukTuk2025!
🎭 Role: conductor
📍 Região: milfontes
```

## 🌐 Links de Teste

### 🖥️ Aplicação Local
**URL**: http://localhost:8080/
**Status**: ✅ Servidor a correr na porta 8080

### ☁️ Aplicação Produção (se disponível)
**URL**: https://tuktuk-milfontes.vercel.app/
**Status**: ⏳ Para verificar

## 📋 Lista de Verificação por Conta

### ✅ Teste: carlosbarradas111@gmail.com (SUPER ADMIN)
- [ ] **Acesso à página de login** - URL carrega corretamente
- [ ] **Inserir credenciais** - Email e password aceites
- [ ] **Login bem-sucedido** - Redirecionamento após login
- [ ] **Dados do perfil** - Nome "Carlos Barradas (Super Admin)" aparece
- [ ] **Role super_admin** - Interface administrativa completa acessível
- [ ] **Todos os roles** - super_admin, admin_global, admin_local, conductor
- [ ] **Permissões máximas** - Acesso total ao sistema
- [ ] **Dados linkados** - Informações do condutor carregam
- [ ] **Logout** - Processo de logout funciona

### ✅ Teste: sonia@tuktuk-milfontes.pt
- [ ] **Acesso à página de login**
- [ ] **Inserir credenciais**
- [ ] **Login bem-sucedido**
- [ ] **Dados do perfil** - Nome "Sonia" aparece
- [ ] **Role de condutor**
- [ ] **Permissões ativas**
- [ ] **Dados linkados**
- [ ] **Logout**

### ✅ Teste: diogo@tuktuk-milfontes.pt
- [ ] **Acesso à página de login**
- [ ] **Inserir credenciais**
- [ ] **Login bem-sucedido**
- [ ] **Dados do perfil** - Nome "Diogo" aparece
- [ ] **Role de condutor**
- [ ] **Permissões ativas**
- [ ] **Dados linkados**
- [ ] **Logout**

## 🔍 Verificações Técnicas

### 📊 Base de Dados
```sql
-- Verificar se users existem
SELECT email, created_at FROM auth.users 
WHERE email IN (
  'carlosbarradas111@gmail.com',
  'sonia@tuktuk-milfontes.pt', 
  'diogo@tuktuk-milfontes.pt'
);

-- Verificar profiles linkados
SELECT u.email, p.full_name, p.role, p.admin_level 
FROM auth.users u
JOIN public.profiles p ON u.id = p.id
WHERE u.email IN (
  'carlosbarradas111@gmail.com',
  'sonia@tuktuk-milfontes.pt',
  'diogo@tuktuk-milfontes.pt'
);

-- Verificar conductors linkados
SELECT c.name, c.phone, u.email, c.user_id IS NOT NULL as linkado
FROM public.conductors c
LEFT JOIN auth.users u ON c.user_id = u.id
WHERE c.id IN (
  'c2b84b4e-ecbf-47d1-adc0-f3d7549829b3',
  'c4c9a172-92c2-410e-a671-56b443fc093d', 
  'e4b3296c-13eb-4faa-aead-e246ddb2bf66'
);
```

### 🌐 Frontend
```javascript
// Console do browser - verificar autenticação
console.log('Current user:', supabase.auth.getUser());
console.log('Session:', supabase.auth.getSession());

// Verificar se dados carregam
fetch('/api/conductors').then(r => r.json()).then(console.log);
```

## ❌ Possíveis Problemas e Soluções

### 🚨 Problema: "Invalid login credentials"
**Causa**: Users não foram criados no auth.users
**Solução**: 
1. Execute `sql/MIGRACAO-FINAL-DEFINITIVA.sql` no Supabase
2. Ou crie users manualmente no Dashboard

### 🚨 Problema: Login funciona mas dados não carregam
**Causa**: Profiles não linkados ou RLS mal configurado
**Solução**:
1. Verificar se profiles foram criados
2. Verificar políticas RLS

### 🚨 Problema: "Access denied" após login
**Causa**: user_roles não atribuídos ou permissions incorretas
**Solução**:
1. Verificar tabela user_roles
2. Confirmar permissions no profile

### 🚨 Problema: Interface de condutor não aparece
**Causa**: Role não reconhecido ou componentes com erro
**Solução**:
1. Verificar role = 'conductor' no profile
2. Verificar console do browser para erros JS

## 📱 Teste em Diferentes Dispositivos

### 💻 Desktop
- [ ] Chrome/Edge
- [ ] Firefox  
- [ ] Safari (se disponível)

### 📱 Mobile (simulação)
- [ ] DevTools modo mobile
- [ ] Interface responsiva
- [ ] Touch interactions

## 📊 Relatório de Resultados

### ✅ Sucessos
```
[ ] carlosbarradas111@gmail.com - LOGIN OK (SUPER ADMIN)
[ ] sonia@tuktuk-milfontes.pt - LOGIN OK  
[ ] diogo@tuktuk-milfontes.pt - LOGIN OK
[ ] Todos os profiles carregam corretamente
[ ] Permissões corretas por role
[ ] Interface administrativa completa para super admin
[ ] Interface responsiva
```

### ❌ Problemas Encontrados
```
[ ] Problema 1: [Descrição]
[ ] Problema 2: [Descrição]
[ ] Problema 3: [Descrição]
```

### 🔧 Ações Necessárias
```
[ ] Ação 1: [Descrição e prioridade]
[ ] Ação 2: [Descrição e prioridade]  
[ ] Ação 3: [Descrição e prioridade]
```

## 🎯 Critérios de Sucesso

### ✅ Teste Passou Se:
- ✅ **3/3 logins funcionam** sem erros
- ✅ **Dados carregam** corretamente para todos
- ✅ **Permissões ativas** para role conductor
- ✅ **Interface estável** sem crashes
- ✅ **Logout funciona** para todos

### 📈 Próximo Passo:
Se todos os testes passarem → **Passo 2: Enviar credenciais para condutores**

---

**🎮 PRONTO PARA TESTAR! Abra http://localhost:8080/ e comece pelos testes de login!**
