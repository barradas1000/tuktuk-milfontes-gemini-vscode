require('dotenv').config();
const { createClient } = require('@supabase/supabase-js');

// ========================================
// 🔧 CRIAR USER DIRETAMENTE VIA SERVICE ROLE
// ========================================

async function criarUserAuth() {
  const supabaseUrl = 'https://iweurnqdomiqlohvaoat.supabase.co';
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  
  const supabase = createClient(supabaseUrl, serviceRoleKey, {
    auth: {
      autoRefreshToken: false,
      persistSession: false
    }
  });

  console.log('🔧 CRIANDO USER DE AUTENTICAÇÃO');
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

  try {
    // 1. Buscar o profile existente para pegar o ID
    const { data: profile, error: profileError } = await supabase
      .from('profiles')
      .select('id, email, full_name, role, admin_level')
      .eq('email', 'carlosbarradas1@gmail.com')
      .single();
    
    if (profileError || !profile) {
      console.log('❌ Profile não encontrado:', profileError?.message);
      return;
    }
    
    console.log('✅ Profile encontrado:', profile.email);
    console.log('🆔 ID:', profile.id);
    
    // 2. Criar user usando raw SQL via rpc
    console.log('\n🔧 Criando user na tabela auth.users...');
    
    const userId = profile.id;
    
    // Usar SQL raw para inserir na tabela auth.users
    const { data: sqlResult, error: sqlError } = await supabase.rpc('exec_sql', {
      query: `
        INSERT INTO auth.users (
          instance_id, id, aud, role, email, encrypted_password,
          email_confirmed_at, created_at, updated_at, raw_app_meta_data,
          raw_user_meta_data, is_super_admin
        ) VALUES (
          '00000000-0000-0000-0000-000000000000'::uuid,
          '${userId}'::uuid,
          'authenticated',
          'authenticated',
          'carlosbarradas1@gmail.com',
          crypt('TukTuk2025!', gen_salt('bf')),
          now(),
          now(),
          now(),
          '{"provider":"email","providers":["email"]}'::jsonb,
          '{}'::jsonb,
          true
        )
        ON CONFLICT (id) DO UPDATE SET
          email = EXCLUDED.email,
          encrypted_password = EXCLUDED.encrypted_password,
          email_confirmed_at = EXCLUDED.email_confirmed_at,
          is_super_admin = EXCLUDED.is_super_admin,
          updated_at = now()
        RETURNING id, email, is_super_admin;
      `
    });
    
    if (sqlError) {
      console.log('❌ Erro SQL:', sqlError.message);
      return;
    }
    
    console.log('✅ User criado/atualizado na auth.users');
    
    // 3. Testar login imediatamente
    console.log('\n🔑 Testando login...');
    
    // Criar nova instância com anon key para testar como user normal
    const testSupabase = createClient(supabaseUrl, process.env.VITE_SUPABASE_ANON_KEY);
    
    const { data: loginData, error: loginError } = await testSupabase.auth.signInWithPassword({
      email: 'carlosbarradas1@gmail.com',
      password: 'TukTuk2025!'
    });
    
    if (loginError) {
      console.log('❌ Erro no teste de login:', loginError.message);
      return;
    }
    
    console.log('✅ LOGIN TESTE FUNCIONOU!');
    console.log('👤 User ID:', loginData.user.id);
    console.log('📧 Email:', loginData.user.email);
    
    // Fazer logout do teste
    await testSupabase.auth.signOut();
    
    console.log('\n🎉 SUCESSO COMPLETO!');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log('✅ Carlos Barradas pode fazer login agora!');
    console.log('📧 Email: carlosbarradas1@gmail.com');
    console.log('🔑 Password: TukTuk2025!');
    console.log('🌐 URL: http://localhost:8080/');
    console.log('🎭 Role: admin (Super Admin)');
    
  } catch (error) {
    console.log('❌ Erro geral:', error.message);
  }
}

criarUserAuth();
