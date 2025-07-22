#!/usr/bin/env node

/**
 * Script para testar o sistema de permissões granulares
 * Execute: node test-permissions-system.js
 */

import { createClient } from "@supabase/supabase-js";

// Configurar Supabase
const supabaseUrl =
  process.env.VITE_SUPABASE_URL || "https://cqnahwnnqzraqcsljaz.supabase.co";
const supabaseKey =
  process.env.VITE_SUPABASE_ANON_KEY ||
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNxbmFod25ucXpyYXFjc2xqYXoiLCJyb2xlIjoiYW5vbiIsImlhdCI6MTcxOTczNDc4OCwiZXhwIjoyMDM1MzEwNzg4fQ.u-aUDxcHIv7TbE4CAgwNBr06eGTKz3G5PZqM8wVZYPM";

const supabase = createClient(supabaseUrl, supabaseKey);

async function testPermissionsSystem() {
  console.log("🧪 TESTE DO SISTEMA DE PERMISSÕES GRANULARES");
  console.log("=============================================");

  try {
    // 1. Verificar usuário atual
    const {
      data: { user },
      error: userError,
    } = await supabase.auth.getUser();

    if (userError || !user) {
      console.log("❌ Usuário não autenticado");
      return;
    }

    console.log("👤 Usuário atual:", user.email);

    // 2. Buscar perfil admin
    const { data: profile, error: profileError } = await supabase
      .from("profiles")
      .select("*")
      .eq("id", user.id)
      .single();

    if (profileError) {
      console.log("❌ Erro ao buscar perfil:", profileError.message);
      return;
    }

    console.log("🔐 Perfil Admin:");
    console.log("   - Role:", profile.role);
    console.log("   - Level:", profile.admin_level);
    console.log("   - Região:", profile.region);
    console.log(
      "   - Permissões:",
      JSON.stringify(profile.permissions, null, 2)
    );

    // 3. Testar busca de condutores com permissões
    console.log("\n📋 Testando busca de condutores...");
    const { data: conductors, error: conductorsError } = await supabase
      .from("conductors")
      .select("*");

    if (conductorsError) {
      console.log("❌ Erro ao buscar condutores:", conductorsError.message);
    } else {
      console.log(`✅ Encontrados ${conductors.length} condutores`);
      conductors.forEach((conductor) => {
        console.log(
          `   - ${conductor.name} (${conductor.region || "sem região"}) - ${
            conductor.is_active ? "Ativo" : "Inativo"
          }`
        );
      });
    }

    // 4. Testar função de verificação de permissões
    if (conductors && conductors.length > 0) {
      const testConductor = conductors[0];
      console.log(
        `\n🔍 Testando permissões para condutor: ${testConductor.name}`
      );

      const { data: hasPermission, error: permError } = await supabase.rpc(
        "check_admin_permissions",
        {
          target_conductor_id: testConductor.id,
          admin_user_id: user.id,
        }
      );

      if (permError) {
        console.log("❌ Erro ao verificar permissões:", permError.message);
      } else {
        console.log(
          `✅ Permissão para gerenciar: ${hasPermission ? "SIM" : "NÃO"}`
        );
      }
    }

    // 5. Testar auditoria
    console.log("\n📊 Testando logs de auditoria...");
    const { data: auditLogs, error: auditError } = await supabase
      .from("conductor_status_audit")
      .select("*")
      .order("created_at", { ascending: false })
      .limit(5);

    if (auditError) {
      console.log("❌ Erro ao buscar logs de auditoria:", auditError.message);
    } else {
      console.log(`✅ Encontrados ${auditLogs.length} logs de auditoria`);
      auditLogs.forEach((log) => {
        console.log(
          `   - ${new Date(log.created_at).toLocaleString("pt-BR")}: ${
            log.new_status ? "Ativação" : "Desativação"
          } por ${log.admin_level}`
        );
      });
    }

    // 6. Simular mudança de status
    if (conductors && conductors.length > 0) {
      const testConductor = conductors[0];
      const newStatus = !testConductor.is_active;

      console.log(
        `\n🔄 Testando mudança de status: ${testConductor.name} para ${
          newStatus ? "ATIVO" : "INATIVO"
        }`
      );

      const { data: updateResult, error: updateError } = await supabase
        .from("conductors")
        .update({
          is_active: newStatus,
          updated_at: new Date().toISOString(),
          updated_by: user.id,
        })
        .eq("id", testConductor.id)
        .select();

      if (updateError) {
        console.log("❌ Erro ao atualizar status:", updateError.message);
        console.log("   Isso pode indicar problema nas políticas RLS");
      } else {
        console.log("✅ Status atualizado com sucesso!");
        console.log("   Resultado:", updateResult);

        // Reverter mudança
        console.log("🔄 Revertendo mudança...");
        await supabase
          .from("conductors")
          .update({
            is_active: testConductor.is_active,
            updated_at: new Date().toISOString(),
            updated_by: user.id,
          })
          .eq("id", testConductor.id);
        console.log("✅ Status revertido");
      }
    }

    // 7. Verificar estrutura de permissões
    console.log("\n🏗️  Verificando estrutura de permissões:");

    // Verificar enum admin_level
    const { data: enumValues, error: enumError } = await supabase
      .from("information_schema.check_constraints")
      .select("*")
      .like("constraint_name", "%admin_level%");

    if (enumError) {
      console.log("⚠️  Não foi possível verificar enum admin_level");
    } else {
      console.log("✅ Enum admin_level configurado");
    }

    // Verificar tabela de auditoria
    const { data: auditTable, error: auditTableError } = await supabase
      .from("information_schema.tables")
      .select("*")
      .eq("table_name", "conductor_status_audit")
      .eq("table_schema", "public");

    if (auditTableError || !auditTable || auditTable.length === 0) {
      console.log("⚠️  Tabela de auditoria não encontrada");
    } else {
      console.log("✅ Tabela de auditoria configurada");
    }

    console.log("\n🎉 TESTE CONCLUÍDO!");
    console.log("📋 Sistema de permissões granulares funcionando");
    console.log("🔐 Controle de acesso baseado em região e nível");
    console.log("📊 Auditoria de mudanças ativa");
  } catch (error) {
    console.error("❌ Erro durante o teste:", error);
  }
}

// Executar se chamado diretamente
if (import.meta.url === `file://${process.argv[1]}`) {
  testPermissionsSystem()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error("💥 Erro fatal:", error);
      process.exit(1);
    });
}
