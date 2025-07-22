import { createClient } from "@supabase/supabase-js";

// Configuração do Supabase
const supabaseUrl = "https://cqnahwnnqzraqcslljaz.supabase.co";
const supabaseKey =
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNxbmFod25ucXpyYXFjc2xsamF6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE0ODE1NDQsImV4cCI6MjA2NzA1NzU0NH0.3lW9juEq0C8Vq737Og56-aXMGVtLfkB58tjYRwKMnhE";

const supabase = createClient(supabaseUrl, supabaseKey);

async function debugConductors() {
  console.log("🔍 DEBUG DETALHADO DOS CONDUTORES");
  console.log("==================================================");

  try {
    // 1. Consultar todos os condutores
    console.log("\n1️⃣ Consulta geral de condutores:");
    const { data: allConductors, error: errorAll } = await supabase
      .from("conductors")
      .select("*")
      .order("name");

    if (errorAll) {
      console.error("❌ Erro na consulta geral:", errorAll);
    } else {
      console.log(`✅ Encontrados ${allConductors.length} condutores:`);
      allConductors.forEach((conductor, index) => {
        console.log(`📄 Condutor ${index + 1}:`);
        console.log(`   ID: ${conductor.id}`);
        console.log(`   Nome: ${conductor.name}`);
        console.log(`   WhatsApp: ${conductor.whatsapp}`);
        console.log(`   Ativo: ${conductor.is_active}`);
        console.log(`   User ID: ${conductor.user_id}`);
        console.log("   ---");
      });
    }

    // 2. Consultar condutores ativos
    console.log("\n2️⃣ Consulta de condutores ativos:");
    const { data: activeConductors, error: errorActive } = await supabase
      .from("conductors")
      .select("id, name, latitude, longitude, is_active")
      .eq("is_active", true);

    if (errorActive) {
      console.error("❌ Erro na consulta de ativos:", errorActive);
    } else {
      console.log(
        `✅ Encontrados ${activeConductors.length} condutores ativos:`
      );
      activeConductors.forEach((conductor, index) => {
        console.log(`📄 Condutor Ativo ${index + 1}:`);
        console.log(`   ID: ${conductor.id}`);
        console.log(`   Nome: ${conductor.name}`);
        console.log(`   Ativo: ${conductor.is_active}`);
        console.log("   ---");
      });
    }

    // 3. Testar atualização específica do ID problemático
    console.log("\n3️⃣ Testando o ID problemático:");
    const problematicId = "c2b84b4e-ecbf-47d1-adc0-f3d7549829b3";

    console.log(`🔍 Consultando especificamente o ID: ${problematicId}`);
    const { data: specificConductor, error: errorSpecific } = await supabase
      .from("conductors")
      .select("*")
      .eq("id", problematicId)
      .single();

    if (errorSpecific) {
      console.error("❌ Erro na consulta específica:", errorSpecific);
    } else {
      console.log("✅ Dados do condutor específico:");
      console.log(JSON.stringify(specificConductor, null, 2));
    }

    // 4. Simular uma atualização (sem fazer)
    console.log("\n4️⃣ Simulando query de atualização:");
    console.log(
      `UPDATE conductors SET is_active = false WHERE id = '${problematicId}'`
    );

    const { data: updateResult, error: updateError } = await supabase
      .from("conductors")
      .update({ is_active: false })
      .eq("id", problematicId)
      .select();

    if (updateError) {
      console.error("❌ Erro na simulação de atualização:", updateError);
    } else {
      console.log("✅ Resultado da atualização:");
      console.log(JSON.stringify(updateResult, null, 2));
    }
  } catch (error) {
    console.error("💥 Erro geral:", error);
  }

  console.log("\n✨ Debug concluído!");
}

debugConductors();
