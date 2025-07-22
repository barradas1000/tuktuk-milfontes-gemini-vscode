import { createClient } from "@supabase/supabase-js";

// Configuração do Supabase
const supabaseUrl = "https://cqnahwnnqzraqcslljaz.supabase.co";
const supabaseKey =
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNxbmFod25ucXpyYXFjc2xsamF6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE0ODE1NDQsImV4cCI6MjA2NzA1NzU0NH0.3lW9juEq0C8Vq737Og56-aXMGVtLfkB58tjYRwKMnhE";

const supabase = createClient(supabaseUrl, supabaseKey);

async function testUpdateConductor() {
  console.log("🧪 TESTE DE ATUALIZAÇÃO DE CONDUTOR");
  console.log("==================================================");

  const testId = "c2b84b4e-ecbf-47d1-adc0-f3d7549829b3";

  try {
    // 1. Primeiro vamos verificar o estado atual
    console.log("\n1️⃣ Estado atual:");
    const { data: before, error: errorBefore } = await supabase
      .from("conductors")
      .select("id, name, is_active")
      .eq("id", testId)
      .single();

    if (errorBefore) {
      console.error("❌ Erro ao consultar estado atual:", errorBefore);
      return;
    }

    console.log("✅ Estado atual:", before);

    // 2. Tentar atualização simples sem .select()
    console.log("\n2️⃣ Teste 1 - Atualização sem .select():");
    const { data: updateResult1, error: updateError1 } = await supabase
      .from("conductors")
      .update({ is_active: !before.is_active })
      .eq("id", testId);

    if (updateError1) {
      console.error("❌ Erro na atualização 1:", updateError1);
    } else {
      console.log("✅ Resultado 1:", updateResult1);
    }

    // 3. Verificar se mudou
    console.log("\n3️⃣ Verificando mudança:");
    const { data: after1, error: errorAfter1 } = await supabase
      .from("conductors")
      .select("id, name, is_active")
      .eq("id", testId)
      .single();

    if (errorAfter1) {
      console.error("❌ Erro ao consultar após atualização 1:", errorAfter1);
    } else {
      console.log("✅ Estado após atualização 1:", after1);
    }

    // 4. Tentar atualização com .select()
    console.log("\n4️⃣ Teste 2 - Atualização com .select():");
    const { data: updateResult2, error: updateError2 } = await supabase
      .from("conductors")
      .update({ is_active: !after1.is_active })
      .eq("id", testId)
      .select();

    if (updateError2) {
      console.error("❌ Erro na atualização 2:", updateError2);
    } else {
      console.log("✅ Resultado 2:", updateResult2);
    }

    // 5. Verificar estado final
    console.log("\n5️⃣ Estado final:");
    const { data: after2, error: errorAfter2 } = await supabase
      .from("conductors")
      .select("id, name, is_active")
      .eq("id", testId)
      .single();

    if (errorAfter2) {
      console.error("❌ Erro ao consultar estado final:", errorAfter2);
    } else {
      console.log("✅ Estado final:", after2);
    }

    // 6. Restaurar estado original
    console.log("\n6️⃣ Restaurando estado original:");
    const { data: restore, error: errorRestore } = await supabase
      .from("conductors")
      .update({ is_active: before.is_active })
      .eq("id", testId);

    if (errorRestore) {
      console.error("❌ Erro ao restaurar:", errorRestore);
    } else {
      console.log("✅ Estado restaurado com sucesso");
    }
  } catch (error) {
    console.error("💥 Erro geral:", error);
  }

  console.log("\n✨ Teste concluído!");
}

testUpdateConductor();
