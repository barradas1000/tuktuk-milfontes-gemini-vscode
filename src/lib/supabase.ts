import { createClient } from "@supabase/supabase-js";

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

// Criar uma única instância do Supabase para toda a aplicação
export const supabase = createClient(supabaseUrl, supabaseAnonKey, {
  realtime: {
    params: {
      eventsPerSecond: 10,
    },
  },
  auth: {
    // Usar storage key único para evitar conflitos
    storageKey: 'tuktuk-milfontes-auth',
    // Auto refresh token
    autoRefreshToken: true,
    persistSession: true,
    detectSessionInUrl: true
  },
  global: {
    // Headers padrão
    headers: {
      'X-Client-Info': 'tuktuk-milfontes-web'
    }
  }
});

// Verificar se as variáveis de ambiente estão configuradas
if (!supabaseUrl || !supabaseAnonKey) {
  console.warn('⚠️ Variáveis de ambiente do Supabase não configuradas!');
  console.warn('VITE_SUPABASE_URL e VITE_SUPABASE_ANON_KEY são necessárias.');
  console.log('Supabase URL:', supabaseUrl);
  console.log('Supabase Anon Key:', supabaseAnonKey);
} else {
  console.log('Supabase client initialized successfully.');
}

// Exportar o cliente Supabase para uso em outros módulos
export default supabase;