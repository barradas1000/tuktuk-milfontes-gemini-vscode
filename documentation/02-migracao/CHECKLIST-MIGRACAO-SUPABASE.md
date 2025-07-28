# 📋 Checklist - Migração Supabase

## ✅ Status da Migração

### 🔧 **1. PREPARAÇÃO**
- [ ] Nova conta Supabase criada
nome do projeto :  tuktukmilfontes@gmail.com's Project

Project ID : iweurnqdomiqlohvaoat (DESTINO)

- [x] Novo projeto Supabase criado
- [x] Credenciais da nova conta obtidas (URL + ANON_KEY)

### 🔗 **2. ATUALIZAÇÃO DA APLICAÇÃO**
- [x] Arquivo `.env` atualizado com novas credenciais
- [x] `VITE_SUPABASE_URL` https://iweurnqdomiqlohvaoat.supabase.co 
- [x] `VITE_SUPABASE_ANON_KEY` eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml3ZXVybnFkb21pcWxvaHZhb2F0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM0NTU2MzIsImV4cCI6MjA2OTAzMTYzMn0.LdLnL_sluHpIs_7qS3c3nCqNOrT_G0RaS3vhawloQjc

- [ ] Servidor de desenvolvimento reiniciado após mudanças no `.env`

### 📊 **3. MIGRAÇÃO DOS DADOS**
- [x] Credenciais de conexão direta ao PostgreSQL obtidas (do projeto origem)
- [x] Dados exportados via SQL (projeto origem `cqnahwnnqzraqcslljaz`)
  - [x] `backup-data-reservations.sql` (3 reservas)
  - [x] `backup-data-tour-types.sql` (6 tipos de passeio)  
  - [x] `backup-data-conductors.sql` (3 condutores)

**Próximo Passo:** Importar dados para projeto destino `iweurnqdomiqlohvaoat`

**Credenciais Direct Connection (DESTINO):**
```
Connection String: postgresql://postgres:[SENHA-BD]@db.iweurnqdomiqlohvaoat.supabase.co:5432/postgres

Host: db.iweurnqdomiqlohvaoat.supabase.co
Port: 5432
Database: postgres
User: postgres
Password: [SENHA-BD-DIRETA]
```

- [ ] Schema criado no projeto destino (via SQL Editor)
- [ ] Dados importados para o projeto destino (via SQL Editor)
- [ ] Relacionamentos verificados

### ⚙️ **4. CONFIGURAÇÕES SUPABASE**
- [ ] Policies de segurança (RLS) configuradas
- [ ] Autenticação configurada (providers, emails, etc.)
- [ ] Storage buckets criados (se aplicável)
- [ ] Functions/triggers recriadas (se aplicável)
- [ ] Extensions ativadas (se aplicável)

### 🧪 **5. TESTES**
- [ ] Teste de conexão da aplicação com novo Supabase
- [ ] Login/autenticação funcionando
- [ ] Queries de leitura funcionando
- [ ] Queries de escrita funcionando
- [ ] Storage funcionando (se aplicável)
- [ ] Functions funcionando (se aplicável)

### 🎯 **6. FINALIZAÇÃO**
- [ ] Aplicação funcionando completamente com novo Supabase
- [ ] Variáveis de ambiente de produção atualizadas
- [ ] Deploy realizado com novas configurações
- [ ] Antigo projeto Supabase desativado/removido

---

## 🔍 **ONDE ESTOU AGORA?**

**Migração: `cqnahwnnqzraqcslljaz` → `iweurnqdomiqlohvaoat`**

✅ **Passos Concluídos:**
- [x] Dados exportados do projeto origem
- [x] Arquivo `.env` atualizado com projeto destino
- [x] Credenciais do projeto destino configuradas
- [x] 3 arquivos SQL criados com dados essenciais

⚠️ **Próximo Passo Crítico:**
1. **Ir ao SQL Editor do projeto `iweurnqdomiqlohvaoat`**
2. **Criar schema (estrutura das tabelas)**
3. **Executar arquivos de dados na ordem correta**

📂 **Arquivos Criados:**
- `backup-data-tour-types.sql`
- `backup-data-conductors.sql` 
- `backup-data-reservations.sql`
- `MIGRATION-GUIDE.md`

---

## 📝 **COMANDOS ÚTEIS**

### Exportar Schema (YA NO ES NECESARIO):
```bash
# Los datos ya fueron exportados vía SQL del proyecto origen
# Ver archivos: backup-data-*.sql

# Para proyecto destino, usar SQL Editor directamente
# URL: https://supabase.com/dashboard/project/iweurnqdomiqlohvaoat
```

### Importar Datos al Proyecto Destino:
```sql
-- 1. Primero crear schema (estructura) en SQL Editor
-- 2. Luego ejecutar en orden:
-- backup-data-tour-types.sql
-- backup-data-conductors.sql  
-- backup-data-reservations.sql
```

### Testar Conexão:
```javascript
// No console do navegador ou componente
console.log('Supabase URL:', import.meta.env.VITE_SUPABASE_URL)
supabase.from('auth.users').select('count').then(console.log)
```

---

## 🆘 **EM CASO DE PROBLEMAS**

1. **Erro de conexão:** Verificar credenciais no `.env`
2. **Tabelas não encontradas:** Importar schema primeiro
3. **Dados vazios:** Importar dados após schema
4. **Policies:** Configurar RLS no painel Supabase

---

**📅 Última atualização:** ${new Date().toLocaleDateString('pt-BR')}
