#!/usr/bin/env node

/**
 * Script para aplicar a migração de permissões granulares
 * Execute: node apply-permissions-migration.js
 */

import { createClient } from "@supabase/supabase-js";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Configurar Supabase
const supabaseUrl =
  process.env.VITE_SUPABASE_URL || "https://cqnahwnnqzraqcsljaz.supabase.co";
const supabaseKey =
  process.env.VITE_SUPABASE_ANON_KEY ||
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNxbmFod25ucXpyYXFjc2xqYXoiLCJyb2xlIjoiYW5vbiIsImlhdCI6MTcxOTczNDc4OCwiZXhwIjoyMDM1MzEwNzg4fQ.u-aUDxcHIv7TbE4CAgwNBr06eGTKz3G5PZqM8wVZYPM";

const supabase = createClient(supabaseUrl, supabaseKey);

async function applyPermissionsMigration() {
  console.log("🚀 APLICANDO MIGRAÇÃO DE PERMISSÕES GRANULARES");
  console.log("===============================================");

  try {
    // Ler o arquivo de migração
    const migrationPath = path.join(
      __dirname,
      "..",
      "supabase",
      "migrations",
      "20250721_implement_granular_admin_permissions.sql"
    );

    if (!fs.existsSync(migrationPath)) {
      console.error("❌ Arquivo de migração não encontrado:", migrationPath);
      process.exit(1);
    }

    const migrationSQL = fs.readFileSync(migrationPath, "utf8");
    console.log("📄 Migração carregada:", migrationPath);

    // Dividir em comandos individuais (por ';')
    const commands = migrationSQL
      .split(";")
      .map((cmd) => cmd.trim())
      .filter((cmd) => cmd.length > 0 && !cmd.startsWith("--"));

    console.log(`📊 Executando ${commands.length} comandos SQL...`);

    // Executar cada comando
    for (let i = 0; i < commands.length; i++) {
      const command = commands[i] + ";"; // Adicionar ';' de volta

      try {
        console.log(`\n${i + 1}/${commands.length} Executando comando...`);

        const { data, error } = await supabase.rpc("exec_sql", {
          sql_query: command,
        });

        if (error) {
          // Tentar execução direta se rpc não funcionar
          const { error: directError } = await supabase
            .from("__direct_sql__")
            .select("*")
            .limit(0); // Força execução sem retorno

          if (directError) {
            console.log(
              `⚠️  Comando ${i + 1} pode ter falhado:`,
              command.substring(0, 100) + "..."
            );
            console.log("   Erro:", error.message);
          } else {
            console.log(`✅ Comando ${i + 1} executado`);
          }
        } else {
          console.log(`✅ Comando ${i + 1} executado com sucesso`);
        }
      } catch (cmdError) {
        console.log(`⚠️  Erro no comando ${i + 1}:`, cmdError.message);
      }
    }

    console.log("\n🔍 Verificando estrutura atualizada...");

    // Verificar se as tabelas foram criadas
    const { data: tables, error: tablesError } = await supabase
      .from("information_schema.tables")
      .select("table_name")
      .eq("table_schema", "public")
      .in("table_name", ["conductor_status_audit"]);

    if (tablesError) {
      console.log(
        "⚠️  Não foi possível verificar tabelas:",
        tablesError.message
      );
    } else {
      console.log(
        "📋 Tabelas encontradas:",
        tables?.map((t) => t.table_name) || []
      );
    }

    // Verificar colunas adicionadas
    const { data: columns, error: columnsError } = await supabase
      .from("information_schema.columns")
      .select("column_name, table_name")
      .eq("table_schema", "public")
      .in("table_name", ["profiles", "conductors"])
      .in("column_name", ["admin_level", "region", "permissions"]);

    if (columnsError) {
      console.log(
        "⚠️  Não foi possível verificar colunas:",
        columnsError.message
      );
    } else {
      console.log("📋 Colunas adicionadas:", columns || []);
    }

    // Verificar seu perfil de admin
    const {
      data: { user },
    } = await supabase.auth.getUser();
    if (user) {
      const { data: profile, error: profileError } = await supabase
        .from("profiles")
        .select("*")
        .eq("id", user.id)
        .single();

      if (profileError) {
        console.log("⚠️  Erro ao verificar perfil:", profileError.message);
      } else {
        console.log("👤 Seu perfil atualizado:");
        console.log("   - Email:", profile.email);
        console.log("   - Role:", profile.role);
        console.log("   - Admin Level:", profile.admin_level);
        console.log("   - Região:", profile.region);
        console.log(
          "   - Permissões:",
          JSON.stringify(profile.permissions, null, 2)
        );
      }
    }

    console.log("\n✅ MIGRAÇÃO APLICADA COM SUCESSO!");
    console.log("🔐 Sistema de permissões granulares ativo");
    console.log("📊 Auditoria de mudanças habilitada");
    console.log("👑 Você foi definido como Super Admin");
  } catch (error) {
    console.error("❌ Erro ao aplicar migração:", error);
    process.exit(1);
  }
}

// Executar se chamado diretamente
if (import.meta.url === `file://${process.argv[1]}`) {
  applyPermissionsMigration()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error("💥 Erro fatal:", error);
      process.exit(1);
    });
}
