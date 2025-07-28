-- 🚀 Script Rápido para Criar Tabelas Essenciais
-- Execute este script no SQL Editor do Supabase: https://supabase.com/dashboard/project/iweurnqdomiqlohvaoat/sql

-- 1. Ativar extensões
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. Criar tabela tour_types (sem dependências)
CREATE TABLE IF NOT EXISTS public.tour_types (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    name character varying NOT NULL UNIQUE,
    description text,
    duration_minutes integer NOT NULL,
    base_price numeric NOT NULL,
    max_people integer DEFAULT 4,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now()
);

-- 3. Criar tabela profiles (ligada ao auth.users)
CREATE TABLE IF NOT EXISTS public.profiles (
    id uuid PRIMARY KEY,
    email text,
    full_name text,
    role text DEFAULT 'user',
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id)
);

-- 4. Criar ENUM para conductor status
DO $$ BEGIN
    CREATE TYPE conductor_status AS ENUM ('active', 'blocked', 'expelled', 'inactive');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- 5. Criar tabela conductors (simples para começar)
CREATE TABLE IF NOT EXISTS public.conductors (
    id uuid PRIMARY KEY,
    name text NOT NULL,
    whatsapp text NOT NULL,
    is_active boolean DEFAULT true,
    user_id uuid,
    latitude double precision,
    longitude double precision,
    created_at timestamp without time zone DEFAULT now(),
    region character varying DEFAULT 'milfontes',
    updated_at timestamp with time zone DEFAULT now(),
    status conductor_status DEFAULT 'active',
    CONSTRAINT conductors_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id)
);

-- 6. Criar tabela reservations
CREATE TABLE IF NOT EXISTS public.reservations (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    customer_name character varying NOT NULL,
    customer_email character varying NOT NULL,
    customer_phone character varying NOT NULL,
    reservation_date date NOT NULL,
    reservation_time time without time zone NOT NULL,
    number_of_people integer NOT NULL,
    tour_type character varying NOT NULL,
    special_requests text,
    status character varying DEFAULT 'pending',
    total_price numeric,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    language text,
    manual_payment numeric,
    assigned_conductor_id uuid,
    CONSTRAINT reservations_number_of_people_check CHECK (number_of_people >= 1 AND number_of_people <= 6),
    CONSTRAINT reservations_status_check CHECK (status IN ('pending', 'confirmed', 'cancelled', 'completed'))
);

-- 7. Ativar RLS
ALTER TABLE public.tour_types ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.conductors ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reservations ENABLE ROW LEVEL SECURITY;

-- 8. Criar políticas básicas
CREATE POLICY "Allow public read tour_types" ON public.tour_types FOR SELECT USING (true);
CREATE POLICY "Allow authenticated manage tour_types" ON public.tour_types FOR ALL USING (auth.role() = 'authenticated');

CREATE POLICY "Allow users manage own profile" ON public.profiles FOR ALL USING (auth.uid() = id);

CREATE POLICY "Allow public read conductors" ON public.conductors FOR SELECT USING (true);
CREATE POLICY "Allow authenticated manage conductors" ON public.conductors FOR ALL USING (auth.role() = 'authenticated');

CREATE POLICY "Allow public insert reservations" ON public.reservations FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow authenticated manage reservations" ON public.reservations FOR ALL USING (auth.role() = 'authenticated');

-- Mensagem de sucesso
SELECT '✅ Tabelas criadas com sucesso! Agora pode executar os ficheiros de dados.' as status;
