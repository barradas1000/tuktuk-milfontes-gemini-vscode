#!/usr/bin/env node

// ========================================
// MIGRAÇÃO SIMPLIFICADA DE USERS
// ========================================
// Este script cria comandos SQL para executar manualmente

const users = [
  {
    oldId: 'c2b84b4e-ecbf-47d1-adc0-f3d7549829b3',
    email: 'motorista.teste@tuktuk-milfontes.pt',
    name: 'Motorista Teste',
    whatsapp: '351965748022'
  },
  {
    oldId: 'c4c9a172-92c2-410e-a671-56b443fc093d',
    email: 'sonia@tuktuk-milfontes.pt', 
    name: 'Sonia',
    whatsapp: '351968784043'
  },
  {
    oldId: 'e4b3296c-13eb-4faa-aead-e246ddb2bf66',
    email: 'diogo@tuktuk-milfontes.pt',
    name: 'Diogo', 
    whatsapp: '351963496320'
  }
];

console.log('🔄 MIGRAÇÃO AUTOMÁTICA DE USERS');
console.log('================================');
console.log('');

console.log('📋 PASSO 1: CRIAR USERS NO DASHBOARD');
console.log('====================================');
console.log('Acesse: https://supabase.com/dashboard/project/iweurnqdomiqlohvaoat/auth/users');
console.log('');

users.forEach((user, index) => {
  console.log(`👤 User ${index + 1}: ${user.name}`);
  console.log(`   Email: ${user.email}`);
  console.log(`   Password: TukTuk2025!`);
  console.log(`   Email Confirmed: ✅ true`);
  console.log(`   User Metadata: {"full_name": "${user.name}", "role": "conductor"}`);
  console.log('');
});

console.log('📝 PASSO 2: ANOTAR NOVOS UUIDs');
console.log('==============================');
users.forEach((user, index) => {
  console.log(`const newId${index + 1} = 'NOVO_UUID_${user.name.toUpperCase().replace(' ', '_')}_AQUI';`);
});
console.log('');

console.log('📊 PASSO 3: EXECUTAR SQL NO PROJETO NOVO');
console.log('=========================================');
console.log('Execute este SQL no projeto iweurnqdomiqlohvaoat:');
console.log('');

// Gerar SQL para profiles
console.log('-- Criar profiles');
console.log('INSERT INTO public.profiles (id, email, full_name, role, admin_level, region, permissions, created_at, updated_at) VALUES');
users.forEach((user, index) => {
  const comma = index === users.length - 1 ? ';' : ',';
  console.log(`(newId${index + 1}, '${user.email}', '${user.name}', 'conductor', 'admin_local', 'milfontes', '{"conductor": {"can_update_location": true, "can_accept_rides": true}}', now(), now())${comma}`);
});
console.log('');

// Gerar SQL para user_roles
console.log('-- Criar user_roles');
console.log('INSERT INTO public.user_roles (user_id, role, created_at, updated_at) VALUES');
users.forEach((user, index) => {
  const comma = index === users.length - 1 ? ';' : ',';
  console.log(`(newId${index + 1}, 'conductor', now(), now())${comma}`);
});
console.log('');

// Gerar SQL para atualizar conductors
console.log('-- Atualizar conductors');
users.forEach((user, index) => {
  console.log(`UPDATE public.conductors SET user_id = newId${index + 1} WHERE id = '${user.oldId}';`);
});
console.log('');

console.log('🧪 PASSO 4: VALIDAR MIGRAÇÃO');
console.log('============================');
console.log('Execute para verificar:');
console.log('');
console.log('SELECT c.name, c.whatsapp, u.email, p.full_name, ur.role');
console.log('FROM public.conductors c');
console.log('LEFT JOIN auth.users u ON c.user_id = u.id');
console.log('LEFT JOIN public.profiles p ON c.user_id = p.id');  
console.log('LEFT JOIN public.user_roles ur ON c.user_id = ur.user_id');
console.log('WHERE c.is_active = true;');
console.log('');

console.log('✅ RESULTADO ESPERADO:');
console.log('======================');
users.forEach(user => {
  console.log(`${user.name} | ${user.whatsapp} | ${user.email} | ${user.name} | conductor`);
});
console.log('');

console.log('🎉 Migração pronta! Siga os passos acima para completar.');

// Também salvar instruções em arquivo
const fs = require('fs');
const instructions = `
# INSTRUÇÕES DE MIGRAÇÃO GERADAS AUTOMATICAMENTE

## Users para criar no Dashboard:

${users.map((user, i) => `
### User ${i + 1}: ${user.name}
- Email: ${user.email}
- Password: TukTuk2025!
- Email Confirmed: true
- Metadata: {"full_name": "${user.name}", "role": "conductor"}
`).join('')}

## SQL para executar após criar users:

\`\`\`sql
-- SUBSTITUIR pelos UUIDs reais gerados
${users.map((user, i) => `const newId${i + 1} = 'NOVO_UUID_${user.name.toUpperCase().replace(' ', '_')}_AQUI';`).join('\n')}

-- Criar profiles
INSERT INTO public.profiles (id, email, full_name, role, admin_level, region, permissions, created_at, updated_at) VALUES
${users.map((user, i) => `(newId${i + 1}, '${user.email}', '${user.name}', 'conductor', 'admin_local', 'milfontes', '{"conductor": {"can_update_location": true, "can_accept_rides": true}}', now(), now())${i === users.length - 1 ? ';' : ','}`).join('\n')}

-- Criar user_roles  
INSERT INTO public.user_roles (user_id, role, created_at, updated_at) VALUES
${users.map((user, i) => `(newId${i + 1}, 'conductor', now(), now())${i === users.length - 1 ? ';' : ','}`).join('\n')}

-- Atualizar conductors
${users.map((user, i) => `UPDATE public.conductors SET user_id = newId${i + 1} WHERE id = '${user.oldId}';`).join('\n')}
\`\`\`
`;

try {
  fs.writeFileSync('MIGRATION-INSTRUCTIONS.md', instructions);
  console.log('📄 Instruções salvas em: MIGRATION-INSTRUCTIONS.md');
} catch (error) {
  console.log('ℹ️  Execute este script com Node.js para salvar as instruções em arquivo');
}
