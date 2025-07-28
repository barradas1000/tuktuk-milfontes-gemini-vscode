-- Script completo para criar todas as tabelas no projeto iweurnqdomiqlohvaoat
-- Execute este script no SQL Editor do Supabase

-- 1. Ativar extensões necessárias
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. Criar ENUMs
CREATE TYPE admin_level AS ENUM ('super_admin', 'admin_regional', 'admin_local');
CREATE TYPE conductor_status AS ENUM ('active', 'blocked', 'expelled', 'inactive');
CREATE TYPE vehicle_status AS ENUM ('operational', 'maintenance', 'out_of_service');
CREATE TYPE application_status AS ENUM ('link_created', 'submitted', 'approved', 'rejected', 'expired');

-- 3. Criar tabela tour_types
CREATE TABLE public.tour_types (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    description text,
    duration_minutes integer NOT NULL,
    base_price numeric NOT NULL,
    max_people integer DEFAULT 4,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT tour_types_pkey PRIMARY KEY (id),
    CONSTRAINT tour_types_name_key UNIQUE (name)
);

-- 4. Criar tabela profiles
CREATE TABLE public.profiles (
    id uuid NOT NULL,
    email text,
    full_name text,
    role text DEFAULT 'user'::text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    admin_level admin_level DEFAULT 'admin_local'::admin_level,
    region character varying,
    permissions jsonb DEFAULT '{}'::jsonb,
    created_by uuid,
    zone character varying,
    CONSTRAINT profiles_pkey PRIMARY KEY (id),
    CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id),
    CONSTRAINT profiles_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth.users(id)
);

-- 5. Criar tabela tuktuks
CREATE TABLE public.tuktuks (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    nome text NOT NULL,
    identificador text NOT NULL,
    ativo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    CONSTRAINT tuktuks_pkey PRIMARY KEY (id),
    CONSTRAINT tuktuks_identificador_key UNIQUE (identificador)
);

-- 6. Criar tabela tuktuk_vehicles
CREATE TABLE public.tuktuk_vehicles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    vehicle_number integer NOT NULL,
    vehicle_name character varying NOT NULL,
    region character varying NOT NULL,
    zone character varying,
    managed_by uuid,
    is_available boolean DEFAULT true,
    is_active boolean DEFAULT false,
    current_conductor uuid,
    license_plate character varying,
    vehicle_info jsonb DEFAULT '{}'::jsonb,
    maintenance_status vehicle_status DEFAULT 'operational'::vehicle_status,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    CONSTRAINT tuktuk_vehicles_pkey PRIMARY KEY (id),
    CONSTRAINT tuktuk_vehicles_managed_by_fkey FOREIGN KEY (managed_by) REFERENCES auth.users(id)
);

-- 7. Criar tabela conductors
CREATE TABLE public.conductors (
    id uuid NOT NULL,
    name text NOT NULL,
    whatsapp text NOT NULL,
    is_active boolean,
    user_id uuid,
    tuktuk_id uuid,
    latitude double precision,
    longitude double precision,
    created_at timestamp without time zone,
    region character varying DEFAULT 'milfontes'::character varying,
    updated_at timestamp with time zone DEFAULT now(),
    updated_by uuid,
    status conductor_status DEFAULT 'active'::conductor_status,
    assigned_vehicle uuid,
    blocked_by uuid,
    blocked_at timestamp without time zone,
    block_reason text,
    restricted_zone jsonb,
    CONSTRAINT conductors_pkey PRIMARY KEY (id),
    CONSTRAINT conductors_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id),
    CONSTRAINT conductors_tuktuk_id_fkey FOREIGN KEY (tuktuk_id) REFERENCES public.tuktuks(id),
    CONSTRAINT conductors_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES auth.users(id),
    CONSTRAINT conductors_assigned_vehicle_fkey FOREIGN KEY (assigned_vehicle) REFERENCES public.tuktuk_vehicles(id),
    CONSTRAINT conductors_blocked_by_fkey FOREIGN KEY (blocked_by) REFERENCES auth.users(id)
);

-- 8. Adicionar foreign key que depende de conductors
ALTER TABLE public.tuktuk_vehicles 
ADD CONSTRAINT tuktuk_vehicles_current_conductor_fkey 
FOREIGN KEY (current_conductor) REFERENCES public.conductors(id);

-- 9. Criar tabela reservations
CREATE TABLE public.reservations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    customer_name character varying NOT NULL,
    customer_email character varying NOT NULL,
    customer_phone character varying NOT NULL,
    reservation_date date NOT NULL,
    reservation_time time without time zone NOT NULL,
    number_of_people integer NOT NULL,
    tour_type character varying NOT NULL,
    special_requests text,
    status character varying DEFAULT 'pending'::character varying,
    total_price numeric,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    language text,
    manual_payment numeric,
    assigned_conductor_id uuid,
    CONSTRAINT reservations_pkey PRIMARY KEY (id),
    CONSTRAINT reservations_number_of_people_check CHECK (((number_of_people >= 1) AND (number_of_people <= 6))),
    CONSTRAINT reservations_status_check CHECK ((status::text = ANY (ARRAY['pending'::character varying, 'confirmed'::character varying, 'cancelled'::character varying, 'completed'::character varying]::text[])))
);

-- 10. Outras tabelas auxiliares
CREATE TABLE public.tuk_tuk_availability (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tuk_tuk_id character varying NOT NULL,
    available_date date NOT NULL,
    time_slots jsonb DEFAULT '{}'::jsonb NOT NULL,
    max_capacity integer DEFAULT 4,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT tuk_tuk_availability_pkey PRIMARY KEY (id)
);

CREATE TABLE public.blocked_periods (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    date date NOT NULL,
    start_time time without time zone,
    end_time time without time zone,
    reason text,
    created_by text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    "createdBy" text,
    CONSTRAINT blocked_periods_pkey PRIMARY KEY (id)
);

CREATE TABLE public.user_roles (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    user_id uuid,
    role text,
    CONSTRAINT user_roles_pkey PRIMARY KEY (id),
    CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id),
    CONSTRAINT user_roles_role_check CHECK ((role = ANY (ARRAY['admin'::text, 'condutor'::text])))
);

-- 11. Tabelas de auditoria e localização
CREATE TABLE public.conductor_locations (
    id uuid NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    conductor_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    accuracy numeric NOT NULL,
    CONSTRAINT conductor_locations_pkey PRIMARY KEY (id, latitude, longitude, updated_at, conductor_id, created_at, accuracy),
    CONSTRAINT conductor_locations_conductor_id_fkey FOREIGN KEY (conductor_id) REFERENCES public.conductors(id)
);

CREATE TABLE public.active_conductors (
    id integer NOT NULL,
    conductor_id uuid UNIQUE,
    is_active boolean DEFAULT false,
    activated_at timestamp with time zone,
    deactivated_at timestamp with time zone,
    CONSTRAINT active_conductors_pkey PRIMARY KEY (id)
);

CREATE SEQUENCE active_conductors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE active_conductors_id_seq OWNED BY public.active_conductors.id;
ALTER TABLE ONLY public.active_conductors ALTER COLUMN id SET DEFAULT nextval('active_conductors_id_seq'::regclass);

-- 12. Ativar RLS em todas as tabelas
ALTER TABLE public.tour_types ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tuktuks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tuktuk_vehicles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.conductors ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reservations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tuk_tuk_availability ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.blocked_periods ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.conductor_locations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.active_conductors ENABLE ROW LEVEL SECURITY;

-- 13. Comentários nas tabelas
COMMENT ON COLUMN public.reservations.manual_payment IS 'Valor de pagamento manual inserido pelo administrador';
COMMENT ON COLUMN public.conductors.is_active IS 'status do condutor';
COMMENT ON COLUMN public.profiles.admin_level IS 'Nível de permissão do administrador';
COMMENT ON COLUMN public.profiles.region IS 'Região de responsabilidade do administrador';
COMMENT ON COLUMN public.profiles.permissions IS 'Permissões específicas em formato JSON';

-- Mensagem final
SELECT 'Schema criado com sucesso! Agora pode executar os arquivos de dados.' as status;
