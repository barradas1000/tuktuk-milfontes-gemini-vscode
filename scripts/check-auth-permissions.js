import { createClient } from "@supabase/supabase-js";

// Configuração do Supabase
const supabaseUrl = "https://cqnahwnnqzraqcslljaz.supabase.co";
const supabaseKey =
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNxbmFod25ucXpyYXFjc2xsamF6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE0ODE1NDQsImV4cCI6MjA2NzA1NzU0NH0.3lW9juEq0C8Vq737Og56-aXMGVtLfkB58tjYRwKMnhE";

const supabase = createClient(supabaseUrl, supabaseKey);

async function checkAuth() {
  console.log("🔐 VERIFICAÇÃO DE AUTENTICAÇÃO E PERMISSÕES");
  console.log("==================================================");

  try {
    // 1. Verificar usuário atual
    console.log("\n1️⃣ Verificando usuário atual:");
    const {
      data: { user },
      error: userError,
    } = await supabase.auth.getUser();

    if (userError) {
      console.error("❌ Erro ao obter usuário:", userError);
    } else if (user) {
      console.log("✅ Usuário autenticado:");
      console.log(`   ID: ${user.id}`);
      console.log(`   Email: ${user.email}`);
      console.log(`   Role: ${user.role}`);
      console.log(`   Metadata:`, user.user_metadata);
    } else {
      console.log("❌ Usuário não autenticado");
    }

    // 2. Tentar fazer login como admin
    console.log("\n2️⃣ Tentando fazer login como admin:");

    // Primeiro fazer logout se estiver logado
    await supabase.auth.signOut();

    const { data: loginData, error: loginError } =
      await supabase.auth.signInWithPassword({
        email: "admin@tuktuk-milfontes.com",
        password: "admin123",
      });

    if (loginError) {
      console.error("❌ Erro no login admin:", loginError);
    } else {
      console.log("✅ Login admin bem-sucedido:");
      console.log(`   User ID: ${loginData.user?.id}`);
      console.log(`   Email: ${loginData.user?.email}`);
    }

    // 3. Tentar atualização com usuário autenticado
    console.log("\n3️⃣ Tentando atualização com usuário autenticado:");
    const testId = "c2b84b4e-ecbf-47d1-adc0-f3d7549829b3";

    const { data: updateResult, error: updateError } = await supabase
      .from("conductors")
      .update({ is_active: false })
      .eq("id", testId)
      .select();

    if (updateError) {
      console.error("❌ Erro na atualização autenticada:", updateError);
    } else {
      console.log("✅ Resultado da atualização autenticada:", updateResult);
    }

    // 4. Verificar resultado
    console.log("\n4️⃣ Verificando resultado:");
    const { data: checkResult, error: checkError } = await supabase
      .from("conductors")
      .select("id, name, is_active")
      .eq("id", testId)
      .single();

    if (checkError) {
      console.error("❌ Erro ao verificar resultado:", checkError);
    } else {
      console.log("✅ Estado após atualização autenticada:", checkResult);
    }

    // 5. Restaurar e fazer logout
    console.log("\n5️⃣ Restaurando e fazendo logout:");
    await supabase
      .from("conductors")
      .update({ is_active: true })
      .eq("id", testId);

    await supabase.auth.signOut();
    console.log("✅ Logout realizado");
  } catch (error) {
    console.error("💥 Erro geral:", error);
  }

  console.log("\n✨ Verificação concluída!");
}

checkAuth();
