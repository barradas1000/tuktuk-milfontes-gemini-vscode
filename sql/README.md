# 📁 Scripts SQL - TukTuk Milfontes

Esta pasta contém todos os scripts SQL organizados por categoria para facilitar a manutenção e uso.

## 🎯 Scripts de Migração Principal

### `MIGRACAO-FINAL-DEFINITIVA.sql`
**Script principal e definitivo para migração completa**
- ✅ Criação automática de users (experimental)
- ✅ Migração de profiles e user_roles
- ✅ Linkagem de conductors
- ✅ Verificação completa automática
- 🎯 **USAR ESTE SCRIPT PARA MIGRAÇÃO FINAL**

### `verificacao-corrigida.sql`
**Script de verificação pós-migração**
- Verificação de status de todos os componentes migrados
- Estatísticas finais da migração
- Versão corrigida sem caracteres Unicode problemáticos

## 🗃️ Scripts de Schema e Estrutura

### `schema.sql`
**Schema completo da base de dados**
- Definição de todas as 15 tabelas
- Estrutura completa do projeto

### `create-schema-complete.sql`
**Script de criação de schema**
- Versão alternativa para criação de estrutura

### `schema-essencial.sql`
**Schema essencial simplificado**
- Versão reduzida com componentes essenciais

## 💾 Scripts de Backup de Dados

### `backup-data-conductors.sql`
**Backup dos dados de condutores**
- Dados dos 3 condutores migrados
- IDs originais preservados

### `backup-data-reservations.sql`
**Backup das reservas**
- Todas as reservas do sistema original
- Relações mantidas

### `backup-data-tour-types.sql`
**Backup dos tipos de tour**
- Configurações de tours disponíveis

### `tuktuk_backup.sql`
**Backup completo original**
- Backup completo do sistema antigo
- Arquivo histórico

## 🔧 Scripts de Desenvolvimento e Debug

### `COMPLETE-USER-CREATION.sql`
**Script de criação de users (versão anterior)**
- ⚠️ Substituído por MIGRACAO-FINAL-DEFINITIVA.sql
- Mantido para referência histórica

### `debug-auth.sql`
**Script de debug de autenticação**
- Ferramentas de diagnóstico
- Consultas de verificação de auth

## 📋 Como Usar

### Para Migração Completa:
1. Execute `MIGRACAO-FINAL-DEFINITIVA.sql` no projeto destino
2. Execute `verificacao-corrigida.sql` para verificar sucesso

### Para Backup/Restore:
1. Use os scripts `backup-data-*.sql` para restaurar dados específicos
2. Use `tuktuk_backup.sql` para backup completo

### Para Desenvolvimento:
1. Use `schema.sql` para recriar estrutura
2. Use `debug-auth.sql` para diagnosticar problemas

## ⚠️ Notas Importantes

- **Projeto Destino**: iweurnqdomiqlohvaoat
- **Projeto Origem**: cqnahwnnqzraqcslljaz  
- **Credenciais Temporárias**: TukTuk2025! (todos os users)
- **Status**: Migração 95% completa, falta apenas execução final

## 🎯 Próximo Passo

Execute `MIGRACAO-FINAL-DEFINITIVA.sql` para completar os 5% finais da migração!
