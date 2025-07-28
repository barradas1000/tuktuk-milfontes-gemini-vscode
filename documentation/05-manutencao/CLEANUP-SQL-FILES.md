# 📋 LIMPEZA E ORGANIZAÇÃO DOS ARQUIVOS SQL

## Análise dos Arquivos SQL Criados

### 🗂️ ARQUIVOS PRINCIPAIS (MANTER):

1. **`schema.sql`** - Schema completo do projeto ✅ MANTER
2. **`backup-data-*.sql`** - Backups de dados ✅ MANTER
3. **`verificacao-corrigida.sql`** - Verificação final ✅ MANTER

### 🔄 ARQUIVOS DE MIGRAÇÃO DE USERS (CONSOLIDAR):

Arquivos duplicados/similares para criar users:
- `COMPLETE-USER-CREATION.sql` - ✅ MANTER (mais completo)
- `EXECUTE-USER-MIGRATION.sql` - ❌ REMOVER (duplicado)
- `FINAL-AUTO-MIGRATION.sql` - ❌ REMOVER (duplicado)
- `FINAL-MIGRATION-SCRIPT.sql` - ❌ REMOVER (duplicado)
- `MIGRATION-COMPLETE-SCRIPT.sql` - ❌ REMOVER (duplicado)
- `execute-final-migration.sql` - ❌ REMOVER (manual/complexo)
- `create-users-sql-attempt.sql` - ❌ REMOVER (experimental)
- `SIMPLE-MIGRATION-SCRIPT.sql` - ❌ REMOVER (duplicado)

### 🔍 ARQUIVOS DE DEBUG/ANÁLISE (MANTER 1):
- `debug-auth.sql` - ✅ MANTER (útil para análise)

### 📤 ARQUIVOS DE EXTRAÇÃO (HISTÓRICO):
- `EXTRACT-USERS-ANTIGO.sql` - ❌ REMOVER (já usado)
- `extract-users-from-old-project.sql` - ❌ REMOVER (já usado)
- `migrate-users.sql` - ❌ REMOVER (já usado)

### 🧹 ARQUIVOS CORRIGIDOS (REMOVER ANTIGOS):
- `CORRECTED-MIGRATION-SCRIPT.sql` - ❌ REMOVER (substituído)

## 📁 ESTRUTURA FINAL RECOMENDADA:

```
sql/
├── schema.sql                    # Schema completo
├── backup-data-conductors.sql    # Backup dados
├── backup-data-reservations.sql  # Backup dados  
├── backup-data-tour-types.sql    # Backup dados
├── COMPLETE-USER-CREATION.sql    # Criação users (FINAL)
├── verificacao-corrigida.sql     # Verificação final
└── debug-auth.sql               # Debug/análise
```

## 🎯 AÇÕES A REALIZAR:

1. **MANTER** apenas 6 arquivos essenciais
2. **REMOVER** 8+ arquivos duplicados
3. **CRIAR** arquivo final consolidado
4. **DOCUMENTAR** processo completo
