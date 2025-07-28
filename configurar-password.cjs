require('dotenv').config();
const { createClient } = require('@supabase/supabase-js');

// ========================================
// 🔍 VERIFICAR E CONFIGURAR PASSWORD
// ========================================

async function verificarEConfigurarPassword() {
  const supabaseUrl = 'https://iweurnqdomiqlohvaoat.supabase.co';
  const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  
  if (!supabaseKey) {
    console.error('❌ SUPABASE_SERVICE_ROLE_KEY não configurada');
    return;
  }

  const supabase = createClient(supabaseUrl, supabaseKey, {
    auth: {
      autoRefreshToken: false,
      persistSession: false
    }
  });

  try {
    console.log('🔍 Verificando Carlos Barradas...');
    
    // 1. Verificar profile primeiro
    const { data: profile, error: profileError } = await supabase
      .from('profiles')
      .select('*')
      .eq('email', 'carlosbarradas1@gmail.com')
      .single();
    
    if (profileError || !profile) {
      console.log('❌ Profile não encontrado:', profileError?.message);
      return;
    }
    
    console.log('✅ Profile encontrado:', profile.email);
    
    // 2. Tentar fazer signup (vai dar erro se já existir, mas vai mostrar o problema)
    console.log('🔧 Tentando criar/verificar user na autenticação...');
    
    const { data: signUpData, error: signUpError } = await supabase.auth.signUp({
      email: 'carlosbarradas1@gmail.com',
      password: 'TukTuk2025!'
    });
    
    if (signUpError) {
      if (signUpError.message.includes('already registered')) {
        console.log('✅ User já existe na autenticação');
        
        // Tentar login para testar
        console.log('� Testando login...');
        const { data: loginData, error: loginError } = await supabase.auth.signInWithPassword({
          email: 'carlosbarradas1@gmail.com',
          password: 'TukTuk2025!'
        });
        
        if (loginError) {
          console.log('❌ Erro no login:', loginError.message);
          console.log('💡 Possível solução: Password pode estar diferente');
        } else {
          console.log('✅ Login funcionando perfeitamente!');
        }
        
      } else {
        console.log('❌ Erro no signup:', signUpError.message);
      }
    } else {
      console.log('✅ User criado com sucesso!');
    }

    console.log('\n� CREDENCIAIS PARA TESTE:');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log('📧 Email: carlosbarradas1@gmail.com');
    console.log('🔑 Password: TukTuk2025!');
    console.log('🌐 Acesse: http://localhost:8080/');
    
  } catch (error) {
    console.error('❌ Erro geral:', error.message);
  }
}

verificarEConfigurarPassword();

verificarEConfigurarPassword();
