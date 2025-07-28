# 📋 TEMPLATE PARA CRIAÇÃO MANUAL DE USERS

## 🎯 **INSTRUÇÕES RÁPIDAS:**

### **PASSO 1: Extrair dados do projeto antigo**
1. Aceder: https://supabase.com/dashboard/project/cqnahwnnqzraqcslljaz/sql
2. Executar o script: `EXTRACT-USERS-ANTIGO.sql`
3. Copiar resultados abaixo

### **PASSO 2: Preencher template com dados reais**

#### **👤 USER 1 - Motorista Teste**
```
DADOS DO PROJETO ANTIGO:
- ID Antigo: c2b84b4e-ecbf-47d1-adc0-f3d7549829b3
- Email: [PREENCHER COM RESULTADO DA QUERY]
- Created: [PREENCHER COM RESULTADO DA QUERY]
- Email Confirmed: [PREENCHER COM RESULTADO DA QUERY]
- Last Sign In: [PREENCHER COM RESULTADO DA QUERY]
- Metadata: [PREENCHER COM RESULTADO DA QUERY]

CRIAR NO PROJETO NOVO:
- Email: [COPIAR DO ACIMA]
- Password: TukTuk2025!
- Email Confirmed: ✅ true
- User Metadata: [COPIAR DO ACIMA]

NOVO UUID GERADO: [ANOTAR AQUI APÓS CRIAR]
```

#### **👤 USER 2 - Sonia**
```
DADOS DO PROJETO ANTIGO:
- ID Antigo: c4c9a172-92c2-410e-a671-56b443fc093d
- Email: [PREENCHER COM RESULTADO DA QUERY]
- Created: [PREENCHER COM RESULTADO DA QUERY]
- Email Confirmed: [PREENCHER COM RESULTADO DA QUERY]
- Last Sign In: [PREENCHER COM RESULTADO DA QUERY]
- Metadata: [PREENCHER COM RESULTADO DA QUERY]

CRIAR NO PROJETO NOVO:
- Email: [COPIAR DO ACIMA]
- Password: TukTuk2025!
- Email Confirmed: ✅ true
- User Metadata: [COPIAR DO ACIMA]

NOVO UUID GERADO: [ANOTAR AQUI APÓS CRIAR]
```

#### **👤 USER 3 - Diogo**
```
DADOS DO PROJETO ANTIGO:
- ID Antigo: e4b3296c-13eb-4faa-aead-e246ddb2bf66
- Email: [PREENCHER COM RESULTADO DA QUERY]
- Created: [PREENCHER COM RESULTADO DA QUERY]
- Email Confirmed: [PREENCHER COM RESULTADO DA QUERY]
- Last Sign In: [PREENCHER COM RESULTADO DA QUERY]
- Metadata: [PREENCHER COM RESULTADO DA QUERY]

CRIAR NO PROJETO NOVO:
- Email: [COPIAR DO ACIMA]
- Password: TukTuk2025!
- Email Confirmed: ✅ true
- User Metadata: [COPIAR DO ACIMA]

NOVO UUID GERADO: [ANOTAR AQUI APÓS CRIAR]
```

---

### **PASSO 3: Criar users no projeto novo**
Aceder: https://supabase.com/dashboard/project/iweurnqdomiqlohvaoat/auth/users

Para cada user acima:
1. Clicar **"Add user"**
2. **Preencher dados** conforme template acima
3. **Anotar UUID gerado** no template

---

### **PASSO 4: Mapeamento de UUIDs**
```
MAPEAMENTO ANTIGO → NOVO:
c2b84b4e-ecbf-47d1-adc0-f3d7549829b3 → [NOVO UUID USER 1]
c4c9a172-92c2-410e-a671-56b443fc093d → [NOVO UUID USER 2]  
e4b3296c-13eb-4faa-aead-e246ddb2bf66 → [NOVO UUID USER 3]
```

---

### **PASSO 5: Executar migração final**
1. Editar `MIGRATION-COMPLETE-SCRIPT.sql`
2. Substituir placeholders pelos novos UUIDs
3. Executar no SQL Editor do projeto novo

---

## ✅ **CHECKLIST DE VERIFICAÇÃO:**

- [ ] Script `EXTRACT-USERS-ANTIGO.sql` executado
- [ ] Dados dos users copiados para template
- [ ] User 1 criado no projeto novo
- [ ] User 2 criado no projeto novo  
- [ ] User 3 criado no projeto novo
- [ ] UUIDs anotados no mapeamento
- [ ] `MIGRATION-COMPLETE-SCRIPT.sql` editado
- [ ] Script final executado
- [ ] Conductors linkados aos novos users
- [ ] Profiles criados corretamente
- [ ] System testado (login funcional)

---

## 🚨 **PROBLEMAS COMUNS:**

**❌ User já existe:**
- Verificar se email já foi usado no projeto novo
- Usar email ligeiramente diferente se necessário

**❌ UUID não encontrado:**
- Verificar se user foi criado corretamente
- Copiar UUID exato do dashboard

**❌ Profiles não criados:**
- Verificar foreign key constraints
- Confirmar que auth.users existem primeiro

---

**Tempo estimado total: 15-20 minutos** ⏱️
