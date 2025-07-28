#!/bin/bash

# ====================================
# SCRIPT DE AUTOMAÇÃO COMPLETA 
# TukTuk Milfontes - Migração de Users
# ====================================

echo "🚀 INICIANDO MIGRAÇÃO COMPLETA DE USERS"
echo "========================================="

# Variáveis dos projetos
OLD_PROJECT="cqnahwnnqzraqcslljaz"
NEW_PROJECT="iweurnqdomiqlohvaoat"
TOKEN="sbp_d9cd1a79e89b1611d97cf8877fad747e44c44693"

echo "📊 Projeto Antigo: $OLD_PROJECT"
echo "📊 Projeto Novo: $NEW_PROJECT"
echo ""

# ====================================
# PASSO 1: Verificar dados no projeto antigo
# ====================================
echo "🔍 PASSO 1: Consultando dados do projeto antigo..."

echo "Conectando ao projeto antigo para extrair users..."
echo "npx @supabase/mcp-server-supabase --project-ref=$OLD_PROJECT"

# ====================================
# PASSO 2: Listar comandos para criar users
# ====================================
echo ""
echo "👥 PASSO 2: USERS PARA CRIAR NO DASHBOARD"
echo "========================================="
echo "Projeto: https://supabase.com/dashboard/project/$NEW_PROJECT"
echo "Navegue para: Authentication > Users"
echo ""

echo "User 1:"
echo "  Email: motorista.teste@tuktuk-milfontes.pt"
echo "  Password: TukTuk2025!"
echo "  Confirm Email: true"
echo ""

echo "User 2:"
echo "  Email: sonia@tuktuk-milfontes.pt"  
echo "  Password: TukTuk2025!"
echo "  Confirm Email: true"
echo ""

echo "User 3:"
echo "  Email: diogo@tuktuk-milfontes.pt"
echo "  Password: TukTuk2025!"
echo "  Confirm Email: true"
echo ""

# ====================================
# PASSO 3: Instruções pós-criação
# ====================================
echo "✅ PASSO 3: APÓS CRIAR OS USERS"
echo "==============================="
echo "1. Copie os UUIDs gerados"
echo "2. Edite o arquivo: MIGRATION-COMPLETE-SCRIPT.sql"
echo "3. Substitua os placeholders pelos UUIDs reais"
echo "4. Execute o script no SQL Editor"
echo ""

# ====================================
# PASSO 4: Verificação final
# ====================================
echo "🧪 PASSO 4: COMANDOS DE VERIFICAÇÃO"
echo "==================================="
echo "Execute no SQL Editor para validar:"
echo ""
echo "-- Verificar auth.users"
echo "SELECT id, email, created_at FROM auth.users;"
echo ""
echo "-- Verificar profiles"  
echo "SELECT id, email, full_name, role FROM public.profiles;"
echo ""
echo "-- Verificar conductors linkados"
echo "SELECT c.name, c.whatsapp, p.email FROM public.conductors c"
echo "LEFT JOIN public.profiles p ON c.user_id = p.id;"
echo ""

echo "🎉 MIGRAÇÃO PRONTA PARA EXECUÇÃO!"
echo "Siga os passos acima para completar."
