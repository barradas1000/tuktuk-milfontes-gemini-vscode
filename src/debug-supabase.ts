console.log('🔍 VERIFICAÇÃO DE CONFIGURAÇÃO SUPABASE');
console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
console.log('VITE_SUPABASE_URL:', import.meta.env.VITE_SUPABASE_URL);
console.log('VITE_SUPABASE_ANON_KEY:', import.meta.env.VITE_SUPABASE_ANON_KEY ? '✅ Configurada' : '❌ Não configurada');
console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

// Testar conexão básica
import { supabase } from './supabase';

async function testarConexao() {
  try {
    console.log('🔗 Testando conexão com Supabase...');
    
    // Teste simples de conexão
    const { data, error } = await supabase.auth.getSession();
    
    if (error) {
      console.error('❌ Erro na conexão:', error.message);
    } else {
      console.log('✅ Conexão com Supabase OK');
      console.log('Session:', data.session ? 'Ativa' : 'Inativa');
    }
  } catch (err) {
    console.error('❌ Erro ao testar conexão:', err);
  }
}

testarConexao();
