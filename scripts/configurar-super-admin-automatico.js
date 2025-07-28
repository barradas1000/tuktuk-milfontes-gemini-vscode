require('dotenv').config();
const { createClient } = require('@supabase/supabase-js');

// ========================================
// 🔄 CONFIGURAR CARLOS BARRADAS AUTOMATICAMENTE
// ========================================

async function configurarSuperAdmin() {
  // Configuração do Supabase
  const supabaseUrl = 'https://iweurnqdomiqlohvaoat.supabase.co';
  const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY; // Precisa da Service Role Key
  
  if (!supabaseKey) {
    console.error('❌ Erro: SUPABASE_SERVICE_ROLE_KEY não configurada no .env');
    console.log('📋 Adicione ao .env: SUPABASE_SERVICE_ROLE_KEY=sua_service_role_key');
    return;
  }

  const supabase = createClient(supabaseUrl, supabaseKey);

  try {
    console.log('🔍 Configurando Carlos Barradas como Super Admin...');
    
    // 1. Buscar user por email no profiles (mais simples)
    const { data: profile, error: profileError } = await supabase
      .from('profiles')
      .select('*')
      .eq('email', 'carlosbarradas111@gmail.com')
      .single();
    
    if (profileError || !profile) {
      console.error('❌ User não encontrado no profiles:', profileError?.message);
      return;
    }

    console.log('✅ User encontrado:', profile.email);
    const userId = profile.id;

    // 2. Atualizar profile para super admin
    console.log('📝 Atualizando profile...');
    const { error: updateProfileError } = await supabase
      .from('profiles')
      .update({
        full_name: 'Carlos Barradas',
        admin_level: 'super_admin',
        role: 'admin',
        updated_at: new Date().toISOString()
      })
      .eq('id', userId);

    if (updateProfileError) {
      console.error('❌ Erro ao atualizar profile:', updateProfileError.message);
      return;
    }
    console.log('✅ Profile atualizado para Super Admin');

    // 3. Remover roles existentes
    console.log('🗑️ Removendo roles existentes...');
    const { error: deleteError } = await supabase
      .from('user_roles')
      .delete()
      .eq('user_id', userId);

    if (deleteError) {
      console.log('⚠️ Aviso ao remover roles:', deleteError.message);
    } else {
      console.log('✅ Roles antigas removidas');
    }

    // 4. Inserir role conductor (único que sabemos que funciona)
    console.log('➕ Adicionando role conductor...');
    const { error: insertError } = await supabase
      .from('user_roles')
      .insert({
        user_id: userId,
        role: 'conductor',
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      });

    if (insertError) {
      console.error('❌ Erro ao inserir role:', insertError.message);
      return;
    }
    console.log('✅ Role conductor adicionada');

    // 5. Verificar resultado final
    console.log('🔍 Verificando configuração final...');
    
    const { data: finalProfile } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', userId)
      .single();

    const { data: finalRoles } = await supabase
      .from('user_roles')
      .select('role')
      .eq('user_id', userId);

    console.log('\n🎉 CONFIGURAÇÃO COMPLETADA COM SUCESSO!');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log('👤 Nome:', finalProfile?.full_name);
    console.log('📧 Email:', finalProfile?.email);
    console.log('🔑 Admin Level:', finalProfile?.admin_level);
    console.log('🎭 Role no Profile:', finalProfile?.role);
    console.log('📋 Roles na tabela:', finalRoles?.map(r => r.role).join(', '));
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log('✅ Carlos Barradas está configurado como Super Admin!');
    
  } catch (error) {
    console.error('❌ Erro geral:', error.message);
  }
}

// Executar a configuração
configurarSuperAdmin();
