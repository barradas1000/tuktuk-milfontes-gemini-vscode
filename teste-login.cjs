require('dotenv').config();
const { createClient } = require('@supabase/supabase-js');

// ========================================
// 🔍 TESTE FINAL DE LOGIN
// ========================================

async function testarLogin() {
  const supabaseUrl = 'https://iweurnqdomiqlohvaoat.supabase.co';
  const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY; // Usar anon key como na aplicação
  
  const supabase = createClient(supabaseUrl, supabaseKey);

  console.log('🔍 TESTE FINAL DE LOGIN');
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

  try {
    // 1. Verificar configuração
    console.log('📧 Email: carlosbarradas111@gmail.com');
    console.log('🔑 Password: TukTuk2025!');
    console.log('🌐 URL Supabase:', supabaseUrl);
    console.log('🔐 Anon Key:', supabaseKey ? 'Configurada ✅' : 'Não configurada ❌');
    
    // 2. Tentar login
    console.log('\n🔑 Tentando fazer login...');
    const { data: loginData, error: loginError } = await supabase.auth.signInWithPassword({
      email: 'carlosbarradas111@gmail.com',
      password: 'TukTuk2025!'
    });
    
    if (loginError) {
      console.log('❌ ERRO NO LOGIN:', loginError.message);
      console.log('💡 Soluções possíveis:');
      console.log('   1. Execute o script sql/criar-user-auth.sql no Supabase');
      console.log('   2. Verifique se o user existe na aba Auth > Users');
      console.log('   3. Confirme se a password está correta');
      return false;
    }
    
    console.log('✅ LOGIN SUCESSO!');
    console.log('👤 User ID:', loginData.user.id);
    console.log('📧 Email:', loginData.user.email);
    console.log('🔒 Session ativa:', !!loginData.session);
    
    // 3. Buscar profile
    console.log('\n📋 Buscando profile...');
    const { data: profile, error: profileError } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', loginData.user.id)
      .single();
    
    if (profileError) {
      console.log('❌ Erro ao buscar profile:', profileError.message);
      return false;
    }
    
    console.log('✅ PROFILE ENCONTRADO:');
    console.log('👤 Nome:', profile.full_name);
    console.log('🎭 Role:', profile.role);
    console.log('🔑 Admin Level:', profile.admin_level);
    
    // 4. Fazer logout
    await supabase.auth.signOut();
    console.log('\n🚪 Logout realizado');
    
    console.log('\n🎉 TESTE COMPLETO - LOGIN FUNCIONANDO!');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log('✅ Pode fazer login na aplicação agora!');
    console.log('🌐 Acesse: http://localhost:8080/');
    
    return true;
    
  } catch (error) {
    console.log('❌ ERRO GERAL:', error.message);
    return false;
  }
}

testarLogin();
