// ========================================
// SCRIPT AUTOMÁTICO PARA MIGRAÇÃO DE USERS
// ========================================
// Execute este script no console do browser

// Configuração dos projetos
const OLD_PROJECT = {
  url: 'https://cqnahwnnqzraqcslljaz.supabase.co',
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNxbmFod25ucXpyYXFjc2xsamF6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI3MTM0ODUsImV4cCI6MjA0ODI4OTQ4NX0.7y89jITkXbxhG5ziFANaKJK5zXzUtZkF_0E4Jq1kNvw',
  serviceKey: 'SUA_SERVICE_KEY_ANTIGA' // Substituir pela service key real
};

const NEW_PROJECT = {
  url: 'https://iweurnqdomiqlohvaoat.supabase.co',
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml3ZXVybnFkb21pcWxvaHZhb2F0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI3MTM2MjgsImV4cCI6MjA0ODI4OTYyOH0.ODBSCpfMKaDYb4DFBz9Sn9NJLJjH4Ku0lfEKzP3_EQ4',
  serviceKey: 'SUA_SERVICE_KEY_NOVA' // Substituir pela service key real
};

// IDs dos users para migrar
const USER_IDS = [
  'c2b84b4e-ecbf-47d1-adc0-f3d7549829b3', // Motorista Teste
  'c4c9a172-92c2-410e-a671-56b443fc093d', // Sonia  
  'e4b3296c-13eb-4faa-aead-e246ddb2bf66'  // Diogo
];

// ========================================
// FUNÇÃO PARA EXTRAIR USERS DO PROJETO ANTIGO
// ========================================
async function extractUsersFromOldProject() {
  console.log('🔍 Extraindo users do projeto antigo...');
  
  try {
    // Tentar via SQL direto (se funcionar)
    const response = await fetch(`${OLD_PROJECT.url}/rest/v1/rpc/get_auth_users`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${OLD_PROJECT.serviceKey}`,
        'Content-Type': 'application/json',
        'apikey': OLD_PROJECT.anonKey
      },
      body: JSON.stringify({ user_ids: USER_IDS })
    });
    
    if (response.ok) {
      const users = await response.json();
      console.log('✅ Users extraídos:', users);
      return users;
    }
  } catch (error) {
    console.log('❌ Erro na extração automática:', error);
  }
  
  // Fallback: Dados conhecidos dos conductors
  console.log('📋 Usando dados conhecidos dos conductors...');
  return [
    {
      id: 'c2b84b4e-ecbf-47d1-adc0-f3d7549829b3',
      email: 'motorista.teste@tuktuk-milfontes.pt',
      name: 'Motorista Teste'
    },
    {
      id: 'c4c9a172-92c2-410e-a671-56b443fc093d', 
      email: 'sonia@tuktuk-milfontes.pt',
      name: 'Sonia'
    },
    {
      id: 'e4b3296c-13eb-4faa-aead-e246ddb2bf66',
      email: 'diogo@tuktuk-milfontes.pt', 
      name: 'Diogo'
    }
  ];
}

// ========================================
// FUNÇÃO PARA CRIAR USERS NO PROJETO NOVO
// ========================================
async function createUsersInNewProject(users) {
  console.log('➕ Criando users no projeto novo...');
  
  const createdUsers = [];
  
  for (const user of users) {
    try {
      console.log(`Criando user: ${user.email}`);
      
      const response = await fetch(`${NEW_PROJECT.url}/auth/v1/admin/users`, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${NEW_PROJECT.serviceKey}`,
          'Content-Type': 'application/json',
          'apikey': NEW_PROJECT.anonKey
        },
        body: JSON.stringify({
          email: user.email,
          password: 'TukTuk2025!',
          email_confirm: true,
          user_metadata: {
            full_name: user.name,
            role: 'conductor'
          }
        })
      });
      
      if (response.ok) {
        const newUser = await response.json();
        console.log(`✅ User criado: ${user.email} → ${newUser.id}`);
        createdUsers.push({
          oldId: user.id,
          newId: newUser.id,
          email: user.email,
          name: user.name
        });
      } else {
        const error = await response.text();
        console.log(`❌ Erro ao criar ${user.email}:`, error);
      }
    } catch (error) {
      console.log(`❌ Erro ao criar ${user.email}:`, error);
    }
  }
  
  return createdUsers;
}

// ========================================
// FUNÇÃO PARA CRIAR PROFILES E ATUALIZAR CONDUCTORS
// ========================================
async function createProfilesAndUpdateConductors(userMapping) {
  console.log('👤 Criando profiles e atualizando conductors...');
  
  for (const mapping of userMapping) {
    try {
      // Criar profile
      console.log(`Criando profile para: ${mapping.email}`);
      
      const profileResponse = await fetch(`${NEW_PROJECT.url}/rest/v1/profiles`, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${NEW_PROJECT.serviceKey}`,
          'Content-Type': 'application/json',
          'apikey': NEW_PROJECT.anonKey,
          'Prefer': 'return=representation'
        },
        body: JSON.stringify({
          id: mapping.newId,
          email: mapping.email,
          full_name: mapping.name,
          role: 'conductor',
          admin_level: 'admin_local',
          region: 'milfontes',
          permissions: {
            conductor: {
              can_update_location: true,
              can_accept_rides: true,
              can_view_reservations: true
            }
          }
        })
      });
      
      if (profileResponse.ok) {
        console.log(`✅ Profile criado para: ${mapping.email}`);
      }
      
      // Criar user_role
      const roleResponse = await fetch(`${NEW_PROJECT.url}/rest/v1/user_roles`, {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${NEW_PROJECT.serviceKey}`,
          'Content-Type': 'application/json',
          'apikey': NEW_PROJECT.anonKey
        },
        body: JSON.stringify({
          user_id: mapping.newId,
          role: 'conductor'
        })
      });
      
      if (roleResponse.ok) {
        console.log(`✅ User role criado para: ${mapping.email}`);
      }
      
      // Atualizar conductor
      const conductorResponse = await fetch(`${NEW_PROJECT.url}/rest/v1/conductors?id=eq.${mapping.oldId}`, {
        method: 'PATCH',
        headers: {
          'Authorization': `Bearer ${NEW_PROJECT.serviceKey}`,
          'Content-Type': 'application/json',
          'apikey': NEW_PROJECT.anonKey
        },
        body: JSON.stringify({
          user_id: mapping.newId
        })
      });
      
      if (conductorResponse.ok) {
        console.log(`✅ Conductor atualizado para: ${mapping.email}`);
      }
      
    } catch (error) {
      console.log(`❌ Erro ao processar ${mapping.email}:`, error);
    }
  }
}

// ========================================
// FUNÇÃO PRINCIPAL
// ========================================
async function migrateUsers() {
  console.log('🚀 INICIANDO MIGRAÇÃO AUTOMÁTICA DE USERS');
  console.log('==========================================');
  
  try {
    // Passo 1: Extrair users
    const oldUsers = await extractUsersFromOldProject();
    
    // Passo 2: Criar users no projeto novo
    const userMapping = await createUsersInNewProject(oldUsers);
    
    if (userMapping.length === 0) {
      console.log('❌ Nenhum user foi criado. Verifique as service keys.');
      return;
    }
    
    // Passo 3: Criar profiles e atualizar conductors
    await createProfilesAndUpdateConductors(userMapping);
    
    // Passo 4: Mostrar mapeamento final
    console.log('\n🎉 MIGRAÇÃO CONCLUÍDA!');
    console.log('========================');
    console.log('Mapeamento de UUIDs:');
    userMapping.forEach(mapping => {
      console.log(`${mapping.name}: ${mapping.oldId} → ${mapping.newId}`);
    });
    
    return userMapping;
    
  } catch (error) {
    console.log('❌ Erro geral na migração:', error);
  }
}

// ========================================
// EXECUTAR MIGRAÇÃO
// ========================================
console.log('📋 Para executar a migração:');
console.log('1. Atualize as SERVICE_KEYs nas variáveis OLD_PROJECT e NEW_PROJECT');
console.log('2. Execute: migrateUsers()');
console.log('3. Aguarde a conclusão e verifique os resultados');

// Executar automaticamente se as service keys estiverem configuradas
if (OLD_PROJECT.serviceKey !== 'SUA_SERVICE_KEY_ANTIGA' && 
    NEW_PROJECT.serviceKey !== 'SUA_SERVICE_KEY_NOVA') {
  migrateUsers();
} else {
  console.log('⚠️  Configure as service keys primeiro!');
}
