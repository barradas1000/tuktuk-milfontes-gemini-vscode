import 'dotenv/config';
// Teste de registro de usuário no Supabase Auth via API
// Instale @supabase/supabase-js antes de rodar este script

import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function testSignup() {
  const email = 'carlosbarradas1@gmail.com'; // Use um e-mail de teste
  const password = 'TukTuk2025!';
  const { user, session, error } = await supabase.auth.signUp({
    email,
    password,
  });
  if (error) {
    console.error('Erro ao registrar:', error.message);
  } else {
    console.log('Usuário criado:', user);
    console.log('Sessão:', session);
  }
}

testSignup();
