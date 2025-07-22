import { createClient } from "@supabase/supabase-js";

// Configurações do Supabase
const SUPABASE_URL = "https://cqnahwnnqzraqcslljaz.supabase.co";
const SUPABASE_ANON_KEY =
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNxbmFod25ucXpyYXFjc2xsamF6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE0ODE1NDQsImV4cCI6MjA2NzA1NzU0NH0.3lW9juEq0C8Vq737Og56-aXMGVtLfkB58tjYRwKMnhE";

async function checkConductorCoordinates() {
  try {
    console.log("🔗 Conectando ao Supabase...");
    console.log(`📊 URL: ${SUPABASE_URL}\n`);

    const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

    console.log("📍 COORDENADAS DOS CONDUTORES");
    console.log("=".repeat(50));

    // Consultar condutores com suas coordenadas
    const { data, error } = await supabase
      .from("conductors")
      .select("id, name, latitude, longitude, is_active")
      .order("name");

    if (error) {
      console.log(`❌ Erro ao consultar condutores: ${error.message}`);
      return;
    }

    if (!data || data.length === 0) {
      console.log("📭 Nenhum condutor encontrado");
      return;
    }

    console.log(`✅ Encontrados ${data.length} condutores:\n`);

    data.forEach((conductor, index) => {
      console.log(`📄 Condutor ${index + 1}:`);
      console.log(`  ID: ${conductor.id}`);
      console.log(`  Nome: ${conductor.name || "N/A"}`);
      console.log(`  Latitude: ${conductor.latitude || "N/A"}`);
      console.log(`  Longitude: ${conductor.longitude || "N/A"}`);
      console.log(`  Ativo: ${conductor.is_active ? "✅ Sim" : "❌ Não"}`);

      // Verificar se as coordenadas são válidas
      if (conductor.latitude && conductor.longitude) {
        console.log(
          `  📍 Coordenadas: ${conductor.latitude}, ${conductor.longitude}`
        );

        // Verificar se são coordenadas padrão/fallback
        if (conductor.latitude === 37.724 && conductor.longitude === -8.783) {
          console.log(`  ⚠️  AVISO: Usando coordenadas padrão (fallback)`);
        } else {
          console.log(`  ✅ Coordenadas específicas definidas`);
        }
      } else {
        console.log(`  ❌ Coordenadas não definidas (usando fallback)`);
      }

      console.log(""); // Linha em branco
    });

    console.log("✨ Análise concluída!");
  } catch (error) {
    console.error("❌ Erro inesperado:", error);
  }
}

checkConductorCoordinates();
