# 🔄 Script de Migração - Projeto Supabase

## 📋 SITUAÇÃO ATUAL
- **Projeto Origem:** `cqnahwnnqzraqcslljaz` (dados exportados)
- **Projeto Destino:** `iweurnqdomiqlohvaoat` (migração para)

## ✅ DADOS EXPORTADOS
- ✅ `backup-data-reservations.sql` - 3 reservas
- ✅ `backup-data-tour-types.sql` - 6 tipos de passeio
- ✅ `backup-data-conductors.sql` - 3 condutores

## 🎯 PRÓXIMOS PASSOS

### 1. **Configurar novo projeto** `iweurnqdomiqlohvaoat`
```bash
# As credenciais já estão atualizadas no .env:
VITE_SUPABASE_URL=https://iweurnqdomiqlohvaoat.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### 2. **Criar schema no projeto destino**
- Ir ao SQL Editor do projeto `iweurnqdomiqlohvaoat`
- Executar o schema completo (estrutura das tabelas)

### 3. **Importar dados**
- Executar `backup-data-tour-types.sql` primeiro
- Executar `backup-data-conductors.sql` 
- Executar `backup-data-reservations.sql` por último

### 4. **Configurar RLS e Políticas**
- Configurar Row Level Security
- Recriar políticas de acesso
- Configurar triggers e functions

### 5. **Testar aplicação**
- Testar login/autenticação
- Verificar se todas as funcionalidades funcionam
- Validar dados migrados

## 🔧 COMANDOS PARA EXPORTAR SCHEMA COMPLETO

Se precisar do schema completo do projeto origem:
```sql
-- No SQL Editor do projeto origem (cqnahwnnqzraqcslljaz):
-- Pode copiar todas as definições de tabelas e executar no projeto destino
```

## 📝 NOTAS IMPORTANTES

1. **Ordem de importação:**
   - tour_types (sem dependências)
   - conductors (depende de profiles)
   - reservations (pode depender de conductors)

2. **Dados de autenticação (auth.users):**
   - Precisam ser recriados manualmente
   - Ou migrados através do painel administrativo

3. **IDs de referência:**
   - Manter os mesmos UUIDs para preservar relacionamentos
   - Verificar foreign keys após importação

## 🆘 EM CASO DE ERRO

Se algum INSERT falhar:
1. Verificar se todas as tabelas foram criadas
2. Verificar foreign keys
3. Executar dados em ordem correta
4. Verificar se extensions estão ativadas (uuid-ossp, etc.)

---
**Data:** 27/01/2025  
**Status:** Pronto para migração manual via SQL Editor
