# 🎯 EXECUÇÃO DA MIGRAÇÃO NO SUPABASE

## 📋 Passos para Executar a Migração

### 🔗 **1. Aceder ao Supabase Dashboard**

1. **Abra o navegador** e vá para: https://supabase.com/dashboard
2. **Faça login** na sua conta Supabase
3. **Selecione o projeto destino**: `iweurnqdomiqlohvaoat`
4. **Navegue para**: SQL Editor (ícone </> na sidebar)

### 📄 **2. Executar o Script de Migração**

#### **Script a Executar**: `sql/MIGRACAO-FINAL-DEFINITIVA.sql`

**Localização**: `c:\codigo\tuktuk-milfontes\tuktuk-milfontes\milfontes-tuk-tuk-gemini\tuktuk-milfontes-gemini\sql\MIGRACAO-FINAL-DEFINITIVA.sql`

#### **Passos no SQL Editor**:

1. **Criar Nova Query** - Clique em "New query"
2. **Copiar o Script** - Abra o ficheiro `MIGRACAO-FINAL-DEFINITIVA.sql` e copie todo o conteúdo
3. **Colar no Editor** - Cole no SQL Editor do Supabase
4. **Executar** - Clique em "Run" ou pressione Ctrl+Enter
5. **Aguardar Resultado** - Verifique se executa sem erros

### ⚠️ **3. Verificações Importantes**

#### **Antes de Executar**:
- [ ] Confirme que está no projeto **correto** (`iweurnqdomiqlohvaoat`)
- [ ] Verifique se o schema já foi migrado (15 tabelas devem existir)
- [ ] Confirme que não há users existentes com os emails a criar

#### **Durante a Execução**:
- [ ] Aguarde as mensagens de NOTICE aparecerem
- [ ] Verifique se não há erros vermelhos
- [ ] Observe se os utilizadores são criados automaticamente ou se requer criação manual

---

## 🎯 **Resultado Esperado**

### ✅ **Se Tudo Correr Bem**:

```sql
-- Mensagens esperadas:
NOTICE: ✅ USERS CRIADOS AUTOMATICAMENTE!

-- Ou, se falhar a criação automática:
NOTICE: ❌ Criação automática falhou: [erro]
NOTICE: 👉 CRIE OS USERS VIA DASHBOARD:
NOTICE:    1. Acesse: https://supabase.com/dashboard/project/iweurnqdomiqlohvaoat
NOTICE:    2. Authentication → Users → Add User
NOTICE:    3. Email: carlosbarradas1@gmail.com | Password: TukTuk2025!
NOTICE:    4. Email: sonia@tuktuk-milfontes.pt | Password: TukTuk2025!
NOTICE:    5. Email: diogo@tuktuk-milfontes.pt | Password: TukTuk2025!
```

### 📊 **Queries de Verificação**:

O script executa automaticamente estas verificações:

1. **Estatísticas Finais**:
   ```sql
   SELECT 'ESTATÍSTICAS FINAIS' as secao,
          users_criados, profiles_criados, 
          user_roles_criados, conductors_linkados;
   ```

2. **Status Individual**:
   ```sql
   SELECT condutor, email_auth, profile_nome, 
          user_role, status_final;
   ```

3. **Credenciais de Acesso**:
   ```sql
   SELECT email, 'TukTuk2025!' as password_temporaria;
   ```

4. **Resultado Final**:
   ```sql
   SELECT '🎉 MIGRAÇÃO 100% COMPLETA! SISTEMA PRONTO! 🎉' 
   -- ou '⚠️ MIGRAÇÃO INCOMPLETA - VERIFIQUE STATUS ACIMA'
   ```

---

## 🚨 **Se Houver Problemas**

### **Problema 1: Criação Automática Falha**

**Sintoma**: Mensagem de erro na criação de users
**Solução**: Criar manualmente no Dashboard

1. **Vá para**: Authentication → Users
2. **Clique**: "Add user"
3. **Para cada utilizador**:
   ```
   Email: carlosbarradas1@gmail.com
   Password: TukTuk2025!
   Email confirm: ✅ Sim
   
   Email: sonia@tuktuk-milfontes.pt
   Password: TukTuk2025!
   Email confirm: ✅ Sim
   
   Email: diogo@tuktuk-milfontes.pt  
   Password: TukTuk2025!
   Email confirm: ✅ Sim
   ```
4. **Execute o script novamente** após criar os users

### **Problema 2: Tabelas Não Existem**

**Sintoma**: Erro "table does not exist"
**Solução**: Executar primeiro o schema

1. **Execute primeiro**: `sql/schema.sql` ou `sql/create-schema-complete.sql`
2. **Depois execute**: `sql/MIGRACAO-FINAL-DEFINITIVA.sql`

### **Problema 3: Permissões Negadas**

**Sintoma**: "permission denied" ou "access denied"
**Solução**: Verificar RLS

1. **Desative temporariamente RLS**:
   ```sql
   ALTER TABLE profiles DISABLE ROW LEVEL SECURITY;
   ALTER TABLE user_roles DISABLE ROW LEVEL SECURITY;
   ALTER TABLE conductors DISABLE ROW LEVEL SECURITY;
   ```

2. **Execute a migração**

3. **Reative RLS**:
   ```sql
   ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
   ALTER TABLE user_roles ENABLE ROW LEVEL SECURITY;
   ALTER TABLE conductors ENABLE ROW LEVEL SECURITY;
   ```

---

## 📋 **Checklist de Execução**

### **Antes da Execução**:
- [ ] Login no Supabase Dashboard realizado
- [ ] Projeto `iweurnqdomiqlohvaoat` selecionado
- [ ] SQL Editor aberto
- [ ] Script `MIGRACAO-FINAL-DEFINITIVA.sql` copiado

### **Durante a Execução**:
- [ ] Script colado no editor
- [ ] Comando "Run" executado
- [ ] Mensagens de NOTICE observadas
- [ ] Nenhum erro vermelho apareceu

### **Após a Execução**:
- [ ] Resultado final mostra "MIGRAÇÃO 100% COMPLETA"
- [ ] 3 users criados verificados
- [ ] 3 profiles criados verificados
- [ ] 3+ user_roles criados verificados (Carlos tem 4)
- [ ] 3 conductors linkados verificados

### **Teste Final**:
- [ ] Login testado: `carlosbarradas1@gmail.com` / `TukTuk2025!`
- [ ] Login testado: `sonia@tuktuk-milfontes.pt` / `TukTuk2025!`
- [ ] Login testado: `diogo@tuktuk-milfontes.pt` / `TukTuk2025!`

---

## 🎯 **Próximo Passo**

**EXECUTE AGORA**:
1. **Abra**: https://supabase.com/dashboard/project/iweurnqdomiqlohvaoat/sql
2. **Cole**: Todo o conteúdo de `sql/MIGRACAO-FINAL-DEFINITIVA.sql`
3. **Execute**: Clique em "Run"
4. **Verifique**: Resultados das queries de verificação

**🚀 PRONTO! Após executar, teremos o sistema 100% migrado e funcional!**
