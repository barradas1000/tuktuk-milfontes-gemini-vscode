import { createClient } from "@supabase/supabase-js";

// Configuração do Supabase
const supabaseUrl = "https://cqnahwnnqzraqcslljaz.supabase.co";
const supabaseKey =
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNxbmFod25ucXpyYXFjc2xsamF6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE0ODE1NDQsImV4cCI6MjA2NzA1NzU0NH0.3lW9juEq0C8Vq737Og56-aXMGVtLfkB58tjYRwKMnhE";

const supabase = createClient(supabaseUrl, supabaseKey);

async function checkProfiles() {
  console.log("👥 VERIFICANDO PROFILES E USUÁRIOS");
  console.log("==================================================");

  try {
    // 1. Verificar usuários existentes na tabela auth.users (não diretamente acessível)
    console.log("\n1️⃣ Tentando criar usuário admin se não existir:");

    const { data: signUpData, error: signUpError } = await supabase.auth.signUp(
      {
        email: "admin@gmail.com",
        password: "admin123456",
        options: {
          data: {
            full_name: "Administrador TukTuk",
            role: "admin",
          },
        },
      }
    );

    if (signUpError) {
      if (signUpError.message.includes("already registered")) {
        console.log("✅ Usuário admin já existe");
      } else {
        console.error("❌ Erro ao criar usuário admin:", signUpError);
      }
    } else {
      console.log("✅ Usuário admin criado:", signUpData.user?.email);
    }

    // 2. Tentar fazer login
    console.log("\n2️⃣ Tentando fazer login com admin:");
    const { data: loginData, error: loginError } =
      await supabase.auth.signInWithPassword({
        email: "admin@gmail.com",
        password: "admin123456",
      });

    if (loginError) {
      console.error("❌ Erro no login:", loginError);
    } else {
      console.log("✅ Login bem-sucedido:", loginData.user?.email);

      // 3. Verificar se o perfil existe
      console.log("\n3️⃣ Verificando perfil na tabela profiles:");
      const { data: profile, error: profileError } = await supabase
        .from("profiles")
        .select("*")
        .eq("id", loginData.user?.id)
        .single();

      if (profileError) {
        console.error("❌ Erro ao buscar perfil:", profileError);

        // Tentar criar perfil se não existir
        console.log("\n4️⃣ Criando perfil na tabela profiles:");
        const { data: newProfile, error: createProfileError } = await supabase
          .from("profiles")
          .insert({
            id: loginData.user?.id,
            email: loginData.user?.email,
            full_name: "Administrador TukTuk",
            role: "admin",
          })
          .select()
          .single();

        if (createProfileError) {
          console.error("❌ Erro ao criar perfil:", createProfileError);
        } else {
          console.log("✅ Perfil criado:", newProfile);
        }
      } else {
        console.log("✅ Perfil encontrado:", profile);
      }

      // 4. Testar atualização de condutor com usuário autenticado
      console.log(
        "\n5️⃣ Testando atualização de condutor com usuário autenticado:"
      );
      const testId = "c2b84b4e-ecbf-47d1-adc0-f3d7549829b3";

      const { data: updateResult, error: updateError } = await supabase
        .from("conductors")
        .update({ is_active: false })
        .eq("id", testId)
        .select();

      if (updateError) {
        console.error("❌ Erro na atualização:", updateError);
      } else {
        console.log("✅ Atualização bem-sucedida:", updateResult);

        // Reverter
        await supabase
          .from("conductors")
          .update({ is_active: true })
          .eq("id", testId);
        console.log("✅ Estado revertido");
      }

      // Fazer logout
      await supabase.auth.signOut();
      console.log("✅ Logout realizado");
    }
  } catch (error) {
    console.error("💥 Erro geral:", error);
  }

  console.log("\n✨ Verificação concluída!");
}

checkProfiles();
