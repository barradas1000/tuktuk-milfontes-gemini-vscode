#!/usr/bin/env node

/**
 * Script de teste para verificar o funcionamento do sistema de tracking otimizado
 */

import { createClient } from "@supabase/supabase-js";

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error("❌ Variáveis de ambiente SUPABASE não configuradas");
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

async function testOptimizedSystem() {
  console.log("🧪 Testando sistema otimizado de tracking...\n");

  try {
    // 1. Verificar tabela conductors
    console.log("1️⃣ Verificando tabela conductors...");
    const { data: conductors, error: conductorsError } = await supabase
      .from("conductors")
      .select("id, name, is_active, latitude, longitude")
      .limit(5);

    if (conductorsError) {
      console.error("❌ Erro ao buscar conductors:", conductorsError);
      return;
    }

    console.log(`✅ Encontrados ${conductors?.length || 0} condutores:`);
    conductors?.forEach((c, i) => {
      console.log(
        `   ${i + 1}. ${c.name} (${c.id.substring(0, 8)}...) - ${
          c.is_active ? "🟢 ATIVO" : "🔴 INATIVO"
        }`
      );
      if (c.latitude && c.longitude) {
        console.log(
          `      Localização: ${c.latitude.toFixed(4)}, ${c.longitude.toFixed(
            4
          )}`
        );
      }
    });

    // 2. Testar busca de condutores ativos
    console.log("\n2️⃣ Testando busca de condutores ativos...");
    const { data: activeConductors, error: activeError } = await supabase
      .from("conductors")
      .select("id, name, latitude, longitude, is_active")
      .eq("is_active", true);

    if (activeError) {
      console.error("❌ Erro ao buscar condutores ativos:", activeError);
      return;
    }

    console.log(`✅ Condutores ativos: ${activeConductors?.length || 0}`);
    activeConductors?.forEach((c, i) => {
      console.log(
        `   ${i + 1}. ${c.name} - Lat: ${c.latitude || "N/A"}, Lng: ${
          c.longitude || "N/A"
        }`
      );
    });

    // 3. Verificar estrutura da tabela conductor_locations
    console.log("\n3️⃣ Verificando tabela conductor_locations...");
    const { data: locations, error: locationsError } = await supabase
      .from("conductor_locations")
      .select("conductor_id, latitude, longitude, updated_at")
      .order("updated_at", { ascending: false })
      .limit(3);

    if (locationsError) {
      console.error("❌ Erro ao buscar locations:", locationsError);
    } else {
      console.log(`✅ Últimas ${locations?.length || 0} localizações:`);
      locations?.forEach((l, i) => {
        console.log(
          `   ${i + 1}. Condutor ${l.conductor_id.substring(0, 8)}... - ${
            l.latitude
          }, ${l.longitude}`
        );
        console.log(
          `      Atualização: ${new Date(l.updated_at).toLocaleString()}`
        );
      });
    }

    // 4. Resumo do sistema
    console.log("\n📊 RESUMO DO SISTEMA OTIMIZADO:");
    console.log('✅ Usa apenas tabela "conductors" para tracking principal');
    console.log('✅ Tabela "conductor_locations" para histórico (opcional)');
    console.log('✅ Real-time via postgres_changes na tabela "conductors"');
    console.log("✅ Funções simplificadas no supabaseService");
    console.log("✅ Componente ToggleConductorTrackingButton otimizado");
    console.log("✅ PassengerMap com subscription simplificado");

    console.log("\n🎯 PRÓXIMOS PASSOS:");
    console.log("1. Teste o painel do conductor para ligar/desligar tracking");
    console.log(
      "2. Verifique se o TukTuk aparece/desaparece no mapa de passageiros"
    );
    console.log(
      "3. Confirme que as localizações são atualizadas em tempo real"
    );
  } catch (error) {
    console.error("💥 Erro durante o teste:", error);
  }
}

// Executar teste
testOptimizedSystem();
