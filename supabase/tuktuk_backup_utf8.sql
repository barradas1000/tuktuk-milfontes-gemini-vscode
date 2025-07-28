--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.5

-- Started on 2025-07-24 16:20:59

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 20 (class 2615 OID 16492)
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- TOC entry 15 (class 2615 OID 16388)
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- TOC entry 18 (class 2615 OID 16622)
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- TOC entry 17 (class 2615 OID 16611)
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- TOC entry 10 (class 2615 OID 16386)
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- TOC entry 23 (class 2615 OID 16603)
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- TOC entry 19 (class 2615 OID 16540)
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- TOC entry 14 (class 2615 OID 19548)
-- Name: supabase_migrations; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA supabase_migrations;


ALTER SCHEMA supabase_migrations OWNER TO postgres;

--
-- TOC entry 16 (class 2615 OID 16651)
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- TOC entry 6 (class 3079 OID 16687)
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- TOC entry 4349 (class 0 OID 0)
-- Dependencies: 6
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- TOC entry 2 (class 3079 OID 16389)
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- TOC entry 4350 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- TOC entry 4 (class 3079 OID 16441)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- TOC entry 4351 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 5 (class 3079 OID 16652)
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- TOC entry 4352 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- TOC entry 3 (class 3079 OID 16430)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- TOC entry 4353 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- TOC entry 1162 (class 1247 OID 16780)
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- TOC entry 1186 (class 1247 OID 16921)
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- TOC entry 1159 (class 1247 OID 16774)
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- TOC entry 1156 (class 1247 OID 16769)
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1192 (class 1247 OID 16963)
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1117 (class 1247 OID 45687)
-- Name: admin_level; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.admin_level AS ENUM (
    'super_admin',
    'admin_regional',
    'admin_local'
);


ALTER TYPE public.admin_level OWNER TO postgres;

--
-- TOC entry 4354 (class 0 OID 0)
-- Dependencies: 1117
-- Name: TYPE admin_level; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE public.admin_level IS 'N├¡veis de administrador: super_admin (acesso total), admin_regional (regi├úo espec├¡fica), admin_local (├írea local)';


--
-- TOC entry 1246 (class 1247 OID 45735)
-- Name: application_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.application_status AS ENUM (
    'link_created',
    'submitted',
    'approved',
    'rejected',
    'expired'
);


ALTER TYPE public.application_status OWNER TO postgres;

--
-- TOC entry 1252 (class 1247 OID 45746)
-- Name: conductor_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.conductor_status AS ENUM (
    'active',
    'blocked',
    'expelled',
    'inactive'
);


ALTER TYPE public.conductor_status OWNER TO postgres;

--
-- TOC entry 1255 (class 1247 OID 45756)
-- Name: vehicle_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.vehicle_status AS ENUM (
    'operational',
    'maintenance',
    'out_of_service'
);


ALTER TYPE public.vehicle_status OWNER TO postgres;

--
-- TOC entry 1234 (class 1247 OID 17135)
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- TOC entry 1207 (class 1247 OID 17094)
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- TOC entry 1210 (class 1247 OID 17109)
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- TOC entry 1240 (class 1247 OID 17176)
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- TOC entry 1237 (class 1247 OID 17147)
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- TOC entry 440 (class 1255 OID 16538)
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- TOC entry 4355 (class 0 OID 0)
-- Dependencies: 440
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- TOC entry 459 (class 1255 OID 16751)
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- TOC entry 439 (class 1255 OID 16537)
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- TOC entry 4358 (class 0 OID 0)
-- Dependencies: 439
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- TOC entry 438 (class 1255 OID 16536)
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- TOC entry 4360 (class 0 OID 0)
-- Dependencies: 438
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- TOC entry 441 (class 1255 OID 16595)
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- TOC entry 4376 (class 0 OID 0)
-- Dependencies: 441
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- TOC entry 445 (class 1255 OID 16616)
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- TOC entry 4378 (class 0 OID 0)
-- Dependencies: 445
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- TOC entry 442 (class 1255 OID 16597)
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- TOC entry 4380 (class 0 OID 0)
-- Dependencies: 442
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- TOC entry 443 (class 1255 OID 16607)
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- TOC entry 444 (class 1255 OID 16608)
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- TOC entry 446 (class 1255 OID 16618)
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- TOC entry 4409 (class 0 OID 0)
-- Dependencies: 446
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- TOC entry 388 (class 1255 OID 16387)
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- TOC entry 493 (class 1255 OID 45862)
-- Name: assign_vehicle(uuid, uuid, uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.assign_vehicle(conductor_id uuid, vehicle_id uuid, assigned_by uuid) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
BEGIN
  -- Verificar se ve├¡culo est├í dispon├¡vel
  IF NOT EXISTS (
    SELECT 1 FROM tuktuk_vehicles 
    WHERE id = $2 AND is_available = true AND current_conductor IS NULL
  ) THEN
    RAISE EXCEPTION 'Ve├¡culo n├úo est├í dispon├¡vel';
  END IF;
  
  -- Remover condutor do ve├¡culo anterior
  UPDATE tuktuk_vehicles 
  SET current_conductor = NULL 
  WHERE current_conductor = $1;
  
  -- Atribuir novo ve├¡culo
  UPDATE conductors 
  SET assigned_vehicle = $2 
  WHERE id = $1;
  
  UPDATE tuktuk_vehicles 
  SET current_conductor = $1 
  WHERE id = $2;
  
  RETURN TRUE;
END;
$_$;


ALTER FUNCTION public.assign_vehicle(conductor_id uuid, vehicle_id uuid, assigned_by uuid) OWNER TO postgres;

--
-- TOC entry 490 (class 1255 OID 45859)
-- Name: block_conductor(uuid, text, uuid, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.block_conductor(conductor_id uuid, block_reason text, blocked_by uuid, duration text DEFAULT NULL::text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
BEGIN
  UPDATE conductors 
  SET 
    status = 'blocked',
    blocked_by = $3,
    blocked_at = NOW(),
    block_reason = $2
  WHERE id = $1;
  
  -- Log da a├º├úo na auditoria (se tabela existir)
  IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'conductor_status_audit') THEN
    INSERT INTO conductor_status_audit (
      conductor_id,
      old_status,
      new_status,
      changed_by,
      reason
    ) VALUES (
      $1,
      'active',
      'blocked',
      $3,
      $2
    );
  END IF;
  
  RETURN TRUE;
END;
$_$;


ALTER FUNCTION public.block_conductor(conductor_id uuid, block_reason text, blocked_by uuid, duration text) OWNER TO postgres;

--
-- TOC entry 485 (class 1255 OID 45727)
-- Name: check_admin_permissions(uuid, uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_admin_permissions(target_conductor_id uuid, admin_user_id uuid) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  admin_profile public.profiles;
  conductor_region VARCHAR(100);
BEGIN
  -- Buscar perfil do admin
  SELECT * INTO admin_profile 
  FROM public.profiles 
  WHERE id = admin_user_id AND role = 'admin';
  
  IF admin_profile IS NULL THEN
    RETURN FALSE;
  END IF;
  
  -- Super admins podem tudo
  IF admin_profile.admin_level = 'super_admin' THEN
    RETURN TRUE;
  END IF;
  
  -- Buscar regi├úo do condutor
  SELECT region INTO conductor_region 
  FROM public.conductors 
  WHERE id = target_conductor_id;
  
  -- Admin regional pode gerenciar condutores da sua regi├úo
  IF admin_profile.admin_level = 'admin_regional' THEN
    RETURN admin_profile.region = conductor_region;
  END IF;
  
  -- Admin local s├│ pode gerenciar condutores da mesma regi├úo
  IF admin_profile.admin_level = 'admin_local' THEN
    RETURN admin_profile.region = conductor_region;
  END IF;
  
  RETURN FALSE;
END;
$$;


ALTER FUNCTION public.check_admin_permissions(target_conductor_id uuid, admin_user_id uuid) OWNER TO postgres;

--
-- TOC entry 4425 (class 0 OID 0)
-- Dependencies: 485
-- Name: FUNCTION check_admin_permissions(target_conductor_id uuid, admin_user_id uuid); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.check_admin_permissions(target_conductor_id uuid, admin_user_id uuid) IS 'Verifica se um admin tem permiss├úo para modificar um condutor espec├¡fico';


--
-- TOC entry 494 (class 1255 OID 45863)
-- Name: create_conductor_from_approved_application(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_conductor_from_approved_application() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NEW.status = 'approved' AND OLD.status != 'approved' THEN
    INSERT INTO conductors (
      user_id,
      name, 
      email, 
      whatsapp, 
      region,
      vehicle_info, 
      license_number,
      is_active,
      status,
      restricted_zone,
      created_by
    ) VALUES (
      -- Criar um novo usu├írio auth para o condutor seria ideal,
      -- mas por simplicidade vamos usar NULL e permitir signup posterior
      NULL,
      NEW.full_name, 
      NEW.email, 
      NEW.whatsapp, 
      NEW.region,
      NEW.vehicle_info, 
      NEW.license_number,
      true,
      'active',
      NEW.assigned_coordinates,
      NEW.created_by
    );
    
    -- Marcar candidatura como processada
    NEW.approved_at = NOW();
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.create_conductor_from_approved_application() OWNER TO postgres;

--
-- TOC entry 491 (class 1255 OID 45860)
-- Name: expel_conductor(uuid, text, uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.expel_conductor(conductor_id uuid, expulsion_reason text, expelled_by uuid) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
BEGIN
  UPDATE conductors 
  SET 
    status = 'expelled',
    blocked_by = $3,
    blocked_at = NOW(),
    block_reason = $2,
    is_active = false
  WHERE id = $1;
  
  -- Remover ve├¡culo atribu├¡do
  UPDATE conductors 
  SET assigned_vehicle = NULL 
  WHERE id = $1;
  
  -- Log da a├º├úo na auditoria (se tabela existir)
  IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'conductor_status_audit') THEN
    INSERT INTO conductor_status_audit (
      conductor_id,
      old_status,
      new_status,
      changed_by,
      reason
    ) VALUES (
      $1,
      'active',
      'expelled',
      $3,
      $2
    );
  END IF;
  
  RETURN TRUE;
END;
$_$;


ALTER FUNCTION public.expel_conductor(conductor_id uuid, expulsion_reason text, expelled_by uuid) OWNER TO postgres;

--
-- TOC entry 487 (class 1255 OID 45856)
-- Name: get_admin_level(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_admin_level(user_id uuid) RETURNS public.admin_level
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  RETURN (
    SELECT admin_level 
    FROM profiles 
    WHERE id = user_id AND role = 'admin'
  );
END;
$$;


ALTER FUNCTION public.get_admin_level(user_id uuid) OWNER TO postgres;

--
-- TOC entry 488 (class 1255 OID 45857)
-- Name: get_admin_region(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_admin_region(user_id uuid) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  RETURN (
    SELECT region 
    FROM profiles 
    WHERE id = user_id AND role = 'admin'
  );
END;
$$;


ALTER FUNCTION public.get_admin_region(user_id uuid) OWNER TO postgres;

--
-- TOC entry 489 (class 1255 OID 45858)
-- Name: get_admin_zone(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_admin_zone(user_id uuid) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  RETURN (
    SELECT zone 
    FROM profiles 
    WHERE id = user_id AND role = 'admin'
  );
END;
$$;


ALTER FUNCTION public.get_admin_zone(user_id uuid) OWNER TO postgres;

--
-- TOC entry 483 (class 1255 OID 19586)
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, role)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'full_name', ''),
    'user'
  );
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.handle_new_user() OWNER TO postgres;

--
-- TOC entry 484 (class 1255 OID 26530)
-- Name: limit_audit_log_entries_gradually(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.limit_audit_log_entries_gradually() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN

  -- S├│ apaga se houver mais de 80 registos

  IF (SELECT COUNT(*) FROM audit_log_entries) > 80 THEN

    DELETE FROM audit_log_entries

    WHERE id IN (

      SELECT id

      FROM audit_log_entries

      ORDER BY created_at ASC

      LIMIT 10

    );

  END IF;



  RETURN NULL;

END;

$$;


ALTER FUNCTION public.limit_audit_log_entries_gradually() OWNER TO postgres;

--
-- TOC entry 486 (class 1255 OID 45728)
-- Name: log_conductor_status_change(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.log_conductor_status_change() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  admin_profile public.profiles;
BEGIN
  -- Buscar perfil do admin que fez a mudan├ºa
  SELECT * INTO admin_profile 
  FROM public.profiles 
  WHERE id = auth.uid();
  
  -- Registrar a mudan├ºa se o status mudou
  IF OLD.is_active IS DISTINCT FROM NEW.is_active THEN
    INSERT INTO public.conductor_status_audit (
      conductor_id,
      changed_by,
      previous_status,
      new_status,
      region,
      admin_level,
      metadata
    ) VALUES (
      NEW.id,
      auth.uid(),
      OLD.is_active,
      NEW.is_active,
      COALESCE(admin_profile.region, 'unknown'),
      COALESCE(admin_profile.admin_level, 'admin_local'),
      jsonb_build_object(
        'timestamp', NOW(),
        'admin_name', admin_profile.full_name,
        'conductor_name', NEW.name
      )
    );
  END IF;
  
  -- Atualizar updated_at e updated_by
  NEW.updated_at = NOW();
  NEW.updated_by = auth.uid();
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.log_conductor_status_change() OWNER TO postgres;

--
-- TOC entry 492 (class 1255 OID 45861)
-- Name: unblock_conductor(uuid, uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.unblock_conductor(conductor_id uuid, unblocked_by uuid) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
BEGIN
  UPDATE conductors 
  SET 
    status = 'active',
    blocked_by = NULL,
    blocked_at = NULL,
    block_reason = NULL
  WHERE id = $1;
  
  -- Log da a├º├úo na auditoria (se tabela existir)
  IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'conductor_status_audit') THEN
    INSERT INTO conductor_status_audit (
      conductor_id,
      old_status,
      new_status,
      changed_by,
      reason
    ) VALUES (
      $1,
      'blocked',
      'active',
      $2,
      'Desbloqueado pelo admin'
    );
  END IF;
  
  RETURN TRUE;
END;
$_$;


ALTER FUNCTION public.unblock_conductor(conductor_id uuid, unblocked_by uuid) OWNER TO postgres;

--
-- TOC entry 482 (class 1255 OID 19516)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO postgres;

--
-- TOC entry 475 (class 1255 OID 17169)
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- TOC entry 481 (class 1255 OID 17248)
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- TOC entry 477 (class 1255 OID 17181)
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- TOC entry 473 (class 1255 OID 17131)
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- TOC entry 472 (class 1255 OID 17126)
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- TOC entry 476 (class 1255 OID 17177)
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- TOC entry 478 (class 1255 OID 17188)
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- TOC entry 471 (class 1255 OID 17125)
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- TOC entry 480 (class 1255 OID 17247)
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- TOC entry 470 (class 1255 OID 17123)
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- TOC entry 474 (class 1255 OID 17158)
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- TOC entry 479 (class 1255 OID 17241)
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- TOC entry 466 (class 1255 OID 17028)
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- TOC entry 462 (class 1255 OID 17002)
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 461 (class 1255 OID 17001)
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 460 (class 1255 OID 17000)
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 463 (class 1255 OID 17014)
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- TOC entry 468 (class 1255 OID 17067)
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 467 (class 1255 OID 17030)
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 469 (class 1255 OID 17083)
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- TOC entry 464 (class 1255 OID 17017)
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- TOC entry 465 (class 1255 OID 17018)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 325 (class 1259 OID 16523)
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- TOC entry 4452 (class 0 OID 0)
-- Dependencies: 325
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- TOC entry 342 (class 1259 OID 16925)
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- TOC entry 4454 (class 0 OID 0)
-- Dependencies: 342
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- TOC entry 333 (class 1259 OID 16723)
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- TOC entry 4456 (class 0 OID 0)
-- Dependencies: 333
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- TOC entry 4457 (class 0 OID 0)
-- Dependencies: 333
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- TOC entry 324 (class 1259 OID 16516)
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- TOC entry 4459 (class 0 OID 0)
-- Dependencies: 324
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- TOC entry 337 (class 1259 OID 16812)
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- TOC entry 4461 (class 0 OID 0)
-- Dependencies: 337
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- TOC entry 336 (class 1259 OID 16800)
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- TOC entry 4463 (class 0 OID 0)
-- Dependencies: 336
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- TOC entry 335 (class 1259 OID 16787)
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- TOC entry 4465 (class 0 OID 0)
-- Dependencies: 335
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- TOC entry 343 (class 1259 OID 16975)
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 323 (class 1259 OID 16505)
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 4468 (class 0 OID 0)
-- Dependencies: 323
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- TOC entry 322 (class 1259 OID 16504)
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- TOC entry 4470 (class 0 OID 0)
-- Dependencies: 322
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- TOC entry 340 (class 1259 OID 16854)
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 4472 (class 0 OID 0)
-- Dependencies: 340
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- TOC entry 341 (class 1259 OID 16872)
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- TOC entry 4474 (class 0 OID 0)
-- Dependencies: 341
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- TOC entry 326 (class 1259 OID 16531)
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- TOC entry 4476 (class 0 OID 0)
-- Dependencies: 326
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- TOC entry 334 (class 1259 OID 16753)
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- TOC entry 4478 (class 0 OID 0)
-- Dependencies: 334
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- TOC entry 4479 (class 0 OID 0)
-- Dependencies: 334
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- TOC entry 339 (class 1259 OID 16839)
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- TOC entry 4481 (class 0 OID 0)
-- Dependencies: 339
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- TOC entry 338 (class 1259 OID 16830)
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 4483 (class 0 OID 0)
-- Dependencies: 338
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- TOC entry 4484 (class 0 OID 0)
-- Dependencies: 338
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- TOC entry 321 (class 1259 OID 16493)
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- TOC entry 4486 (class 0 OID 0)
-- Dependencies: 321
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- TOC entry 4487 (class 0 OID 0)
-- Dependencies: 321
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- TOC entry 361 (class 1259 OID 34655)
-- Name: active_conductors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_conductors (
    id integer NOT NULL,
    conductor_id uuid,
    is_active boolean DEFAULT false,
    activated_at timestamp with time zone,
    deactivated_at timestamp with time zone
);


ALTER TABLE public.active_conductors OWNER TO postgres;

--
-- TOC entry 360 (class 1259 OID 34654)
-- Name: active_conductors_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_conductors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_conductors_id_seq OWNER TO postgres;

--
-- TOC entry 4492 (class 0 OID 0)
-- Dependencies: 360
-- Name: active_conductors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_conductors_id_seq OWNED BY public.active_conductors.id;


--
-- TOC entry 358 (class 1259 OID 26242)
-- Name: blocked_periods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blocked_periods (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    date date NOT NULL,
    start_time time without time zone,
    end_time time without time zone,
    reason text,
    created_by text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    "createdBy" text
);


ALTER TABLE public.blocked_periods OWNER TO postgres;

--
-- TOC entry 372 (class 1259 OID 45789)
-- Name: conductor_applications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conductor_applications (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    full_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(20) NOT NULL,
    whatsapp character varying(20),
    vehicle_info jsonb DEFAULT '{}'::jsonb,
    license_number character varying(50),
    region character varying(100) NOT NULL,
    zone character varying(100),
    assigned_coordinates jsonb,
    created_by uuid,
    admin_level public.admin_level NOT NULL,
    status public.application_status DEFAULT 'link_created'::public.application_status,
    documents jsonb DEFAULT '{}'::jsonb,
    created_at timestamp without time zone DEFAULT now(),
    submitted_at timestamp without time zone,
    reviewed_at timestamp without time zone,
    approved_at timestamp without time zone,
    registration_token uuid DEFAULT gen_random_uuid(),
    admin_notes text,
    rejection_reason text
);


ALTER TABLE public.conductor_applications OWNER TO postgres;

--
-- TOC entry 359 (class 1259 OID 34641)
-- Name: conductor_locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conductor_locations (
    id uuid NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    conductor_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    accuracy numeric NOT NULL
);


ALTER TABLE public.conductor_locations OWNER TO postgres;

--
-- TOC entry 370 (class 1259 OID 45700)
-- Name: conductor_status_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conductor_status_audit (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    conductor_id uuid NOT NULL,
    changed_by uuid NOT NULL,
    previous_status boolean,
    new_status boolean NOT NULL,
    reason text,
    region character varying(100),
    admin_level public.admin_level,
    created_at timestamp with time zone DEFAULT now(),
    metadata jsonb DEFAULT '{}'::jsonb
);


ALTER TABLE public.conductor_status_audit OWNER TO postgres;

--
-- TOC entry 4497 (class 0 OID 0)
-- Dependencies: 370
-- Name: TABLE conductor_status_audit; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.conductor_status_audit IS 'Log de auditoria para mudan├ºas de status de condutores';


--
-- TOC entry 373 (class 1259 OID 45809)
-- Name: conductor_vehicle_sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conductor_vehicle_sessions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    conductor_id uuid,
    vehicle_id uuid,
    started_at timestamp without time zone DEFAULT now(),
    ended_at timestamp without time zone,
    start_location jsonb,
    end_location jsonb,
    route_data jsonb,
    total_distance numeric(10,2),
    total_time interval,
    rides_completed integer DEFAULT 0,
    is_active boolean DEFAULT true
);


ALTER TABLE public.conductor_vehicle_sessions OWNER TO postgres;

--
-- TOC entry 363 (class 1259 OID 40475)
-- Name: conductors; Type: TABLE; Schema: public; Owner: postgres
--

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
    region character varying(100) DEFAULT 'milfontes'::character varying,
    updated_at timestamp with time zone DEFAULT now(),
    updated_by uuid,
    status public.conductor_status DEFAULT 'active'::public.conductor_status,
    assigned_vehicle uuid,
    blocked_by uuid,
    blocked_at timestamp without time zone,
    block_reason text,
    restricted_zone jsonb
);


ALTER TABLE public.conductors OWNER TO postgres;

--
-- TOC entry 4500 (class 0 OID 0)
-- Dependencies: 363
-- Name: COLUMN conductors.is_active; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.conductors.is_active IS 'status do condutor';


--
-- TOC entry 357 (class 1259 OID 19569)
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profiles (
    id uuid NOT NULL,
    email text,
    full_name text,
    role text DEFAULT 'user'::text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    admin_level public.admin_level DEFAULT 'admin_local'::public.admin_level,
    region character varying(100),
    permissions jsonb DEFAULT '{}'::jsonb,
    created_by uuid,
    zone character varying(100)
);


ALTER TABLE public.profiles OWNER TO postgres;

--
-- TOC entry 4502 (class 0 OID 0)
-- Dependencies: 357
-- Name: COLUMN profiles.admin_level; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.profiles.admin_level IS 'N├¡vel de permiss├úo do administrador';


--
-- TOC entry 4503 (class 0 OID 0)
-- Dependencies: 357
-- Name: COLUMN profiles.region; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.profiles.region IS 'Regi├úo de responsabilidade do administrador';


--
-- TOC entry 4504 (class 0 OID 0)
-- Dependencies: 357
-- Name: COLUMN profiles.permissions; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.profiles.permissions IS 'Permiss├Áes espec├¡ficas em formato JSON';


--
-- TOC entry 353 (class 1259 OID 19477)
-- Name: reservations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    customer_name character varying(255) NOT NULL,
    customer_email character varying(255) NOT NULL,
    customer_phone character varying(20) NOT NULL,
    reservation_date date NOT NULL,
    reservation_time time without time zone NOT NULL,
    number_of_people integer NOT NULL,
    tour_type character varying(100) NOT NULL,
    special_requests text,
    status character varying(50) DEFAULT 'pending'::character varying,
    total_price numeric(10,2),
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    language text,
    manual_payment numeric(10,2) DEFAULT NULL::numeric,
    assigned_conductor_id uuid,
    CONSTRAINT reservations_number_of_people_check CHECK (((number_of_people >= 1) AND (number_of_people <= 6))),
    CONSTRAINT reservations_status_check CHECK (((status)::text = ANY ((ARRAY['pending'::character varying, 'confirmed'::character varying, 'cancelled'::character varying, 'completed'::character varying])::text[])))
);


ALTER TABLE public.reservations OWNER TO postgres;

--
-- TOC entry 4506 (class 0 OID 0)
-- Dependencies: 353
-- Name: COLUMN reservations.manual_payment; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.reservations.manual_payment IS 'Valor de pagamento manual inserido pelo administrador';


--
-- TOC entry 355 (class 1259 OID 19503)
-- Name: tour_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tour_types (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    duration_minutes integer NOT NULL,
    base_price numeric(10,2) NOT NULL,
    max_people integer DEFAULT 4,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.tour_types OWNER TO postgres;

--
-- TOC entry 354 (class 1259 OID 19490)
-- Name: tuk_tuk_availability; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tuk_tuk_availability (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    tuk_tuk_id character varying(50) NOT NULL,
    available_date date NOT NULL,
    time_slots jsonb DEFAULT '{}'::jsonb NOT NULL,
    max_capacity integer DEFAULT 4,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.tuk_tuk_availability OWNER TO postgres;

--
-- TOC entry 371 (class 1259 OID 45763)
-- Name: tuktuk_vehicles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tuktuk_vehicles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    vehicle_number integer NOT NULL,
    vehicle_name character varying(50) NOT NULL,
    region character varying(100) NOT NULL,
    zone character varying(100),
    managed_by uuid,
    is_available boolean DEFAULT true,
    is_active boolean DEFAULT false,
    current_conductor uuid,
    license_plate character varying(20),
    vehicle_info jsonb DEFAULT '{}'::jsonb,
    maintenance_status public.vehicle_status DEFAULT 'operational'::public.vehicle_status,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.tuktuk_vehicles OWNER TO postgres;

--
-- TOC entry 368 (class 1259 OID 44334)
-- Name: tuktuks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tuktuks (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    nome text NOT NULL,
    identificador text NOT NULL,
    ativo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.tuktuks OWNER TO postgres;

--
-- TOC entry 367 (class 1259 OID 44300)
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid,
    role text,
    CONSTRAINT user_roles_role_check CHECK ((role = ANY (ARRAY['admin'::text, 'condutor'::text])))
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- TOC entry 352 (class 1259 OID 17251)
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- TOC entry 362 (class 1259 OID 39329)
-- Name: messages_2025_07_20; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_20 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_20 OWNER TO supabase_admin;

--
-- TOC entry 364 (class 1259 OID 43163)
-- Name: messages_2025_07_21; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_21 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_21 OWNER TO supabase_admin;

--
-- TOC entry 365 (class 1259 OID 43174)
-- Name: messages_2025_07_22; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_22 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_22 OWNER TO supabase_admin;

--
-- TOC entry 366 (class 1259 OID 43185)
-- Name: messages_2025_07_23; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_23 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_23 OWNER TO supabase_admin;

--
-- TOC entry 369 (class 1259 OID 44572)
-- Name: messages_2025_07_24; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_24 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_24 OWNER TO supabase_admin;

--
-- TOC entry 374 (class 1259 OID 45876)
-- Name: messages_2025_07_25; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_25 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_25 OWNER TO supabase_admin;

--
-- TOC entry 375 (class 1259 OID 46990)
-- Name: messages_2025_07_26; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_26 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_26 OWNER TO supabase_admin;

--
-- TOC entry 346 (class 1259 OID 17088)
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- TOC entry 349 (class 1259 OID 17111)
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- TOC entry 348 (class 1259 OID 17110)
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 327 (class 1259 OID 16544)
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- TOC entry 4524 (class 0 OID 0)
-- Dependencies: 327
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 329 (class 1259 OID 16586)
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- TOC entry 328 (class 1259 OID 16559)
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- TOC entry 4526 (class 0 OID 0)
-- Dependencies: 328
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 344 (class 1259 OID 17032)
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- TOC entry 345 (class 1259 OID 17046)
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- TOC entry 356 (class 1259 OID 19549)
-- Name: schema_migrations; Type: TABLE; Schema: supabase_migrations; Owner: postgres
--

CREATE TABLE supabase_migrations.schema_migrations (
    version text NOT NULL,
    statements text[],
    name text,
    created_by text,
    idempotency_key text
);


ALTER TABLE supabase_migrations.schema_migrations OWNER TO postgres;

--
-- TOC entry 376 (class 1259 OID 48104)
-- Name: seed_files; Type: TABLE; Schema: supabase_migrations; Owner: postgres
--

CREATE TABLE supabase_migrations.seed_files (
    path text NOT NULL,
    hash text NOT NULL
);


ALTER TABLE supabase_migrations.seed_files OWNER TO postgres;

--
-- TOC entry 3695 (class 0 OID 0)
-- Name: messages_2025_07_20; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_20 FOR VALUES FROM ('2025-07-20 00:00:00') TO ('2025-07-21 00:00:00');


--
-- TOC entry 3696 (class 0 OID 0)
-- Name: messages_2025_07_21; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_21 FOR VALUES FROM ('2025-07-21 00:00:00') TO ('2025-07-22 00:00:00');


--
-- TOC entry 3697 (class 0 OID 0)
-- Name: messages_2025_07_22; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_22 FOR VALUES FROM ('2025-07-22 00:00:00') TO ('2025-07-23 00:00:00');


--
-- TOC entry 3698 (class 0 OID 0)
-- Name: messages_2025_07_23; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_23 FOR VALUES FROM ('2025-07-23 00:00:00') TO ('2025-07-24 00:00:00');


--
-- TOC entry 3699 (class 0 OID 0)
-- Name: messages_2025_07_24; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_24 FOR VALUES FROM ('2025-07-24 00:00:00') TO ('2025-07-25 00:00:00');


--
-- TOC entry 3700 (class 0 OID 0)
-- Name: messages_2025_07_25; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_25 FOR VALUES FROM ('2025-07-25 00:00:00') TO ('2025-07-26 00:00:00');


--
-- TOC entry 3701 (class 0 OID 0)
-- Name: messages_2025_07_26; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_26 FOR VALUES FROM ('2025-07-26 00:00:00') TO ('2025-07-27 00:00:00');


--
-- TOC entry 3711 (class 2604 OID 16508)
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- TOC entry 3764 (class 2604 OID 34658)
-- Name: active_conductors id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_conductors ALTER COLUMN id SET DEFAULT nextval('public.active_conductors_id_seq'::regclass);


--
-- TOC entry 4293 (class 0 OID 16523)
-- Dependencies: 325
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	21d09dc1-8ca2-42fc-bca1-579b843adaa3	{"action":"logout","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-04 22:11:56.138226+00	
00000000-0000-0000-0000-000000000000	e3cf6ced-847c-46c6-bfaa-ef066046d3bc	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-04 22:12:03.606812+00	
00000000-0000-0000-0000-000000000000	1fde63da-e900-4fee-8b72-90a1b7b6c5ac	{"action":"logout","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-04 22:12:18.764334+00	
00000000-0000-0000-0000-000000000000	cf1757ef-1abb-4887-a8e3-0e77db032549	{"action":"logout","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-04 22:13:30.857754+00	
00000000-0000-0000-0000-000000000000	384aee93-876e-49d1-a89d-0a703aaacc33	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 22:13:52.385293+00	
00000000-0000-0000-0000-000000000000	1bc6c749-df3e-40cb-be76-265fef23e802	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-04 22:13:52.385868+00	
00000000-0000-0000-0000-000000000000	f353f77c-bdd0-4c27-bf8f-79dce1cc5925	{"action":"user_recovery_requested","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-07-04 22:14:13.022276+00	
00000000-0000-0000-0000-000000000000	46eb2dd0-fdb9-49d9-9edf-3aa3838e288d	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-04 22:17:50.403801+00	
00000000-0000-0000-0000-000000000000	f223c251-c842-43e5-8ed7-c74930828278	{"action":"user_recovery_requested","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-07-04 23:04:24.839884+00	
00000000-0000-0000-0000-000000000000	034e6925-503b-4f24-b987-a462f020a9d8	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-04 23:04:44.317301+00	
00000000-0000-0000-0000-000000000000	6a7f6a16-0acf-4a7c-9a04-b1822ae2052d	{"action":"logout","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-04 23:13:18.132699+00	
00000000-0000-0000-0000-000000000000	4fdc7e0d-10c9-4db0-b20b-e2510e4dde73	{"action":"user_recovery_requested","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"user"}	2025-07-04 23:13:28.952843+00	
00000000-0000-0000-0000-000000000000	398c2fe5-13d0-4376-9a8d-2710f12ea069	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-04 23:13:41.773964+00	
00000000-0000-0000-0000-000000000000	354a1aec-1dc3-47a6-accb-a015c9ea6e45	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 00:48:31.250869+00	
00000000-0000-0000-0000-000000000000	14c03441-a153-4e73-9cbf-af34c1a5a4c7	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 00:48:31.251791+00	
00000000-0000-0000-0000-000000000000	65d0e051-b0a6-485a-b5cc-5adc683387d2	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 09:17:52.797677+00	
00000000-0000-0000-0000-000000000000	305739c3-3177-426d-b6c6-d5ab889d245f	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 09:17:52.807652+00	
00000000-0000-0000-0000-000000000000	b00d4e8f-92b7-49a3-a3dc-2d94d5006a42	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 11:40:30.533011+00	
00000000-0000-0000-0000-000000000000	e0757c30-3e6e-4949-b5bb-ce62ac9f625d	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 11:40:30.534945+00	
00000000-0000-0000-0000-000000000000	018e13cc-6354-4c68-a9b3-aaded2d940a9	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 14:16:40.452933+00	
00000000-0000-0000-0000-000000000000	9073a97a-483e-48d4-a5de-d72f15cacaa0	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 14:16:40.461541+00	
00000000-0000-0000-0000-000000000000	c8001b0a-4147-4f53-abe9-996de151085d	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-05 16:03:56.513738+00	
00000000-0000-0000-0000-000000000000	05e47e8a-f4d5-4e08-bfbc-f0e9d2466126	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-05 16:30:00.476329+00	
00000000-0000-0000-0000-000000000000	9c23c2b3-e1cc-43c4-ba5f-d914be810ee0	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-05 17:00:15.560796+00	
00000000-0000-0000-0000-000000000000	7d0fc812-e987-4e69-8ca4-5bfa6280a8a7	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-05 17:17:11.773414+00	
00000000-0000-0000-0000-000000000000	1f591bd5-7277-4a6a-98c8-b5b63bba5a1a	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 18:18:45.132861+00	
00000000-0000-0000-0000-000000000000	884a2daf-2480-4027-965e-536a6308ec65	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 18:18:45.136049+00	
00000000-0000-0000-0000-000000000000	704a21c6-a8ab-4450-9d3b-737e044c5ec9	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 18:47:19.424437+00	
00000000-0000-0000-0000-000000000000	beadb79f-bb66-491f-b04c-bb79ac029402	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 18:47:19.426879+00	
00000000-0000-0000-0000-000000000000	a6c14004-bbc1-47f2-acf5-0f7f7a8573d3	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 18:48:49.832766+00	
00000000-0000-0000-0000-000000000000	dc085365-6c57-4b86-b26f-40a2dec60009	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 18:48:49.834414+00	
00000000-0000-0000-0000-000000000000	e6851dde-ceb5-4660-b749-d3256440f4d3	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 19:45:39.167952+00	
00000000-0000-0000-0000-000000000000	44ed1c12-07b0-4dd1-8bf4-ef0b59269d78	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 19:45:39.16938+00	
00000000-0000-0000-0000-000000000000	c9f6cea4-d29c-481f-bfab-a5c081a7169c	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 19:48:31.113741+00	
00000000-0000-0000-0000-000000000000	c52bd709-d503-4c08-8073-243b657e16e8	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 19:48:31.114639+00	
00000000-0000-0000-0000-000000000000	1419af83-0ac1-41fe-b1a3-86f9a95cea6f	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-05 19:56:54.764917+00	
00000000-0000-0000-0000-000000000000	ba743ee0-9274-4522-970f-032e88b44f75	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 20:43:58.879776+00	
00000000-0000-0000-0000-000000000000	bab0a8c1-4d34-4882-8752-2e1d9756eb68	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 20:43:58.880685+00	
00000000-0000-0000-0000-000000000000	c9fc28e4-adde-4d18-8f94-2fd902237ef8	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 20:47:38.606307+00	
00000000-0000-0000-0000-000000000000	b50877a7-e761-461c-bd90-a462ae6fa050	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 20:47:38.607422+00	
00000000-0000-0000-0000-000000000000	cad9f4f6-97c4-47ee-86d9-d8c4f0cf7afa	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 21:40:36.735174+00	
00000000-0000-0000-0000-000000000000	1187ea3e-5a30-48cb-85f5-aa95282c0cd1	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 21:40:36.73703+00	
00000000-0000-0000-0000-000000000000	af72351c-9e9f-4dbe-b507-093eff7b8fcc	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 21:58:17.289314+00	
00000000-0000-0000-0000-000000000000	12c13177-16da-4716-a2f5-3e25d27e461e	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 21:58:17.291752+00	
00000000-0000-0000-0000-000000000000	10ebea43-983e-4d77-9d55-aafc09f1dd73	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 22:02:11.431712+00	
00000000-0000-0000-0000-000000000000	a294b976-ba41-486f-8fd9-74b19f3984eb	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 22:02:11.432639+00	
00000000-0000-0000-0000-000000000000	eddba12a-6500-4265-a1ef-d0d12a5d0ff6	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 22:50:06.423046+00	
00000000-0000-0000-0000-000000000000	07e1c19a-8c4c-426e-81d9-c8201eb0d8c1	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 22:50:06.424537+00	
00000000-0000-0000-0000-000000000000	44fcab14-5e73-41b9-8e3a-3a4550b52ee7	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 22:53:20.859841+00	
00000000-0000-0000-0000-000000000000	d5350ee3-8c7c-4ba2-bf98-17080bb3c09f	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 22:53:20.861709+00	
00000000-0000-0000-0000-000000000000	49e4917c-7d05-4d0b-9284-558dde40064c	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 23:05:55.978481+00	
00000000-0000-0000-0000-000000000000	56b8b9f0-37c0-47c1-86ee-abc2d9a7f5e2	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 23:05:55.980113+00	
00000000-0000-0000-0000-000000000000	0f9275c2-0650-4fdc-a178-0685fa62abdd	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 23:06:09.025025+00	
00000000-0000-0000-0000-000000000000	f6306103-981c-4a05-9e97-3e3f8f6d811e	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 23:06:09.026421+00	
00000000-0000-0000-0000-000000000000	9bda4bfd-7900-4308-8567-2b444a4c7ecc	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 23:11:58.198105+00	
00000000-0000-0000-0000-000000000000	b5b0094f-8e77-497e-9baa-9ad2b7b5a0fd	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 23:11:58.200376+00	
00000000-0000-0000-0000-000000000000	3aaa11ad-32ee-494c-a322-d7c479d8d3f9	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 23:22:10.134808+00	
00000000-0000-0000-0000-000000000000	4a669864-a935-4bf2-95b9-4700ca32be6e	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-05 23:22:10.136963+00	
00000000-0000-0000-0000-000000000000	a3eabba2-4888-4bbd-9220-bf97f0677237	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-05 23:31:36.754629+00	
00000000-0000-0000-0000-000000000000	8ea098a0-5146-4fe6-ab6f-46959bb35163	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 00:10:18.023769+00	
00000000-0000-0000-0000-000000000000	8fd81383-dcc9-43bd-a85f-a61477ce8c21	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 00:10:18.026095+00	
00000000-0000-0000-0000-000000000000	da10d5b9-70d4-4afc-b5b9-c64ce1361e03	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 00:34:55.081314+00	
00000000-0000-0000-0000-000000000000	be009d56-b7d7-4345-920d-adf0de9ccc8e	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 00:34:55.082226+00	
00000000-0000-0000-0000-000000000000	6061d47f-f326-4971-9840-23670bb89765	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 00:45:23.707157+00	
00000000-0000-0000-0000-000000000000	cf689285-42c6-4b5a-b857-9c4c7946fd4c	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 00:45:23.708855+00	
00000000-0000-0000-0000-000000000000	d9505e2d-ef2b-4e86-b592-1b8e434916bc	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 00:47:10.05843+00	
00000000-0000-0000-0000-000000000000	d746595a-f676-4746-97e0-211bdb04d8fd	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 00:47:10.059287+00	
00000000-0000-0000-0000-000000000000	e2dd9f57-519e-4878-b377-046d5e1a5ee6	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 00:53:43.090357+00	
00000000-0000-0000-0000-000000000000	421642f1-ef5d-4ef3-883a-c216a7ec4f8e	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 00:53:43.092025+00	
00000000-0000-0000-0000-000000000000	d1fa4d4f-94df-46b4-8681-8f718ec29835	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 08:25:34.483893+00	
00000000-0000-0000-0000-000000000000	66f04cb9-ac18-4c7d-9684-34a036c583e8	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 08:25:34.483869+00	
00000000-0000-0000-0000-000000000000	d9f829ea-6728-4ccc-91e2-47dd127e535e	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 08:25:34.510337+00	
00000000-0000-0000-0000-000000000000	f93fcd5b-3a2f-4021-b8b6-8f180fdedde5	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 08:25:34.513763+00	
00000000-0000-0000-0000-000000000000	80da5422-fc6b-4473-9bb0-38d2b37d423b	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 08:25:34.908253+00	
00000000-0000-0000-0000-000000000000	dde9e75c-7550-4abd-baee-032fd436f85d	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 08:25:34.908864+00	
00000000-0000-0000-0000-000000000000	6a30451f-22d3-4d22-b8b9-533fd9f2449f	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 08:25:40.270381+00	
00000000-0000-0000-0000-000000000000	02543f6d-fddd-4857-b3ef-9ecccd3d2c5f	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 08:25:40.270994+00	
00000000-0000-0000-0000-000000000000	f88f7d58-b30d-4f90-a914-70d22a1840fe	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 08:35:05.299088+00	
00000000-0000-0000-0000-000000000000	e671bd92-07d0-4262-8670-c0f2b6b77370	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 08:35:05.299945+00	
00000000-0000-0000-0000-000000000000	23ec14dd-5203-4726-ba39-cabe50761418	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 09:33:21.698468+00	
00000000-0000-0000-0000-000000000000	2d97da4c-777e-4701-9ed1-c986e937c7f5	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 09:33:21.701135+00	
00000000-0000-0000-0000-000000000000	399f0e85-382f-4428-a1d8-822b97be0d3c	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 10:28:30.142137+00	
00000000-0000-0000-0000-000000000000	de237434-519c-4e0a-bfee-4bfe77591c0c	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 10:28:30.144405+00	
00000000-0000-0000-0000-000000000000	28a8d22b-5e31-499b-92b8-c99f922f0f79	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 10:31:27.492627+00	
00000000-0000-0000-0000-000000000000	99a8b6a0-40cf-4735-9603-2fa747a0d493	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 10:31:27.494428+00	
00000000-0000-0000-0000-000000000000	16b94383-2d2e-458b-8c62-4240dd628812	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 11:26:52.822167+00	
00000000-0000-0000-0000-000000000000	e605b540-2263-4eaf-b408-9b796376e7ee	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 11:26:52.824306+00	
00000000-0000-0000-0000-000000000000	77b337da-6f63-4314-a2d1-4c6cd24ff6d1	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 11:29:41.148289+00	
00000000-0000-0000-0000-000000000000	07da66d1-2967-4233-942f-1d10f3280d73	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 11:29:41.15024+00	
00000000-0000-0000-0000-000000000000	e35406a5-d14d-43de-a313-c8705f7b8c29	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 13:02:38.602886+00	
00000000-0000-0000-0000-000000000000	bdb2fd6b-24b1-4d4b-b3f6-7bf0b19b36d2	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 13:02:38.612908+00	
00000000-0000-0000-0000-000000000000	14478389-03fc-4497-9ee0-2bb79d7f1fbe	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 13:02:38.658126+00	
00000000-0000-0000-0000-000000000000	f28f9262-6fb7-4aee-a4e4-a105e951a75b	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 13:02:38.658852+00	
00000000-0000-0000-0000-000000000000	b75d920c-b80c-49a6-86cc-3b05b2dbd9db	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 13:02:38.668287+00	
00000000-0000-0000-0000-000000000000	a4e7c3d7-88bb-463d-8ff8-8ab1238d57e0	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 13:02:38.669208+00	
00000000-0000-0000-0000-000000000000	c1baf10c-a864-46b5-8c9f-24d2f612e60b	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 14:00:38.331707+00	
00000000-0000-0000-0000-000000000000	66ff0ecb-0969-427d-8446-6fcedac8fd4b	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 14:00:38.338103+00	
00000000-0000-0000-0000-000000000000	e4248756-b6f4-433c-9f9b-ba6dd7c07b5f	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 14:58:56.063008+00	
00000000-0000-0000-0000-000000000000	9bdd0114-689a-46c8-bfde-2310c874e513	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 14:58:56.066302+00	
00000000-0000-0000-0000-000000000000	a44c7a81-3fc2-4e4d-9881-e1c7779c01c1	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 16:21:25.095113+00	
00000000-0000-0000-0000-000000000000	e1f41738-870b-4402-8d30-730a9bbadf18	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 16:21:25.098368+00	
00000000-0000-0000-0000-000000000000	c1c9fdbc-6644-40d6-afb6-990235b26720	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 16:21:25.101585+00	
00000000-0000-0000-0000-000000000000	aef09f96-a854-475f-ba18-6be91a280e64	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 16:21:25.103491+00	
00000000-0000-0000-0000-000000000000	615441c7-3d83-422d-b89c-2a0c929aaf3c	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 16:33:20.181286+00	
00000000-0000-0000-0000-000000000000	0fc4de76-6c10-4759-b843-4f0cb3f4f50e	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 16:33:20.18221+00	
00000000-0000-0000-0000-000000000000	3de06bd6-6705-4440-aea5-d0e8b14603bc	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 16:33:52.011408+00	
00000000-0000-0000-0000-000000000000	3d725b98-1650-4228-96f9-e41c53da80d3	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 16:33:52.012025+00	
00000000-0000-0000-0000-000000000000	f79d3cc2-f302-4d0c-969b-cd5bc4db45a0	{"action":"logout","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-06 16:34:05.256136+00	
00000000-0000-0000-0000-000000000000	c593b19e-7136-4469-92a3-cefe8f1fa734	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-06 16:54:27.196743+00	
00000000-0000-0000-0000-000000000000	458a965b-b6f0-4eb0-a6b4-4a32f40ee39f	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 17:52:28.984308+00	
00000000-0000-0000-0000-000000000000	063caac3-b287-461c-a897-f99b3c31017f	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 17:52:28.989645+00	
00000000-0000-0000-0000-000000000000	8000cc71-8eb8-44bf-8c91-94c2c7af30c1	{"action":"logout","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-06 18:02:26.13919+00	
00000000-0000-0000-0000-000000000000	e86d5288-de45-43f7-94a6-62a0de447387	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-06 18:04:12.346711+00	
00000000-0000-0000-0000-000000000000	4a7f31b3-d627-4c38-b86f-af476ac5fa21	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 21:25:39.222498+00	
00000000-0000-0000-0000-000000000000	38e913ea-109a-4d0f-838c-0a901501f26c	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 21:25:39.224503+00	
00000000-0000-0000-0000-000000000000	2294f509-15ad-40a5-805b-718c7230614b	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 21:25:53.22784+00	
00000000-0000-0000-0000-000000000000	0ba70af7-1c15-4aab-9694-3bb77e977c71	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 21:25:53.231624+00	
00000000-0000-0000-0000-000000000000	80724d13-5ab3-4aa9-aca5-58b5eb9a8dc8	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 21:25:54.727184+00	
00000000-0000-0000-0000-000000000000	0692afa3-3e02-4010-8ab6-2634e3356f82	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 21:25:54.727786+00	
00000000-0000-0000-0000-000000000000	8a5e4f9a-4711-432b-b5f4-25329ab38dbb	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 22:37:47.296693+00	
00000000-0000-0000-0000-000000000000	b2eb33eb-d603-4025-8d9b-5dd46ddb398f	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 22:37:47.298812+00	
00000000-0000-0000-0000-000000000000	3135367a-4d46-4d14-9101-ec013f366853	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 22:37:47.685331+00	
00000000-0000-0000-0000-000000000000	86a45975-c0f2-40d3-b724-662a12a697b9	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-06 22:37:47.685924+00	
00000000-0000-0000-0000-000000000000	dc79b4f5-2326-4ab7-a627-900b157b9f1d	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 09:20:49.498652+00	
00000000-0000-0000-0000-000000000000	b09243a2-3401-4806-a94f-a8820882d49b	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 09:20:49.516235+00	
00000000-0000-0000-0000-000000000000	93508b84-ba57-447f-8956-a422eda58e68	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 10:24:16.946313+00	
00000000-0000-0000-0000-000000000000	9186a8b6-6ed2-4e5e-91b2-fa5f7f96dc05	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 10:24:16.948999+00	
00000000-0000-0000-0000-000000000000	01270a8c-f676-4490-b9b9-124b6ee6bd3a	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 10:41:13.00771+00	
00000000-0000-0000-0000-000000000000	aab6ad20-a045-4b02-be45-e10d5b9c5b6b	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 10:41:13.010392+00	
00000000-0000-0000-0000-000000000000	8b2a4779-c460-4b86-ab18-ff3d3b55a793	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 11:25:22.845291+00	
00000000-0000-0000-0000-000000000000	6f58c633-eaf9-4129-b02a-9977f3c225fe	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 11:25:22.847873+00	
00000000-0000-0000-0000-000000000000	d35be24f-4543-4ddc-81fc-958560b409c5	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 12:23:41.025825+00	
00000000-0000-0000-0000-000000000000	a0788928-d57b-436f-bd2d-a7b59d5a2524	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 12:23:41.028229+00	
00000000-0000-0000-0000-000000000000	d248a311-983e-4a80-95fe-84157726360d	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 14:11:22.943711+00	
00000000-0000-0000-0000-000000000000	f25ad963-7cd5-4ba1-85ef-4580cc266cc9	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 14:11:22.945966+00	
00000000-0000-0000-0000-000000000000	0047e249-8e01-4ab3-a171-050cf764222e	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 14:13:53.560177+00	
00000000-0000-0000-0000-000000000000	1c76ea3d-9f2a-48ab-90da-d456bc7174c8	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 14:13:53.561065+00	
00000000-0000-0000-0000-000000000000	11b6d98a-aec4-4e1f-8c7c-fc7090c4df88	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 14:20:42.486502+00	
00000000-0000-0000-0000-000000000000	6dd12f65-daae-43fd-b786-225a6e0feec3	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 14:20:42.489264+00	
00000000-0000-0000-0000-000000000000	171c0632-a744-48ed-9f61-b48f52c18065	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 14:25:21.10568+00	
00000000-0000-0000-0000-000000000000	9d0490ff-03d2-48d2-81fa-d56212ab028a	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 14:25:21.108834+00	
00000000-0000-0000-0000-000000000000	8b500393-9568-4633-96e8-c4aba9441ad2	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 14:25:41.939342+00	
00000000-0000-0000-0000-000000000000	9f417814-633d-43df-8c4e-4981e8ef7105	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 14:25:41.939973+00	
00000000-0000-0000-0000-000000000000	fcf08e1a-58e4-4c00-87c4-ba4474a68ec2	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 18:59:16.103645+00	
00000000-0000-0000-0000-000000000000	6fb51644-0413-4f93-ab60-c10d50fcdb5f	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 18:59:16.103489+00	
00000000-0000-0000-0000-000000000000	be24eb6f-67e8-4492-aaaa-6e7176dcf8b0	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 18:59:16.117886+00	
00000000-0000-0000-0000-000000000000	c78e0808-4bf7-4ea8-9a32-499912ef7b10	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 18:59:16.1179+00	
00000000-0000-0000-0000-000000000000	d7244e6e-8d78-4dbf-819b-18c5e5cec39a	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 19:06:26.546006+00	
00000000-0000-0000-0000-000000000000	3be2f58a-96f5-4fd2-9a65-58fd56b83311	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 19:06:26.54816+00	
00000000-0000-0000-0000-000000000000	d9addf3a-cb77-4171-9a2c-40591345d8b7	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 20:12:22.860417+00	
00000000-0000-0000-0000-000000000000	7486cc81-9fb6-489e-9d4b-f2728f1fc456	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 20:12:22.861862+00	
00000000-0000-0000-0000-000000000000	747be5c0-0b12-4a10-851d-054bf65489c4	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 20:12:22.892096+00	
00000000-0000-0000-0000-000000000000	1fa06130-ac21-4b63-b6f5-cab2e4bca09d	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 20:12:22.89271+00	
00000000-0000-0000-0000-000000000000	70cbe88f-542b-495a-ac09-317dbf6dd9c1	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 22:40:20.474014+00	
00000000-0000-0000-0000-000000000000	19bb1423-8098-40a5-b3cb-90abf2951730	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 22:40:20.479965+00	
00000000-0000-0000-0000-000000000000	d86aad3d-510f-4697-8318-1e0d949b5e8c	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 22:40:20.492713+00	
00000000-0000-0000-0000-000000000000	57f2834f-65fc-4eaa-bae2-18f076c7a0be	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 22:40:20.494981+00	
00000000-0000-0000-0000-000000000000	567b9cb4-e50a-4c9b-ad6a-26405529c0a6	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 22:44:16.866909+00	
00000000-0000-0000-0000-000000000000	f22659f2-f016-409c-bd5a-8558b3f84c2d	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 22:44:16.86896+00	
00000000-0000-0000-0000-000000000000	98017034-f521-45b0-bcc4-27ff0d41cb67	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 22:49:08.250497+00	
00000000-0000-0000-0000-000000000000	80587813-84f2-48f9-b18e-a6c4f2849815	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 22:49:08.253603+00	
00000000-0000-0000-0000-000000000000	984fbafc-11d6-4759-b450-8a7a15d33d12	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 23:44:41.754935+00	
00000000-0000-0000-0000-000000000000	2f7b1eb2-c72e-49df-8e51-c5d2a85e0972	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-07 23:44:41.757558+00	
00000000-0000-0000-0000-000000000000	4aaaea04-b6bf-4d19-a5de-0b66c0d0b316	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 00:14:06.992286+00	
00000000-0000-0000-0000-000000000000	abdbd277-0ec7-47a3-8b8c-eed7a1eaa99b	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 00:14:06.995372+00	
00000000-0000-0000-0000-000000000000	bb761e16-d130-494c-ac1c-66794d7a8ed8	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 10:18:50.377158+00	
00000000-0000-0000-0000-000000000000	a8049682-4a81-4041-8983-46e100d4600f	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 10:18:50.38595+00	
00000000-0000-0000-0000-000000000000	6281b463-e67b-4d7f-8fcd-f7fdbc942b4d	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 14:58:54.14839+00	
00000000-0000-0000-0000-000000000000	22755b70-23c6-4d79-94d6-2ff30ceca4b3	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 14:58:54.148397+00	
00000000-0000-0000-0000-000000000000	428cfbd6-8903-4217-abd1-2fbb3e3ae104	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 14:58:54.149523+00	
00000000-0000-0000-0000-000000000000	521c5a48-27dd-488d-8f48-db79fa8ad782	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 14:58:54.152478+00	
00000000-0000-0000-0000-000000000000	14ebf10b-6be6-4c3c-b622-d91a8c3103c2	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 14:58:54.152355+00	
00000000-0000-0000-0000-000000000000	54a830fa-1eae-4d35-a7fe-ae5ef6866a39	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 14:58:54.153239+00	
00000000-0000-0000-0000-000000000000	97e7f80c-5440-4f19-8f4b-4b00d26258f8	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 14:58:54.206349+00	
00000000-0000-0000-0000-000000000000	6622e863-8611-4e75-a22a-d8603157d51c	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 14:58:54.207106+00	
00000000-0000-0000-0000-000000000000	44224e03-9eee-43f5-8599-8eae343175ab	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 15:01:12.0927+00	
00000000-0000-0000-0000-000000000000	e59cbf3e-12ba-464a-a2e9-97cad9b4598a	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 15:01:12.096562+00	
00000000-0000-0000-0000-000000000000	3568e924-892b-4562-b50d-0d319489c015	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 21:53:05.193761+00	
00000000-0000-0000-0000-000000000000	43d693ec-083d-42a5-8cff-43c3206b91d7	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 21:53:05.196386+00	
00000000-0000-0000-0000-000000000000	db150914-afb8-470c-94ce-456298713d35	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 21:53:05.202486+00	
00000000-0000-0000-0000-000000000000	c922cbc2-3536-40a3-b4c0-27779a1fa971	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 21:53:05.202508+00	
00000000-0000-0000-0000-000000000000	d4a668f5-923d-4a92-9002-d43039f7ccab	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 21:57:31.632203+00	
00000000-0000-0000-0000-000000000000	0a24ee5b-9bff-4818-a474-9bf65a5de233	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 21:57:31.635218+00	
00000000-0000-0000-0000-000000000000	ebc1b694-f5a4-46a6-86c0-9807687e9633	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 22:35:28.653049+00	
00000000-0000-0000-0000-000000000000	18d87825-1b73-4d36-b5a1-e425f1bb9c96	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 22:35:28.655962+00	
00000000-0000-0000-0000-000000000000	881f39d5-19e8-40a4-8355-63a89d1693bc	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 23:34:26.80446+00	
00000000-0000-0000-0000-000000000000	22ad7f34-40c8-45d9-a12d-37b97092c5c6	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-08 23:34:26.80665+00	
00000000-0000-0000-0000-000000000000	521fc0c5-d230-45e9-8da6-0483dd55d8ae	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 06:56:57.10638+00	
00000000-0000-0000-0000-000000000000	d9a08476-b9ed-4e2b-a2b1-b40abe41c677	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 06:56:57.112624+00	
00000000-0000-0000-0000-000000000000	29be4435-0036-4b0c-933b-dfb7cc394f47	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 06:56:59.18346+00	
00000000-0000-0000-0000-000000000000	eb37a0f9-7ac5-42d8-b44d-1fd945dfc797	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 06:56:59.184072+00	
00000000-0000-0000-0000-000000000000	dd9d132c-e53e-403b-9853-948346ba5603	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 07:01:24.507073+00	
00000000-0000-0000-0000-000000000000	52971b59-31e9-4d54-b415-b58ed9960517	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 07:01:24.510467+00	
00000000-0000-0000-0000-000000000000	aa6cdde2-6ea1-48ff-9785-7dca534b8ffd	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 07:16:01.229908+00	
00000000-0000-0000-0000-000000000000	8b5ab3b0-2c2a-4f54-bed0-c7e1610b7b75	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 07:16:01.232318+00	
00000000-0000-0000-0000-000000000000	86fe3624-1015-481c-a2a9-174fa9255065	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 07:26:46.353916+00	
00000000-0000-0000-0000-000000000000	66787830-c59d-4180-8159-2279d4cc1eb0	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 07:26:46.35534+00	
00000000-0000-0000-0000-000000000000	e1e6b4ad-d9b1-4d68-85c6-d830844d2df0	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 08:11:34.315165+00	
00000000-0000-0000-0000-000000000000	7ddc2d7c-b8ed-49c6-ae81-d990527308f2	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 08:11:34.320293+00	
00000000-0000-0000-0000-000000000000	dbb2d06d-5dc5-4299-b6fa-2ed72fcd90ed	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 08:19:32.830411+00	
00000000-0000-0000-0000-000000000000	5f4d9b29-3b56-4614-9637-6adcc5580d11	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 08:19:32.83434+00	
00000000-0000-0000-0000-000000000000	0b391252-a5d9-4f38-9cfe-1b9f2d7c3dcb	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 08:33:59.620196+00	
00000000-0000-0000-0000-000000000000	352ca90c-c5e0-4444-bde2-866bde52d387	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 08:33:59.626084+00	
00000000-0000-0000-0000-000000000000	96e4c029-817f-4690-8cf1-32479d83ac13	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 08:34:43.843954+00	
00000000-0000-0000-0000-000000000000	ef8cb2ca-6926-47ab-b3c7-37f67f45ec27	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 08:34:43.844595+00	
00000000-0000-0000-0000-000000000000	8c36ca97-e718-4ad9-a3fd-37fc05b03e23	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 08:55:27.509115+00	
00000000-0000-0000-0000-000000000000	50f19f9c-5195-412b-9371-931641aa1bf1	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 08:55:27.511682+00	
00000000-0000-0000-0000-000000000000	072cf98f-e32a-49a3-8af5-d1ce38e1061e	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 09:11:01.48842+00	
00000000-0000-0000-0000-000000000000	b5469b42-ce4d-457e-ac71-2d161ae6be46	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 09:11:01.491204+00	
00000000-0000-0000-0000-000000000000	aab7556a-140d-4a17-9894-8ba58ea049c4	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 09:33:58.660715+00	
00000000-0000-0000-0000-000000000000	7244a896-9952-41cb-b5c5-b8c51475dd3b	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 09:33:58.663276+00	
00000000-0000-0000-0000-000000000000	c92bd78c-010d-4339-a632-5b10cd2f5c1e	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 09:54:01.500104+00	
00000000-0000-0000-0000-000000000000	f91fdbe6-acc5-40d8-9eaf-7057e8592a64	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 09:54:01.503108+00	
00000000-0000-0000-0000-000000000000	2f8ac2d7-84cd-4331-909d-23f9e393b4b1	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 10:10:01.617661+00	
00000000-0000-0000-0000-000000000000	7301246e-830a-4960-b649-2aec58ddada9	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 10:10:01.619238+00	
00000000-0000-0000-0000-000000000000	c1f0d099-4a6b-4e4e-bb7d-9a39c916e448	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 10:33:01.887407+00	
00000000-0000-0000-0000-000000000000	182efe9a-6252-44be-b649-627f303940c1	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 10:33:01.889816+00	
00000000-0000-0000-0000-000000000000	ad27203c-b17d-488d-97dd-70fcf18145eb	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 10:53:01.778076+00	
00000000-0000-0000-0000-000000000000	c216c036-8b3c-45c5-8870-4061a202c314	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 10:53:01.781408+00	
00000000-0000-0000-0000-000000000000	ead5aa53-5c65-4e5d-b9df-f0fa5482f88d	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 11:32:01.574885+00	
00000000-0000-0000-0000-000000000000	20a71661-17a2-4696-8d86-83f244ba2744	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 11:32:01.577153+00	
00000000-0000-0000-0000-000000000000	b952380c-3d2b-4172-be30-d792bfb345ad	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 11:52:01.590274+00	
00000000-0000-0000-0000-000000000000	790364ab-ce7e-431a-95de-f5abb78f6c9d	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 11:52:01.592468+00	
00000000-0000-0000-0000-000000000000	ce5c912f-d816-4a43-9ffa-620041de05fc	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 12:23:54.113776+00	
00000000-0000-0000-0000-000000000000	68e9481a-f66f-49f0-99db-6b98bc332aa6	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 12:23:54.118153+00	
00000000-0000-0000-0000-000000000000	981fdd6a-affa-4423-8c53-13bd3bbde261	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 12:31:43.990469+00	
00000000-0000-0000-0000-000000000000	66a86b77-0eae-4969-88ba-37e8836ac145	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 12:31:43.992957+00	
00000000-0000-0000-0000-000000000000	5aa42369-fa32-4cbb-a9f7-058d9a2c8410	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 12:32:25.08133+00	
00000000-0000-0000-0000-000000000000	3aa2efd0-ead3-4a4a-b54c-9db09ecc3976	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 12:32:25.082067+00	
00000000-0000-0000-0000-000000000000	43078e9a-8ec2-4e9b-8f37-117fc5893819	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 12:36:18.826487+00	
00000000-0000-0000-0000-000000000000	2d999126-1f02-4a82-8f27-46b1ffb86c08	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 12:36:18.827425+00	
00000000-0000-0000-0000-000000000000	8c3019df-5f4b-41d4-a41b-ab98986ae10d	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 13:23:02.480439+00	
00000000-0000-0000-0000-000000000000	7747ab53-19ad-41ef-8adc-eb21ab872fda	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 13:23:02.484863+00	
00000000-0000-0000-0000-000000000000	2ccfc2d5-0492-4635-a69b-34619a0a577d	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 13:35:20.490376+00	
00000000-0000-0000-0000-000000000000	8c0792c3-6a95-4920-af9d-614276425f0a	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 13:35:20.493571+00	
00000000-0000-0000-0000-000000000000	82124b88-1283-4864-b72d-7be66d565944	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 17:34:43.523327+00	
00000000-0000-0000-0000-000000000000	fa60ba25-52a4-43cb-b6da-8fc9e4279927	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 17:34:43.526137+00	
00000000-0000-0000-0000-000000000000	7baa3c19-9b25-484a-b44e-67d106e3520d	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 17:34:43.55135+00	
00000000-0000-0000-0000-000000000000	147edda1-09af-44c8-ba36-92c230d739d7	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 17:34:43.55229+00	
00000000-0000-0000-0000-000000000000	2b862864-bf7f-4ca7-aafd-354969116039	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 17:34:43.61531+00	
00000000-0000-0000-0000-000000000000	fa01acf9-3688-4e61-870b-e0e6e7048c4a	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 17:34:43.615861+00	
00000000-0000-0000-0000-000000000000	a0f82b74-00d1-4979-b67d-2eca0df3bc19	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 18:34:02.033097+00	
00000000-0000-0000-0000-000000000000	57b7fb19-824b-4922-8261-07f7d162a771	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 18:34:02.035343+00	
00000000-0000-0000-0000-000000000000	f12cc528-185c-4873-98bb-d8982b4384b5	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 19:33:01.922424+00	
00000000-0000-0000-0000-000000000000	d53e905d-8c96-4c50-a952-90dc21a777dd	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 19:33:01.925847+00	
00000000-0000-0000-0000-000000000000	d2c23ac4-2493-4a2b-bce7-9233c76dc46b	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 20:39:01.304997+00	
00000000-0000-0000-0000-000000000000	e6ddf14a-69b5-40a2-83e9-5876d712dacb	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 20:39:01.30634+00	
00000000-0000-0000-0000-000000000000	29b10d5e-1e9f-4dd7-92c6-6dc772852b34	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 20:39:01.307705+00	
00000000-0000-0000-0000-000000000000	e9c8196e-2d1e-4bae-a107-bb60d270c53e	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 20:39:01.307615+00	
00000000-0000-0000-0000-000000000000	ab83e11d-c839-4427-a4fb-6ac063c729fe	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 20:45:54.622017+00	
00000000-0000-0000-0000-000000000000	7fb7b5b0-8a63-44ad-bde7-9688ea755479	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-09 20:45:54.624593+00	
00000000-0000-0000-0000-000000000000	935d40f0-3522-4b02-b22d-e5c9df08309e	{"action":"logout","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-09 21:23:59.747831+00	
00000000-0000-0000-0000-000000000000	d3c3cd75-8199-4c0d-95c3-056e7c30863a	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-09 21:24:13.500124+00	
00000000-0000-0000-0000-000000000000	2484c73d-2459-4a72-a8c6-22ce817a9730	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 00:20:16.705246+00	
00000000-0000-0000-0000-000000000000	5921ac1b-9d14-498d-8072-9c6131583706	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 00:20:16.707962+00	
00000000-0000-0000-0000-000000000000	e304d57b-898e-410b-99e8-38af064983ea	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 00:20:16.81541+00	
00000000-0000-0000-0000-000000000000	04d1cfaf-5f6b-4a07-8eb5-f8731f2c11ad	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 00:20:16.815995+00	
00000000-0000-0000-0000-000000000000	2ac5a519-be63-4225-b368-fec2bcc60e20	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 01:29:44.900704+00	
00000000-0000-0000-0000-000000000000	603ce24f-e451-40ff-a5cc-fddfdbe984cc	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 01:29:44.902206+00	
00000000-0000-0000-0000-000000000000	8923c1b3-f154-4aee-b5ee-72c3b3914eb3	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 01:29:46.954598+00	
00000000-0000-0000-0000-000000000000	8e7f5f65-a81c-460c-9a04-32c23f8e3b98	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 01:29:46.955239+00	
00000000-0000-0000-0000-000000000000	74aea71a-7568-4f12-883b-71121ca8af50	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 02:44:46.433096+00	
00000000-0000-0000-0000-000000000000	c6ab3681-f280-426a-8361-f3c999a1564b	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 02:44:46.437121+00	
00000000-0000-0000-0000-000000000000	edbef941-c8bc-424a-afb1-5b0de2f70498	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 02:44:46.594024+00	
00000000-0000-0000-0000-000000000000	55765a96-a4d2-435a-a56e-8fc9974ccb61	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 02:44:46.594585+00	
00000000-0000-0000-0000-000000000000	72b28a12-90da-4a5b-a610-af5dfd77305f	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 20:43:25.819345+00	
00000000-0000-0000-0000-000000000000	abeaf4d3-8823-462b-9e37-7301a50b0482	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 20:43:25.829971+00	
00000000-0000-0000-0000-000000000000	cf592b04-b258-46a3-b79c-e6162b99e42a	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 20:49:02.608017+00	
00000000-0000-0000-0000-000000000000	3d6bd785-45fb-47ed-b993-3363431fa93d	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 20:49:02.610255+00	
00000000-0000-0000-0000-000000000000	5e5f032b-37ea-4369-b744-9320d342ac0b	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 21:01:36.153102+00	
00000000-0000-0000-0000-000000000000	9b5c08c0-012a-4289-ae6e-81f1097c385e	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 21:01:36.155024+00	
00000000-0000-0000-0000-000000000000	e1b06d4b-dbf2-46d6-9e89-6919afc01ee9	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 21:42:29.018117+00	
00000000-0000-0000-0000-000000000000	c104ba20-1d8a-4b21-b435-198c90fdaae0	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 21:42:29.020952+00	
00000000-0000-0000-0000-000000000000	8e4f7c3c-a144-40e4-8071-5a08e2feb7cb	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 21:48:28.725351+00	
00000000-0000-0000-0000-000000000000	18d47265-d92f-46be-af23-9e429e2aa4a5	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 21:48:28.727151+00	
00000000-0000-0000-0000-000000000000	ea1d9965-4b9b-4aea-b713-686bbceb4519	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 22:00:28.687436+00	
00000000-0000-0000-0000-000000000000	556a55a0-b68f-44fd-968c-28413d838afd	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 22:00:28.691472+00	
00000000-0000-0000-0000-000000000000	41a593bb-d746-4145-8e38-51729b30b19a	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 22:48:32.221992+00	
00000000-0000-0000-0000-000000000000	c331cc90-1f36-484d-8464-6e89c5543f55	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-10 22:48:32.224043+00	
00000000-0000-0000-0000-000000000000	f69c7fcf-e1a8-49ed-8eb1-040297b596e0	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 08:54:29.907169+00	
00000000-0000-0000-0000-000000000000	b49ffe14-1dfd-4a4c-b2b4-f24e69c7aa67	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 08:54:29.912865+00	
00000000-0000-0000-0000-000000000000	729a4108-feee-45a0-80df-ca89eca03104	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 08:54:52.851422+00	
00000000-0000-0000-0000-000000000000	2c157e78-22ac-4fb1-988c-86092fb77ccc	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 08:54:52.852597+00	
00000000-0000-0000-0000-000000000000	ef1f0087-0f28-4df4-96f4-01a29f3b2c00	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 08:54:53.849691+00	
00000000-0000-0000-0000-000000000000	fb272c46-1a97-4e3f-b349-30cd8d673baa	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 08:54:53.850356+00	
00000000-0000-0000-0000-000000000000	2d2ad4a5-ed41-424c-bcfe-2481e2ab7141	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 10:13:27.350265+00	
00000000-0000-0000-0000-000000000000	8aaf64c8-9bbb-4b5c-8440-e19c60a45f76	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 10:13:27.352598+00	
00000000-0000-0000-0000-000000000000	56ed8e59-25bc-4bcb-8385-73c450d2c81d	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 11:43:44.401796+00	
00000000-0000-0000-0000-000000000000	3fcdd1fe-6cfe-4737-8181-0f6d069c9f54	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 11:43:44.405257+00	
00000000-0000-0000-0000-000000000000	0d40d327-ee5b-430a-bbd3-0850f2558588	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 15:25:41.498364+00	
00000000-0000-0000-0000-000000000000	d3f8e4da-8761-4fb4-8afb-e7b4c205d773	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 15:25:41.502808+00	
00000000-0000-0000-0000-000000000000	ecf94a97-8906-4f23-9d16-f37831f56174	{"action":"logout","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-11 15:42:08.040335+00	
00000000-0000-0000-0000-000000000000	c5d48ca8-3b8b-4c1c-86a5-7b64345e4482	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 15:57:06.034821+00	
00000000-0000-0000-0000-000000000000	1c2f4451-b44c-4b06-be1a-c86c61ae4e49	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 15:57:06.037654+00	
00000000-0000-0000-0000-000000000000	59e52bd6-6ed7-4d1c-8598-11c7da2c6873	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 16:03:23.940098+00	
00000000-0000-0000-0000-000000000000	59c34aea-5504-4f11-a3b3-9c287d0f86d7	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 16:03:23.941779+00	
00000000-0000-0000-0000-000000000000	9cb403b7-da5c-4654-8cd5-bac2472c3d72	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 16:03:25.560006+00	
00000000-0000-0000-0000-000000000000	b4093e01-5a29-4743-b2b7-a9fe6fab6bce	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 16:03:25.560644+00	
00000000-0000-0000-0000-000000000000	c9c3a2ee-5fb5-4826-9d8a-1617c9478327	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 16:55:26.109549+00	
00000000-0000-0000-0000-000000000000	1409c68f-4f8f-4b99-8200-40290e64d8a5	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 16:55:26.111275+00	
00000000-0000-0000-0000-000000000000	6da7e2ed-cf63-427f-bdfc-ea017ff34b82	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 17:54:27.601683+00	
00000000-0000-0000-0000-000000000000	e1e43402-71dc-4930-950c-cca27dc7e0c8	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 17:54:27.610397+00	
00000000-0000-0000-0000-000000000000	0dec535d-3942-4093-88f4-6c42fc103313	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 18:19:33.546259+00	
00000000-0000-0000-0000-000000000000	00bb8ab4-f4f8-4bc6-afda-62d60e364277	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 18:19:33.548095+00	
00000000-0000-0000-0000-000000000000	20d9e8e8-b55f-4c66-acab-eb330cba0bd0	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 18:33:54.023386+00	
00000000-0000-0000-0000-000000000000	ad23d7f4-cba9-4e7a-990e-8a2e4aec7808	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 18:33:54.025657+00	
00000000-0000-0000-0000-000000000000	e3d5c61c-e681-41a1-930a-9d749ee96f65	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 18:38:25.892002+00	
00000000-0000-0000-0000-000000000000	3949f4c9-60b0-4d6a-bc81-cded019fa060	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 18:38:25.893416+00	
00000000-0000-0000-0000-000000000000	eefe5b0c-d335-4b04-a962-aa5a468a6a66	{"action":"logout","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-11 18:39:07.956803+00	
00000000-0000-0000-0000-000000000000	e448f34c-3576-42c1-82d6-a3d52ba92e2e	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 18:53:27.495658+00	
00000000-0000-0000-0000-000000000000	8aca12c8-c7ca-4c8e-a84f-17fbb1f7fc40	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 18:53:27.498543+00	
00000000-0000-0000-0000-000000000000	2472a5e1-6832-4f09-bcbc-a7b03fa46099	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 19:32:27.624046+00	
00000000-0000-0000-0000-000000000000	72425738-9094-484f-acdf-e02a1fc15bec	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 19:32:27.628502+00	
00000000-0000-0000-0000-000000000000	1929193e-5407-4366-b2dc-7ba95697e387	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 20:24:12.070818+00	
00000000-0000-0000-0000-000000000000	5797a967-0986-4156-82e3-81c1b96db62e	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 20:24:12.073618+00	
00000000-0000-0000-0000-000000000000	0fb16bc2-7838-434b-9c4c-a14fab4e3eb3	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 20:24:12.134542+00	
00000000-0000-0000-0000-000000000000	551d5d48-50ec-4d5d-83da-9773e4dfecca	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 20:24:12.135095+00	
00000000-0000-0000-0000-000000000000	d7bb525b-4c4c-49a4-9710-252faaaf0668	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 20:35:09.892102+00	
00000000-0000-0000-0000-000000000000	362e00e4-37da-46ad-9e70-0ded624234d9	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 20:35:09.894755+00	
00000000-0000-0000-0000-000000000000	b2c27239-0bd2-4af0-ab59-eb7abe3ab25b	{"action":"logout","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-11 20:40:24.550729+00	
00000000-0000-0000-0000-000000000000	02f2caf7-da43-4bbc-b205-89b14b900505	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-11 20:45:20.474823+00	
00000000-0000-0000-0000-000000000000	698b1d6f-bca6-4a03-8096-2ca961a38e83	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 21:44:00.783529+00	
00000000-0000-0000-0000-000000000000	f9a7377e-47ff-4772-95ea-6df0fbb9456b	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 21:44:00.785556+00	
00000000-0000-0000-0000-000000000000	bc48bd23-b84c-4012-ab58-4c940c681d0f	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 22:42:50.576163+00	
00000000-0000-0000-0000-000000000000	ad0ca1ae-2ada-44bb-aede-765f7deecd93	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-11 22:42:50.577126+00	
00000000-0000-0000-0000-000000000000	65c509b0-e2dd-45fb-bcb7-3b0cd9ba60a3	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 07:51:33.146693+00	
00000000-0000-0000-0000-000000000000	4e24a24a-7b9d-4396-b119-bbe13d2a042c	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 07:51:33.152422+00	
00000000-0000-0000-0000-000000000000	9cc461ed-9c1e-485f-9078-c25922582595	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 08:51:41.292177+00	
00000000-0000-0000-0000-000000000000	f5656d3a-b9a1-4178-a4c2-0680ce77f4fc	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 08:51:41.297446+00	
00000000-0000-0000-0000-000000000000	f57fcff7-9588-4ca8-9817-910af5fb12a1	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-12 09:14:54.195028+00	
00000000-0000-0000-0000-000000000000	f1d4aa20-48fd-4217-a6f1-061af386926c	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-12 09:24:12.035985+00	
00000000-0000-0000-0000-000000000000	825b33a1-c600-445f-81cb-8a56da367605	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 09:53:41.198634+00	
00000000-0000-0000-0000-000000000000	1a8aac1d-cd97-4c7b-97bd-5ca8d61a6dd2	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 09:53:41.200933+00	
00000000-0000-0000-0000-000000000000	32721f16-5c16-4bd4-89e7-8a78b2539049	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-12 10:06:21.585749+00	
00000000-0000-0000-0000-000000000000	e08cdcc5-005f-4934-a561-dd4e1fa15f44	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 10:23:02.014366+00	
00000000-0000-0000-0000-000000000000	bc9515e1-9a84-40ba-a117-f89d5800f76e	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 10:23:02.01698+00	
00000000-0000-0000-0000-000000000000	2c52aece-d75e-482e-b8c4-9b231fc4a144	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 10:38:41.637739+00	
00000000-0000-0000-0000-000000000000	fc0b25e2-2858-4e72-b9d2-88ca8389f032	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 10:38:41.642852+00	
00000000-0000-0000-0000-000000000000	a21e465d-062d-4fb6-b624-f799453772aa	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 10:52:17.027339+00	
00000000-0000-0000-0000-000000000000	339f5c30-bd41-4d7c-ac00-5e2ceb3ca741	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 10:52:17.029791+00	
00000000-0000-0000-0000-000000000000	47216fa3-493b-4ebe-967a-19d1e8601b95	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 12:41:05.826402+00	
00000000-0000-0000-0000-000000000000	36bb7d53-dd29-4223-9d43-af1088dac6e4	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 12:41:05.827835+00	
00000000-0000-0000-0000-000000000000	b04e328a-3170-4690-8104-85e229a53ec4	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 12:41:12.02492+00	
00000000-0000-0000-0000-000000000000	a1d39d24-e017-47ae-b8a5-4caa2878aabf	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 12:41:12.025667+00	
00000000-0000-0000-0000-000000000000	41a0912a-babc-4cfd-9616-653a5e2ee6fa	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 12:41:13.902555+00	
00000000-0000-0000-0000-000000000000	9ec8a08a-00be-4454-8e7a-4f171edb852c	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 12:41:13.903141+00	
00000000-0000-0000-0000-000000000000	eadac8dc-003c-4e49-ba17-f083e33e01bf	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 12:41:17.93333+00	
00000000-0000-0000-0000-000000000000	8cca8934-48e8-4df6-ba1f-c94f90234b0c	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 12:41:17.934423+00	
00000000-0000-0000-0000-000000000000	02373880-c925-472a-9e3e-eca8bca35204	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-12 13:20:24.191199+00	
00000000-0000-0000-0000-000000000000	793e9ade-2581-41c4-836d-3c200a601375	{"action":"login","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-12 13:28:14.607148+00	
00000000-0000-0000-0000-000000000000	13b49fac-d1ee-4800-8123-de073c34ebd4	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 13:40:17.389742+00	
00000000-0000-0000-0000-000000000000	4d71de8b-1e62-4995-81c1-7806116aaba6	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 13:40:17.391455+00	
00000000-0000-0000-0000-000000000000	eccde54f-7817-4a9c-8c46-5a20c952a5bf	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 13:40:17.503744+00	
00000000-0000-0000-0000-000000000000	48776b89-3020-4b97-a944-4b11c35ffec4	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 13:40:17.504321+00	
00000000-0000-0000-0000-000000000000	ab982943-718a-4182-9317-6d6f3d5d1c98	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 14:27:40.474968+00	
00000000-0000-0000-0000-000000000000	31d6ca1e-c665-47f3-bb3a-13979c6af67b	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 14:27:40.47591+00	
00000000-0000-0000-0000-000000000000	0154ffe3-c106-4f5b-ba3e-a8200f2be9d9	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 14:39:03.429563+00	
00000000-0000-0000-0000-000000000000	6aa69797-154b-404d-b969-e9207d94c83a	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 14:39:03.431003+00	
00000000-0000-0000-0000-000000000000	fce5c00a-1a06-4bda-8275-0f3b1a752330	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 14:39:17.473105+00	
00000000-0000-0000-0000-000000000000	4f6f907b-6761-45d3-ae7a-aa67464e8b72	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 14:39:17.473731+00	
00000000-0000-0000-0000-000000000000	a8ef51c4-f7b8-479b-ba4f-b2377e5ee4f9	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 14:40:59.773215+00	
00000000-0000-0000-0000-000000000000	c9710d5e-9dc8-4ef7-a99d-42430fd21bd4	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-12 14:40:59.774119+00	
00000000-0000-0000-0000-000000000000	4082a776-9be3-4390-8175-a9cab0a12683	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 08:14:34.422454+00	
00000000-0000-0000-0000-000000000000	b9d84beb-5da0-49bd-abce-f648d6b8b290	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 08:14:34.424568+00	
00000000-0000-0000-0000-000000000000	6675d384-56c5-4176-a422-a518ecfb62d8	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 08:14:34.42954+00	
00000000-0000-0000-0000-000000000000	a20c06e1-e6e9-44dd-81e8-1dd9058e3b89	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 08:14:34.433774+00	
00000000-0000-0000-0000-000000000000	8feea60f-f877-426b-a2f2-02e62942682a	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 08:14:34.433671+00	
00000000-0000-0000-0000-000000000000	184e9fae-796d-4c25-bc26-52c985605e37	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 08:14:34.433861+00	
00000000-0000-0000-0000-000000000000	0362dbf4-4c19-4502-b63d-27984f5a1e97	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 08:29:17.403859+00	
00000000-0000-0000-0000-000000000000	cd4084ad-e2b6-443a-be71-ef4e333a61ea	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 08:29:17.40541+00	
00000000-0000-0000-0000-000000000000	772a1af2-7fd3-47e5-a89f-8c153ebdd774	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 08:55:50.478985+00	
00000000-0000-0000-0000-000000000000	e25bd115-b623-4faa-a274-6426ff11fbce	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 08:55:50.480761+00	
00000000-0000-0000-0000-000000000000	bed03491-e979-4648-9b57-4856461e74db	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 09:25:31.713234+00	
00000000-0000-0000-0000-000000000000	052b0baf-2fbe-433c-b7a3-033417033ba5	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 09:25:31.715021+00	
00000000-0000-0000-0000-000000000000	6bfef9ca-589d-4f7b-99ea-7b0566311e9c	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 09:56:30.292143+00	
00000000-0000-0000-0000-000000000000	ee955f14-c468-4031-bdf4-8e10c5a026b3	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 09:56:30.29355+00	
00000000-0000-0000-0000-000000000000	53ddc3c9-7903-425a-a732-58869d78e551	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 10:22:20.777805+00	
00000000-0000-0000-0000-000000000000	7c1f06a5-76f7-4409-9d2c-cf452dff515a	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 10:22:20.779955+00	
00000000-0000-0000-0000-000000000000	cef050bb-963e-4e55-8bf1-07311befe3fb	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 10:37:28.396108+00	
00000000-0000-0000-0000-000000000000	8efa6d01-3aff-4708-af65-931d7f039e15	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 10:37:28.3997+00	
00000000-0000-0000-0000-000000000000	c23348c0-15e2-4429-b310-5362fe19177c	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 10:38:19.12121+00	
00000000-0000-0000-0000-000000000000	35d1d4ce-1460-4d29-b466-a60fe2589406	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 10:38:19.121826+00	
00000000-0000-0000-0000-000000000000	612535ce-5bf4-4db8-bcad-5ac1ac3333a5	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 11:57:41.102706+00	
00000000-0000-0000-0000-000000000000	25d520e8-e25a-4a08-a126-85616b43afb9	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 11:57:41.103989+00	
00000000-0000-0000-0000-000000000000	c6528f6e-71ea-40b9-a13f-7eef5e664546	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 13:55:24.461167+00	
00000000-0000-0000-0000-000000000000	4b2e067c-993e-42c9-9982-d05230b33641	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 13:55:24.46216+00	
00000000-0000-0000-0000-000000000000	5d1e575a-533d-4692-8d4a-a490fd6a2a8e	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 15:17:28.115669+00	
00000000-0000-0000-0000-000000000000	2dbf0197-edd5-482f-bdb4-be3536e682b9	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 15:17:28.118103+00	
00000000-0000-0000-0000-000000000000	84674ee3-38dd-4c22-9098-ea1e520bc82c	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 16:00:30.214004+00	
00000000-0000-0000-0000-000000000000	33d312c3-3bd3-4cc2-9a3c-31ecc31715fd	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 16:00:30.217226+00	
00000000-0000-0000-0000-000000000000	540a816b-2ad0-44d1-9ec6-a28347e39faa	{"action":"login","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-13 16:10:02.867628+00	
00000000-0000-0000-0000-000000000000	93b8db6f-dc03-4acf-80fb-4c7040fc8580	{"action":"login","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-13 16:13:19.43118+00	
00000000-0000-0000-0000-000000000000	ac6d5002-24f1-4e39-b93b-f5c7419e80e4	{"action":"user_confirmation_requested","actor_id":"c4c9a172-92c2-410e-a671-56b443fc093d","actor_name":"S├│nia Cristina Pinto dos Santos Carias ","actor_username":"sonia.santos.scps82@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-07-13 16:36:25.009868+00	
00000000-0000-0000-0000-000000000000	527ddf88-d932-4379-ab6b-8275f02eb666	{"action":"user_confirmation_requested","actor_id":"e4b3296c-13eb-4faa-aead-e246ddb2bf66","actor_name":"Diogo Miguel da Concei├º├úo silva Carias ","actor_username":"diogo.carias@outlook.pt","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-07-13 16:36:49.768148+00	
00000000-0000-0000-0000-000000000000	f262acb5-1bd4-4512-aa8c-b46d612acd6b	{"action":"user_signedup","actor_id":"c4c9a172-92c2-410e-a671-56b443fc093d","actor_name":"S├│nia Cristina Pinto dos Santos Carias ","actor_username":"sonia.santos.scps82@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-07-13 16:36:51.490258+00	
00000000-0000-0000-0000-000000000000	4287aae5-1691-4597-9d54-6962578d0d4a	{"action":"user_signedup","actor_id":"e4b3296c-13eb-4faa-aead-e246ddb2bf66","actor_name":"Diogo Miguel da Concei├º├úo silva Carias ","actor_username":"diogo.carias@outlook.pt","actor_via_sso":false,"log_type":"team"}	2025-07-13 16:37:57.97418+00	
00000000-0000-0000-0000-000000000000	8f36cba3-b8b0-46d5-8a4b-362a13291ca6	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 17:15:13.861817+00	
00000000-0000-0000-0000-000000000000	bd33ade2-427f-4dc4-a3d9-cdca3aaa1056	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 17:15:13.864009+00	
00000000-0000-0000-0000-000000000000	149abce1-7e6c-4560-8d46-e9710f32f7bc	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 18:28:59.245434+00	
00000000-0000-0000-0000-000000000000	f0ffa419-ace3-4765-b83a-484227cf2676	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 18:28:59.249679+00	
00000000-0000-0000-0000-000000000000	c39cdf8f-1f69-4590-bebf-88ecca661d6a	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 18:32:43.49224+00	
00000000-0000-0000-0000-000000000000	ae6d3725-1f02-4009-8f26-50242d46e0e5	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 18:32:43.494308+00	
00000000-0000-0000-0000-000000000000	4e3b1f34-9e99-4407-8b90-0cc0f14c9ae3	{"action":"token_refreshed","actor_id":"e4b3296c-13eb-4faa-aead-e246ddb2bf66","actor_name":"Diogo Miguel da Concei├º├úo silva Carias ","actor_username":"diogo.carias@outlook.pt","actor_via_sso":false,"log_type":"token"}	2025-07-13 19:11:30.631955+00	
00000000-0000-0000-0000-000000000000	a999cbf5-0f25-4482-92c5-f10ba54c72b7	{"action":"token_revoked","actor_id":"e4b3296c-13eb-4faa-aead-e246ddb2bf66","actor_name":"Diogo Miguel da Concei├º├úo silva Carias ","actor_username":"diogo.carias@outlook.pt","actor_via_sso":false,"log_type":"token"}	2025-07-13 19:11:30.636822+00	
00000000-0000-0000-0000-000000000000	594e1c25-b82d-411d-b95f-432d583f4586	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 19:29:24.471142+00	
00000000-0000-0000-0000-000000000000	c8b33a7e-44c6-44ca-903c-eeb6fb3ce403	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 19:29:24.474488+00	
00000000-0000-0000-0000-000000000000	5b47dd6c-0cfb-448f-8d6f-f2a69efb0b39	{"action":"token_refreshed","actor_id":"e4b3296c-13eb-4faa-aead-e246ddb2bf66","actor_name":"Diogo Miguel da Concei├º├úo silva Carias ","actor_username":"diogo.carias@outlook.pt","actor_via_sso":false,"log_type":"token"}	2025-07-13 23:05:18.607179+00	
00000000-0000-0000-0000-000000000000	12867710-ba7c-4608-9a15-84a3981dfb2d	{"action":"token_revoked","actor_id":"e4b3296c-13eb-4faa-aead-e246ddb2bf66","actor_name":"Diogo Miguel da Concei├º├úo silva Carias ","actor_username":"diogo.carias@outlook.pt","actor_via_sso":false,"log_type":"token"}	2025-07-13 23:05:18.610982+00	
00000000-0000-0000-0000-000000000000	c2dc0a7f-d62b-445b-8793-2a969132e301	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 23:13:10.830088+00	
00000000-0000-0000-0000-000000000000	866319f9-5726-488e-9c37-8bffce91fea3	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-13 23:13:10.832395+00	
00000000-0000-0000-0000-000000000000	d20d3884-90be-44e3-80e5-1dd95eac1ac3	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 08:53:18.016908+00	
00000000-0000-0000-0000-000000000000	929f45c0-d340-4278-b9d4-2e8ac0b1ae05	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 08:53:18.028872+00	
00000000-0000-0000-0000-000000000000	fb66c56f-44ce-40c5-ad61-3fd0724e53bd	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 09:38:53.136438+00	
00000000-0000-0000-0000-000000000000	abed6c86-d9a0-4ed5-99a7-d2eeff9326ba	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 09:38:53.139338+00	
00000000-0000-0000-0000-000000000000	af9359f6-ddd5-452a-8ba8-95607c222d10	{"action":"user_repeated_signup","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-07-14 10:35:15.941632+00	
00000000-0000-0000-0000-000000000000	28a46523-f93e-428d-b59f-62a29da561d0	{"action":"user_repeated_signup","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-07-14 10:40:45.321663+00	
00000000-0000-0000-0000-000000000000	911cf7a9-d7a9-47a9-996f-bd2c05139c62	{"action":"user_repeated_signup","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-07-14 10:58:40.875994+00	
00000000-0000-0000-0000-000000000000	15736fe9-40b4-4914-9ad8-25e5a0ab7c0c	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 11:02:42.688158+00	
00000000-0000-0000-0000-000000000000	2431b790-4370-46d4-a694-a10e517b9e8f	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 11:02:42.689614+00	
00000000-0000-0000-0000-000000000000	cfce5069-5f90-49ba-81ef-045c8dbf0a0f	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 11:03:31.665123+00	
00000000-0000-0000-0000-000000000000	dc39aa38-aaf2-4520-91f8-bd622255b77a	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 11:03:31.665733+00	
00000000-0000-0000-0000-000000000000	1b49463e-b158-41da-b0d1-de66f8fed138	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-14 11:43:06.357655+00	
00000000-0000-0000-0000-000000000000	3312765f-26d2-4926-a063-aa64ab64b8a7	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 14:04:16.758911+00	
00000000-0000-0000-0000-000000000000	0f9a129f-f369-4000-ba00-f94623c3acf6	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 14:04:16.76258+00	
00000000-0000-0000-0000-000000000000	fac4852b-4a4b-4a8b-8ab4-3f2bd8f19f88	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 16:04:43.885226+00	
00000000-0000-0000-0000-000000000000	db8e1974-6863-45be-a5e2-8e068a83673b	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 16:04:43.887211+00	
00000000-0000-0000-0000-000000000000	6537b139-7876-4601-9fa7-d8f335ee4188	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 16:30:46.490883+00	
00000000-0000-0000-0000-000000000000	1742e628-db24-4eca-b7af-ecc9fa307d64	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 16:30:46.493997+00	
00000000-0000-0000-0000-000000000000	161f0b3d-b226-4fc7-9c7a-60fbcd87d63f	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 17:09:00.915426+00	
00000000-0000-0000-0000-000000000000	fabaf65c-1806-4f11-a831-ec41790c6e4b	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 17:09:00.918023+00	
00000000-0000-0000-0000-000000000000	86f47e5f-27aa-4b4a-9e41-37e1a239adbb	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 17:35:38.165095+00	
00000000-0000-0000-0000-000000000000	b9af8c20-9c38-4994-a13f-11f396eea68f	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 17:35:38.16851+00	
00000000-0000-0000-0000-000000000000	81e71e00-6d63-4d60-8b88-b2f90fe02493	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 19:24:45.623764+00	
00000000-0000-0000-0000-000000000000	08db627d-2b18-490d-91a7-98883c2e19bc	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 19:24:45.627521+00	
00000000-0000-0000-0000-000000000000	949bf184-fc14-47f0-9b94-4d3555c396b9	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 21:47:06.777854+00	
00000000-0000-0000-0000-000000000000	5d505de1-74da-477f-9dc8-169f37306b79	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 21:47:06.783897+00	
00000000-0000-0000-0000-000000000000	8f97d482-b934-4ee6-82ed-da23c2688b84	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 22:45:23.770243+00	
00000000-0000-0000-0000-000000000000	40462410-c0df-4cac-8d8d-98749437b2eb	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 22:45:23.771749+00	
00000000-0000-0000-0000-000000000000	29ca12f3-aa6f-4c52-a122-acb4df9a8731	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 23:45:10.510589+00	
00000000-0000-0000-0000-000000000000	e691f1a6-3855-4496-a2e4-11502d82bad1	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 23:45:10.513366+00	
00000000-0000-0000-0000-000000000000	406a7b8d-8f1b-4f88-9dad-5be856f73048	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 23:46:32.852093+00	
00000000-0000-0000-0000-000000000000	d4154781-1a50-4731-9618-ccfa26f2ecba	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-14 23:46:32.853682+00	
00000000-0000-0000-0000-000000000000	0052c380-5f3d-49fe-918e-3c71f32917f8	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 00:49:32.64938+00	
00000000-0000-0000-0000-000000000000	7b455654-8648-44bf-b13f-dd7d945cf003	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 00:49:32.652219+00	
00000000-0000-0000-0000-000000000000	1a6e97a7-65e9-4ebc-b449-cc6c29353a06	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 01:05:20.014384+00	
00000000-0000-0000-0000-000000000000	fa16ec0f-1f28-4bd9-be76-c8589380d25e	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 01:05:20.017049+00	
00000000-0000-0000-0000-000000000000	9cb56fcf-705b-4ad9-b8b0-3148dcf2a034	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 01:05:46.833823+00	
00000000-0000-0000-0000-000000000000	76956504-6e34-4bfd-9874-86485711fbce	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 01:05:46.83502+00	
00000000-0000-0000-0000-000000000000	277b1098-272f-4992-a256-1df69b31fc64	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 02:04:32.656326+00	
00000000-0000-0000-0000-000000000000	f40d51b9-3c03-498e-ae34-f30877e7c7a9	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 02:04:32.65798+00	
00000000-0000-0000-0000-000000000000	3d0e5891-d343-4a3d-bd44-3e8ffe86f180	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 02:14:05.358644+00	
00000000-0000-0000-0000-000000000000	978dda7d-8438-4e6e-b28d-5140493b4df7	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 02:14:05.360497+00	
00000000-0000-0000-0000-000000000000	490636d5-5443-4396-9f5d-41ff44ee15d6	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 03:03:31.610864+00	
00000000-0000-0000-0000-000000000000	fde36027-9c89-47d1-a7b9-9e68214639b0	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 03:03:31.61423+00	
00000000-0000-0000-0000-000000000000	2e772de7-dae5-45d5-8550-c5432afd0727	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 03:13:31.81184+00	
00000000-0000-0000-0000-000000000000	8fa96f64-e658-42d9-9940-37c4812894af	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 03:13:31.814472+00	
00000000-0000-0000-0000-000000000000	9487c5ea-0bc4-4147-a074-cb047791a6f5	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 04:02:31.489717+00	
00000000-0000-0000-0000-000000000000	ceb2ae7d-ea0a-4543-a4a5-5b779edf97c5	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 04:02:31.492567+00	
00000000-0000-0000-0000-000000000000	bca1572c-c058-4fe4-819f-65999115fd13	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 04:12:10.583909+00	
00000000-0000-0000-0000-000000000000	d5b05c34-2796-4157-a7dc-62f40cbc92a9	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 04:12:10.585899+00	
00000000-0000-0000-0000-000000000000	7c47772b-a66b-4be7-a199-e232b74cbfa1	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 05:01:31.701034+00	
00000000-0000-0000-0000-000000000000	0cddf551-1cfa-436e-997e-470af74724df	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 05:01:31.701968+00	
00000000-0000-0000-0000-000000000000	ce0f3d40-47aa-4006-8fd7-e46e6e0d7231	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 05:11:27.60847+00	
00000000-0000-0000-0000-000000000000	d5b00a99-2be1-4bcf-9ffc-3b7a107e1816	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 05:11:27.609333+00	
00000000-0000-0000-0000-000000000000	9d7cacb8-af53-4719-9d4a-cc5405a77500	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 07:14:29.633068+00	
00000000-0000-0000-0000-000000000000	e6324ad0-4670-4a78-bb48-9034ce9c20ac	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 07:14:29.637575+00	
00000000-0000-0000-0000-000000000000	29b6266c-d34c-47b7-b308-662255d6918f	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 07:18:17.778779+00	
00000000-0000-0000-0000-000000000000	266939bf-6dd3-4c91-818d-30e3e2539bc6	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 07:18:17.780199+00	
00000000-0000-0000-0000-000000000000	d59898bf-8f3c-4849-b984-d78eff7aebeb	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 08:16:46.452484+00	
00000000-0000-0000-0000-000000000000	d2ec4730-9f11-4314-ada0-23ab5b491513	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 08:16:46.455537+00	
00000000-0000-0000-0000-000000000000	bf102727-7100-47d2-8580-2b91e104912c	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 09:17:35.374624+00	
00000000-0000-0000-0000-000000000000	f219cb8e-37d5-4f6b-bc57-95a3840d2731	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 09:17:35.376789+00	
00000000-0000-0000-0000-000000000000	24204cbb-510a-4cfd-83d8-0b19aefbf6a6	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 10:32:35.609872+00	
00000000-0000-0000-0000-000000000000	48561f20-c790-4e4d-964f-a4e7c3129458	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 10:32:35.611311+00	
00000000-0000-0000-0000-000000000000	c0a56a17-b2ec-44f8-9d78-ea31924267de	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 11:49:01.311912+00	
00000000-0000-0000-0000-000000000000	38cda529-2653-4802-af16-6bd3d5584f42	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 11:49:01.313795+00	
00000000-0000-0000-0000-000000000000	26b52840-1dc7-4750-9bbd-8857e46ba6e9	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 13:54:40.684017+00	
00000000-0000-0000-0000-000000000000	b67a8fe7-4d9c-4397-90cb-abf4a4e3c6f6	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 13:54:40.686042+00	
00000000-0000-0000-0000-000000000000	5dc47ad2-474f-45e2-b914-35e936a6b532	{"action":"token_refreshed","actor_id":"c4c9a172-92c2-410e-a671-56b443fc093d","actor_name":"S├│nia Cristina Pinto dos Santos Carias ","actor_username":"sonia.santos.scps82@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 13:57:00.772181+00	
00000000-0000-0000-0000-000000000000	082b56be-ef8c-4cbd-a075-76a381838a3b	{"action":"token_revoked","actor_id":"c4c9a172-92c2-410e-a671-56b443fc093d","actor_name":"S├│nia Cristina Pinto dos Santos Carias ","actor_username":"sonia.santos.scps82@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 13:57:00.77359+00	
00000000-0000-0000-0000-000000000000	e06eea99-43fa-4688-9e4f-d7d583259c3f	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 14:26:29.033449+00	
00000000-0000-0000-0000-000000000000	ef013c66-4c62-4f8f-8221-fec1327b2f72	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 14:26:29.038519+00	
00000000-0000-0000-0000-000000000000	7bde7063-f19c-4e72-be78-95fddfb959ed	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 14:53:59.873304+00	
00000000-0000-0000-0000-000000000000	a2770a33-c1dd-430a-8201-c11d95fd2fc0	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 14:53:59.875257+00	
00000000-0000-0000-0000-000000000000	40ee7d9d-fc2b-42e9-a10e-66da5dd450d4	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 15:52:59.96044+00	
00000000-0000-0000-0000-000000000000	af2c2c44-9027-4f46-9497-8f8b220efe22	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 15:52:59.965916+00	
00000000-0000-0000-0000-000000000000	05839fd5-2d86-48a9-a8a1-2576b614406a	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 16:51:55.885298+00	
00000000-0000-0000-0000-000000000000	887cf8ef-a8b3-414b-82ab-1f59dab50b68	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 16:51:55.889643+00	
00000000-0000-0000-0000-000000000000	16347f83-5b90-420f-9eaf-f48c4d62b1f0	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 17:08:44.337892+00	
00000000-0000-0000-0000-000000000000	02d7c299-ecee-485b-a354-c156962b2fdb	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 17:08:44.341234+00	
00000000-0000-0000-0000-000000000000	0b15cd46-d45d-4ecb-8256-def7f42f139f	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 18:03:35.730666+00	
00000000-0000-0000-0000-000000000000	ec2f8eda-673d-4be8-a239-b080d974a601	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 18:03:35.732949+00	
00000000-0000-0000-0000-000000000000	46c92330-e2d3-4ae9-9594-31421d34fb3c	{"action":"logout","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-15 18:03:40.471962+00	
00000000-0000-0000-0000-000000000000	d1aaf044-5c9c-4b28-aa8c-2d7055ed9ccd	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 21:55:27.956025+00	
00000000-0000-0000-0000-000000000000	b3093583-477a-4668-89ca-c12d991c5b66	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 21:55:27.962903+00	
00000000-0000-0000-0000-000000000000	65dc62ed-b544-401d-838c-ebd83e649d1e	{"action":"login","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-15 22:09:05.05675+00	
00000000-0000-0000-0000-000000000000	e64b21fc-3077-43d7-8197-b2e72e5beda5	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 23:07:25.080622+00	
00000000-0000-0000-0000-000000000000	3e9e0c17-4a59-4d62-9416-5a8551cd3fc3	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-15 23:07:25.083484+00	
00000000-0000-0000-0000-000000000000	0be28465-5543-4967-a8ff-19d88fc2b187	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-15 23:13:35.750517+00	
00000000-0000-0000-0000-000000000000	9b877d65-e24c-46b7-8dc5-f0297dc8ac18	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 04:32:25.990008+00	
00000000-0000-0000-0000-000000000000	e8905c4f-bc60-45a6-9195-855d922d4c41	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 04:32:25.997658+00	
00000000-0000-0000-0000-000000000000	e5887ba4-9bbf-414c-8211-dca493cfc34f	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 09:04:12.923796+00	
00000000-0000-0000-0000-000000000000	bb7a8e71-cfc6-4f35-97fc-bf0c870b98cb	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 09:04:12.933535+00	
00000000-0000-0000-0000-000000000000	61a6d4da-651e-4e39-8a59-2eb063db0b39	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 09:50:31.329366+00	
00000000-0000-0000-0000-000000000000	abefa4ef-51d6-47ec-bcec-7bb65d3522ae	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 09:50:31.33359+00	
00000000-0000-0000-0000-000000000000	6b53d76f-47f8-4eee-9ef2-e0500720e687	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 10:02:12.323608+00	
00000000-0000-0000-0000-000000000000	e9fc3b58-1903-4aa5-87d3-c6922e522d4b	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 10:02:12.326148+00	
00000000-0000-0000-0000-000000000000	be991c94-8b78-4a7e-a829-0666b554e946	{"action":"token_refreshed","actor_id":"e4b3296c-13eb-4faa-aead-e246ddb2bf66","actor_name":"Diogo Miguel da Concei├º├úo silva Carias ","actor_username":"diogo.carias@outlook.pt","actor_via_sso":false,"log_type":"token"}	2025-07-16 10:33:19.103854+00	
00000000-0000-0000-0000-000000000000	2946f66d-8ba2-4821-a792-ee5fcf60ee0e	{"action":"token_revoked","actor_id":"e4b3296c-13eb-4faa-aead-e246ddb2bf66","actor_name":"Diogo Miguel da Concei├º├úo silva Carias ","actor_username":"diogo.carias@outlook.pt","actor_via_sso":false,"log_type":"token"}	2025-07-16 10:33:19.106636+00	
00000000-0000-0000-0000-000000000000	e4d55717-2199-47b1-aa36-d78d50ea6292	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 11:00:51.67834+00	
00000000-0000-0000-0000-000000000000	cf1dcca5-2dde-4ff9-84e6-3432f5c985fd	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 11:00:51.680847+00	
00000000-0000-0000-0000-000000000000	a32e07f7-1484-4c7a-ae3d-b8c8c8e12df0	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 11:59:00.963836+00	
00000000-0000-0000-0000-000000000000	e9379359-6318-4323-8765-8f4b4715ed26	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 11:59:00.965415+00	
00000000-0000-0000-0000-000000000000	3c649f76-849d-44e4-aa43-9b97b3ee9887	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 12:57:42.878513+00	
00000000-0000-0000-0000-000000000000	4d5a90a0-f195-40e7-a27e-227c0cda2229	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 12:57:42.889711+00	
00000000-0000-0000-0000-000000000000	232e5b19-efa6-4299-991e-552793201ec7	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 13:57:41.480112+00	
00000000-0000-0000-0000-000000000000	804a96ef-4980-4370-8613-963d80d5a8a0	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 13:57:41.482886+00	
00000000-0000-0000-0000-000000000000	2258fa71-686b-47f3-85fe-2c683b1ab020	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 13:57:42.226194+00	
00000000-0000-0000-0000-000000000000	1951a6cf-0e56-4398-a96d-47be9652ae9b	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 13:57:42.228806+00	
00000000-0000-0000-0000-000000000000	8293a739-291f-4297-9be2-c56cd8c9fea4	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 14:56:33.370371+00	
00000000-0000-0000-0000-000000000000	ffee908e-fafc-4d70-b48d-c5194de58f79	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 14:56:33.373148+00	
00000000-0000-0000-0000-000000000000	c6e864e4-d2cc-4bf6-9554-cf3b058bbd78	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 15:55:01.000523+00	
00000000-0000-0000-0000-000000000000	9034c802-5407-4306-9246-aa84d0ab3de0	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 15:55:01.004695+00	
00000000-0000-0000-0000-000000000000	87e2f8d5-7d1d-460e-9fe6-8a5966dfd389	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 16:53:54.325908+00	
00000000-0000-0000-0000-000000000000	b1b8da69-f590-45cf-82b8-cb360576feaf	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 16:53:54.32883+00	
00000000-0000-0000-0000-000000000000	ef8b7fc8-5035-432b-a0f7-83860021188c	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 17:52:33.561455+00	
00000000-0000-0000-0000-000000000000	c3e4db43-cb2c-4dfd-b506-a2a87d9c709e	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 17:52:33.563478+00	
00000000-0000-0000-0000-000000000000	d2e0b0b1-c009-4310-9ea4-2d484e14287f	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-16 21:12:24.381524+00	
00000000-0000-0000-0000-000000000000	25c310f9-3dd3-49f1-82a7-84d3f3aef214	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 22:13:40.299407+00	
00000000-0000-0000-0000-000000000000	8a3ca3d3-9c79-4ba5-b50a-e7f63c258cb3	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-16 22:13:40.302603+00	
00000000-0000-0000-0000-000000000000	b0c1be55-6268-4a21-9f32-950e1ce68390	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 09:12:56.368008+00	
00000000-0000-0000-0000-000000000000	d0a6be05-5a1a-4a9a-bced-98371f600fc5	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 09:12:56.378608+00	
00000000-0000-0000-0000-000000000000	9847c768-95e5-4f99-8db6-eb4bfa7c4add	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-17 09:45:54.532172+00	
00000000-0000-0000-0000-000000000000	74331adb-a7da-4b64-8aed-a16b31e2034e	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 10:11:43.924694+00	
00000000-0000-0000-0000-000000000000	28bc7306-ddd7-4566-9ee4-9bf8928289fc	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 10:11:43.927264+00	
00000000-0000-0000-0000-000000000000	b4438b38-9af3-4720-b77b-2d44ec41c9db	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 11:13:47.38319+00	
00000000-0000-0000-0000-000000000000	d77b40dc-66a7-4ea5-aacf-84991a5cda36	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 11:13:47.384582+00	
00000000-0000-0000-0000-000000000000	07c64e55-dcab-4208-87c5-6a546de627ad	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 12:12:33.300208+00	
00000000-0000-0000-0000-000000000000	23eaf157-b89a-4a2c-b931-65a05ef79391	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 12:12:33.304024+00	
00000000-0000-0000-0000-000000000000	6a9c016f-62cf-4a4c-82a7-edf500d70b65	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 12:57:41.898759+00	
00000000-0000-0000-0000-000000000000	d25eb25c-0922-4883-af57-a457163d6209	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 12:57:41.900366+00	
00000000-0000-0000-0000-000000000000	353b4ba6-7af9-467f-ba40-300b35d33786	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 13:11:33.828206+00	
00000000-0000-0000-0000-000000000000	ce9e04d5-b7e5-4ee4-87bf-b2fd3c4906fd	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 13:11:33.831285+00	
00000000-0000-0000-0000-000000000000	8328f0f0-c174-40ab-b29c-4920da0b41c0	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 14:10:32.908392+00	
00000000-0000-0000-0000-000000000000	739b7238-579f-4b93-911c-83e9391b4895	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 14:10:32.910837+00	
00000000-0000-0000-0000-000000000000	4eff22ee-f1d3-43a9-803a-54fa3840fd8c	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 14:57:17.483416+00	
00000000-0000-0000-0000-000000000000	3e3a5bc1-cde7-4f6f-b2db-e52afdd0197e	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 14:57:17.485952+00	
00000000-0000-0000-0000-000000000000	09d5f237-ebb2-488a-a31b-a97389720292	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 15:09:33.016073+00	
00000000-0000-0000-0000-000000000000	9d9d14c0-d48d-47a5-b4a0-5b79ea9347d9	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 15:09:33.018931+00	
00000000-0000-0000-0000-000000000000	14ce3b4d-204e-4330-85b1-b63887ea3f7e	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 16:08:32.901109+00	
00000000-0000-0000-0000-000000000000	3d46b62c-d5e4-4402-b218-ed6433e008a2	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 16:08:32.905074+00	
00000000-0000-0000-0000-000000000000	b6e68628-5933-4362-bf93-fe9bd70d3201	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 16:09:34.578383+00	
00000000-0000-0000-0000-000000000000	e6b6564b-9441-4000-baa7-838b6c3c8571	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 16:09:34.580476+00	
00000000-0000-0000-0000-000000000000	75af7bb7-f34c-4cd5-b7a2-627bf77cef9d	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 17:07:33.089882+00	
00000000-0000-0000-0000-000000000000	5916992f-ab99-42cf-bd34-2b87dc02fcd6	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 17:07:33.092116+00	
00000000-0000-0000-0000-000000000000	53b9b142-77ae-4b5a-8c6a-571233b583cd	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 18:06:32.91605+00	
00000000-0000-0000-0000-000000000000	3d9e3d2f-a936-4992-b32a-175ca025596c	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 18:06:32.918893+00	
00000000-0000-0000-0000-000000000000	074e7cfe-7c7c-4ff2-a775-034cafd7b31a	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 18:18:48.349721+00	
00000000-0000-0000-0000-000000000000	6b28e579-6d0f-41f7-9c80-d7a6784aa641	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 18:18:48.352548+00	
00000000-0000-0000-0000-000000000000	5995841f-1f37-463d-87ef-085e5e8d694f	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 19:05:33.010449+00	
00000000-0000-0000-0000-000000000000	2662673e-ba96-4c26-b07a-c2b510246500	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 19:05:33.013442+00	
00000000-0000-0000-0000-000000000000	0168d378-22f4-45f6-94ec-92e4cf44318b	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 20:42:02.914596+00	
00000000-0000-0000-0000-000000000000	c641ca39-99c1-406f-a558-2c24f2dc09e7	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 20:42:02.91753+00	
00000000-0000-0000-0000-000000000000	58f26b1c-502f-4312-b7c3-241a7ff70124	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 20:43:02.122914+00	
00000000-0000-0000-0000-000000000000	befa21ba-7f82-4c64-a1ac-24ccf706f20b	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 20:43:02.12374+00	
00000000-0000-0000-0000-000000000000	1833be4f-0df7-4e06-93b4-47feedff5452	{"action":"logout","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-17 21:00:34.897134+00	
00000000-0000-0000-0000-000000000000	259e2ccc-0d30-42c2-a4ff-243ebf385d29	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-17 21:46:18.79212+00	
00000000-0000-0000-0000-000000000000	6250ca0b-c46c-4b7b-8b97-f857936b88bc	{"action":"logout","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-17 21:46:25.530062+00	
00000000-0000-0000-0000-000000000000	5dacc688-9f5f-4510-a996-732f0edd2a98	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-17 21:46:34.193235+00	
00000000-0000-0000-0000-000000000000	029ff236-fc8d-4e71-bdc1-ab77579bc525	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 22:45:17.633225+00	
00000000-0000-0000-0000-000000000000	d2346b10-f373-41be-849f-435eeb863d00	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-17 22:45:17.637074+00	
00000000-0000-0000-0000-000000000000	430b5a8c-0812-435a-8e53-0e610dec6cd5	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 09:03:35.329488+00	
00000000-0000-0000-0000-000000000000	6a984694-e800-44be-a1b4-0ed3fcebaacf	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 09:03:35.34695+00	
00000000-0000-0000-0000-000000000000	26ab7776-5940-4938-a5e6-d8d08190d723	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 10:01:52.19577+00	
00000000-0000-0000-0000-000000000000	bb6c6bb1-6fd8-414e-b7d6-aeb9217b4af8	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 10:01:52.201034+00	
00000000-0000-0000-0000-000000000000	fdf813e4-d5dd-454e-abb1-fb313a64f50b	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 11:00:44.242005+00	
00000000-0000-0000-0000-000000000000	7c86fd36-c8f4-42ee-914f-e1ec466effe4	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 11:00:44.246351+00	
00000000-0000-0000-0000-000000000000	8f7bf696-31d6-4a82-9c3e-f30a25581612	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 11:34:20.036249+00	
00000000-0000-0000-0000-000000000000	cdb30186-9588-421e-9d2c-a563ee8e955c	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 11:34:20.039835+00	
00000000-0000-0000-0000-000000000000	66d80982-4cb6-484f-901b-59abbbcfd979	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 11:59:44.213823+00	
00000000-0000-0000-0000-000000000000	75f347e4-bbb7-428c-a857-8d7a9a60c89e	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 11:59:44.223936+00	
00000000-0000-0000-0000-000000000000	403d3fca-6585-4636-ab4c-c972ec3e406c	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 12:58:01.070403+00	
00000000-0000-0000-0000-000000000000	9b3916b5-5351-49ac-bb96-84c463fd6fe7	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 12:58:01.072883+00	
00000000-0000-0000-0000-000000000000	f772b70b-0869-4fb1-b84f-a667ed780970	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 13:40:47.134556+00	
00000000-0000-0000-0000-000000000000	c4b5a87b-7f1b-47c3-9e31-88170ae776af	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 13:40:47.136087+00	
00000000-0000-0000-0000-000000000000	6c84480a-6ea5-43f2-a697-fc93fc9d65e3	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 14:18:03.96445+00	
00000000-0000-0000-0000-000000000000	c3771503-45fb-4257-b1e4-c835909a088c	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 14:18:03.967087+00	
00000000-0000-0000-0000-000000000000	5f713c87-d3f3-4bdc-825f-77f8a303f912	{"action":"logout","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-18 14:31:03.556213+00	
00000000-0000-0000-0000-000000000000	967951b0-896d-48d7-95a1-407c7899e4d2	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-18 14:39:45.3961+00	
00000000-0000-0000-0000-000000000000	5de7e147-6f77-4659-9ade-e25d9c451d06	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 15:51:22.246754+00	
00000000-0000-0000-0000-000000000000	39733f3a-d8e5-4fe2-8b9b-f77b16bfdb5f	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 15:51:22.251154+00	
00000000-0000-0000-0000-000000000000	2bf8c028-0111-46ce-b5a5-43b633f53e7a	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-18 17:22:41.170748+00	
00000000-0000-0000-0000-000000000000	5a47e3e3-8bc6-4167-8938-c5447c35dcf5	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 17:23:57.015454+00	
00000000-0000-0000-0000-000000000000	13c9ee28-91c1-45c3-a008-8ecc1708d3d8	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 17:23:57.016988+00	
00000000-0000-0000-0000-000000000000	19f8c656-3455-4069-b8a0-d008fa42a0c5	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 18:22:06.171383+00	
00000000-0000-0000-0000-000000000000	252514cd-c380-45ff-9d81-b9f0b4c7a33a	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 18:22:06.17628+00	
00000000-0000-0000-0000-000000000000	1fffb0e7-ff47-4275-a2bc-7bf13740b311	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 18:31:14.776407+00	
00000000-0000-0000-0000-000000000000	bcfd785e-5098-4e38-ae65-3f65ae2f2574	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 18:31:14.77937+00	
00000000-0000-0000-0000-000000000000	e4f0f3be-3b96-47f0-905e-e4febaca4b0a	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-18 18:33:33.734435+00	
00000000-0000-0000-0000-000000000000	9e514d86-a446-4df8-85f9-3b0cd3872ad5	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 19:30:15.181189+00	
00000000-0000-0000-0000-000000000000	9868de60-b62d-433b-9a36-105c994f49d1	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-18 19:30:15.184152+00	
00000000-0000-0000-0000-000000000000	57c2a5b1-6966-4ed3-9a12-0e0a978268b3	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 08:29:31.715386+00	
00000000-0000-0000-0000-000000000000	86a3dd28-1cab-4b7c-b9ae-fd7e2b90e559	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 08:29:31.728814+00	
00000000-0000-0000-0000-000000000000	0914d49a-cac5-4316-ab0c-fbb18cb8fcab	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 08:33:19.404564+00	
00000000-0000-0000-0000-000000000000	efbb3938-82bd-452f-9d8f-ec6e8c96547a	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 08:33:19.406199+00	
00000000-0000-0000-0000-000000000000	77046d13-05e1-46a3-92b7-18996937f06d	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-19 09:15:14.519614+00	
00000000-0000-0000-0000-000000000000	8bbb3ae1-db92-4367-9c86-bbf6d17711ea	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 09:53:05.022562+00	
00000000-0000-0000-0000-000000000000	b8b6a92d-56d4-45bb-a367-01a88beee7a7	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 09:53:05.023972+00	
00000000-0000-0000-0000-000000000000	086aab3e-6027-4d7c-acb1-bc7592615561	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 11:05:28.368744+00	
00000000-0000-0000-0000-000000000000	a84bad7d-4f1a-4e1b-9f71-f0e0af9fdfea	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 11:05:28.37343+00	
00000000-0000-0000-0000-000000000000	72a87830-9aa0-460e-809b-72b14ec9c42d	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-19 11:50:09.295756+00	
00000000-0000-0000-0000-000000000000	dd7f6ea4-7b18-4591-be70-5c55d557da38	{"action":"token_refreshed","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 12:50:36.368383+00	
00000000-0000-0000-0000-000000000000	961e729c-d3bb-45f0-a27e-bca3501ea918	{"action":"token_revoked","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 12:50:36.369995+00	
00000000-0000-0000-0000-000000000000	085cddcd-ba3a-4629-ad5c-dbfbf601919d	{"action":"logout","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-19 12:50:41.687667+00	
00000000-0000-0000-0000-000000000000	1fa341be-77d8-4ebf-85a4-8708b3d0e77c	{"action":"login","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-19 13:02:41.232359+00	
00000000-0000-0000-0000-000000000000	3284cf3e-3c47-4198-9285-53c4cfdaf1b7	{"action":"logout","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-19 13:03:15.390315+00	
00000000-0000-0000-0000-000000000000	58fb89cd-534f-47b9-baec-0dc251bcff3d	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 14:02:41.665653+00	
00000000-0000-0000-0000-000000000000	2f1d72cc-3284-4e21-bd8e-032f1bfd6beb	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 14:02:41.667407+00	
00000000-0000-0000-0000-000000000000	9fd20df0-4ae0-4385-8e57-a3ab0940fb4d	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-19 14:57:47.11914+00	
00000000-0000-0000-0000-000000000000	4ecfc276-8442-4839-8a0c-dddfd085b63e	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-19 14:59:34.97517+00	
00000000-0000-0000-0000-000000000000	18c31ef2-3bd3-4f71-8cc4-69813db05190	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-19 15:14:21.642428+00	
00000000-0000-0000-0000-000000000000	21b6dbbc-6127-4b8c-8108-ac00f52624f0	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 15:32:25.725761+00	
00000000-0000-0000-0000-000000000000	70f4330f-ce36-4f7b-a471-05019d20c369	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 15:32:25.728521+00	
00000000-0000-0000-0000-000000000000	1f8ca083-acf8-4899-95e4-b3b090cc2e3f	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-19 15:40:53.74661+00	
00000000-0000-0000-0000-000000000000	235721ab-e6a6-43a9-9314-e68e2712e49a	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 17:12:18.265256+00	
00000000-0000-0000-0000-000000000000	d42fd7df-47cb-40dc-b2e1-a7630d83da7c	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 17:12:18.267774+00	
00000000-0000-0000-0000-000000000000	4c911e16-b640-4526-8e94-bb534dbd8f4d	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 17:12:59.907728+00	
00000000-0000-0000-0000-000000000000	0f653663-dfbd-42e6-9dae-ad9f34db7cdb	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 17:12:59.908384+00	
00000000-0000-0000-0000-000000000000	68efec1f-ccbd-4677-935b-311874060c59	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 18:22:26.614632+00	
00000000-0000-0000-0000-000000000000	19b218ad-23f0-4487-aefa-33a05fcf74dc	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 18:22:26.618784+00	
00000000-0000-0000-0000-000000000000	dc579b1a-f594-4ece-9bc9-1869fd12e73a	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 19:41:13.150953+00	
00000000-0000-0000-0000-000000000000	3b10eda0-3938-4b8c-b5a2-949d935c1d3c	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 19:41:13.156248+00	
00000000-0000-0000-0000-000000000000	cad92fed-b695-4412-b527-0f8eeb523836	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 21:21:42.468251+00	
00000000-0000-0000-0000-000000000000	bf23ec3f-b12f-40bc-a247-96171d5edeb5	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 21:21:42.473801+00	
00000000-0000-0000-0000-000000000000	bf049a17-c467-4c21-baba-a8713995b159	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 22:15:38.225674+00	
00000000-0000-0000-0000-000000000000	829a13de-dfcd-42a6-bb69-9a063642f870	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-19 22:15:38.22886+00	
00000000-0000-0000-0000-000000000000	f724ea6a-f79e-44d4-a127-3ba84b129995	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-19 23:15:35.839777+00	
00000000-0000-0000-0000-000000000000	76f22603-650a-4027-877c-158d71ae1ecb	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-19 23:38:08.400107+00	
00000000-0000-0000-0000-000000000000	41806dc9-8f9e-48b9-94d0-558fe2a30977	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 08:51:49.597505+00	
00000000-0000-0000-0000-000000000000	ad8bfd71-d0ca-4b78-b806-0317d76326f4	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 08:52:19.075725+00	
00000000-0000-0000-0000-000000000000	eadee08b-0fd3-4421-becd-69fb64ea984d	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 08:52:19.078039+00	
00000000-0000-0000-0000-000000000000	8acd0b8e-d1a9-4482-9fd8-ae40b1b5f8d4	{"action":"logout","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-20 08:53:10.745303+00	
00000000-0000-0000-0000-000000000000	a2cb2a8e-414d-4c16-b0d6-a635569b5638	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 08:53:55.671571+00	
00000000-0000-0000-0000-000000000000	bf04ab06-833b-4b4d-84ad-ca876f729afe	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 09:05:05.334917+00	
00000000-0000-0000-0000-000000000000	9415e370-0f77-42ec-a1fb-32ec402ed999	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 09:05:05.340364+00	
00000000-0000-0000-0000-000000000000	f3bfaccd-e46e-4b68-8ae0-adbc3d3ac322	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 09:07:31.472135+00	
00000000-0000-0000-0000-000000000000	dc210ad6-c47a-44e0-92b2-3de69a76bb29	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 09:07:31.473741+00	
00000000-0000-0000-0000-000000000000	b2696b75-d9fb-4ea5-9ab5-fee95efd9be7	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 09:08:14.295484+00	
00000000-0000-0000-0000-000000000000	f370f7e4-fa26-4dcd-a7b2-57d1aa9360d5	{"action":"login","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 09:13:03.059485+00	
00000000-0000-0000-0000-000000000000	e0cfad48-e6da-40f4-8a13-ae747f0f1cd4	{"action":"logout","actor_id":"5774d833-c4c9-4375-b393-710c408f5426","actor_name":"Carlos Barradas ","actor_username":"carlosbarradas.cripto@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-20 09:15:40.204634+00	
00000000-0000-0000-0000-000000000000	6a647460-f96f-44c8-9d6f-2ebd248b63d4	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 09:16:24.772621+00	
00000000-0000-0000-0000-000000000000	e810b839-1986-4b3c-9dcd-cd43c87c361f	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 09:26:08.611178+00	
00000000-0000-0000-0000-000000000000	accc0084-d72d-497d-80fa-88455622cc31	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 09:54:32.328506+00	
00000000-0000-0000-0000-000000000000	b06bd53b-b622-4bc9-bbc6-86675b3e10ec	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 11:05:19.249774+00	
00000000-0000-0000-0000-000000000000	619e1284-9401-4e00-8c3e-b96089f04b13	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 11:05:19.254796+00	
00000000-0000-0000-0000-000000000000	6edd0b29-0bcd-4671-895d-0150a3c0fb19	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 14:34:04.910402+00	
00000000-0000-0000-0000-000000000000	efdf4f0b-cf73-4ca2-adea-c1cc397b6da3	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 14:34:04.918124+00	
00000000-0000-0000-0000-000000000000	67910e12-4dda-46d3-954d-61c896104a87	{"action":"token_refreshed","actor_id":"e4b3296c-13eb-4faa-aead-e246ddb2bf66","actor_name":"Diogo Miguel da Concei├º├úo silva Carias ","actor_username":"diogo.carias@outlook.pt","actor_via_sso":false,"log_type":"token"}	2025-07-20 15:12:01.259266+00	
00000000-0000-0000-0000-000000000000	6f4ad320-8d55-40c8-b6e0-024e138cb935	{"action":"token_revoked","actor_id":"e4b3296c-13eb-4faa-aead-e246ddb2bf66","actor_name":"Diogo Miguel da Concei├º├úo silva Carias ","actor_username":"diogo.carias@outlook.pt","actor_via_sso":false,"log_type":"token"}	2025-07-20 15:12:01.267853+00	
00000000-0000-0000-0000-000000000000	b1494fa6-c31d-4c48-8023-99e4b440c542	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 16:53:12.293107+00	
00000000-0000-0000-0000-000000000000	50056c21-dcc3-4ddd-bb28-5b5ee8f9e66b	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 16:53:12.300897+00	
00000000-0000-0000-0000-000000000000	93c37fb9-ce86-49c3-9958-611dc709f262	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 17:21:36.142337+00	
00000000-0000-0000-0000-000000000000	5d09cc2b-a749-40d5-bb83-179dfa0ec1ca	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 17:21:36.146539+00	
00000000-0000-0000-0000-000000000000	cffb337c-c0bb-40e4-b65f-d871a8e9e9db	{"action":"token_refreshed","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 17:52:10.284109+00	
00000000-0000-0000-0000-000000000000	c2d7b0be-a77b-4b6d-810a-8ccbdd38089f	{"action":"token_revoked","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 17:52:10.290098+00	
00000000-0000-0000-0000-000000000000	14a0f6b7-46e4-4caf-8590-f810ebedef2f	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 17:55:43.761844+00	
00000000-0000-0000-0000-000000000000	5e122491-f063-4427-8835-8802a9aeb4d6	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 18:04:41.790269+00	
00000000-0000-0000-0000-000000000000	b3b88034-221e-4110-9414-f67b0f5e6d14	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 18:11:45.464395+00	
00000000-0000-0000-0000-000000000000	749b98c5-8d51-4588-ba06-f6c2298d21c6	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 18:18:50.016731+00	
00000000-0000-0000-0000-000000000000	f76933cc-aa18-46f2-aad9-6c220c7d9123	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 18:24:54.080451+00	
00000000-0000-0000-0000-000000000000	d58a554b-f4fe-4309-ba32-86bc47f4f81b	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 18:30:10.799525+00	
00000000-0000-0000-0000-000000000000	7a530ad0-abf9-40ed-814f-2bb806c26f49	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 19:02:48.639906+00	
00000000-0000-0000-0000-000000000000	1d83cebf-568c-4132-8137-af5d69ab2625	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 19:10:09.67301+00	
00000000-0000-0000-0000-000000000000	9e790672-666f-445b-a067-a252f7d2b091	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 19:10:09.675066+00	
00000000-0000-0000-0000-000000000000	91015ad5-bc21-41dc-92fd-23fa7aa52787	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 21:30:52.489024+00	
00000000-0000-0000-0000-000000000000	3198d2cb-5e8e-4ecd-8f04-17a58e396860	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 21:30:52.492791+00	
00000000-0000-0000-0000-000000000000	bb5c120a-dd17-416b-ad52-c5ac136b0b4a	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 21:47:00.757773+00	
00000000-0000-0000-0000-000000000000	591e8b4f-b0ce-4f69-8077-0081e88d2868	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 21:50:34.227812+00	
00000000-0000-0000-0000-000000000000	b39057fa-4624-41d5-95c3-91f32feeec90	{"action":"logout","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-20 21:51:20.409227+00	
00000000-0000-0000-0000-000000000000	5ae2d94d-e163-42e0-8473-6f75967cc8e8	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 21:51:55.506524+00	
00000000-0000-0000-0000-000000000000	7c4b470d-fc75-4712-87b6-bee967c25daf	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 22:35:16.648349+00	
00000000-0000-0000-0000-000000000000	f7d47533-4341-468c-90e3-2f224774bea2	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 22:46:14.026068+00	
00000000-0000-0000-0000-000000000000	1e34954a-f586-47f6-b3d8-ce06f8794805	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 22:46:14.030915+00	
00000000-0000-0000-0000-000000000000	000707fa-be87-4890-8122-81b51dc99ad1	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 22:46:42.264226+00	
00000000-0000-0000-0000-000000000000	cb9d12fa-3992-43b4-ae71-92961cd8adc7	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-20 22:46:42.265868+00	
00000000-0000-0000-0000-000000000000	4a0533a9-f847-41c2-a5b8-5f21878d1685	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 22:54:29.513771+00	
00000000-0000-0000-0000-000000000000	d9b6fa57-9c0c-4495-94f6-b77e35036be2	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 23:09:47.004076+00	
00000000-0000-0000-0000-000000000000	f8267aa2-fb4f-491a-a627-1be619f3a644	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 23:22:08.762697+00	
00000000-0000-0000-0000-000000000000	408d7cfa-148f-4715-9bf6-c25eb66720fd	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-20 23:40:31.489787+00	
00000000-0000-0000-0000-000000000000	9f8e3594-1c3e-42dd-a466-c6941a62ae40	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 00:01:07.517164+00	
00000000-0000-0000-0000-000000000000	de236b5e-8c54-4e0d-819e-6b1196860b09	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 00:04:42.861987+00	
00000000-0000-0000-0000-000000000000	4041ea3a-e1da-4022-9dc1-6ad408c64365	{"action":"logout","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-21 00:28:37.792482+00	
00000000-0000-0000-0000-000000000000	a9c12c16-b5bd-493e-a4d8-ae1eb68e420b	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 00:28:57.416402+00	
00000000-0000-0000-0000-000000000000	be62db07-6827-42f2-b32f-828041194f5d	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 00:31:19.344498+00	
00000000-0000-0000-0000-000000000000	ca050515-7324-4918-baf2-a3854326c23e	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-21 09:45:56.578473+00	
00000000-0000-0000-0000-000000000000	2728266a-815e-4e02-8c7f-b804a0b0f017	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-21 09:45:56.59639+00	
00000000-0000-0000-0000-000000000000	3919cf2c-9038-447c-acd9-13367a1294c5	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-21 09:46:16.104672+00	
00000000-0000-0000-0000-000000000000	989063b6-53bd-4ee4-8d1f-fd1dbaf409ee	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 10:34:23.768308+00	
00000000-0000-0000-0000-000000000000	4d1b1c1b-daf9-4ef9-96b8-85ad043b0ae5	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 10:52:08.989042+00	
00000000-0000-0000-0000-000000000000	8239027b-ba9f-42b6-ba24-295aaf3f5275	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 11:03:13.762551+00	
00000000-0000-0000-0000-000000000000	f9dfcac2-221d-4ecb-ba8c-7f4680094036	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 11:04:35.389202+00	
00000000-0000-0000-0000-000000000000	dca7ae0a-8a48-456c-a44e-f5d8ccda5618	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 11:13:10.004631+00	
00000000-0000-0000-0000-000000000000	6a6fd145-7f42-4e0e-b640-15b72a2a1476	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 11:13:41.752443+00	
00000000-0000-0000-0000-000000000000	6afb7998-9c9b-42e4-aec0-d6ef07521d05	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 11:14:32.304041+00	
00000000-0000-0000-0000-000000000000	c4a9c9ac-fec1-4cfa-8633-407e640ea019	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 11:21:42.051402+00	
00000000-0000-0000-0000-000000000000	b450ee3b-4017-4729-b7c9-b1ddae3078a4	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 11:57:10.652466+00	
00000000-0000-0000-0000-000000000000	d7fbc37f-59f7-4e72-b7d8-d6f3d90d47d9	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 12:21:04.091495+00	
00000000-0000-0000-0000-000000000000	05ce4ead-14f5-42ca-8b71-c49feeb92409	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-21 13:50:02.102133+00	
00000000-0000-0000-0000-000000000000	9430b187-a466-47f3-b766-564c04d64467	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-21 13:50:02.105851+00	
00000000-0000-0000-0000-000000000000	c05cc906-ed64-4f8e-807c-d03497eb4c3a	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-21 13:59:35.890105+00	
00000000-0000-0000-0000-000000000000	5573b792-7c5f-48ce-834a-4498c27d4646	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-21 13:59:35.892992+00	
00000000-0000-0000-0000-000000000000	6ed01b23-23ff-4994-a0d8-220a99c653fc	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-21 14:00:19.204672+00	
00000000-0000-0000-0000-000000000000	71b50860-489b-485d-bf87-4d78eb7d17db	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-21 14:00:19.205314+00	
00000000-0000-0000-0000-000000000000	66712846-e89e-4adc-bc0d-bbc5bd08629a	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 14:05:41.298979+00	
00000000-0000-0000-0000-000000000000	44de4709-9d82-4624-8d71-4063cb31e607	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 14:20:43.594995+00	
00000000-0000-0000-0000-000000000000	92eca2f1-7498-4709-a9d2-501dfb166d36	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 14:46:36.672883+00	
00000000-0000-0000-0000-000000000000	2860cea1-9e85-41cc-b8be-dde633621e5c	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 14:47:21.484388+00	
00000000-0000-0000-0000-000000000000	d34c4c38-bcd5-49d6-8a5d-261b062048f9	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 14:48:22.11761+00	
00000000-0000-0000-0000-000000000000	3291a3f9-2afb-44dc-9d04-ddce7fa97762	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 15:40:31.568226+00	
00000000-0000-0000-0000-000000000000	80f00340-23ae-46f3-b671-b3c6deaebb6d	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 15:44:57.891203+00	
00000000-0000-0000-0000-000000000000	09c244d4-b7b2-46da-8f9c-2e698b24ea9b	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 15:52:41.858049+00	
00000000-0000-0000-0000-000000000000	a2e50042-5cc4-4e2d-a4d0-72c0f2419534	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-21 16:09:30.997678+00	
00000000-0000-0000-0000-000000000000	87035231-41d2-4c7e-9ea6-0257f35db4e3	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-21 16:09:31.000145+00	
00000000-0000-0000-0000-000000000000	0268aeed-731e-448d-995c-69bc3f4de582	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 16:36:34.483936+00	
00000000-0000-0000-0000-000000000000	718af0aa-0b88-4cd0-96b4-ab515a8fc939	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 16:39:58.238703+00	
00000000-0000-0000-0000-000000000000	f2141963-0dc8-4ffb-86cc-c5576087a4ca	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 16:40:50.979985+00	
00000000-0000-0000-0000-000000000000	b46aff05-d1a9-4e2f-80ce-695724fd63a6	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 16:43:45.787549+00	
00000000-0000-0000-0000-000000000000	cdf2c8bf-cfa6-4d15-87f4-75bca3af8d1e	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 16:45:29.633327+00	
00000000-0000-0000-0000-000000000000	8ffb2084-8735-4a12-95ae-53887f103fb8	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 16:47:32.149724+00	
00000000-0000-0000-0000-000000000000	1d7cd497-d75b-4877-8746-7462944bb603	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 16:52:32.155364+00	
00000000-0000-0000-0000-000000000000	c048a9ba-8419-410c-9962-b75af3b3fa57	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 17:01:24.002899+00	
00000000-0000-0000-0000-000000000000	8930f9f5-50d3-42cd-a6ee-44b35b3ba24e	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-21 17:36:20.748648+00	
00000000-0000-0000-0000-000000000000	84970560-ea38-4b26-8c22-3365c1e34f88	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-21 17:36:20.756639+00	
00000000-0000-0000-0000-000000000000	1f400bfc-cc8a-409e-ba78-a1a1c5729adf	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-21 19:27:46.334882+00	
00000000-0000-0000-0000-000000000000	48057b3c-943e-49ce-a755-5c4672c3359c	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-21 19:27:46.337363+00	
00000000-0000-0000-0000-000000000000	357806bd-a0d5-4c7d-8626-bc976f3ce38a	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-21 19:36:31.419059+00	
00000000-0000-0000-0000-000000000000	ca8a06dd-a38e-4897-943c-ebe1dc0c192a	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-21 19:36:31.421929+00	
00000000-0000-0000-0000-000000000000	ecd3d607-753d-463d-9cfb-2989bb2a5a7a	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 19:38:07.314155+00	
00000000-0000-0000-0000-000000000000	f848ea6b-bfe9-46c4-8042-ad43721d44d9	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 19:44:31.212548+00	
00000000-0000-0000-0000-000000000000	c3e2aa0c-adeb-40ca-8b50-351f290d210f	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 22:08:49.058648+00	
00000000-0000-0000-0000-000000000000	43129bf1-0292-4418-8f63-67b8fa9cfe7d	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 22:49:11.242529+00	
00000000-0000-0000-0000-000000000000	156e798f-ef08-4c81-906d-0b9e3e187ab9	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-21 23:25:45.449157+00	
00000000-0000-0000-0000-000000000000	43090825-3810-4126-97ef-1311db541dcc	{"action":"login","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 08:47:51.324978+00	
00000000-0000-0000-0000-000000000000	e9cece4d-1d4a-4329-9cd9-3845d75d7d3a	{"action":"logout","actor_id":"25158bf6-d02c-43ca-9efd-2608a32d4a60","actor_name":"Carlos Barradas","actor_username":"carlosbarradas1@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-22 08:49:59.253353+00	
00000000-0000-0000-0000-000000000000	3435f586-e196-4312-a0db-921703bccbb5	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 08:50:27.611264+00	
00000000-0000-0000-0000-000000000000	17bdb05d-b063-4c00-85a1-099026aacb31	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 10:18:04.562052+00	
00000000-0000-0000-0000-000000000000	2f27794e-0bc0-4086-aa29-9199d7e5bcd3	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 10:18:51.928111+00	
00000000-0000-0000-0000-000000000000	33c47dae-7dfe-4210-b67c-829636781021	{"action":"token_refreshed","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-22 10:19:17.805703+00	
00000000-0000-0000-0000-000000000000	9ff7a7be-1d7c-40e5-a8cb-194297bba39a	{"action":"token_revoked","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-22 10:19:17.806328+00	
00000000-0000-0000-0000-000000000000	98716d41-7e6b-43f6-b7b8-fed6621d46b3	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 10:19:24.513184+00	
00000000-0000-0000-0000-000000000000	edbe7f98-6e31-4f6c-8446-887e8b07582c	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 10:22:18.4783+00	
00000000-0000-0000-0000-000000000000	5f05e0f1-4ea5-439d-a498-d659295aa0eb	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 10:25:30.121406+00	
00000000-0000-0000-0000-000000000000	9c62541e-404b-4f41-97ea-01bf8e72a72c	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 10:28:05.289573+00	
00000000-0000-0000-0000-000000000000	10e9f0d0-e662-454e-9811-b709d1fd4726	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 10:35:44.151254+00	
00000000-0000-0000-0000-000000000000	324d1205-4b43-4c99-8fb1-32cd5fd00f46	{"action":"logout","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-22 10:36:06.695923+00	
00000000-0000-0000-0000-000000000000	9c347e24-f32b-4924-88c0-dd727ca2335f	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 10:58:53.100614+00	
00000000-0000-0000-0000-000000000000	bee862f5-1531-4f34-90f9-d06665ced4f2	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 11:03:46.43164+00	
00000000-0000-0000-0000-000000000000	f64de530-b64f-4e57-b725-bd4f4754c1fb	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 13:57:25.483969+00	
00000000-0000-0000-0000-000000000000	46f4bb9a-2f25-4c44-afc5-7cf25360198a	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 14:12:17.104198+00	
00000000-0000-0000-0000-000000000000	13e0f13b-a79c-4d96-a57e-e9fa9f990e8e	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 14:19:36.511327+00	
00000000-0000-0000-0000-000000000000	cb060100-4ae3-465b-807d-75113b9d5cda	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 14:23:13.444246+00	
00000000-0000-0000-0000-000000000000	b01bb7ad-a67d-4dd6-9308-5987cd036a24	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 18:22:44.278474+00	
00000000-0000-0000-0000-000000000000	8481d868-739d-4576-a015-27844b91f0a1	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 18:49:44.464967+00	
00000000-0000-0000-0000-000000000000	a0921248-edae-47c5-9055-b8458993f194	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 18:50:57.925668+00	
00000000-0000-0000-0000-000000000000	22fc9467-8393-4ce9-b13b-481f765e7ca0	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 18:54:37.939099+00	
00000000-0000-0000-0000-000000000000	2c78d7e9-6acb-4057-bc8f-ce6c728cf293	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 18:55:51.578556+00	
00000000-0000-0000-0000-000000000000	5da0cd61-3cee-4922-8e17-431a9d383b01	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 19:31:07.475731+00	
00000000-0000-0000-0000-000000000000	c2602d7f-3545-4b07-a61e-27bde85ac43f	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 19:44:46.712572+00	
00000000-0000-0000-0000-000000000000	55b54d57-2d00-48c6-8b1e-868e5687d201	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 19:46:28.838727+00	
00000000-0000-0000-0000-000000000000	c52f182d-14a4-4292-96d4-f38960b5b6c3	{"action":"token_refreshed","actor_id":"e4b3296c-13eb-4faa-aead-e246ddb2bf66","actor_name":"Diogo Miguel da Concei├º├úo silva Carias ","actor_username":"diogo.carias@outlook.pt","actor_via_sso":false,"log_type":"token"}	2025-07-22 21:19:16.827578+00	
00000000-0000-0000-0000-000000000000	4b238e2f-2e38-4337-88ed-2bdbc570d983	{"action":"token_revoked","actor_id":"e4b3296c-13eb-4faa-aead-e246ddb2bf66","actor_name":"Diogo Miguel da Concei├º├úo silva Carias ","actor_username":"diogo.carias@outlook.pt","actor_via_sso":false,"log_type":"token"}	2025-07-22 21:19:16.830874+00	
00000000-0000-0000-0000-000000000000	3dd320c9-3915-4f0e-bfba-cbcfde73750b	{"action":"login","actor_id":"c4c9a172-92c2-410e-a671-56b443fc093d","actor_name":"S├│nia Cristina Pinto dos Santos Carias ","actor_username":"sonia.santos.scps82@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-22 21:20:07.49521+00	
00000000-0000-0000-0000-000000000000	9c659774-a49a-4792-ae80-ea43c8d22823	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-23 09:00:41.231667+00	
00000000-0000-0000-0000-000000000000	51cb57e0-c22e-4f51-aa63-8a94b97d871e	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-23 09:54:23.313036+00	
00000000-0000-0000-0000-000000000000	2656b346-1cc0-43fc-9cfb-317ec925beb9	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-23 09:55:21.392119+00	
00000000-0000-0000-0000-000000000000	2c8316f4-e238-473f-94bc-39b951e44362	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-23 09:56:44.645953+00	
00000000-0000-0000-0000-000000000000	819a5439-fa20-4d24-8b71-a7820eb16af9	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-23 09:59:09.834265+00	
00000000-0000-0000-0000-000000000000	9dda1677-c64f-44f1-bba1-7c1ca818f8df	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-23 10:01:52.14165+00	
00000000-0000-0000-0000-000000000000	9c63d5d2-9bd8-47d9-bc00-743eb1e01761	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-23 10:04:55.714832+00	
00000000-0000-0000-0000-000000000000	bbffc9f7-9a20-4794-8a1e-bc15817ef5ae	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-23 10:05:38.003393+00	
00000000-0000-0000-0000-000000000000	4a2d85e8-b157-443e-9a2a-aee18223aae2	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-23 10:13:32.441028+00	
00000000-0000-0000-0000-000000000000	f605bb01-b289-4d4d-9a39-a79e3f01ffb7	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-23 10:32:00.971626+00	
00000000-0000-0000-0000-000000000000	437b92ef-ffab-4937-86c8-08fa63011099	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-23 11:07:20.255845+00	
00000000-0000-0000-0000-000000000000	a88453c6-23ba-47f4-bb44-851742205861	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-23 11:11:04.704436+00	
00000000-0000-0000-0000-000000000000	fbafee54-0f87-4b80-bf49-b9b690f0d1d9	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-23 11:18:11.246603+00	
00000000-0000-0000-0000-000000000000	2a5bc8d2-e1b7-4159-819b-be53d220088a	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-23 11:46:45.339522+00	
00000000-0000-0000-0000-000000000000	395fe43c-a313-4bb5-bc46-f46e55ad7707	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-23 11:54:10.238949+00	
00000000-0000-0000-0000-000000000000	94b04574-89f1-430d-90a0-1b4d4dfe73ac	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-23 12:07:17.19125+00	
00000000-0000-0000-0000-000000000000	81f5aa3b-710a-4a38-8d29-de7c9e2ce885	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-23 12:07:38.466538+00	
00000000-0000-0000-0000-000000000000	122a141f-f21f-413c-b3c7-93cf6ae48494	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-23 12:09:32.202888+00	
00000000-0000-0000-0000-000000000000	fba92148-eee2-4f09-a1c3-d25a4ef71a9f	{"action":"login","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-23 23:45:17.935295+00	
00000000-0000-0000-0000-000000000000	874029bf-8eb4-48eb-9a5b-e9d69e2281fa	{"action":"logout","actor_id":"c2b84b4e-ecbf-47d1-adc0-f3d7549829b3","actor_name":"Carlos Barradas","actor_username":"carlosbarradas111@gmail.com","actor_via_sso":false,"log_type":"account"}	2025-07-23 23:46:13.691766+00	
\.


--
-- TOC entry 4307 (class 0 OID 16925)
-- Dependencies: 342
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- TOC entry 4298 (class 0 OID 16723)
-- Dependencies: 333
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	{"sub": "c2b84b4e-ecbf-47d1-adc0-f3d7549829b3", "email": "carlosbarradas111@gmail.com", "full_name": "Carlos Barradas", "email_verified": false, "phone_verified": false}	email	2025-06-29 21:59:49.36328+00	2025-06-29 21:59:49.363352+00	2025-06-29 21:59:49.363352+00	3b1673c8-32c7-49f7-9a4b-09a4e9a38c5c
25158bf6-d02c-43ca-9efd-2608a32d4a60	25158bf6-d02c-43ca-9efd-2608a32d4a60	{"sub": "25158bf6-d02c-43ca-9efd-2608a32d4a60", "role": "admin", "email": "carlosbarradas1@gmail.com", "full_name": "Carlos Barradas", "email_verified": true, "phone_verified": false}	email	2025-07-03 09:06:49.596806+00	2025-07-03 09:06:49.596861+00	2025-07-03 09:06:49.596861+00	83318a37-b388-4796-9bf4-2554faec16a9
5774d833-c4c9-4375-b393-710c408f5426	5774d833-c4c9-4375-b393-710c408f5426	{"sub": "5774d833-c4c9-4375-b393-710c408f5426", "role": "admin", "email": "carlosbarradas.cripto@gmail.com", "full_name": "Carlos Barradas ", "email_verified": true, "phone_verified": false}	email	2025-07-03 09:42:51.872803+00	2025-07-03 09:42:51.872855+00	2025-07-03 09:42:51.872855+00	98c52bde-d322-4641-a2ee-5ab9e156af52
c4c9a172-92c2-410e-a671-56b443fc093d	c4c9a172-92c2-410e-a671-56b443fc093d	{"sub": "c4c9a172-92c2-410e-a671-56b443fc093d", "role": "admin", "email": "sonia.santos.scps82@gmail.com", "full_name": "S├│nia Cristina Pinto dos Santos Carias ", "email_verified": true, "phone_verified": false}	email	2025-07-13 16:36:24.995542+00	2025-07-13 16:36:24.995606+00	2025-07-13 16:36:24.995606+00	b450d01c-4f28-4287-9d67-4b5eaf2cc14e
e4b3296c-13eb-4faa-aead-e246ddb2bf66	e4b3296c-13eb-4faa-aead-e246ddb2bf66	{"sub": "e4b3296c-13eb-4faa-aead-e246ddb2bf66", "role": "admin", "email": "diogo.carias@outlook.pt", "full_name": "Diogo Miguel da Concei├º├úo silva Carias ", "email_verified": true, "phone_verified": false}	email	2025-07-13 16:36:49.762191+00	2025-07-13 16:36:49.762241+00	2025-07-13 16:36:49.762241+00	0bb4c01b-739d-4817-ba6d-c0275ad82093
\.


--
-- TOC entry 4292 (class 0 OID 16516)
-- Dependencies: 324
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4302 (class 0 OID 16812)
-- Dependencies: 337
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
25e036f2-d6bd-4fd1-a451-5788b2ac63e0	2025-07-22 21:20:07.499283+00	2025-07-22 21:20:07.499283+00	password	dabf492d-1889-4f92-bedf-13780fd6e6c0
60853ad0-d925-4bfc-9bac-0ca6c6af3559	2025-07-13 16:36:51.503526+00	2025-07-13 16:36:51.503526+00	otp	21ea3912-b973-42bd-884b-313b696db2c8
5ba10f8f-7c9b-462a-8a94-9eab1c76b5e1	2025-07-13 16:37:57.982651+00	2025-07-13 16:37:57.982651+00	otp	7774dd40-12c0-4e0c-bdc2-7b6a308c55c3
\.


--
-- TOC entry 4301 (class 0 OID 16800)
-- Dependencies: 336
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- TOC entry 4300 (class 0 OID 16787)
-- Dependencies: 335
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid) FROM stdin;
\.


--
-- TOC entry 4308 (class 0 OID 16975)
-- Dependencies: 343
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
adf7c217-f892-4f2c-a72b-2276a8b6f50e	5774d833-c4c9-4375-b393-710c408f5426	recovery_token	ce6f420d631dec8f5344c11ad65c0034a886cf277235b3814247c55f	carlosbarradas.cripto@gmail.com	2025-07-04 22:06:46.228338	2025-07-04 22:06:46.228338
\.


--
-- TOC entry 4291 (class 0 OID 16505)
-- Dependencies: 323
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	263	6si62xlazmpy	c4c9a172-92c2-410e-a671-56b443fc093d	t	2025-07-13 16:36:51.4973+00	2025-07-15 13:57:00.774099+00	\N	60853ad0-d925-4bfc-9bac-0ca6c6af3559
00000000-0000-0000-0000-000000000000	270	ojply2vnttbg	e4b3296c-13eb-4faa-aead-e246ddb2bf66	t	2025-07-13 23:05:18.614545+00	2025-07-16 10:33:19.107772+00	sr47rxfgtqyn	5ba10f8f-7c9b-462a-8a94-9eab1c76b5e1
00000000-0000-0000-0000-000000000000	403	skdad3gymy27	e4b3296c-13eb-4faa-aead-e246ddb2bf66	t	2025-07-20 15:12:01.280307+00	2025-07-22 21:19:16.83285+00	mcw2dmzjibvr	5ba10f8f-7c9b-462a-8a94-9eab1c76b5e1
00000000-0000-0000-0000-000000000000	320	mcw2dmzjibvr	e4b3296c-13eb-4faa-aead-e246ddb2bf66	t	2025-07-16 10:33:19.110274+00	2025-07-20 15:12:01.269911+00	ojply2vnttbg	5ba10f8f-7c9b-462a-8a94-9eab1c76b5e1
00000000-0000-0000-0000-000000000000	264	5k56iknoa63i	e4b3296c-13eb-4faa-aead-e246ddb2bf66	t	2025-07-13 16:37:57.980915+00	2025-07-13 19:11:30.638716+00	\N	5ba10f8f-7c9b-462a-8a94-9eab1c76b5e1
00000000-0000-0000-0000-000000000000	268	sr47rxfgtqyn	e4b3296c-13eb-4faa-aead-e246ddb2bf66	t	2025-07-13 19:11:30.641072+00	2025-07-13 23:05:18.612193+00	5k56iknoa63i	5ba10f8f-7c9b-462a-8a94-9eab1c76b5e1
00000000-0000-0000-0000-000000000000	493	p2uwzmksdd3o	e4b3296c-13eb-4faa-aead-e246ddb2bf66	f	2025-07-22 21:19:16.837778+00	2025-07-22 21:19:16.837778+00	skdad3gymy27	5ba10f8f-7c9b-462a-8a94-9eab1c76b5e1
00000000-0000-0000-0000-000000000000	494	pfexbtlj3sbm	c4c9a172-92c2-410e-a671-56b443fc093d	f	2025-07-22 21:20:07.497999+00	2025-07-22 21:20:07.497999+00	\N	25e036f2-d6bd-4fd1-a451-5788b2ac63e0
00000000-0000-0000-0000-000000000000	305	ljktuj6kzb74	c4c9a172-92c2-410e-a671-56b443fc093d	f	2025-07-15 13:57:00.777171+00	2025-07-15 13:57:00.777171+00	6si62xlazmpy	60853ad0-d925-4bfc-9bac-0ca6c6af3559
\.


--
-- TOC entry 4305 (class 0 OID 16854)
-- Dependencies: 340
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- TOC entry 4306 (class 0 OID 16872)
-- Dependencies: 341
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- TOC entry 4294 (class 0 OID 16531)
-- Dependencies: 326
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
\.


--
-- TOC entry 4299 (class 0 OID 16753)
-- Dependencies: 334
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
5ba10f8f-7c9b-462a-8a94-9eab1c76b5e1	e4b3296c-13eb-4faa-aead-e246ddb2bf66	2025-07-13 16:37:57.979344+00	2025-07-22 21:19:16.840422+00	\N	aal1	\N	2025-07-22 21:19:16.840348	Mozilla/5.0 (Linux; U; Android 13; pt-pt; Redmi Note 11S Build/TP1A.220624.014) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/112.0.5615.136 Mobile Safari/537.36 XiaoMi/MiuiBrowser/14.10.1.3-gn	89.214.119.104	\N
60853ad0-d925-4bfc-9bac-0ca6c6af3559	c4c9a172-92c2-410e-a671-56b443fc093d	2025-07-13 16:36:51.495412+00	2025-07-15 13:57:00.780519+00	\N	aal1	\N	2025-07-15 13:57:00.780447	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/28.0 Chrome/130.0.0.0 Mobile Safari/537.36	81.193.231.43	\N
25e036f2-d6bd-4fd1-a451-5788b2ac63e0	c4c9a172-92c2-410e-a671-56b443fc093d	2025-07-22 21:20:07.496121+00	2025-07-22 21:20:07.496121+00	\N	aal1	\N	\N	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Mobile Safari/537.36	81.193.231.43	\N
\.


--
-- TOC entry 4304 (class 0 OID 16839)
-- Dependencies: 339
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4303 (class 0 OID 16830)
-- Dependencies: 338
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4289 (class 0 OID 16493)
-- Dependencies: 321
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	e4b3296c-13eb-4faa-aead-e246ddb2bf66	authenticated	authenticated	diogo.carias@outlook.pt	$2a$10$Kf..W7cGhRwL7/vqYhHXgORsEBch1Fh2SllDVfW2n71AhI0spwRUy	2025-07-13 16:37:57.975084+00	\N		2025-07-13 16:36:49.769315+00		\N			\N	2025-07-13 16:37:57.979277+00	{"provider": "email", "providers": ["email"]}	{"sub": "e4b3296c-13eb-4faa-aead-e246ddb2bf66", "role": "admin", "email": "diogo.carias@outlook.pt", "full_name": "Diogo Miguel da Concei├º├úo silva Carias ", "email_verified": true, "phone_verified": false}	\N	2025-07-13 16:36:49.759412+00	2025-07-22 21:19:16.83903+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	c4c9a172-92c2-410e-a671-56b443fc093d	authenticated	authenticated	sonia.santos.scps82@gmail.com	$2a$10$P8GvINfDIkA9Qgeig8oSAuGoRcg1KozgAPou1p3xM5HR6qc1HO4aa	2025-07-13 16:36:51.490875+00	\N		2025-07-13 16:36:25.015088+00		\N			\N	2025-07-22 21:20:07.496039+00	{"provider": "email", "providers": ["email"]}	{"sub": "c4c9a172-92c2-410e-a671-56b443fc093d", "role": "admin", "email": "sonia.santos.scps82@gmail.com", "full_name": "S├│nia Cristina Pinto dos Santos Carias ", "email_verified": true, "phone_verified": false}	\N	2025-07-13 16:36:24.973682+00	2025-07-22 21:20:07.498962+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	25158bf6-d02c-43ca-9efd-2608a32d4a60	authenticated	authenticated	carlosbarradas1@gmail.com	$2a$10$nVWGXRzwZOS3tQARpyWjYO.uzAqg024bn15rWKRlp0tAJzNqICoju	2025-07-03 09:07:35.40711+00	\N		2025-07-03 09:06:49.603866+00		2025-07-04 23:13:28.95342+00			\N	2025-07-22 08:47:51.338613+00	{"provider": "email", "providers": ["email"]}	{"sub": "25158bf6-d02c-43ca-9efd-2608a32d4a60", "role": "admin", "email": "carlosbarradas1@gmail.com", "full_name": "Carlos Barradas", "email_verified": true, "phone_verified": false}	\N	2025-07-03 09:06:49.57502+00	2025-07-22 08:47:51.360456+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	authenticated	authenticated	carlosbarradas111@gmail.com	$2a$10$FfcB7snY.nkaX3iduQNOouzSENCmgv9mEzf1Ocxfxs5vo10DEx.Dq	2025-07-02 19:29:28.924697+00	\N		2025-06-29 22:17:06.924626+00		2025-07-04 21:42:23.646716+00			\N	2025-07-23 23:45:17.958152+00	{"provider": "email", "providers": ["email"]}	{"sub": "c2b84b4e-ecbf-47d1-adc0-f3d7549829b3", "role": "admin", "email": "carlosbarradas111@gmail.com", "full_name": "Carlos Barradas", "email_verified": true, "phone_verified": false}	\N	2025-06-29 21:59:49.343539+00	2025-07-23 23:45:17.991485+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	5774d833-c4c9-4375-b393-710c408f5426	authenticated	authenticated	carlosbarradas.cripto@gmail.com	$2a$10$vmqiU00baM1n5B03O1dwo.bmyPIyi4zzyZzox8DnWbBZL65icT832	2025-07-03 09:44:43.269016+00	\N		2025-07-03 09:42:51.878562+00	ce6f420d631dec8f5344c11ad65c0034a886cf277235b3814247c55f	2025-07-04 22:06:45.776728+00			\N	2025-07-20 09:13:03.062701+00	{"provider": "email", "providers": ["email"]}	{"sub": "5774d833-c4c9-4375-b393-710c408f5426", "role": "admin", "email": "carlosbarradas.cripto@gmail.com", "full_name": "Carlos Barradas ", "email_verified": true, "phone_verified": false}	\N	2025-07-03 09:42:51.85389+00	2025-07-20 09:13:03.069372+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- TOC entry 4322 (class 0 OID 34655)
-- Dependencies: 361
-- Data for Name: active_conductors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_conductors (id, conductor_id, is_active, activated_at, deactivated_at) FROM stdin;
55	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	2025-07-20 22:56:21.679+00	2025-07-22 21:20:21.009+00
53	e4b3296c-13eb-4faa-aead-e246ddb2bf66	f	2025-07-18 09:39:43.482+00	2025-07-18 17:24:41.947+00
52	550e8400-e29b-41d4-a716-446655440003	f	2025-07-18 11:32:36.745+00	2025-07-18 17:24:41.947+00
69	c4c9a172-92c2-410e-a671-56b443fc093d	f	2025-07-18 18:34:37.67+00	2025-07-18 18:34:39.289+00
76	25158bf6-d02c-43ca-9efd-2608a32d4a60	f	2025-07-20 09:17:27.854+00	2025-07-20 09:17:45.456+00
\.


--
-- TOC entry 4319 (class 0 OID 26242)
-- Dependencies: 358
-- Data for Name: blocked_periods; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.blocked_periods (id, date, start_time, end_time, reason, created_by, created_at, "createdBy") FROM stdin;
7f4cfde5-2f72-474e-99cb-e89e9e12fa8f	2025-07-16	19:00:00	19:00:00		admin	2025-07-16 11:57:23.245616+00	\N
3894bf2d-b8fa-4ee8-be19-866e3fb00143	2025-07-18	16:00:00	16:25:00	pausa	Motorista Teste	2025-07-17 09:19:40.939446+00	\N
ef615356-7868-4e3a-b47a-a27c14f242f5	2025-07-18	\N	\N		admin	2025-07-17 14:20:52.056355+00	\N
7cb13b87-2abb-4928-94a3-0502332713f2	2025-07-23	08:00:00	08:00:00		admin	2025-07-22 21:20:57.970098+00	\N
1d9a7963-8e01-40d6-9ac8-6504a9ac195a	2025-07-23	08:30:00	08:30:00		admin	2025-07-22 21:21:00.341433+00	\N
b6e8a91d-bfdf-4eb3-b4cc-970bdbb624c5	2025-07-23	09:00:00	09:00:00		admin	2025-07-22 21:21:01.957555+00	\N
a4639f88-7581-4aad-8465-ddaf9dff3712	2025-07-23	09:30:00	09:30:00		admin	2025-07-22 21:21:08.502843+00	\N
84acbd61-c6b7-4ffe-9171-5c029512e60c	2025-07-23	10:00:00	10:00:00		admin	2025-07-22 21:21:10.025318+00	\N
8d6b046f-3e00-4f1a-8e20-ab16a2a95f51	2025-07-23	10:30:00	10:30:00		admin	2025-07-22 21:21:11.300626+00	\N
abee5926-9bc8-47bf-a792-ce53d9946d76	2025-07-23	11:00:00	11:00:00		admin	2025-07-22 21:21:13.729701+00	\N
d3c97968-a7de-4b76-9397-696f22912602	2025-07-23	11:30:00	11:30:00		admin	2025-07-22 21:21:14.845248+00	\N
b42af0aa-6de0-4565-b89d-fbd74a15877e	2025-07-23	12:00:00	12:00:00		admin	2025-07-22 21:21:16.654868+00	\N
93fb70eb-4f73-49bf-9d83-d3da635324a5	2025-07-24	\N	\N	Folga	admin	2025-07-22 21:21:54.005101+00	\N
c73d0a90-4fb6-46d2-b97d-f1bc2fcdd339	2025-07-23	13:00:00	13:00:00		admin	2025-07-23 12:24:40.812012+00	\N
e2b3a52d-1a78-4ed3-a62b-0c25119ccc4b	2025-07-23	13:00:00	13:00:00		admin	2025-07-23 12:24:42.850431+00	\N
114523a2-8951-485f-8c75-4414a38598d8	2025-07-23	13:00:00	13:00:00		admin	2025-07-23 12:24:44.44402+00	\N
53a6e12b-126a-4aec-8dac-473eb9c55418	2025-07-23	13:30:00	13:30:00		admin	2025-07-23 12:24:47.414537+00	\N
\.


--
-- TOC entry 4333 (class 0 OID 45789)
-- Dependencies: 372
-- Data for Name: conductor_applications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conductor_applications (id, full_name, email, phone, whatsapp, vehicle_info, license_number, region, zone, assigned_coordinates, created_by, admin_level, status, documents, created_at, submitted_at, reviewed_at, approved_at, registration_token, admin_notes, rejection_reason) FROM stdin;
\.


--
-- TOC entry 4320 (class 0 OID 34641)
-- Dependencies: 359
-- Data for Name: conductor_locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conductor_locations (id, latitude, longitude, updated_at, conductor_id, created_at, accuracy) FROM stdin;
\.


--
-- TOC entry 4331 (class 0 OID 45700)
-- Dependencies: 370
-- Data for Name: conductor_status_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conductor_status_audit (id, conductor_id, changed_by, previous_status, new_status, reason, region, admin_level, created_at, metadata) FROM stdin;
d87a852a-a12a-475d-953c-3024d0533a0f	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-21 14:20:57.396186+00	{"timestamp": "2025-07-21T14:20:57.396186+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
d79f7db1-a951-4e9c-ae9f-a9e72b31df87	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-21 14:21:02.736012+00	{"timestamp": "2025-07-21T14:21:02.736012+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
a031b081-da32-4f4f-a5cc-43603ddeb749	e4b3296c-13eb-4faa-aead-e246ddb2bf66	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-21 14:21:05.402593+00	{"timestamp": "2025-07-21T14:21:05.402593+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Diogo"}
843fb000-6c07-4f60-a369-66a6f5940f82	c4c9a172-92c2-410e-a671-56b443fc093d	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-21 14:21:09.048308+00	{"timestamp": "2025-07-21T14:21:09.048308+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Sonia"}
c49ed5e0-b8e8-4d65-a154-68c868b5fe21	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-21 14:21:11.778588+00	{"timestamp": "2025-07-21T14:21:11.778588+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
4c6a2a0f-2b09-454c-bd8b-7c2e0cb186d3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-21 14:22:19.148846+00	{"timestamp": "2025-07-21T14:22:19.148846+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
c9759b44-eda8-4dc8-95f5-0fa7056d7235	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-21 14:22:22.902776+00	{"timestamp": "2025-07-21T14:22:22.902776+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
1f490001-c4b7-4673-9025-e0691863930a	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-21 14:48:28.267221+00	{"timestamp": "2025-07-21T14:48:28.267221+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
f1c084a0-130f-46ab-b124-524502a05665	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-21 15:40:58.065259+00	{"timestamp": "2025-07-21T15:40:58.065259+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
e02efb5c-de97-47f3-b5a7-ee7b56f47b75	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-21 15:45:15.756828+00	{"timestamp": "2025-07-21T15:45:15.756828+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
63730838-a951-47e7-9be6-7f1eb76534d6	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-21 15:45:23.69365+00	{"timestamp": "2025-07-21T15:45:23.69365+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
a7163141-a521-4164-ae39-6daa77133a11	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-21 15:45:32.670738+00	{"timestamp": "2025-07-21T15:45:32.670738+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
2168f17e-55d5-4d69-8c39-51860e12ee06	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-21 15:45:40.824522+00	{"timestamp": "2025-07-21T15:45:40.824522+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
63b6dcac-9413-4cc9-bf70-473d914b4692	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-21 23:25:59.461812+00	{"timestamp": "2025-07-21T23:25:59.461812+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
82011b5d-3733-4aaf-91f4-07092ac8e833	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-21 23:26:06.405777+00	{"timestamp": "2025-07-21T23:26:06.405777+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
f1e29760-a57e-4076-beb4-05375be3047f	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-21 23:26:16.828104+00	{"timestamp": "2025-07-21T23:26:16.828104+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
62e3c654-b4cd-4344-b08a-e664b57db1f8	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-21 23:26:19.566948+00	{"timestamp": "2025-07-21T23:26:19.566948+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
80f3b9c4-791c-494a-a70b-424a2c550018	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-22 14:19:49.655589+00	{"timestamp": "2025-07-22T14:19:49.655589+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
9e75d4c6-9a58-4137-92b4-b99369dbd7ca	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-22 14:19:54.056269+00	{"timestamp": "2025-07-22T14:19:54.056269+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
6ced0f40-482f-412c-8129-9b29c9198f4a	c4c9a172-92c2-410e-a671-56b443fc093d	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-22 14:19:57.760292+00	{"timestamp": "2025-07-22T14:19:57.760292+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Sonia"}
91c22593-08f7-45d2-a32a-97090068c00b	c4c9a172-92c2-410e-a671-56b443fc093d	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-22 14:20:01.325358+00	{"timestamp": "2025-07-22T14:20:01.325358+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Sonia"}
68bb063b-27b4-43b8-93ed-f7018a3111bd	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-22 14:26:22.568517+00	{"timestamp": "2025-07-22T14:26:22.568517+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
14c45432-23f1-415f-9e50-2ce7c01964a1	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-22 14:26:32.327932+00	{"timestamp": "2025-07-22T14:26:32.327932+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
9e3cbe1c-6476-4dfc-ba7f-d7909b3b10b8	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-22 14:26:37.925067+00	{"timestamp": "2025-07-22T14:26:37.925067+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
da83a4c5-9c9b-49b9-a36b-3e1745b990a8	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-22 14:33:55.152649+00	{"timestamp": "2025-07-22T14:33:55.152649+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
27f0d6c7-7fa0-4803-a88f-26df317cfa08	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-22 18:22:54.950746+00	{"timestamp": "2025-07-22T18:22:54.950746+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
4fb68b9e-05a7-4a82-959c-ed5baccf8903	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-22 18:25:36.66595+00	{"timestamp": "2025-07-22T18:25:36.66595+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
4074022b-0940-4b03-bec7-3720514c28e2	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-22 18:28:36.803265+00	{"timestamp": "2025-07-22T18:28:36.803265+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
2231a0f0-f985-46ac-9aa6-2d92d3ab5ce0	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-22 18:28:56.544396+00	{"timestamp": "2025-07-22T18:28:56.544396+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
9a6ad404-8caa-4901-8bb4-19db6fe61488	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-22 18:29:07.55652+00	{"timestamp": "2025-07-22T18:29:07.55652+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
479dfa9a-71b4-4a7a-95b7-21a21bbe688b	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-22 18:29:45.19682+00	{"timestamp": "2025-07-22T18:29:45.19682+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
1c4a270e-c193-4033-b558-a24b81cc67c8	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-22 18:29:53.750995+00	{"timestamp": "2025-07-22T18:29:53.750995+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
097f7a77-975e-4998-a998-1c69400a0bb0	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-22 18:30:05.256672+00	{"timestamp": "2025-07-22T18:30:05.256672+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
86f72062-0b30-45b3-a4f5-d165b81c2240	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-22 18:30:50.897126+00	{"timestamp": "2025-07-22T18:30:50.897126+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
d5136444-fb54-4920-80f4-4eb595efbb1c	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-22 18:30:55.277987+00	{"timestamp": "2025-07-22T18:30:55.277987+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
ee395781-d949-4efa-9ecb-884821a9f941	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-22 18:31:05.007751+00	{"timestamp": "2025-07-22T18:31:05.007751+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
f81e6705-0f5e-430a-8635-9ba034825b1d	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-22 18:31:13.50763+00	{"timestamp": "2025-07-22T18:31:13.50763+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
a46dec4a-dea0-472d-aec0-fed05a0d0f7b	e4b3296c-13eb-4faa-aead-e246ddb2bf66	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-22 18:32:19.642668+00	{"timestamp": "2025-07-22T18:32:19.642668+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Diogo"}
a1e18044-e3bb-403f-997a-96af4b8b1d7c	e4b3296c-13eb-4faa-aead-e246ddb2bf66	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-22 18:32:25.055667+00	{"timestamp": "2025-07-22T18:32:25.055667+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Diogo"}
9a53eacf-bf6d-444f-b4a6-d49feb6406bf	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-22 18:32:29.054926+00	{"timestamp": "2025-07-22T18:32:29.054926+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
b3b9e163-6606-483c-aec0-84704a54611b	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-22 18:32:34.7065+00	{"timestamp": "2025-07-22T18:32:34.7065+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
2cfe818f-1a30-49db-b8de-d72ef91e8817	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-22 18:38:41.298814+00	{"timestamp": "2025-07-22T18:38:41.298814+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
6c5cf8d6-de89-4746-a524-8caf542fdc0d	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-22 18:51:18.43526+00	{"timestamp": "2025-07-22T18:51:18.43526+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
e356e22a-6011-4954-87c6-4581e96fbee2	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-22 18:52:27.375176+00	{"timestamp": "2025-07-22T18:52:27.375176+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
767b56ab-33f1-46d2-ab84-1703a16c9fe1	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-22 18:52:32.492408+00	{"timestamp": "2025-07-22T18:52:32.492408+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
13b6fa83-a3fb-4f62-ba20-1eaa9df2a033	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-22 18:52:35.70331+00	{"timestamp": "2025-07-22T18:52:35.70331+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
7f351e4c-a318-4ba7-b35f-86ae19fd05ee	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-22 18:52:37.767883+00	{"timestamp": "2025-07-22T18:52:37.767883+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
058e27c3-9441-45fc-9f5e-977072efed74	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-22 18:52:39.21648+00	{"timestamp": "2025-07-22T18:52:39.21648+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
843c1b10-b133-458a-95c0-995324eb2ac3	e4b3296c-13eb-4faa-aead-e246ddb2bf66	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-22 19:46:47.767935+00	{"timestamp": "2025-07-22T19:46:47.767935+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Diogo"}
60aa6d0f-ac5d-4f6c-8019-aa53bfe70dda	e4b3296c-13eb-4faa-aead-e246ddb2bf66	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-22 19:51:48.939475+00	{"timestamp": "2025-07-22T19:51:48.939475+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Diogo"}
75e654dd-f94e-4b6c-923c-8b27f97d36fe	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-22 19:51:54.980613+00	{"timestamp": "2025-07-22T19:51:54.980613+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
bbc295ef-d8af-44de-9126-1dce194896e0	e4b3296c-13eb-4faa-aead-e246ddb2bf66	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-22 19:52:17.916391+00	{"timestamp": "2025-07-22T19:52:17.916391+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Diogo"}
3b5e0588-c43f-40fa-a44a-08f9e73e6968	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-22 19:52:42.967155+00	{"timestamp": "2025-07-22T19:52:42.967155+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
390d3e62-fcbc-4fad-b1ce-48895099f1e3	c4c9a172-92c2-410e-a671-56b443fc093d	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	t	\N	milfontes	super_admin	2025-07-22 19:52:49.695143+00	{"timestamp": "2025-07-22T19:52:49.695143+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Sonia"}
a6562be8-d252-4ac8-87d4-95326500dfea	e4b3296c-13eb-4faa-aead-e246ddb2bf66	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-22 19:52:56.670232+00	{"timestamp": "2025-07-22T19:52:56.670232+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Diogo"}
5dde374b-bf6d-4d38-91c4-4e171f9b23c5	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-22 19:52:59.169726+00	{"timestamp": "2025-07-22T19:52:59.169726+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Motorista Teste"}
7344bc81-c1c2-4ef0-ad4a-cfe6e6091747	c4c9a172-92c2-410e-a671-56b443fc093d	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	milfontes	super_admin	2025-07-22 19:53:00.995987+00	{"timestamp": "2025-07-22T19:53:00.995987+00:00", "admin_name": "Carlos Barradas", "conductor_name": "Sonia"}
\.


--
-- TOC entry 4334 (class 0 OID 45809)
-- Dependencies: 373
-- Data for Name: conductor_vehicle_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conductor_vehicle_sessions (id, conductor_id, vehicle_id, started_at, ended_at, start_location, end_location, route_data, total_distance, total_time, rides_completed, is_active) FROM stdin;
\.


--
-- TOC entry 4324 (class 0 OID 40475)
-- Dependencies: 363
-- Data for Name: conductors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conductors (id, name, whatsapp, is_active, user_id, tuktuk_id, latitude, longitude, created_at, region, updated_at, updated_by, status, assigned_vehicle, blocked_by, blocked_at, block_reason, restricted_zone) FROM stdin;
c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	Motorista Teste	351965748022	f	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	\N	37.7303936	-8.775574	\N	milfontes	2025-07-22 19:52:59.169726+00	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	active	\N	\N	\N	\N	\N
c4c9a172-92c2-410e-a671-56b443fc093d	Sonia	351968784043	f	c4c9a172-92c2-410e-a671-56b443fc093d	\N	\N	\N	\N	milfontes	2025-07-22 19:53:00.995987+00	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	active	\N	\N	\N	\N	\N
e4b3296c-13eb-4faa-aead-e246ddb2bf66	Diogo	351963496320	f	e4b3296c-13eb-4faa-aead-e246ddb2bf66	\N	37.889	-8.785	\N	milfontes	2025-07-22 19:52:56.670232+00	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	active	\N	\N	\N	\N	\N
\.


--
-- TOC entry 4318 (class 0 OID 19569)
-- Dependencies: 357
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, email, full_name, role, created_at, updated_at, admin_level, region, permissions, created_by, zone) FROM stdin;
c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	carlosbarradas111@gmail.com	Carlos Barradas	admin	2025-07-20 09:49:50+00	2025-07-21 14:12:01.274966+00	super_admin	milfontes	{"can_create_admins": true, "can_view_audit_logs": true, "can_delete_conductors": true, "can_manage_all_conductors": true}	\N	\N
c4c9a172-92c2-410e-a671-56b443fc093d	sonia.santos.scps82@gmail.com	S├│nia Cristina Pinto dos Santos Carias 	admin	2025-07-13 16:36:24.973323+00	2025-07-13 16:36:24.973323+00	admin_local	milfontes	{}	\N	\N
e4b3296c-13eb-4faa-aead-e246ddb2bf66	diogo.carias@outlook.pt	Diogo Miguel da Concei├º├úo silva Carias 	admin	2025-07-13 16:36:49.759104+00	2025-07-13 16:36:49.759104+00	admin_local	milfontes	{}	\N	\N
\.


--
-- TOC entry 4314 (class 0 OID 19477)
-- Dependencies: 353
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reservations (id, customer_name, customer_email, customer_phone, reservation_date, reservation_time, number_of_people, tour_type, special_requests, status, total_price, created_at, updated_at, language, manual_payment, assigned_conductor_id) FROM stdin;
cf3bab98-0e29-4ed6-8fd8-92c707d5f603	Joana Pereira	joana82pereira@gmail.com	965487786	2025-07-23	11:30:00	2	panoramic	Boa noite. ├ë possivel a recolha ser nos alagoachos? Lote 53 (antigo 230B)? Seria para 2 passageiros (a minha M├úe e a minha filha de 8 anos), para irem almo├ºar ├á vila. Obrigada Joana Pereira 	completed	\N	2025-07-22 21:11:10.040516+00	2025-07-23 12:25:04.326611+00	pt	\N	\N
86941180-054b-4c3a-ad3a-d0ead9e43c99	Flavia Mouta	flaviamouta@gmail.com	915156951	2025-07-16	11:00:00	2	panoramic	\n\n\nOnde ├® o ponto de encontro?\n	completed	\N	2025-07-16 09:32:37.376971+00	2025-07-23 12:25:10.997508+00	pt	\N	c4c9a172-92c2-410e-a671-56b443fc093d
c5ba1a07-2670-4287-83ab-364ee064249d	Ana Margarida Santos 	anamrssantos72@gmail.com	965836961	2025-07-15	15:00:00	3	furnas		completed	\N	2025-07-10 16:49:33.471124+00	2025-07-23 12:25:22.913318+00	pt	\N	c4c9a172-92c2-410e-a671-56b443fc093d
\.


--
-- TOC entry 4316 (class 0 OID 19503)
-- Dependencies: 355
-- Data for Name: tour_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tour_types (id, name, description, duration_minutes, base_price, max_people, is_active, created_at) FROM stdin;
431cf2c2-e35c-477b-9062-1dca82753a22	Passeio panor├ómico pela vila	Percurso panor├ómico pelos principais pontos da vila	60	10.00	4	t	2025-06-28 07:59:21.666609+00
4a5baa16-311c-42d1-bd44-2770eee3c8a8	Vila Nova de Milfontes ÔåÆ Praia das Furnas	Travessia pela ponte com vista panor├ómica sobre o rio Mira	90	14.00	4	t	2025-06-28 07:59:21.666609+00
58be6f25-0c1a-425d-ada6-c26a294d769b	Travessia pela ponte	Atravessia da ponte com vista sobre o rio Mira	45	10.00	4	t	2025-06-28 07:59:21.666609+00
03e7a0c3-9c60-435b-b903-3e221e266377	P├┤r-do-Sol Rom├óntico	Passeio panor├ómico com garrafa de vinho e frutos secos	120	25.00	2	t	2025-06-28 07:59:21.666609+00
227eb37c-a05f-447e-b39b-fc51be0a90ed	Passeio noturno	Percurso panor├ómico pelas ruas iluminadas	90	8.00	4	t	2025-06-28 07:59:21.666609+00
e29be2fd-87df-4461-94a5-506365f63307	Rota dos Pescadores	Passeio at├® ao farol com vista para o mar	75	10.00	4	t	2025-06-28 07:59:21.666609+00
\.


--
-- TOC entry 4315 (class 0 OID 19490)
-- Dependencies: 354
-- Data for Name: tuk_tuk_availability; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tuk_tuk_availability (id, tuk_tuk_id, available_date, time_slots, max_capacity, created_at) FROM stdin;
\.


--
-- TOC entry 4332 (class 0 OID 45763)
-- Dependencies: 371
-- Data for Name: tuktuk_vehicles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tuktuk_vehicles (id, vehicle_number, vehicle_name, region, zone, managed_by, is_available, is_active, current_conductor, license_plate, vehicle_info, maintenance_status, created_at, updated_at) FROM stdin;
0d90eb5d-f202-4a04-80da-7584fa73514a	1	tuktuk-1	milfontes	centro	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	TT-01-MF	{"ano": 2020, "cor": "azul", "marca": "Piaggio", "modelo": "Ape"}	operational	2025-07-21 15:18:40.116573	2025-07-21 15:18:40.116573
21c591d8-04ca-4274-a109-2566018dbcfb	2	tuktuk-2	milfontes	centro	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	TT-02-MF	{"ano": 2021, "cor": "vermelho", "marca": "Piaggio", "modelo": "Ape"}	operational	2025-07-21 15:18:40.116573	2025-07-21 15:18:40.116573
4fa1d24b-53b1-44cc-ae2b-899bbf183dde	3	tuktuk-3	milfontes	praia	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	TT-03-MF	{"ano": 2019, "cor": "verde", "marca": "Piaggio", "modelo": "Ape"}	operational	2025-07-21 15:18:40.116573	2025-07-21 15:18:40.116573
b1e9e289-e5c3-4434-bcbc-b8ac6d6cb593	4	tuktuk-4	milfontes	praia	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	f	f	\N	TT-04-MF	{"ano": 2022, "cor": "amarelo", "marca": "Piaggio", "modelo": "Ape"}	maintenance	2025-07-21 15:18:40.116573	2025-07-21 15:18:40.116573
aedc51fc-d662-4235-b20b-b10ab4947a21	5	tuktuk-5	milfontes	porto	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	t	f	\N	TT-05-MF	{"ano": 2021, "cor": "branco", "marca": "Piaggio", "modelo": "Ape"}	operational	2025-07-21 15:18:40.116573	2025-07-21 15:18:40.116573
\.


--
-- TOC entry 4329 (class 0 OID 44334)
-- Dependencies: 368
-- Data for Name: tuktuks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tuktuks (id, nome, identificador, ativo, created_at) FROM stdin;
\.


--
-- TOC entry 4328 (class 0 OID 44300)
-- Dependencies: 367
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_roles (id, user_id, role) FROM stdin;
531fe934-88da-4979-9ba8-167bf110181f	c2b84b4e-ecbf-47d1-adc0-f3d7549829b3	condutor
\.


--
-- TOC entry 4323 (class 0 OID 39329)
-- Dependencies: 362
-- Data for Name: messages_2025_07_20; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_20 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- TOC entry 4325 (class 0 OID 43163)
-- Dependencies: 364
-- Data for Name: messages_2025_07_21; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_21 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- TOC entry 4326 (class 0 OID 43174)
-- Dependencies: 365
-- Data for Name: messages_2025_07_22; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_22 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- TOC entry 4327 (class 0 OID 43185)
-- Dependencies: 366
-- Data for Name: messages_2025_07_23; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_23 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- TOC entry 4330 (class 0 OID 44572)
-- Dependencies: 369
-- Data for Name: messages_2025_07_24; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_24 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- TOC entry 4335 (class 0 OID 45876)
-- Dependencies: 374
-- Data for Name: messages_2025_07_25; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_25 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- TOC entry 4336 (class 0 OID 46990)
-- Dependencies: 375
-- Data for Name: messages_2025_07_26; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_26 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- TOC entry 4311 (class 0 OID 17088)
-- Dependencies: 346
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-06-26 08:52:10
20211116045059	2025-06-26 08:52:12
20211116050929	2025-06-26 08:52:14
20211116051442	2025-06-26 08:52:15
20211116212300	2025-06-26 08:52:17
20211116213355	2025-06-26 08:52:19
20211116213934	2025-06-26 08:52:21
20211116214523	2025-06-26 08:52:23
20211122062447	2025-06-26 08:52:25
20211124070109	2025-06-26 08:52:27
20211202204204	2025-06-26 08:52:28
20211202204605	2025-06-26 08:52:30
20211210212804	2025-06-26 08:52:36
20211228014915	2025-06-26 08:52:37
20220107221237	2025-06-26 08:52:39
20220228202821	2025-06-26 08:52:41
20220312004840	2025-06-26 08:52:43
20220603231003	2025-06-26 08:52:45
20220603232444	2025-06-26 08:52:47
20220615214548	2025-06-26 08:52:49
20220712093339	2025-06-26 08:52:51
20220908172859	2025-06-26 08:52:53
20220916233421	2025-06-26 08:52:54
20230119133233	2025-06-26 08:52:56
20230128025114	2025-06-26 08:52:58
20230128025212	2025-06-26 08:53:00
20230227211149	2025-06-26 08:53:02
20230228184745	2025-06-26 08:53:04
20230308225145	2025-06-26 08:53:05
20230328144023	2025-06-26 08:53:07
20231018144023	2025-06-26 08:53:09
20231204144023	2025-06-26 08:53:12
20231204144024	2025-06-26 08:53:14
20231204144025	2025-06-26 08:53:15
20240108234812	2025-06-26 08:53:17
20240109165339	2025-06-26 08:53:19
20240227174441	2025-06-26 08:53:22
20240311171622	2025-06-26 08:53:24
20240321100241	2025-06-26 08:53:28
20240401105812	2025-06-26 08:53:33
20240418121054	2025-06-26 08:53:35
20240523004032	2025-06-26 08:53:42
20240618124746	2025-06-26 08:53:43
20240801235015	2025-06-26 08:53:45
20240805133720	2025-06-26 08:53:47
20240827160934	2025-06-26 08:53:48
20240919163303	2025-06-26 08:53:51
20240919163305	2025-06-26 08:53:53
20241019105805	2025-06-26 08:53:54
20241030150047	2025-06-26 08:54:01
20241108114728	2025-06-26 08:54:03
20241121104152	2025-06-26 08:54:05
20241130184212	2025-06-26 08:54:07
20241220035512	2025-06-26 08:54:09
20241220123912	2025-06-26 08:54:10
20241224161212	2025-06-26 08:54:12
20250107150512	2025-06-26 08:54:14
20250110162412	2025-06-26 08:54:16
20250123174212	2025-06-26 08:54:17
20250128220012	2025-06-26 08:54:19
20250506224012	2025-06-26 08:54:20
20250523164012	2025-06-26 08:54:22
20250714121412	2025-07-18 13:11:29
\.


--
-- TOC entry 4313 (class 0 OID 17111)
-- Dependencies: 349
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- TOC entry 4295 (class 0 OID 16544)
-- Dependencies: 327
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) FROM stdin;
\.


--
-- TOC entry 4297 (class 0 OID 16586)
-- Dependencies: 329
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-06-26 08:51:46.530372
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-06-26 08:51:46.557055
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-06-26 08:51:46.584751
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-06-26 08:51:46.605643
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-06-26 08:51:46.61559
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-06-26 08:51:46.619244
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-06-26 08:51:46.624251
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-06-26 08:51:46.629001
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-06-26 08:51:46.632764
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-06-26 08:51:46.637518
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-06-26 08:51:46.643575
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-06-26 08:51:46.648714
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-06-26 08:51:46.652962
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-06-26 08:51:46.656872
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-06-26 08:51:46.661011
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-06-26 08:51:46.678816
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-06-26 08:51:46.683012
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-06-26 08:51:46.687385
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-06-26 08:51:46.691776
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-06-26 08:51:46.697855
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-06-26 08:51:46.701763
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-06-26 08:51:46.711645
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-06-26 08:51:46.724098
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-06-26 08:51:46.733408
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-06-26 08:51:46.737791
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-06-26 08:51:46.742283
\.


--
-- TOC entry 4296 (class 0 OID 16559)
-- Dependencies: 328
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
\.


--
-- TOC entry 4309 (class 0 OID 17032)
-- Dependencies: 344
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- TOC entry 4310 (class 0 OID 17046)
-- Dependencies: 345
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- TOC entry 4317 (class 0 OID 19549)
-- Dependencies: 356
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

COPY supabase_migrations.schema_migrations (version, statements, name, created_by, idempotency_key) FROM stdin;
20250628080023	{"\n-- Create reservations table\nCREATE TABLE IF NOT EXISTS reservations (\n  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,\n  customer_name VARCHAR(255) NOT NULL,\n  customer_email VARCHAR(255) NOT NULL,\n  customer_phone VARCHAR(20) NOT NULL,\n  reservation_date DATE NOT NULL,\n  reservation_time TIME NOT NULL,\n  number_of_people INTEGER NOT NULL CHECK (number_of_people >= 1 AND number_of_people <= 6),\n  tour_type VARCHAR(100) NOT NULL,\n  special_requests TEXT,\n  status VARCHAR(50) DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'cancelled', 'completed')),\n  total_price DECIMAL(10,2),\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),\n  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n);\n\n-- Create tuk_tuk_availability table\nCREATE TABLE IF NOT EXISTS tuk_tuk_availability (\n  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,\n  tuk_tuk_id VARCHAR(50) NOT NULL,\n  available_date DATE NOT NULL,\n  time_slots JSONB NOT NULL DEFAULT '{}',\n  max_capacity INTEGER DEFAULT 4,\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),\n  UNIQUE(tuk_tuk_id, available_date)\n);\n\n-- Create tour_types table\nCREATE TABLE IF NOT EXISTS tour_types (\n  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,\n  name VARCHAR(100) NOT NULL UNIQUE,\n  description TEXT,\n  duration_minutes INTEGER NOT NULL,\n  base_price DECIMAL(10,2) NOT NULL,\n  max_people INTEGER DEFAULT 4,\n  is_active BOOLEAN DEFAULT true,\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n);\n\n-- Insert default tour types\nINSERT INTO tour_types (name, description, duration_minutes, base_price, max_people) VALUES\n('Passeio panor├ómico pela vila', 'Percurso panor├ómico pelos principais pontos da vila', 60, 10.00, 4),\n('Vila Nova de Milfontes ÔåÆ Praia das Furnas', 'Travessia pela ponte com vista panor├ómica sobre o rio Mira', 90, 14.00, 4),\n('Travessia pela ponte', 'Atravessia da ponte com vista sobre o rio Mira', 45, 10.00, 4),\n('P├┤r-do-Sol Rom├óntico', 'Passeio panor├ómico com garrafa de vinho e frutos secos', 120, 25.00, 2),\n('Passeio noturno', 'Percurso panor├ómico pelas ruas iluminadas', 90, 8.00, 4),\n('Rota dos Pescadores', 'Passeio at├® ao farol com vista para o mar', 75, 10.00, 4)\nON CONFLICT (name) DO NOTHING;\n\n-- Create function to update updated_at timestamp\nCREATE OR REPLACE FUNCTION update_updated_at_column()\nRETURNS TRIGGER AS $$\nBEGIN\n    NEW.updated_at = NOW();\n    RETURN NEW;\nEND;\n$$ language 'plpgsql';\n\n-- Create trigger for reservations table\nDROP TRIGGER IF EXISTS update_reservations_updated_at ON reservations;\nCREATE TRIGGER update_reservations_updated_at BEFORE UPDATE ON reservations\n    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();\n\n-- Enable Row Level Security\nALTER TABLE reservations ENABLE ROW LEVEL SECURITY;\nALTER TABLE tuk_tuk_availability ENABLE ROW LEVEL SECURITY;\nALTER TABLE tour_types ENABLE ROW LEVEL SECURITY;\n\n-- Drop existing policies if they exist and recreate them\nDROP POLICY IF EXISTS \\"Enable read access for all users\\" ON reservations;\nDROP POLICY IF EXISTS \\"Enable insert for all users\\" ON reservations;\nDROP POLICY IF EXISTS \\"Enable update for all users\\" ON reservations;\n\nDROP POLICY IF EXISTS \\"Enable read access for all users\\" ON tuk_tuk_availability;\nDROP POLICY IF EXISTS \\"Enable insert for all users\\" ON tuk_tuk_availability;\nDROP POLICY IF EXISTS \\"Enable update for all users\\" ON tuk_tuk_availability;\n\nDROP POLICY IF EXISTS \\"Enable read access for all users\\" ON tour_types;\n\n-- Create policies for public access\nCREATE POLICY \\"Enable read access for all users\\" ON reservations FOR SELECT USING (true);\nCREATE POLICY \\"Enable insert for all users\\" ON reservations FOR INSERT WITH CHECK (true);\nCREATE POLICY \\"Enable update for all users\\" ON reservations FOR UPDATE USING (true);\n\nCREATE POLICY \\"Enable read access for all users\\" ON tuk_tuk_availability FOR SELECT USING (true);\nCREATE POLICY \\"Enable insert for all users\\" ON tuk_tuk_availability FOR INSERT WITH CHECK (true);\nCREATE POLICY \\"Enable update for all users\\" ON tuk_tuk_availability FOR UPDATE USING (true);\n\nCREATE POLICY \\"Enable read access for all users\\" ON tour_types FOR SELECT USING (true);\n"}	000db4a7-1a1d-4dd2-8a3f-0ced675a4729	manuela.maneta@gmail.com	\N
20250628080808	{"\n-- Create a profiles table to store additional user information\nCREATE TABLE public.profiles (\n  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,\n  email TEXT,\n  full_name TEXT,\n  role TEXT DEFAULT 'user',\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),\n  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()\n);\n\n-- Enable RLS on profiles table\nALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;\n\n-- Create policies for profiles table\nCREATE POLICY \\"Users can view their own profile\\"\n  ON public.profiles\n  FOR SELECT\n  USING (auth.uid() = id);\n\nCREATE POLICY \\"Users can update their own profile\\"\n  ON public.profiles\n  FOR UPDATE\n  USING (auth.uid() = id);\n\n-- Create function to handle new user registration\nCREATE OR REPLACE FUNCTION public.handle_new_user()\nRETURNS TRIGGER AS $$\nBEGIN\n  INSERT INTO public.profiles (id, email, full_name, role)\n  VALUES (\n    NEW.id,\n    NEW.email,\n    COALESCE(NEW.raw_user_meta_data->>'full_name', ''),\n    'user'\n  );\n  RETURN NEW;\nEND;\n$$ LANGUAGE plpgsql SECURITY DEFINER;\n\n-- Create trigger to automatically create profile on user signup\nCREATE TRIGGER on_auth_user_created\n  AFTER INSERT ON auth.users\n  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();\n\n-- Create policy to allow admins to view all reservations\nCREATE POLICY \\"Admins can view all reservations\\"\n  ON public.reservations\n  FOR SELECT\n  TO authenticated\n  USING (\n    EXISTS (\n      SELECT 1 FROM public.profiles \n      WHERE profiles.id = auth.uid() \n      AND profiles.role = 'admin'\n    )\n  );\n\n-- Create policy to allow admins to update reservations\nCREATE POLICY \\"Admins can update reservations\\"\n  ON public.reservations\n  FOR UPDATE\n  TO authenticated\n  USING (\n    EXISTS (\n      SELECT 1 FROM public.profiles \n      WHERE profiles.id = auth.uid() \n      AND profiles.role = 'admin'\n    )\n  );\n\n-- Enable RLS on reservations table\nALTER TABLE public.reservations ENABLE ROW LEVEL SECURITY;\n"}	3617e5c5-60e3-4da4-8674-3b5e1c81b805	manuela.maneta@gmail.com	\N
20250720053225	{"-- Criar pol├¡ticas RLS para a tabela profiles\n\n-- Pol├¡tica: usu├írios podem ver e editar seu pr├│prio perfil\nCREATE POLICY \\"Users can view own profile\\"\n  ON profiles\n  FOR SELECT \n  USING (auth.uid() = id);\n\nCREATE POLICY \\"Users can update own profile\\"\n  ON profiles\n  FOR UPDATE \n  USING (auth.uid() = id);\n\n-- Pol├¡tica: admins podem ver todos os perfis\nCREATE POLICY \\"Admins can view all profiles\\"\n  ON profiles\n  FOR SELECT \n  USING (\n    EXISTS (\n      SELECT 1 FROM user_roles\n      WHERE user_id = auth.uid() AND role = 'admin'\n    )\n  );\n\n-- Pol├¡tica: admins podem atualizar todos os perfis\nCREATE POLICY \\"Admins can update all profiles\\"\n  ON profiles\n  FOR UPDATE \n  USING (\n    EXISTS (\n      SELECT 1 FROM user_roles\n      WHERE user_id = auth.uid() AND role = 'admin'\n    )\n  );"}	create_profiles_rls_policies	manuela.maneta@gmail.com	\N
20250720053240	{"-- Criar pol├¡ticas RLS para a tabela active_conductors\n\n-- Pol├¡tica: condutores podem ver seu pr├│prio status ativo\nCREATE POLICY \\"Conductors can view their own active status\\"\n  ON active_conductors\n  FOR SELECT \n  USING (\n    EXISTS (\n      SELECT 1 FROM conductors \n      WHERE conductors.user_id = auth.uid() \n      AND conductors.id = active_conductors.conductor_id\n    )\n  );\n\n-- Pol├¡tica: condutores podem inserir seu pr├│prio status ativo\nCREATE POLICY \\"Conductors can insert their own active status\\"\n  ON active_conductors\n  FOR INSERT \n  WITH CHECK (\n    EXISTS (\n      SELECT 1 FROM conductors \n      WHERE conductors.user_id = auth.uid() \n      AND conductors.id = active_conductors.conductor_id\n    )\n  );\n\n-- Pol├¡tica: condutores podem atualizar seu pr├│prio status ativo\nCREATE POLICY \\"Conductors can update their own active status\\"\n  ON active_conductors\n  FOR UPDATE \n  USING (\n    EXISTS (\n      SELECT 1 FROM conductors \n      WHERE conductors.user_id = auth.uid() \n      AND conductors.id = active_conductors.conductor_id\n    )\n  );\n\n-- Pol├¡tica: admins podem gerenciar todos os active_conductors\nCREATE POLICY \\"Admins can manage all active conductors\\"\n  ON active_conductors\n  FOR ALL \n  USING (\n    EXISTS (\n      SELECT 1 FROM user_roles\n      WHERE user_id = auth.uid() AND role = 'admin'\n    )\n  );\n\n-- Pol├¡tica: p├║blico pode ver condutores ativos (para o mapa)\nCREATE POLICY \\"Public can view active conductors\\"\n  ON active_conductors\n  FOR SELECT \n  USING (is_active = true);"}	create_active_conductors_rls_policies	manuela.maneta@gmail.com	\N
20250720053252	{"-- Atualizar pol├¡ticas RLS para conductor_locations usando nova rela├º├úo\n\n-- Remover pol├¡tica antiga se existir\nDROP POLICY IF EXISTS \\"Conductors can update their own location\\" ON conductor_locations;\n\n-- Criar nova pol├¡tica: condutores podem atualizar sua pr├│pria localiza├º├úo\nCREATE POLICY \\"Conductors can update their own location\\"\n  ON conductor_locations\n  FOR ALL\n  USING (\n    EXISTS (\n      SELECT 1 FROM conductors \n      WHERE conductors.user_id = auth.uid() \n      AND conductors.id = conductor_locations.conductor_id\n    )\n  );"}	update_conductor_locations_rls_policies	manuela.maneta@gmail.com	\N
20250720053330	{"-- Ativar RLS e criar pol├¡ticas para user_roles\n\n-- Ativar RLS na tabela user_roles\nALTER TABLE user_roles ENABLE ROW LEVEL SECURITY;\n\n-- Pol├¡tica: admins podem gerenciar todos os roles\nCREATE POLICY \\"Admins can manage all user roles\\"\n  ON user_roles\n  FOR ALL \n  USING (\n    EXISTS (\n      SELECT 1 FROM profiles\n      WHERE profiles.id = auth.uid() AND profiles.role = 'admin'\n    )\n  );\n\n-- Pol├¡tica: usu├írios podem ver apenas seu pr├│prio role\nCREATE POLICY \\"Users can view own role\\"\n  ON user_roles\n  FOR SELECT \n  USING (user_id = auth.uid());"}	enable_rls_user_roles	manuela.maneta@gmail.com	\N
20250720053341	{"-- Ativar RLS e criar pol├¡ticas para tuktuks\n\n-- Ativar RLS na tabela tuktuks\nALTER TABLE tuktuks ENABLE ROW LEVEL SECURITY;\n\n-- Pol├¡tica: p├║blico pode ver tuktuks ativos\nCREATE POLICY \\"Public can view active tuktuks\\"\n  ON tuktuks\n  FOR SELECT \n  USING (ativo = true);\n\n-- Pol├¡tica: admins podem gerenciar todos os tuktuks\nCREATE POLICY \\"Admins can manage all tuktuks\\"\n  ON tuktuks\n  FOR ALL \n  USING (\n    EXISTS (\n      SELECT 1 FROM user_roles\n      WHERE user_id = auth.uid() AND role = 'admin'\n    )\n  );"}	enable_rls_tuktuks	manuela.maneta@gmail.com	\N
20250720054039	{"-- Corrigir as liga├º├Áes entre profiles e conductors\n-- Como os IDs s├úo iguais, podemos fazer o match direto\n\nUPDATE conductors \nSET user_id = id \nWHERE user_id IS NULL;"}	fix_conductor_user_id_links	manuela.maneta@gmail.com	\N
20250720054944	{"-- Adicionar pol├¡tica para permitir acesso p├║blico aos condutores ativos\nCREATE POLICY \\"Public can view active conductors\\" ON conductors\nFOR SELECT\nTO public\nUSING (is_active = true);"}	add_public_conductors_policy	manuela.maneta@gmail.com	\N
20250720055355	{"-- Remover pol├¡tica problem├ítica\nDROP POLICY \\"Conductor owner or admin\\" ON conductors;\n\n-- Criar nova pol├¡tica sem refer├¬ncia a user_roles (evita recurs├úo)\nCREATE POLICY \\"Conductor owner or admin fixed\\" ON conductors\nFOR SELECT\nTO public\nUSING (\n  -- Admin check through profiles directly (no user_roles dependency)\n  (EXISTS (\n    SELECT 1 FROM profiles \n    WHERE profiles.id = auth.uid() \n      AND profiles.role = 'admin'\n  ))\n  OR \n  -- Owner check\n  (user_id = auth.uid())\n);"}	fix_conductors_policy_recursion	manuela.maneta@gmail.com	\N
20250720055447	{"-- Corrigir TODAS as pol├¡ticas que referenciam user_roles para evitar recurs├úo\n-- Usar profiles.role diretamente em vez de user_roles.role\n\n-- 1. Fix active_conductors\nDROP POLICY \\"Admins can manage all active conductors\\" ON active_conductors;\nCREATE POLICY \\"Admins can manage all active conductors fixed\\" ON active_conductors\nFOR ALL\nTO public\nUSING (\n  EXISTS (\n    SELECT 1 FROM profiles \n    WHERE profiles.id = auth.uid() \n      AND profiles.role = 'admin'\n  )\n);\n\n-- 2. Fix profiles admin policies  \nDROP POLICY \\"Admins can update all profiles\\" ON profiles;\nDROP POLICY \\"Admins can view all profiles\\" ON profiles;\n\nCREATE POLICY \\"Admins can view all profiles fixed\\" ON profiles\nFOR SELECT\nTO public\nUSING (\n  -- Owner can see own profile OR admin can see all\n  (id = auth.uid()) OR \n  (EXISTS (\n    SELECT 1 FROM profiles AS admin_check\n    WHERE admin_check.id = auth.uid() \n      AND admin_check.role = 'admin'\n  ))\n);\n\nCREATE POLICY \\"Admins can update all profiles fixed\\" ON profiles\nFOR UPDATE\nTO public\nUSING (\n  -- Owner can update own profile OR admin can update all\n  (id = auth.uid()) OR \n  (EXISTS (\n    SELECT 1 FROM profiles AS admin_check\n    WHERE admin_check.id = auth.uid() \n      AND admin_check.role = 'admin'\n  ))\n);\n\n-- 3. Fix tuktuks\nDROP POLICY \\"Admins can manage all tuktuks\\" ON tuktuks;\nCREATE POLICY \\"Admins can manage all tuktuks fixed\\" ON tuktuks\nFOR ALL\nTO public\nUSING (\n  EXISTS (\n    SELECT 1 FROM profiles \n    WHERE profiles.id = auth.uid() \n      AND profiles.role = 'admin'\n  )\n);"}	fix_all_recursive_policies	manuela.maneta@gmail.com	\N
20250720070808	{"-- Remover todas as pol├¡ticas problem├íticas\nDROP POLICY IF EXISTS \\"Admins can view all profiles fixed\\" ON profiles;\nDROP POLICY IF EXISTS \\"Admins can update all profiles fixed\\" ON profiles;\nDROP POLICY IF EXISTS \\"Users can view own profile\\" ON profiles;\nDROP POLICY IF EXISTS \\"Users can update own profile\\" ON profiles;\n\n-- Criar pol├¡tica simples baseada no JWT (sem recurs├úo)\nCREATE POLICY \\"Profile access by owner or jwt admin\\" ON profiles\nFOR ALL\nTO public\nUSING (\n  -- Owner can access own profile\n  auth.uid() = id \n  OR \n  -- Admin role from JWT token (no table lookup needed)\n  (auth.jwt() ->> 'role' = 'admin')\n  OR\n  -- Admin role from user_metadata (no table lookup needed)  \n  (auth.jwt() -> 'user_metadata' ->> 'role' = 'admin')\n);"}	fix_profiles_policies_clean	manuela.maneta@gmail.com	\N
20250721021201	{"-- Implementar Sistema de Permiss├Áes Granulares para Admins\n-- Data: 21/07/2025\n-- Objetivo: Controlar melhor as permiss├Áes de admin sobre condutores\n\n-- 1. Criar enum para n├¡veis de admin\nCREATE TYPE admin_level AS ENUM ('super_admin', 'admin_regional', 'admin_local');\n\n-- 2. Adicionar colunas ├á tabela profiles para controle granular\nALTER TABLE public.profiles \nADD COLUMN IF NOT EXISTS admin_level admin_level DEFAULT 'admin_local',\nADD COLUMN IF NOT EXISTS region VARCHAR(100),\nADD COLUMN IF NOT EXISTS permissions JSONB DEFAULT '{}',\nADD COLUMN IF NOT EXISTS created_by UUID REFERENCES auth.users(id),\nADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW();\n\n-- 3. Criar tabela de auditoria para mudan├ºas de status de condutores\nCREATE TABLE IF NOT EXISTS public.conductor_status_audit (\n  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,\n  conductor_id UUID NOT NULL REFERENCES public.conductors(id),\n  changed_by UUID NOT NULL REFERENCES auth.users(id),\n  previous_status BOOLEAN,\n  new_status BOOLEAN NOT NULL,\n  reason TEXT,\n  region VARCHAR(100),\n  admin_level admin_level,\n  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),\n  metadata JSONB DEFAULT '{}'\n);\n\n-- 4. Adicionar regi├úo aos condutores\nALTER TABLE public.conductors \nADD COLUMN IF NOT EXISTS region VARCHAR(100) DEFAULT 'milfontes',\nADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),\nADD COLUMN IF NOT EXISTS updated_by UUID REFERENCES auth.users(id);\n\n-- 5. Fun├º├úo para verificar permiss├Áes de admin\nCREATE OR REPLACE FUNCTION check_admin_permissions(\n  target_conductor_id UUID,\n  admin_user_id UUID\n) RETURNS BOOLEAN AS $$\nDECLARE\n  admin_profile public.profiles;\n  conductor_region VARCHAR(100);\nBEGIN\n  -- Buscar perfil do admin\n  SELECT * INTO admin_profile \n  FROM public.profiles \n  WHERE id = admin_user_id AND role = 'admin';\n  \n  IF admin_profile IS NULL THEN\n    RETURN FALSE;\n  END IF;\n  \n  -- Super admins podem tudo\n  IF admin_profile.admin_level = 'super_admin' THEN\n    RETURN TRUE;\n  END IF;\n  \n  -- Buscar regi├úo do condutor\n  SELECT region INTO conductor_region \n  FROM public.conductors \n  WHERE id = target_conductor_id;\n  \n  -- Admin regional pode gerenciar condutores da sua regi├úo\n  IF admin_profile.admin_level = 'admin_regional' THEN\n    RETURN admin_profile.region = conductor_region;\n  END IF;\n  \n  -- Admin local s├│ pode gerenciar condutores da mesma regi├úo\n  IF admin_profile.admin_level = 'admin_local' THEN\n    RETURN admin_profile.region = conductor_region;\n  END IF;\n  \n  RETURN FALSE;\nEND;\n$$ LANGUAGE plpgsql SECURITY DEFINER;\n\n-- 6. Fun├º├úo para registrar mudan├ºas de status\nCREATE OR REPLACE FUNCTION log_conductor_status_change() RETURNS TRIGGER AS $$\nDECLARE\n  admin_profile public.profiles;\nBEGIN\n  -- Buscar perfil do admin que fez a mudan├ºa\n  SELECT * INTO admin_profile \n  FROM public.profiles \n  WHERE id = auth.uid();\n  \n  -- Registrar a mudan├ºa se o status mudou\n  IF OLD.is_active IS DISTINCT FROM NEW.is_active THEN\n    INSERT INTO public.conductor_status_audit (\n      conductor_id,\n      changed_by,\n      previous_status,\n      new_status,\n      region,\n      admin_level,\n      metadata\n    ) VALUES (\n      NEW.id,\n      auth.uid(),\n      OLD.is_active,\n      NEW.is_active,\n      COALESCE(admin_profile.region, 'unknown'),\n      COALESCE(admin_profile.admin_level, 'admin_local'),\n      jsonb_build_object(\n        'timestamp', NOW(),\n        'admin_name', admin_profile.full_name,\n        'conductor_name', NEW.name\n      )\n    );\n  END IF;\n  \n  -- Atualizar updated_at e updated_by\n  NEW.updated_at = NOW();\n  NEW.updated_by = auth.uid();\n  \n  RETURN NEW;\nEND;\n$$ LANGUAGE plpgsql SECURITY DEFINER;\n\n-- 7. Criar trigger para auditoria\nDROP TRIGGER IF EXISTS conductor_status_audit_trigger ON public.conductors;\nCREATE TRIGGER conductor_status_audit_trigger\n  BEFORE UPDATE ON public.conductors\n  FOR EACH ROW\n  EXECUTE FUNCTION log_conductor_status_change();\n\n-- 8. Atualizar pol├¡tica RLS para conductors com controle granular\nDROP POLICY IF EXISTS \\"Admins can update conductors\\" ON public.conductors;\nCREATE POLICY \\"Admins can update conductors with permission check\\"\n  ON public.conductors\n  FOR UPDATE\n  TO authenticated\n  USING (\n    EXISTS (\n      SELECT 1 FROM public.profiles \n      WHERE profiles.id = auth.uid() \n      AND profiles.role = 'admin'\n      AND check_admin_permissions(conductors.id, auth.uid())\n    )\n  );\n\n-- 9. Pol├¡tica para visualizar condutores baseada em regi├úo\nDROP POLICY IF EXISTS \\"Admins can view all conductors\\" ON public.conductors;\nCREATE POLICY \\"Admins can view conductors by region\\"\n  ON public.conductors\n  FOR SELECT\n  TO authenticated\n  USING (\n    EXISTS (\n      SELECT 1 FROM public.profiles \n      WHERE profiles.id = auth.uid() \n      AND profiles.role = 'admin'\n      AND (\n        profiles.admin_level = 'super_admin' OR\n        profiles.region = conductors.region OR\n        profiles.region IS NULL\n      )\n    )\n  );\n\n-- 10. Pol├¡tica para auditoria - apenas super admins podem ver tudo\nCREATE POLICY \\"Admins can view audit logs\\"\n  ON public.conductor_status_audit\n  FOR SELECT\n  TO authenticated\n  USING (\n    EXISTS (\n      SELECT 1 FROM public.profiles \n      WHERE profiles.id = auth.uid() \n      AND profiles.role = 'admin'\n      AND (\n        profiles.admin_level = 'super_admin' OR\n        profiles.id = conductor_status_audit.changed_by\n      )\n    )\n  );\n\n-- 11. Habilitar RLS na tabela de auditoria\nALTER TABLE public.conductor_status_audit ENABLE ROW LEVEL SECURITY;\n\n-- 12. Inserir dados iniciais - definir voc├¬ como super admin\nUPDATE public.profiles \nSET \n  admin_level = 'super_admin',\n  region = 'milfontes',\n  permissions = jsonb_build_object(\n    'can_manage_all_conductors', true,\n    'can_view_audit_logs', true,\n    'can_create_admins', true,\n    'can_delete_conductors', true\n  ),\n  updated_at = NOW()\nWHERE email = 'carlosbarradas111@gmail.com' AND role = 'admin';\n\n-- 13. Atualizar condutores existentes com regi├úo padr├úo\nUPDATE public.conductors \nSET \n  region = 'milfontes',\n  updated_at = NOW()\nWHERE region IS NULL;\n\n-- 14. Coment├írios e documenta├º├úo\nCOMMENT ON TYPE admin_level IS 'N├¡veis de administrador: super_admin (acesso total), admin_regional (regi├úo espec├¡fica), admin_local (├írea local)';\nCOMMENT ON FUNCTION check_admin_permissions IS 'Verifica se um admin tem permiss├úo para modificar um condutor espec├¡fico';\nCOMMENT ON TABLE conductor_status_audit IS 'Log de auditoria para mudan├ºas de status de condutores';\nCOMMENT ON COLUMN profiles.admin_level IS 'N├¡vel de permiss├úo do administrador';\nCOMMENT ON COLUMN profiles.region IS 'Regi├úo de responsabilidade do administrador';\nCOMMENT ON COLUMN profiles.permissions IS 'Permiss├Áes espec├¡ficas em formato JSON';"}	implement_granular_admin_permissions	manuela.maneta@gmail.com	\N
20250721031633	{"-- Criar enums necess├írios\nCREATE TYPE application_status AS ENUM (\n  'link_created',  -- Admin criou link, aguarda candidato\n  'submitted',     -- Candidato submeteu, aguarda revis├úo\n  'approved',      -- Aprovado pelo admin\n  'rejected',      -- Rejeitado pelo admin\n  'expired'        -- Link expirou sem submiss├úo\n);\n\nCREATE TYPE conductor_status AS ENUM (\n  'active',     -- Ativo e pode trabalhar\n  'blocked',    -- Bloqueado temporariamente\n  'expelled',   -- Expulso permanentemente\n  'inactive'    -- Inativo por escolha pr├│pria\n);\n\nCREATE TYPE vehicle_status AS ENUM (\n  'operational',   -- Operacional\n  'maintenance',   -- Em manuten├º├úo\n  'out_of_service' -- Fora de servi├ºo\n);\n\n-- Tabela de ve├¡culos TukTuk\nCREATE TABLE tuktuk_vehicles (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  \n  -- Identifica├º├úo do ve├¡culo\n  vehicle_number INTEGER NOT NULL, -- 1, 2, 3, 4, 5\n  vehicle_name VARCHAR(50) NOT NULL, -- \\"tuktuk-1\\", \\"tuktuk-2\\", etc\n  \n  -- Localiza├º├úo e gest├úo\n  region VARCHAR(100) NOT NULL,\n  zone VARCHAR(100),\n  managed_by UUID REFERENCES auth.users(id), -- Admin respons├ível\n  \n  -- Status do ve├¡culo\n  is_available BOOLEAN DEFAULT true,\n  is_active BOOLEAN DEFAULT false, -- Est├í sendo usado no momento\n  current_conductor UUID REFERENCES conductors(id),\n  \n  -- Dados t├®cnicos\n  license_plate VARCHAR(20),\n  vehicle_info JSONB DEFAULT '{}'::jsonb, -- marca, modelo, ano, cor, etc\n  maintenance_status vehicle_status DEFAULT 'operational',\n  \n  -- Timestamps\n  created_at TIMESTAMP DEFAULT now(),\n  updated_at TIMESTAMP DEFAULT now(),\n  \n  -- Constraint para garantir numera├º├úo ├║nica por regi├úo\n  CONSTRAINT unique_vehicle_number_per_region UNIQUE (region, vehicle_number)\n);\n\n-- Tabela de candidaturas de condutores\nCREATE TABLE conductor_applications (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  \n  -- Dados do candidato (preenchidos pelo condutor)\n  full_name VARCHAR(255) NOT NULL,\n  email VARCHAR(255) NOT NULL,\n  phone VARCHAR(20) NOT NULL,\n  whatsapp VARCHAR(20),\n  \n  -- Dados do ve├¡culo\n  vehicle_info JSONB DEFAULT '{}'::jsonb, -- marca, modelo, ano, matr├¡cula\n  license_number VARCHAR(50),\n  \n  -- Localiza├º├úo (definida pelo admin)\n  region VARCHAR(100) NOT NULL,\n  zone VARCHAR(100),\n  assigned_coordinates JSONB,\n  \n  -- Quem criou o link\n  created_by UUID REFERENCES auth.users(id),\n  admin_level admin_level NOT NULL,\n  \n  -- Status da candidatura\n  status application_status DEFAULT 'link_created',\n  \n  -- Documentos (URLs do Supabase Storage)\n  documents JSONB DEFAULT '{}'::jsonb,\n  \n  -- Timestamps\n  created_at TIMESTAMP DEFAULT now(),\n  submitted_at TIMESTAMP,\n  reviewed_at TIMESTAMP,\n  approved_at TIMESTAMP,\n  \n  -- Token ├║nico para o link\n  registration_token UUID UNIQUE DEFAULT gen_random_uuid(),\n  \n  -- Notas do admin\n  admin_notes TEXT,\n  rejection_reason TEXT\n);\n\n-- Tabela de sess├Áes de trabalho dos condutores\nCREATE TABLE conductor_vehicle_sessions (\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\n  \n  conductor_id UUID REFERENCES conductors(id),\n  vehicle_id UUID REFERENCES tuktuk_vehicles(id),\n  \n  -- Sess├úo de trabalho\n  started_at TIMESTAMP DEFAULT now(),\n  ended_at TIMESTAMP,\n  \n  -- Localiza├º├úo durante a sess├úo\n  start_location JSONB,\n  end_location JSONB,\n  route_data JSONB, -- Array de coordenadas da rota\n  \n  -- M├®tricas da sess├úo\n  total_distance DECIMAL(10,2),\n  total_time INTERVAL,\n  rides_completed INTEGER DEFAULT 0,\n  \n  -- Status\n  is_active BOOLEAN DEFAULT true\n);\n\n-- Adicionar colunas ├á tabela conductors existente\nALTER TABLE conductors \nADD COLUMN IF NOT EXISTS status conductor_status DEFAULT 'active',\nADD COLUMN IF NOT EXISTS assigned_vehicle UUID REFERENCES tuktuk_vehicles(id),\nADD COLUMN IF NOT EXISTS blocked_by UUID REFERENCES auth.users(id),\nADD COLUMN IF NOT EXISTS blocked_at TIMESTAMP,\nADD COLUMN IF NOT EXISTS block_reason TEXT,\nADD COLUMN IF NOT EXISTS restricted_zone JSONB;\n\n-- ├ìndices para performance\nCREATE INDEX idx_tuktuk_vehicles_region ON tuktuk_vehicles(region);\nCREATE INDEX idx_tuktuk_vehicles_status ON tuktuk_vehicles(maintenance_status);\nCREATE INDEX idx_conductor_applications_status ON conductor_applications(status);\nCREATE INDEX idx_conductor_applications_token ON conductor_applications(registration_token);\nCREATE INDEX idx_conductor_sessions_active ON conductor_vehicle_sessions(is_active) WHERE is_active = true;\nCREATE INDEX idx_conductors_status ON conductors(status);\n\n-- Trigger para atualizar updated_at\nCREATE OR REPLACE FUNCTION update_updated_at_column()\nRETURNS TRIGGER AS $$\nBEGIN\n    NEW.updated_at = CURRENT_TIMESTAMP;\n    RETURN NEW;\nEND;\n$$ language 'plpgsql';\n\nCREATE TRIGGER update_tuktuk_vehicles_updated_at BEFORE UPDATE ON tuktuk_vehicles FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();"}	create_conductor_management_system	manuela.maneta@gmail.com	\N
20250721031740	{"-- Criar fun├º├úo get_admin_level que estava em falta\nCREATE OR REPLACE FUNCTION get_admin_level(user_id UUID)\nRETURNS admin_level AS $$\nBEGIN\n  RETURN (\n    SELECT admin_level \n    FROM profiles \n    WHERE id = user_id AND role = 'admin'\n  );\nEND;\n$$ LANGUAGE plpgsql SECURITY DEFINER;\n\n-- Fun├º├úo para obter regi├úo do admin\nCREATE OR REPLACE FUNCTION get_admin_region(user_id UUID)\nRETURNS VARCHAR(100) AS $$\nBEGIN\n  RETURN (\n    SELECT region \n    FROM profiles \n    WHERE id = user_id AND role = 'admin'\n  );\nEND;\n$$ LANGUAGE plpgsql SECURITY DEFINER;\n\n-- Fun├º├úo para obter zona do admin (adicionar coluna zone se n├úo existir)\n-- Primeiro verificar se a coluna zone existe na tabela profiles\nDO $$\nBEGIN\n    IF NOT EXISTS (\n        SELECT 1 FROM information_schema.columns \n        WHERE table_name = 'profiles' AND column_name = 'zone'\n    ) THEN\n        ALTER TABLE profiles ADD COLUMN zone VARCHAR(100);\n    END IF;\nEND $$;\n\nCREATE OR REPLACE FUNCTION get_admin_zone(user_id UUID)\nRETURNS VARCHAR(100) AS $$\nBEGIN\n  RETURN (\n    SELECT zone \n    FROM profiles \n    WHERE id = user_id AND role = 'admin'\n  );\nEND;\n$$ LANGUAGE plpgsql SECURITY DEFINER;"}	create_missing_admin_functions	manuela.maneta@gmail.com	\N
20250721031805	{"-- Fun├º├úo para bloquear condutor\nCREATE OR REPLACE FUNCTION block_conductor(\n  conductor_id UUID,\n  block_reason TEXT,\n  blocked_by UUID,\n  duration TEXT DEFAULT NULL\n)\nRETURNS BOOLEAN AS $$\nBEGIN\n  UPDATE conductors \n  SET \n    status = 'blocked',\n    blocked_by = $3,\n    blocked_at = NOW(),\n    block_reason = $2\n  WHERE id = $1;\n  \n  -- Log da a├º├úo na auditoria (se tabela existir)\n  IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'conductor_status_audit') THEN\n    INSERT INTO conductor_status_audit (\n      conductor_id,\n      old_status,\n      new_status,\n      changed_by,\n      reason\n    ) VALUES (\n      $1,\n      'active',\n      'blocked',\n      $3,\n      $2\n    );\n  END IF;\n  \n  RETURN TRUE;\nEND;\n$$ LANGUAGE plpgsql SECURITY DEFINER;\n\n-- Fun├º├úo para expulsar condutor\nCREATE OR REPLACE FUNCTION expel_conductor(\n  conductor_id UUID,\n  expulsion_reason TEXT,\n  expelled_by UUID\n)\nRETURNS BOOLEAN AS $$\nBEGIN\n  UPDATE conductors \n  SET \n    status = 'expelled',\n    blocked_by = $3,\n    blocked_at = NOW(),\n    block_reason = $2,\n    is_active = false\n  WHERE id = $1;\n  \n  -- Remover ve├¡culo atribu├¡do\n  UPDATE conductors \n  SET assigned_vehicle = NULL \n  WHERE id = $1;\n  \n  -- Log da a├º├úo na auditoria (se tabela existir)\n  IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'conductor_status_audit') THEN\n    INSERT INTO conductor_status_audit (\n      conductor_id,\n      old_status,\n      new_status,\n      changed_by,\n      reason\n    ) VALUES (\n      $1,\n      'active',\n      'expelled',\n      $3,\n      $2\n    );\n  END IF;\n  \n  RETURN TRUE;\nEND;\n$$ LANGUAGE plpgsql SECURITY DEFINER;\n\n-- Fun├º├úo para desbloquear condutor\nCREATE OR REPLACE FUNCTION unblock_conductor(\n  conductor_id UUID,\n  unblocked_by UUID\n)\nRETURNS BOOLEAN AS $$\nBEGIN\n  UPDATE conductors \n  SET \n    status = 'active',\n    blocked_by = NULL,\n    blocked_at = NULL,\n    block_reason = NULL\n  WHERE id = $1;\n  \n  -- Log da a├º├úo na auditoria (se tabela existir)\n  IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'conductor_status_audit') THEN\n    INSERT INTO conductor_status_audit (\n      conductor_id,\n      old_status,\n      new_status,\n      changed_by,\n      reason\n    ) VALUES (\n      $1,\n      'blocked',\n      'active',\n      $2,\n      'Desbloqueado pelo admin'\n    );\n  END IF;\n  \n  RETURN TRUE;\nEND;\n$$ LANGUAGE plpgsql SECURITY DEFINER;\n\n-- Fun├º├úo para atribuir ve├¡culo\nCREATE OR REPLACE FUNCTION assign_vehicle(\n  conductor_id UUID,\n  vehicle_id UUID,\n  assigned_by UUID\n)\nRETURNS BOOLEAN AS $$\nBEGIN\n  -- Verificar se ve├¡culo est├í dispon├¡vel\n  IF NOT EXISTS (\n    SELECT 1 FROM tuktuk_vehicles \n    WHERE id = $2 AND is_available = true AND current_conductor IS NULL\n  ) THEN\n    RAISE EXCEPTION 'Ve├¡culo n├úo est├í dispon├¡vel';\n  END IF;\n  \n  -- Remover condutor do ve├¡culo anterior\n  UPDATE tuktuk_vehicles \n  SET current_conductor = NULL \n  WHERE current_conductor = $1;\n  \n  -- Atribuir novo ve├¡culo\n  UPDATE conductors \n  SET assigned_vehicle = $2 \n  WHERE id = $1;\n  \n  UPDATE tuktuk_vehicles \n  SET current_conductor = $1 \n  WHERE id = $2;\n  \n  RETURN TRUE;\nEND;\n$$ LANGUAGE plpgsql SECURITY DEFINER;\n\n-- Fun├º├úo para auto-criar condutor de candidatura aprovada\nCREATE OR REPLACE FUNCTION create_conductor_from_approved_application()\nRETURNS TRIGGER AS $$\nBEGIN\n  IF NEW.status = 'approved' AND OLD.status != 'approved' THEN\n    INSERT INTO conductors (\n      user_id,\n      name, \n      email, \n      whatsapp, \n      region,\n      vehicle_info, \n      license_number,\n      is_active,\n      status,\n      restricted_zone,\n      created_by\n    ) VALUES (\n      -- Criar um novo usu├írio auth para o condutor seria ideal,\n      -- mas por simplicidade vamos usar NULL e permitir signup posterior\n      NULL,\n      NEW.full_name, \n      NEW.email, \n      NEW.whatsapp, \n      NEW.region,\n      NEW.vehicle_info, \n      NEW.license_number,\n      true,\n      'active',\n      NEW.assigned_coordinates,\n      NEW.created_by\n    );\n    \n    -- Marcar candidatura como processada\n    NEW.approved_at = NOW();\n  END IF;\n  RETURN NEW;\nEND;\n$$ LANGUAGE plpgsql;\n\n-- Criar trigger se n├úo existir\nDROP TRIGGER IF EXISTS create_conductor_from_application ON conductor_applications;\nCREATE TRIGGER create_conductor_from_application\n  BEFORE UPDATE ON conductor_applications\n  FOR EACH ROW EXECUTE FUNCTION create_conductor_from_approved_application();"}	create_conductor_management_policies_v2	manuela.maneta@gmail.com	\N
20250721031822	{"-- RLS Policies para tuktuk_vehicles\nALTER TABLE tuktuk_vehicles ENABLE ROW LEVEL SECURITY;\n\n-- Admins podem ver ve├¡culos da sua regi├úo\nCREATE POLICY \\"admins_view_vehicles_in_region\\"\nON tuktuk_vehicles FOR SELECT\nTO authenticated\nUSING (\n  EXISTS (\n    SELECT 1 FROM profiles \n    WHERE id = auth.uid() \n    AND role = 'admin'\n    AND (\n      admin_level = 'super_admin' OR \n      region = tuktuk_vehicles.region\n    )\n  )\n);\n\n-- Condutores podem ver seu ve├¡culo atribu├¡do\nCREATE POLICY \\"conductors_view_assigned_vehicle\\"\nON tuktuk_vehicles FOR SELECT\nTO authenticated\nUSING (\n  current_conductor IN (\n    SELECT id FROM conductors WHERE user_id = auth.uid()\n  )\n);\n\n-- Admins podem gerenciar ve├¡culos na sua regi├úo\nCREATE POLICY \\"admins_manage_vehicles_in_region\\"\nON tuktuk_vehicles FOR ALL\nTO authenticated\nUSING (\n  EXISTS (\n    SELECT 1 FROM profiles \n    WHERE id = auth.uid() \n    AND role = 'admin'\n    AND (\n      admin_level = 'super_admin' OR \n      region = tuktuk_vehicles.region\n    )\n  )\n);\n\n-- RLS Policies para conductor_applications\nALTER TABLE conductor_applications ENABLE ROW LEVEL SECURITY;\n\n-- Admins podem ver candidaturas da sua regi├úo\nCREATE POLICY \\"admins_view_applications_in_region\\"\nON conductor_applications FOR SELECT\nTO authenticated\nUSING (\n  EXISTS (\n    SELECT 1 FROM profiles \n    WHERE id = auth.uid() \n    AND role = 'admin'\n    AND (\n      admin_level = 'super_admin' OR \n      region = conductor_applications.region\n    )\n  )\n);\n\n-- Admins podem criar candidaturas na sua regi├úo\nCREATE POLICY \\"admins_create_applications_in_region\\"\nON conductor_applications FOR INSERT\nTO authenticated\nWITH CHECK (\n  created_by = auth.uid() AND\n  EXISTS (\n    SELECT 1 FROM profiles \n    WHERE id = auth.uid() \n    AND role = 'admin'\n    AND (\n      admin_level = 'super_admin' OR \n      region = conductor_applications.region\n    )\n  )\n);\n\n-- P├║blico pode ver candidatura por token (acesso an├┤nimo)\nCREATE POLICY \\"public_view_application_by_token\\"\nON conductor_applications FOR SELECT\nTO anon\nUSING (true); -- Token-based access ser├í controlado na aplica├º├úo\n\n-- P├║blico pode submeter candidatura (atualizar status)\nCREATE POLICY \\"public_submit_application\\"\nON conductor_applications FOR UPDATE\nTO anon\nUSING (status = 'link_created')\nWITH CHECK (status IN ('submitted', 'link_created'));\n\n-- Admins podem atualizar candidaturas\nCREATE POLICY \\"admins_update_applications\\"\nON conductor_applications FOR UPDATE\nTO authenticated\nUSING (\n  EXISTS (\n    SELECT 1 FROM profiles \n    WHERE id = auth.uid() \n    AND role = 'admin'\n    AND (\n      admin_level = 'super_admin' OR \n      region = conductor_applications.region\n    )\n  )\n);\n\n-- RLS Policies para conductor_vehicle_sessions\nALTER TABLE conductor_vehicle_sessions ENABLE ROW LEVEL SECURITY;\n\n-- Condutores podem gerenciar suas pr├│prias sess├Áes\nCREATE POLICY \\"conductors_manage_own_sessions\\"\nON conductor_vehicle_sessions FOR ALL\nTO authenticated\nUSING (\n  conductor_id IN (\n    SELECT id FROM conductors WHERE user_id = auth.uid()\n  )\n);\n\n-- Admins podem ver sess├Áes na sua regi├úo\nCREATE POLICY \\"admins_view_sessions_in_region\\"\nON conductor_vehicle_sessions FOR SELECT\nTO authenticated\nUSING (\n  EXISTS (\n    SELECT 1 FROM profiles p\n    JOIN conductors c ON c.region = p.region\n    WHERE p.id = auth.uid() \n    AND p.role = 'admin'\n    AND c.id = conductor_vehicle_sessions.conductor_id\n    AND (\n      p.admin_level = 'super_admin' OR \n      p.region = c.region\n    )\n  )\n);"}	create_rls_policies_conductor_system	manuela.maneta@gmail.com	\N
20250721031840	{"-- Inserir ve├¡culos TukTuk iniciais para a regi├úo de Milfontes\nINSERT INTO tuktuk_vehicles (\n  vehicle_number,\n  vehicle_name,\n  region,\n  zone,\n  managed_by,\n  license_plate,\n  vehicle_info,\n  maintenance_status,\n  is_available\n) VALUES \n  (1, 'tuktuk-1', 'milfontes', 'centro', \n   (SELECT id FROM profiles WHERE email = 'carlosbarradas111@gmail.com'), \n   'TT-01-MF', \n   '{\\"marca\\": \\"Piaggio\\", \\"modelo\\": \\"Ape\\", \\"ano\\": 2020, \\"cor\\": \\"azul\\"}'::jsonb,\n   'operational', true),\n   \n  (2, 'tuktuk-2', 'milfontes', 'centro', \n   (SELECT id FROM profiles WHERE email = 'carlosbarradas111@gmail.com'), \n   'TT-02-MF', \n   '{\\"marca\\": \\"Piaggio\\", \\"modelo\\": \\"Ape\\", \\"ano\\": 2021, \\"cor\\": \\"vermelho\\"}'::jsonb,\n   'operational', true),\n   \n  (3, 'tuktuk-3', 'milfontes', 'praia', \n   (SELECT id FROM profiles WHERE email = 'carlosbarradas111@gmail.com'), \n   'TT-03-MF', \n   '{\\"marca\\": \\"Piaggio\\", \\"modelo\\": \\"Ape\\", \\"ano\\": 2019, \\"cor\\": \\"verde\\"}'::jsonb,\n   'operational', true),\n   \n  (4, 'tuktuk-4', 'milfontes', 'praia', \n   (SELECT id FROM profiles WHERE email = 'carlosbarradas111@gmail.com'), \n   'TT-04-MF', \n   '{\\"marca\\": \\"Piaggio\\", \\"modelo\\": \\"Ape\\", \\"ano\\": 2022, \\"cor\\": \\"amarelo\\"}'::jsonb,\n   'maintenance', false),\n   \n  (5, 'tuktuk-5', 'milfontes', 'porto', \n   (SELECT id FROM profiles WHERE email = 'carlosbarradas111@gmail.com'), \n   'TT-05-MF', \n   '{\\"marca\\": \\"Piaggio\\", \\"modelo\\": \\"Ape\\", \\"ano\\": 2021, \\"cor\\": \\"branco\\"}'::jsonb,\n   'operational', true);\n\n-- Verificar se a inser├º├úo foi bem-sucedida\nSELECT \n  vehicle_name,\n  region,\n  zone,\n  license_plate,\n  maintenance_status,\n  is_available\nFROM tuktuk_vehicles \nORDER BY vehicle_number;"}	populate_initial_tuktuk_vehicles	manuela.maneta@gmail.com	\N
\.


--
-- TOC entry 4337 (class 0 OID 48104)
-- Dependencies: 376
-- Data for Name: seed_files; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

COPY supabase_migrations.seed_files (path, hash) FROM stdin;
\.


--
-- TOC entry 3694 (class 0 OID 16656)
-- Dependencies: 330
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4532 (class 0 OID 0)
-- Dependencies: 322
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 513, true);


--
-- TOC entry 4533 (class 0 OID 0)
-- Dependencies: 360
-- Name: active_conductors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_conductors_id_seq', 96, true);


--
-- TOC entry 4534 (class 0 OID 0)
-- Dependencies: 348
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 638, true);


--
-- TOC entry 3899 (class 2606 OID 16825)
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- TOC entry 3857 (class 2606 OID 16529)
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- TOC entry 3921 (class 2606 OID 16931)
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- TOC entry 3878 (class 2606 OID 16949)
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- TOC entry 3880 (class 2606 OID 16959)
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- TOC entry 3855 (class 2606 OID 16522)
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- TOC entry 3901 (class 2606 OID 16818)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- TOC entry 3897 (class 2606 OID 16806)
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- TOC entry 3889 (class 2606 OID 16999)
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- TOC entry 3891 (class 2606 OID 16793)
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- TOC entry 3925 (class 2606 OID 16984)
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3849 (class 2606 OID 16512)
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3852 (class 2606 OID 16736)
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- TOC entry 3910 (class 2606 OID 16865)
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- TOC entry 3912 (class 2606 OID 16863)
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 3917 (class 2606 OID 16879)
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- TOC entry 3860 (class 2606 OID 16535)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3884 (class 2606 OID 16757)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 3907 (class 2606 OID 16846)
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- TOC entry 3903 (class 2606 OID 16837)
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 3842 (class 2606 OID 16919)
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- TOC entry 3844 (class 2606 OID 16499)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3965 (class 2606 OID 34661)
-- Name: active_conductors active_conductors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_conductors
    ADD CONSTRAINT active_conductors_pkey PRIMARY KEY (id);


--
-- TOC entry 3960 (class 2606 OID 26250)
-- Name: blocked_periods blocked_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blocked_periods
    ADD CONSTRAINT blocked_periods_pkey PRIMARY KEY (id);


--
-- TOC entry 3996 (class 2606 OID 45801)
-- Name: conductor_applications conductor_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductor_applications
    ADD CONSTRAINT conductor_applications_pkey PRIMARY KEY (id);


--
-- TOC entry 3998 (class 2606 OID 45803)
-- Name: conductor_applications conductor_applications_registration_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductor_applications
    ADD CONSTRAINT conductor_applications_registration_token_key UNIQUE (registration_token);


--
-- TOC entry 3963 (class 2606 OID 44571)
-- Name: conductor_locations conductor_locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductor_locations
    ADD CONSTRAINT conductor_locations_pkey PRIMARY KEY (id, latitude, longitude, updated_at, conductor_id, created_at, accuracy);


--
-- TOC entry 3988 (class 2606 OID 45709)
-- Name: conductor_status_audit conductor_status_audit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductor_status_audit
    ADD CONSTRAINT conductor_status_audit_pkey PRIMARY KEY (id);


--
-- TOC entry 4002 (class 2606 OID 45819)
-- Name: conductor_vehicle_sessions conductor_vehicle_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductor_vehicle_sessions
    ADD CONSTRAINT conductor_vehicle_sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 3971 (class 2606 OID 40481)
-- Name: conductors conductors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductors
    ADD CONSTRAINT conductors_pkey PRIMARY KEY (id);


--
-- TOC entry 3958 (class 2606 OID 19578)
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- TOC entry 3944 (class 2606 OID 19489)
-- Name: reservations reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id);


--
-- TOC entry 3950 (class 2606 OID 19515)
-- Name: tour_types tour_types_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_types
    ADD CONSTRAINT tour_types_name_key UNIQUE (name);


--
-- TOC entry 3952 (class 2606 OID 19513)
-- Name: tour_types tour_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tour_types
    ADD CONSTRAINT tour_types_pkey PRIMARY KEY (id);


--
-- TOC entry 3946 (class 2606 OID 19500)
-- Name: tuk_tuk_availability tuk_tuk_availability_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tuk_tuk_availability
    ADD CONSTRAINT tuk_tuk_availability_pkey PRIMARY KEY (id);


--
-- TOC entry 3948 (class 2606 OID 19502)
-- Name: tuk_tuk_availability tuk_tuk_availability_tuk_tuk_id_available_date_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tuk_tuk_availability
    ADD CONSTRAINT tuk_tuk_availability_tuk_tuk_id_available_date_key UNIQUE (tuk_tuk_id, available_date);


--
-- TOC entry 3992 (class 2606 OID 45776)
-- Name: tuktuk_vehicles tuktuk_vehicles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tuktuk_vehicles
    ADD CONSTRAINT tuktuk_vehicles_pkey PRIMARY KEY (id);


--
-- TOC entry 3982 (class 2606 OID 44345)
-- Name: tuktuks tuktuks_identificador_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tuktuks
    ADD CONSTRAINT tuktuks_identificador_key UNIQUE (identificador);


--
-- TOC entry 3984 (class 2606 OID 44343)
-- Name: tuktuks tuktuks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tuktuks
    ADD CONSTRAINT tuktuks_pkey PRIMARY KEY (id);


--
-- TOC entry 3967 (class 2606 OID 41650)
-- Name: active_conductors unique_conductor_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_conductors
    ADD CONSTRAINT unique_conductor_id UNIQUE (conductor_id);


--
-- TOC entry 3994 (class 2606 OID 45778)
-- Name: tuktuk_vehicles unique_vehicle_number_per_region; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tuktuk_vehicles
    ADD CONSTRAINT unique_vehicle_number_per_region UNIQUE (region, vehicle_number);


--
-- TOC entry 3980 (class 2606 OID 44308)
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);


--
-- TOC entry 3941 (class 2606 OID 17265)
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3969 (class 2606 OID 39337)
-- Name: messages_2025_07_20 messages_2025_07_20_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_20
    ADD CONSTRAINT messages_2025_07_20_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3974 (class 2606 OID 43171)
-- Name: messages_2025_07_21 messages_2025_07_21_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_21
    ADD CONSTRAINT messages_2025_07_21_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3976 (class 2606 OID 43182)
-- Name: messages_2025_07_22 messages_2025_07_22_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_22
    ADD CONSTRAINT messages_2025_07_22_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3978 (class 2606 OID 43193)
-- Name: messages_2025_07_23 messages_2025_07_23_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_23
    ADD CONSTRAINT messages_2025_07_23_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3986 (class 2606 OID 44580)
-- Name: messages_2025_07_24 messages_2025_07_24_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_24
    ADD CONSTRAINT messages_2025_07_24_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4005 (class 2606 OID 45884)
-- Name: messages_2025_07_25 messages_2025_07_25_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_25
    ADD CONSTRAINT messages_2025_07_25_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4007 (class 2606 OID 46998)
-- Name: messages_2025_07_26 messages_2025_07_26_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_26
    ADD CONSTRAINT messages_2025_07_26_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3938 (class 2606 OID 17119)
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- TOC entry 3935 (class 2606 OID 17092)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3863 (class 2606 OID 16552)
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- TOC entry 3870 (class 2606 OID 16593)
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- TOC entry 3872 (class 2606 OID 16591)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3868 (class 2606 OID 16569)
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- TOC entry 3933 (class 2606 OID 17055)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- TOC entry 3931 (class 2606 OID 17040)
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- TOC entry 3954 (class 2606 OID 19557)
-- Name: schema_migrations schema_migrations_idempotency_key_key; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_idempotency_key_key UNIQUE (idempotency_key);


--
-- TOC entry 3956 (class 2606 OID 19555)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 4009 (class 2606 OID 48110)
-- Name: seed_files seed_files_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.seed_files
    ADD CONSTRAINT seed_files_pkey PRIMARY KEY (path);


--
-- TOC entry 3858 (class 1259 OID 16530)
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- TOC entry 3832 (class 1259 OID 16746)
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3833 (class 1259 OID 16748)
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3834 (class 1259 OID 16749)
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3887 (class 1259 OID 16827)
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- TOC entry 3919 (class 1259 OID 16935)
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- TOC entry 3876 (class 1259 OID 16915)
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- TOC entry 4535 (class 0 OID 0)
-- Dependencies: 3876
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- TOC entry 3881 (class 1259 OID 16743)
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- TOC entry 3922 (class 1259 OID 16932)
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- TOC entry 3923 (class 1259 OID 16933)
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- TOC entry 3895 (class 1259 OID 16938)
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- TOC entry 3892 (class 1259 OID 16799)
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- TOC entry 3893 (class 1259 OID 16944)
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- TOC entry 3926 (class 1259 OID 16991)
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- TOC entry 3927 (class 1259 OID 16990)
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- TOC entry 3928 (class 1259 OID 16992)
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- TOC entry 3835 (class 1259 OID 16750)
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3836 (class 1259 OID 16747)
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3845 (class 1259 OID 16513)
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- TOC entry 3846 (class 1259 OID 16514)
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- TOC entry 3847 (class 1259 OID 16742)
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- TOC entry 3850 (class 1259 OID 16829)
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- TOC entry 3853 (class 1259 OID 16934)
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- TOC entry 3913 (class 1259 OID 16871)
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- TOC entry 3914 (class 1259 OID 16936)
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- TOC entry 3915 (class 1259 OID 16886)
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- TOC entry 3918 (class 1259 OID 16885)
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- TOC entry 3882 (class 1259 OID 16937)
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- TOC entry 3885 (class 1259 OID 16828)
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- TOC entry 3905 (class 1259 OID 16853)
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- TOC entry 3908 (class 1259 OID 16852)
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- TOC entry 3904 (class 1259 OID 16838)
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- TOC entry 3894 (class 1259 OID 16997)
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- TOC entry 3886 (class 1259 OID 16826)
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- TOC entry 3837 (class 1259 OID 16906)
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- TOC entry 4536 (class 0 OID 0)
-- Dependencies: 3837
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- TOC entry 3838 (class 1259 OID 16744)
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- TOC entry 3839 (class 1259 OID 16503)
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- TOC entry 3840 (class 1259 OID 16961)
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- TOC entry 3961 (class 1259 OID 26277)
-- Name: idx_blocked_periods_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_blocked_periods_date ON public.blocked_periods USING btree (date);


--
-- TOC entry 3999 (class 1259 OID 45843)
-- Name: idx_conductor_applications_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_conductor_applications_status ON public.conductor_applications USING btree (status);


--
-- TOC entry 4000 (class 1259 OID 45844)
-- Name: idx_conductor_applications_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_conductor_applications_token ON public.conductor_applications USING btree (registration_token);


--
-- TOC entry 4003 (class 1259 OID 45845)
-- Name: idx_conductor_sessions_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_conductor_sessions_active ON public.conductor_vehicle_sessions USING btree (is_active) WHERE (is_active = true);


--
-- TOC entry 3972 (class 1259 OID 45846)
-- Name: idx_conductors_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_conductors_status ON public.conductors USING btree (status);


--
-- TOC entry 3942 (class 1259 OID 26276)
-- Name: idx_reservations_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reservations_date ON public.reservations USING btree (reservation_date);


--
-- TOC entry 3989 (class 1259 OID 45841)
-- Name: idx_tuktuk_vehicles_region; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tuktuk_vehicles_region ON public.tuktuk_vehicles USING btree (region);


--
-- TOC entry 3990 (class 1259 OID 45842)
-- Name: idx_tuktuk_vehicles_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tuktuk_vehicles_status ON public.tuktuk_vehicles USING btree (maintenance_status);


--
-- TOC entry 3936 (class 1259 OID 17266)
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- TOC entry 3939 (class 1259 OID 17168)
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- TOC entry 3861 (class 1259 OID 16558)
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- TOC entry 3864 (class 1259 OID 16580)
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- TOC entry 3929 (class 1259 OID 17066)
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- TOC entry 3865 (class 1259 OID 17031)
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- TOC entry 3866 (class 1259 OID 16581)
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- TOC entry 4010 (class 0 OID 0)
-- Name: messages_2025_07_20_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_20_pkey;


--
-- TOC entry 4011 (class 0 OID 0)
-- Name: messages_2025_07_21_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_21_pkey;


--
-- TOC entry 4012 (class 0 OID 0)
-- Name: messages_2025_07_22_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_22_pkey;


--
-- TOC entry 4013 (class 0 OID 0)
-- Name: messages_2025_07_23_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_23_pkey;


--
-- TOC entry 4014 (class 0 OID 0)
-- Name: messages_2025_07_24_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_24_pkey;


--
-- TOC entry 4015 (class 0 OID 0)
-- Name: messages_2025_07_25_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_25_pkey;


--
-- TOC entry 4016 (class 0 OID 0)
-- Name: messages_2025_07_26_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_26_pkey;


--
-- TOC entry 4048 (class 2620 OID 19587)
-- Name: users on_auth_user_created; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


--
-- TOC entry 4052 (class 2620 OID 45729)
-- Name: conductors conductor_status_audit_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER conductor_status_audit_trigger BEFORE UPDATE ON public.conductors FOR EACH ROW EXECUTE FUNCTION public.log_conductor_status_change();


--
-- TOC entry 4054 (class 2620 OID 45864)
-- Name: conductor_applications create_conductor_from_application; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER create_conductor_from_application BEFORE UPDATE ON public.conductor_applications FOR EACH ROW EXECUTE FUNCTION public.create_conductor_from_approved_application();


--
-- TOC entry 4051 (class 2620 OID 19560)
-- Name: reservations update_reservations_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_reservations_updated_at BEFORE UPDATE ON public.reservations FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 4053 (class 2620 OID 45847)
-- Name: tuktuk_vehicles update_tuktuk_vehicles_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_tuktuk_vehicles_updated_at BEFORE UPDATE ON public.tuktuk_vehicles FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 4050 (class 2620 OID 17124)
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- TOC entry 4049 (class 2620 OID 17019)
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- TOC entry 4019 (class 2606 OID 16730)
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4023 (class 2606 OID 16819)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 4022 (class 2606 OID 16807)
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- TOC entry 4021 (class 2606 OID 16794)
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4028 (class 2606 OID 16985)
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4017 (class 2606 OID 16763)
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 4025 (class 2606 OID 16866)
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4026 (class 2606 OID 16939)
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- TOC entry 4027 (class 2606 OID 16880)
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4020 (class 2606 OID 16758)
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4024 (class 2606 OID 16847)
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4045 (class 2606 OID 45804)
-- Name: conductor_applications conductor_applications_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductor_applications
    ADD CONSTRAINT conductor_applications_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth.users(id);


--
-- TOC entry 4034 (class 2606 OID 41732)
-- Name: conductor_locations conductor_locations_conductor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductor_locations
    ADD CONSTRAINT conductor_locations_conductor_id_fkey FOREIGN KEY (conductor_id) REFERENCES public.conductors(id);


--
-- TOC entry 4041 (class 2606 OID 45715)
-- Name: conductor_status_audit conductor_status_audit_changed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductor_status_audit
    ADD CONSTRAINT conductor_status_audit_changed_by_fkey FOREIGN KEY (changed_by) REFERENCES auth.users(id);


--
-- TOC entry 4042 (class 2606 OID 45710)
-- Name: conductor_status_audit conductor_status_audit_conductor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductor_status_audit
    ADD CONSTRAINT conductor_status_audit_conductor_id_fkey FOREIGN KEY (conductor_id) REFERENCES public.conductors(id);


--
-- TOC entry 4046 (class 2606 OID 45820)
-- Name: conductor_vehicle_sessions conductor_vehicle_sessions_conductor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductor_vehicle_sessions
    ADD CONSTRAINT conductor_vehicle_sessions_conductor_id_fkey FOREIGN KEY (conductor_id) REFERENCES public.conductors(id);


--
-- TOC entry 4047 (class 2606 OID 45825)
-- Name: conductor_vehicle_sessions conductor_vehicle_sessions_vehicle_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductor_vehicle_sessions
    ADD CONSTRAINT conductor_vehicle_sessions_vehicle_id_fkey FOREIGN KEY (vehicle_id) REFERENCES public.tuktuk_vehicles(id);


--
-- TOC entry 4035 (class 2606 OID 45831)
-- Name: conductors conductors_assigned_vehicle_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductors
    ADD CONSTRAINT conductors_assigned_vehicle_fkey FOREIGN KEY (assigned_vehicle) REFERENCES public.tuktuk_vehicles(id);


--
-- TOC entry 4036 (class 2606 OID 45836)
-- Name: conductors conductors_blocked_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductors
    ADD CONSTRAINT conductors_blocked_by_fkey FOREIGN KEY (blocked_by) REFERENCES auth.users(id);


--
-- TOC entry 4037 (class 2606 OID 44371)
-- Name: conductors conductors_tuktuk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductors
    ADD CONSTRAINT conductors_tuktuk_id_fkey FOREIGN KEY (tuktuk_id) REFERENCES public.tuktuks(id);


--
-- TOC entry 4038 (class 2606 OID 45722)
-- Name: conductors conductors_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductors
    ADD CONSTRAINT conductors_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES auth.users(id);


--
-- TOC entry 4039 (class 2606 OID 44366)
-- Name: conductors conductors_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conductors
    ADD CONSTRAINT conductors_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id);


--
-- TOC entry 4032 (class 2606 OID 45695)
-- Name: profiles profiles_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_created_by_fkey FOREIGN KEY (created_by) REFERENCES auth.users(id);


--
-- TOC entry 4033 (class 2606 OID 19579)
-- Name: profiles profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4043 (class 2606 OID 45784)
-- Name: tuktuk_vehicles tuktuk_vehicles_current_conductor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tuktuk_vehicles
    ADD CONSTRAINT tuktuk_vehicles_current_conductor_fkey FOREIGN KEY (current_conductor) REFERENCES public.conductors(id);


--
-- TOC entry 4044 (class 2606 OID 45779)
-- Name: tuktuk_vehicles tuktuk_vehicles_managed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tuktuk_vehicles
    ADD CONSTRAINT tuktuk_vehicles_managed_by_fkey FOREIGN KEY (managed_by) REFERENCES auth.users(id);


--
-- TOC entry 4040 (class 2606 OID 44309)
-- Name: user_roles user_roles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id);


--
-- TOC entry 4018 (class 2606 OID 16570)
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4029 (class 2606 OID 17041)
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4030 (class 2606 OID 17061)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4031 (class 2606 OID 17056)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- TOC entry 4206 (class 0 OID 16523)
-- Dependencies: 325
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4220 (class 0 OID 16925)
-- Dependencies: 342
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4211 (class 0 OID 16723)
-- Dependencies: 333
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4205 (class 0 OID 16516)
-- Dependencies: 324
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4215 (class 0 OID 16812)
-- Dependencies: 337
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4214 (class 0 OID 16800)
-- Dependencies: 336
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4213 (class 0 OID 16787)
-- Dependencies: 335
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4221 (class 0 OID 16975)
-- Dependencies: 343
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4204 (class 0 OID 16505)
-- Dependencies: 323
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4218 (class 0 OID 16854)
-- Dependencies: 340
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4219 (class 0 OID 16872)
-- Dependencies: 341
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4207 (class 0 OID 16531)
-- Dependencies: 326
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4212 (class 0 OID 16753)
-- Dependencies: 334
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4217 (class 0 OID 16839)
-- Dependencies: 339
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4216 (class 0 OID 16830)
-- Dependencies: 338
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4203 (class 0 OID 16493)
-- Dependencies: 321
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4262 (class 3256 OID 44565)
-- Name: active_conductors Admins can manage all active conductors fixed; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage all active conductors fixed" ON public.active_conductors USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text)))));


--
-- TOC entry 4263 (class 3256 OID 44568)
-- Name: tuktuks Admins can manage all tuktuks fixed; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage all tuktuks fixed" ON public.tuktuks USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text)))));


--
-- TOC entry 4259 (class 3256 OID 44559)
-- Name: user_roles Admins can manage all user roles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage all user roles" ON public.user_roles USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text)))));


--
-- TOC entry 4251 (class 3256 OID 41760)
-- Name: conductor_locations Admins can manage conductor locations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage conductor locations" ON public.conductor_locations TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text)))));


--
-- TOC entry 4265 (class 3256 OID 45730)
-- Name: conductors Admins can update conductors with permission check; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can update conductors with permission check" ON public.conductors FOR UPDATE TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text) AND public.check_admin_permissions(conductors.id, auth.uid())))));


--
-- TOC entry 4247 (class 3256 OID 19589)
-- Name: reservations Admins can update reservations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can update reservations" ON public.reservations FOR UPDATE TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text)))));


--
-- TOC entry 4246 (class 3256 OID 19588)
-- Name: reservations Admins can view all reservations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view all reservations" ON public.reservations FOR SELECT TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text)))));


--
-- TOC entry 4267 (class 3256 OID 45732)
-- Name: conductor_status_audit Admins can view audit logs; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view audit logs" ON public.conductor_status_audit FOR SELECT TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text) AND ((profiles.admin_level = 'super_admin'::public.admin_level) OR (profiles.id = conductor_status_audit.changed_by))))));


--
-- TOC entry 4266 (class 3256 OID 45731)
-- Name: conductors Admins can view conductors by region; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view conductors by region" ON public.conductors FOR SELECT TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text) AND ((profiles.admin_level = 'super_admin'::public.admin_level) OR ((profiles.region)::text = (conductors.region)::text) OR (profiles.region IS NULL))))));


--
-- TOC entry 4249 (class 3256 OID 26280)
-- Name: blocked_periods Allow all operations on blocked_periods; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow all operations on blocked_periods" ON public.blocked_periods USING (true);


--
-- TOC entry 4248 (class 3256 OID 26279)
-- Name: reservations Allow all operations on reservations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow all operations on reservations" ON public.reservations USING (true);


--
-- TOC entry 4261 (class 3256 OID 44564)
-- Name: conductors Conductor owner or admin fixed; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Conductor owner or admin fixed" ON public.conductors FOR SELECT USING (((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text)))) OR (user_id = auth.uid())));


--
-- TOC entry 4255 (class 3256 OID 44554)
-- Name: active_conductors Conductors can insert their own active status; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Conductors can insert their own active status" ON public.active_conductors FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM public.conductors
  WHERE ((conductors.user_id = auth.uid()) AND (conductors.id = active_conductors.conductor_id)))));


--
-- TOC entry 4256 (class 3256 OID 44555)
-- Name: active_conductors Conductors can update their own active status; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Conductors can update their own active status" ON public.active_conductors FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM public.conductors
  WHERE ((conductors.user_id = auth.uid()) AND (conductors.id = active_conductors.conductor_id)))));


--
-- TOC entry 4258 (class 3256 OID 44558)
-- Name: conductor_locations Conductors can update their own location; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Conductors can update their own location" ON public.conductor_locations USING ((EXISTS ( SELECT 1
   FROM public.conductors
  WHERE ((conductors.user_id = auth.uid()) AND (conductors.id = conductor_locations.conductor_id)))));


--
-- TOC entry 4252 (class 3256 OID 44553)
-- Name: active_conductors Conductors can view their own active status; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Conductors can view their own active status" ON public.active_conductors FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.conductors
  WHERE ((conductors.user_id = auth.uid()) AND (conductors.id = active_conductors.conductor_id)))));


--
-- TOC entry 4240 (class 3256 OID 19562)
-- Name: reservations Enable insert for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable insert for all users" ON public.reservations FOR INSERT WITH CHECK (true);


--
-- TOC entry 4243 (class 3256 OID 19565)
-- Name: tuk_tuk_availability Enable insert for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable insert for all users" ON public.tuk_tuk_availability FOR INSERT WITH CHECK (true);


--
-- TOC entry 4239 (class 3256 OID 19561)
-- Name: reservations Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.reservations FOR SELECT USING (true);


--
-- TOC entry 4245 (class 3256 OID 19567)
-- Name: tour_types Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.tour_types FOR SELECT USING (true);


--
-- TOC entry 4242 (class 3256 OID 19564)
-- Name: tuk_tuk_availability Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.tuk_tuk_availability FOR SELECT USING (true);


--
-- TOC entry 4241 (class 3256 OID 19563)
-- Name: reservations Enable update for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable update for all users" ON public.reservations FOR UPDATE USING (true);


--
-- TOC entry 4244 (class 3256 OID 19566)
-- Name: tuk_tuk_availability Enable update for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable update for all users" ON public.tuk_tuk_availability FOR UPDATE USING (true);


--
-- TOC entry 4264 (class 3256 OID 44569)
-- Name: profiles Profile access by owner or jwt admin; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Profile access by owner or jwt admin" ON public.profiles USING (((auth.uid() = id) OR ((auth.jwt() ->> 'role'::text) = 'admin'::text) OR (((auth.jwt() -> 'user_metadata'::text) ->> 'role'::text) = 'admin'::text)));


--
-- TOC entry 4257 (class 3256 OID 44557)
-- Name: active_conductors Public can view active conductors; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Public can view active conductors" ON public.active_conductors FOR SELECT USING ((is_active = true));


--
-- TOC entry 4260 (class 3256 OID 44563)
-- Name: conductors Public can view active conductors; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Public can view active conductors" ON public.conductors FOR SELECT USING ((is_active = true));


--
-- TOC entry 4254 (class 3256 OID 44561)
-- Name: tuktuks Public can view active tuktuks; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Public can view active tuktuks" ON public.tuktuks FOR SELECT USING ((ativo = true));


--
-- TOC entry 4250 (class 3256 OID 41758)
-- Name: conductor_locations Public can view conductor location; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Public can view conductor location" ON public.conductor_locations FOR SELECT USING (true);


--
-- TOC entry 4253 (class 3256 OID 44560)
-- Name: user_roles Users can view own role; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view own role" ON public.user_roles FOR SELECT USING ((user_id = auth.uid()));


--
-- TOC entry 4231 (class 0 OID 34655)
-- Dependencies: 361
-- Name: active_conductors; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.active_conductors ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4272 (class 3256 OID 45869)
-- Name: conductor_applications admins_create_applications_in_region; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY admins_create_applications_in_region ON public.conductor_applications FOR INSERT TO authenticated WITH CHECK (((created_by = auth.uid()) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text) AND ((profiles.admin_level = 'super_admin'::public.admin_level) OR ((profiles.region)::text = (conductor_applications.region)::text)))))));


--
-- TOC entry 4270 (class 3256 OID 45867)
-- Name: tuktuk_vehicles admins_manage_vehicles_in_region; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY admins_manage_vehicles_in_region ON public.tuktuk_vehicles TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text) AND ((profiles.admin_level = 'super_admin'::public.admin_level) OR ((profiles.region)::text = (tuktuk_vehicles.region)::text))))));


--
-- TOC entry 4275 (class 3256 OID 45872)
-- Name: conductor_applications admins_update_applications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY admins_update_applications ON public.conductor_applications FOR UPDATE TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text) AND ((profiles.admin_level = 'super_admin'::public.admin_level) OR ((profiles.region)::text = (conductor_applications.region)::text))))));


--
-- TOC entry 4271 (class 3256 OID 45868)
-- Name: conductor_applications admins_view_applications_in_region; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY admins_view_applications_in_region ON public.conductor_applications FOR SELECT TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text) AND ((profiles.admin_level = 'super_admin'::public.admin_level) OR ((profiles.region)::text = (conductor_applications.region)::text))))));


--
-- TOC entry 4277 (class 3256 OID 45874)
-- Name: conductor_vehicle_sessions admins_view_sessions_in_region; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY admins_view_sessions_in_region ON public.conductor_vehicle_sessions FOR SELECT TO authenticated USING ((EXISTS ( SELECT 1
   FROM (public.profiles p
     JOIN public.conductors c ON (((c.region)::text = (p.region)::text)))
  WHERE ((p.id = auth.uid()) AND (p.role = 'admin'::text) AND (c.id = conductor_vehicle_sessions.conductor_id) AND ((p.admin_level = 'super_admin'::public.admin_level) OR ((p.region)::text = (c.region)::text))))));


--
-- TOC entry 4268 (class 3256 OID 45865)
-- Name: tuktuk_vehicles admins_view_vehicles_in_region; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY admins_view_vehicles_in_region ON public.tuktuk_vehicles FOR SELECT TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.role = 'admin'::text) AND ((profiles.admin_level = 'super_admin'::public.admin_level) OR ((profiles.region)::text = (tuktuk_vehicles.region)::text))))));


--
-- TOC entry 4229 (class 0 OID 26242)
-- Dependencies: 358
-- Name: blocked_periods; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.blocked_periods ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4237 (class 0 OID 45789)
-- Dependencies: 372
-- Name: conductor_applications; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.conductor_applications ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4230 (class 0 OID 34641)
-- Dependencies: 359
-- Name: conductor_locations; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.conductor_locations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4235 (class 0 OID 45700)
-- Dependencies: 370
-- Name: conductor_status_audit; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.conductor_status_audit ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4238 (class 0 OID 45809)
-- Dependencies: 373
-- Name: conductor_vehicle_sessions; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.conductor_vehicle_sessions ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4232 (class 0 OID 40475)
-- Dependencies: 363
-- Name: conductors; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.conductors ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4276 (class 3256 OID 45873)
-- Name: conductor_vehicle_sessions conductors_manage_own_sessions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY conductors_manage_own_sessions ON public.conductor_vehicle_sessions TO authenticated USING ((conductor_id IN ( SELECT conductors.id
   FROM public.conductors
  WHERE (conductors.user_id = auth.uid()))));


--
-- TOC entry 4269 (class 3256 OID 45866)
-- Name: tuktuk_vehicles conductors_view_assigned_vehicle; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY conductors_view_assigned_vehicle ON public.tuktuk_vehicles FOR SELECT TO authenticated USING ((current_conductor IN ( SELECT conductors.id
   FROM public.conductors
  WHERE (conductors.user_id = auth.uid()))));


--
-- TOC entry 4228 (class 0 OID 19569)
-- Dependencies: 357
-- Name: profiles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4274 (class 3256 OID 45871)
-- Name: conductor_applications public_submit_application; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY public_submit_application ON public.conductor_applications FOR UPDATE TO anon USING ((status = 'link_created'::public.application_status)) WITH CHECK ((status = ANY (ARRAY['submitted'::public.application_status, 'link_created'::public.application_status])));


--
-- TOC entry 4273 (class 3256 OID 45870)
-- Name: conductor_applications public_view_application_by_token; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY public_view_application_by_token ON public.conductor_applications FOR SELECT TO anon USING (true);


--
-- TOC entry 4225 (class 0 OID 19477)
-- Dependencies: 353
-- Name: reservations; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.reservations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4227 (class 0 OID 19503)
-- Dependencies: 355
-- Name: tour_types; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.tour_types ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4226 (class 0 OID 19490)
-- Dependencies: 354
-- Name: tuk_tuk_availability; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.tuk_tuk_availability ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4236 (class 0 OID 45763)
-- Dependencies: 371
-- Name: tuktuk_vehicles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.tuktuk_vehicles ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4234 (class 0 OID 44334)
-- Dependencies: 368
-- Name: tuktuks; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.tuktuks ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4233 (class 0 OID 44300)
-- Dependencies: 367
-- Name: user_roles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4224 (class 0 OID 17251)
-- Dependencies: 352
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4208 (class 0 OID 16544)
-- Dependencies: 327
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4210 (class 0 OID 16586)
-- Dependencies: 329
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4209 (class 0 OID 16559)
-- Dependencies: 328
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4222 (class 0 OID 17032)
-- Dependencies: 344
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4223 (class 0 OID 17046)
-- Dependencies: 345
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4279 (class 6104 OID 16426)
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- TOC entry 4278 (class 6104 OID 33493)
-- Name: supabase_realtime_messages_publication; Type: PUBLICATION; Schema: -; Owner: supabase_admin
--

CREATE PUBLICATION supabase_realtime_messages_publication WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime_messages_publication OWNER TO supabase_admin;

--
-- TOC entry 4283 (class 6106 OID 41786)
-- Name: supabase_realtime active_conductors; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.active_conductors;


--
-- TOC entry 4286 (class 6106 OID 41789)
-- Name: supabase_realtime blocked_periods; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.blocked_periods;


--
-- TOC entry 4284 (class 6106 OID 41787)
-- Name: supabase_realtime conductor_locations; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.conductor_locations;


--
-- TOC entry 4281 (class 6106 OID 41784)
-- Name: supabase_realtime conductors; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.conductors;


--
-- TOC entry 4282 (class 6106 OID 41785)
-- Name: supabase_realtime profiles; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.profiles;


--
-- TOC entry 4288 (class 6106 OID 41791)
-- Name: supabase_realtime reservations; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.reservations;


--
-- TOC entry 4285 (class 6106 OID 41788)
-- Name: supabase_realtime tour_types; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.tour_types;


--
-- TOC entry 4287 (class 6106 OID 41790)
-- Name: supabase_realtime tuk_tuk_availability; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.tuk_tuk_availability;


--
-- TOC entry 4280 (class 6106 OID 33494)
-- Name: supabase_realtime_messages_publication messages; Type: PUBLICATION TABLE; Schema: realtime; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY realtime.messages;


--
-- TOC entry 4343 (class 0 OID 0)
-- Dependencies: 20
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- TOC entry 4344 (class 0 OID 0)
-- Dependencies: 15
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- TOC entry 4345 (class 0 OID 0)
-- Dependencies: 11
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- TOC entry 4346 (class 0 OID 0)
-- Dependencies: 23
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- TOC entry 4347 (class 0 OID 0)
-- Dependencies: 19
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- TOC entry 4348 (class 0 OID 0)
-- Dependencies: 16
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- TOC entry 4356 (class 0 OID 0)
-- Dependencies: 440
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- TOC entry 4357 (class 0 OID 0)
-- Dependencies: 459
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- TOC entry 4359 (class 0 OID 0)
-- Dependencies: 439
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- TOC entry 4361 (class 0 OID 0)
-- Dependencies: 438
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- TOC entry 4362 (class 0 OID 0)
-- Dependencies: 434
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- TOC entry 4363 (class 0 OID 0)
-- Dependencies: 435
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- TOC entry 4364 (class 0 OID 0)
-- Dependencies: 406
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- TOC entry 4365 (class 0 OID 0)
-- Dependencies: 436
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- TOC entry 4366 (class 0 OID 0)
-- Dependencies: 410
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4367 (class 0 OID 0)
-- Dependencies: 412
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4368 (class 0 OID 0)
-- Dependencies: 403
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- TOC entry 4369 (class 0 OID 0)
-- Dependencies: 402
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- TOC entry 4370 (class 0 OID 0)
-- Dependencies: 409
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4371 (class 0 OID 0)
-- Dependencies: 411
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4372 (class 0 OID 0)
-- Dependencies: 413
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- TOC entry 4373 (class 0 OID 0)
-- Dependencies: 414
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- TOC entry 4374 (class 0 OID 0)
-- Dependencies: 407
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- TOC entry 4375 (class 0 OID 0)
-- Dependencies: 408
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- TOC entry 4377 (class 0 OID 0)
-- Dependencies: 441
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- TOC entry 4379 (class 0 OID 0)
-- Dependencies: 445
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4381 (class 0 OID 0)
-- Dependencies: 442
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- TOC entry 4382 (class 0 OID 0)
-- Dependencies: 405
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4383 (class 0 OID 0)
-- Dependencies: 404
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- TOC entry 4384 (class 0 OID 0)
-- Dependencies: 390
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO dashboard_user;


--
-- TOC entry 4385 (class 0 OID 0)
-- Dependencies: 389
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- TOC entry 4386 (class 0 OID 0)
-- Dependencies: 391
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO dashboard_user;


--
-- TOC entry 4387 (class 0 OID 0)
-- Dependencies: 437
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- TOC entry 4388 (class 0 OID 0)
-- Dependencies: 433
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- TOC entry 4389 (class 0 OID 0)
-- Dependencies: 427
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4390 (class 0 OID 0)
-- Dependencies: 429
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4391 (class 0 OID 0)
-- Dependencies: 431
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- TOC entry 4392 (class 0 OID 0)
-- Dependencies: 428
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4393 (class 0 OID 0)
-- Dependencies: 430
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4394 (class 0 OID 0)
-- Dependencies: 432
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- TOC entry 4395 (class 0 OID 0)
-- Dependencies: 423
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- TOC entry 4396 (class 0 OID 0)
-- Dependencies: 425
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- TOC entry 4397 (class 0 OID 0)
-- Dependencies: 424
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4398 (class 0 OID 0)
-- Dependencies: 426
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4399 (class 0 OID 0)
-- Dependencies: 419
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- TOC entry 4400 (class 0 OID 0)
-- Dependencies: 421
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4401 (class 0 OID 0)
-- Dependencies: 420
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- TOC entry 4402 (class 0 OID 0)
-- Dependencies: 422
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4403 (class 0 OID 0)
-- Dependencies: 415
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- TOC entry 4404 (class 0 OID 0)
-- Dependencies: 417
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- TOC entry 4405 (class 0 OID 0)
-- Dependencies: 416
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- TOC entry 4406 (class 0 OID 0)
-- Dependencies: 418
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4407 (class 0 OID 0)
-- Dependencies: 443
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4408 (class 0 OID 0)
-- Dependencies: 444
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4410 (class 0 OID 0)
-- Dependencies: 446
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4411 (class 0 OID 0)
-- Dependencies: 397
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- TOC entry 4412 (class 0 OID 0)
-- Dependencies: 398
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- TOC entry 4413 (class 0 OID 0)
-- Dependencies: 399
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- TOC entry 4414 (class 0 OID 0)
-- Dependencies: 400
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- TOC entry 4415 (class 0 OID 0)
-- Dependencies: 401
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- TOC entry 4416 (class 0 OID 0)
-- Dependencies: 392
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- TOC entry 4417 (class 0 OID 0)
-- Dependencies: 393
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- TOC entry 4418 (class 0 OID 0)
-- Dependencies: 395
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- TOC entry 4419 (class 0 OID 0)
-- Dependencies: 394
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- TOC entry 4420 (class 0 OID 0)
-- Dependencies: 396
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- TOC entry 4421 (class 0 OID 0)
-- Dependencies: 458
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- TOC entry 4422 (class 0 OID 0)
-- Dependencies: 388
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO postgres;


--
-- TOC entry 4423 (class 0 OID 0)
-- Dependencies: 493
-- Name: FUNCTION assign_vehicle(conductor_id uuid, vehicle_id uuid, assigned_by uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.assign_vehicle(conductor_id uuid, vehicle_id uuid, assigned_by uuid) TO anon;
GRANT ALL ON FUNCTION public.assign_vehicle(conductor_id uuid, vehicle_id uuid, assigned_by uuid) TO authenticated;
GRANT ALL ON FUNCTION public.assign_vehicle(conductor_id uuid, vehicle_id uuid, assigned_by uuid) TO service_role;


--
-- TOC entry 4424 (class 0 OID 0)
-- Dependencies: 490
-- Name: FUNCTION block_conductor(conductor_id uuid, block_reason text, blocked_by uuid, duration text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.block_conductor(conductor_id uuid, block_reason text, blocked_by uuid, duration text) TO anon;
GRANT ALL ON FUNCTION public.block_conductor(conductor_id uuid, block_reason text, blocked_by uuid, duration text) TO authenticated;
GRANT ALL ON FUNCTION public.block_conductor(conductor_id uuid, block_reason text, blocked_by uuid, duration text) TO service_role;


--
-- TOC entry 4426 (class 0 OID 0)
-- Dependencies: 485
-- Name: FUNCTION check_admin_permissions(target_conductor_id uuid, admin_user_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.check_admin_permissions(target_conductor_id uuid, admin_user_id uuid) TO anon;
GRANT ALL ON FUNCTION public.check_admin_permissions(target_conductor_id uuid, admin_user_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.check_admin_permissions(target_conductor_id uuid, admin_user_id uuid) TO service_role;


--
-- TOC entry 4427 (class 0 OID 0)
-- Dependencies: 494
-- Name: FUNCTION create_conductor_from_approved_application(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.create_conductor_from_approved_application() TO anon;
GRANT ALL ON FUNCTION public.create_conductor_from_approved_application() TO authenticated;
GRANT ALL ON FUNCTION public.create_conductor_from_approved_application() TO service_role;


--
-- TOC entry 4428 (class 0 OID 0)
-- Dependencies: 491
-- Name: FUNCTION expel_conductor(conductor_id uuid, expulsion_reason text, expelled_by uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.expel_conductor(conductor_id uuid, expulsion_reason text, expelled_by uuid) TO anon;
GRANT ALL ON FUNCTION public.expel_conductor(conductor_id uuid, expulsion_reason text, expelled_by uuid) TO authenticated;
GRANT ALL ON FUNCTION public.expel_conductor(conductor_id uuid, expulsion_reason text, expelled_by uuid) TO service_role;


--
-- TOC entry 4429 (class 0 OID 0)
-- Dependencies: 487
-- Name: FUNCTION get_admin_level(user_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_admin_level(user_id uuid) TO anon;
GRANT ALL ON FUNCTION public.get_admin_level(user_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.get_admin_level(user_id uuid) TO service_role;


--
-- TOC entry 4430 (class 0 OID 0)
-- Dependencies: 488
-- Name: FUNCTION get_admin_region(user_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_admin_region(user_id uuid) TO anon;
GRANT ALL ON FUNCTION public.get_admin_region(user_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.get_admin_region(user_id uuid) TO service_role;


--
-- TOC entry 4431 (class 0 OID 0)
-- Dependencies: 489
-- Name: FUNCTION get_admin_zone(user_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_admin_zone(user_id uuid) TO anon;
GRANT ALL ON FUNCTION public.get_admin_zone(user_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.get_admin_zone(user_id uuid) TO service_role;


--
-- TOC entry 4432 (class 0 OID 0)
-- Dependencies: 483
-- Name: FUNCTION handle_new_user(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.handle_new_user() TO anon;
GRANT ALL ON FUNCTION public.handle_new_user() TO authenticated;
GRANT ALL ON FUNCTION public.handle_new_user() TO service_role;


--
-- TOC entry 4433 (class 0 OID 0)
-- Dependencies: 484
-- Name: FUNCTION limit_audit_log_entries_gradually(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.limit_audit_log_entries_gradually() TO anon;
GRANT ALL ON FUNCTION public.limit_audit_log_entries_gradually() TO authenticated;
GRANT ALL ON FUNCTION public.limit_audit_log_entries_gradually() TO service_role;


--
-- TOC entry 4434 (class 0 OID 0)
-- Dependencies: 486
-- Name: FUNCTION log_conductor_status_change(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.log_conductor_status_change() TO anon;
GRANT ALL ON FUNCTION public.log_conductor_status_change() TO authenticated;
GRANT ALL ON FUNCTION public.log_conductor_status_change() TO service_role;


--
-- TOC entry 4435 (class 0 OID 0)
-- Dependencies: 492
-- Name: FUNCTION unblock_conductor(conductor_id uuid, unblocked_by uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.unblock_conductor(conductor_id uuid, unblocked_by uuid) TO anon;
GRANT ALL ON FUNCTION public.unblock_conductor(conductor_id uuid, unblocked_by uuid) TO authenticated;
GRANT ALL ON FUNCTION public.unblock_conductor(conductor_id uuid, unblocked_by uuid) TO service_role;


--
-- TOC entry 4436 (class 0 OID 0)
-- Dependencies: 482
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_updated_at_column() TO anon;
GRANT ALL ON FUNCTION public.update_updated_at_column() TO authenticated;
GRANT ALL ON FUNCTION public.update_updated_at_column() TO service_role;


--
-- TOC entry 4437 (class 0 OID 0)
-- Dependencies: 475
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 4438 (class 0 OID 0)
-- Dependencies: 481
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- TOC entry 4439 (class 0 OID 0)
-- Dependencies: 477
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- TOC entry 4440 (class 0 OID 0)
-- Dependencies: 473
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- TOC entry 4441 (class 0 OID 0)
-- Dependencies: 472
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- TOC entry 4442 (class 0 OID 0)
-- Dependencies: 476
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- TOC entry 4443 (class 0 OID 0)
-- Dependencies: 478
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 4444 (class 0 OID 0)
-- Dependencies: 471
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- TOC entry 4445 (class 0 OID 0)
-- Dependencies: 480
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- TOC entry 4446 (class 0 OID 0)
-- Dependencies: 470
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- TOC entry 4447 (class 0 OID 0)
-- Dependencies: 474
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- TOC entry 4448 (class 0 OID 0)
-- Dependencies: 479
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- TOC entry 4449 (class 0 OID 0)
-- Dependencies: 448
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- TOC entry 4450 (class 0 OID 0)
-- Dependencies: 450
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- TOC entry 4451 (class 0 OID 0)
-- Dependencies: 451
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- TOC entry 4453 (class 0 OID 0)
-- Dependencies: 325
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- TOC entry 4455 (class 0 OID 0)
-- Dependencies: 342
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- TOC entry 4458 (class 0 OID 0)
-- Dependencies: 333
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- TOC entry 4460 (class 0 OID 0)
-- Dependencies: 324
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- TOC entry 4462 (class 0 OID 0)
-- Dependencies: 337
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- TOC entry 4464 (class 0 OID 0)
-- Dependencies: 336
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- TOC entry 4466 (class 0 OID 0)
-- Dependencies: 335
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- TOC entry 4467 (class 0 OID 0)
-- Dependencies: 343
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- TOC entry 4469 (class 0 OID 0)
-- Dependencies: 323
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- TOC entry 4471 (class 0 OID 0)
-- Dependencies: 322
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- TOC entry 4473 (class 0 OID 0)
-- Dependencies: 340
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- TOC entry 4475 (class 0 OID 0)
-- Dependencies: 341
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- TOC entry 4477 (class 0 OID 0)
-- Dependencies: 326
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- TOC entry 4480 (class 0 OID 0)
-- Dependencies: 334
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- TOC entry 4482 (class 0 OID 0)
-- Dependencies: 339
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- TOC entry 4485 (class 0 OID 0)
-- Dependencies: 338
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- TOC entry 4488 (class 0 OID 0)
-- Dependencies: 321
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- TOC entry 4489 (class 0 OID 0)
-- Dependencies: 320
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- TOC entry 4490 (class 0 OID 0)
-- Dependencies: 319
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- TOC entry 4491 (class 0 OID 0)
-- Dependencies: 361
-- Name: TABLE active_conductors; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.active_conductors TO anon;
GRANT ALL ON TABLE public.active_conductors TO authenticated;
GRANT ALL ON TABLE public.active_conductors TO service_role;


--
-- TOC entry 4493 (class 0 OID 0)
-- Dependencies: 360
-- Name: SEQUENCE active_conductors_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.active_conductors_id_seq TO anon;
GRANT ALL ON SEQUENCE public.active_conductors_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.active_conductors_id_seq TO service_role;


--
-- TOC entry 4494 (class 0 OID 0)
-- Dependencies: 358
-- Name: TABLE blocked_periods; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.blocked_periods TO anon;
GRANT ALL ON TABLE public.blocked_periods TO authenticated;
GRANT ALL ON TABLE public.blocked_periods TO service_role;


--
-- TOC entry 4495 (class 0 OID 0)
-- Dependencies: 372
-- Name: TABLE conductor_applications; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.conductor_applications TO anon;
GRANT ALL ON TABLE public.conductor_applications TO authenticated;
GRANT ALL ON TABLE public.conductor_applications TO service_role;


--
-- TOC entry 4496 (class 0 OID 0)
-- Dependencies: 359
-- Name: TABLE conductor_locations; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.conductor_locations TO anon;
GRANT ALL ON TABLE public.conductor_locations TO authenticated;
GRANT ALL ON TABLE public.conductor_locations TO service_role;


--
-- TOC entry 4498 (class 0 OID 0)
-- Dependencies: 370
-- Name: TABLE conductor_status_audit; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.conductor_status_audit TO anon;
GRANT ALL ON TABLE public.conductor_status_audit TO authenticated;
GRANT ALL ON TABLE public.conductor_status_audit TO service_role;


--
-- TOC entry 4499 (class 0 OID 0)
-- Dependencies: 373
-- Name: TABLE conductor_vehicle_sessions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.conductor_vehicle_sessions TO anon;
GRANT ALL ON TABLE public.conductor_vehicle_sessions TO authenticated;
GRANT ALL ON TABLE public.conductor_vehicle_sessions TO service_role;


--
-- TOC entry 4501 (class 0 OID 0)
-- Dependencies: 363
-- Name: TABLE conductors; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.conductors TO anon;
GRANT ALL ON TABLE public.conductors TO authenticated;
GRANT ALL ON TABLE public.conductors TO service_role;


--
-- TOC entry 4505 (class 0 OID 0)
-- Dependencies: 357
-- Name: TABLE profiles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.profiles TO anon;
GRANT ALL ON TABLE public.profiles TO authenticated;
GRANT ALL ON TABLE public.profiles TO service_role;


--
-- TOC entry 4507 (class 0 OID 0)
-- Dependencies: 353
-- Name: TABLE reservations; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.reservations TO anon;
GRANT ALL ON TABLE public.reservations TO authenticated;
GRANT ALL ON TABLE public.reservations TO service_role;


--
-- TOC entry 4508 (class 0 OID 0)
-- Dependencies: 355
-- Name: TABLE tour_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tour_types TO anon;
GRANT ALL ON TABLE public.tour_types TO authenticated;
GRANT ALL ON TABLE public.tour_types TO service_role;


--
-- TOC entry 4509 (class 0 OID 0)
-- Dependencies: 354
-- Name: TABLE tuk_tuk_availability; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tuk_tuk_availability TO anon;
GRANT ALL ON TABLE public.tuk_tuk_availability TO authenticated;
GRANT ALL ON TABLE public.tuk_tuk_availability TO service_role;


--
-- TOC entry 4510 (class 0 OID 0)
-- Dependencies: 371
-- Name: TABLE tuktuk_vehicles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tuktuk_vehicles TO anon;
GRANT ALL ON TABLE public.tuktuk_vehicles TO authenticated;
GRANT ALL ON TABLE public.tuktuk_vehicles TO service_role;


--
-- TOC entry 4511 (class 0 OID 0)
-- Dependencies: 368
-- Name: TABLE tuktuks; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tuktuks TO anon;
GRANT ALL ON TABLE public.tuktuks TO authenticated;
GRANT ALL ON TABLE public.tuktuks TO service_role;


--
-- TOC entry 4512 (class 0 OID 0)
-- Dependencies: 367
-- Name: TABLE user_roles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_roles TO anon;
GRANT ALL ON TABLE public.user_roles TO authenticated;
GRANT ALL ON TABLE public.user_roles TO service_role;


--
-- TOC entry 4513 (class 0 OID 0)
-- Dependencies: 352
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- TOC entry 4514 (class 0 OID 0)
-- Dependencies: 362
-- Name: TABLE messages_2025_07_20; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_20 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_20 TO dashboard_user;


--
-- TOC entry 4515 (class 0 OID 0)
-- Dependencies: 364
-- Name: TABLE messages_2025_07_21; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_21 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_21 TO dashboard_user;


--
-- TOC entry 4516 (class 0 OID 0)
-- Dependencies: 365
-- Name: TABLE messages_2025_07_22; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_22 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_22 TO dashboard_user;


--
-- TOC entry 4517 (class 0 OID 0)
-- Dependencies: 366
-- Name: TABLE messages_2025_07_23; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_23 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_23 TO dashboard_user;


--
-- TOC entry 4518 (class 0 OID 0)
-- Dependencies: 369
-- Name: TABLE messages_2025_07_24; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_24 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_24 TO dashboard_user;


--
-- TOC entry 4519 (class 0 OID 0)
-- Dependencies: 374
-- Name: TABLE messages_2025_07_25; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_25 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_25 TO dashboard_user;


--
-- TOC entry 4520 (class 0 OID 0)
-- Dependencies: 375
-- Name: TABLE messages_2025_07_26; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_26 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_26 TO dashboard_user;


--
-- TOC entry 4521 (class 0 OID 0)
-- Dependencies: 346
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- TOC entry 4522 (class 0 OID 0)
-- Dependencies: 349
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- TOC entry 4523 (class 0 OID 0)
-- Dependencies: 348
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- TOC entry 4525 (class 0 OID 0)
-- Dependencies: 327
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres;


--
-- TOC entry 4527 (class 0 OID 0)
-- Dependencies: 328
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres;


--
-- TOC entry 4528 (class 0 OID 0)
-- Dependencies: 344
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- TOC entry 4529 (class 0 OID 0)
-- Dependencies: 345
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- TOC entry 4530 (class 0 OID 0)
-- Dependencies: 330
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- TOC entry 4531 (class 0 OID 0)
-- Dependencies: 331
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- TOC entry 2507 (class 826 OID 16601)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 2508 (class 826 OID 16602)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 2506 (class 826 OID 16600)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- TOC entry 2517 (class 826 OID 16680)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- TOC entry 2516 (class 826 OID 16679)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- TOC entry 2515 (class 826 OID 16678)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- TOC entry 2520 (class 826 OID 16635)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2519 (class 826 OID 16634)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2518 (class 826 OID 16633)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2512 (class 826 OID 16615)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2514 (class 826 OID 16614)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2513 (class 826 OID 16613)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2499 (class 826 OID 16488)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2500 (class 826 OID 16489)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2498 (class 826 OID 16487)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2502 (class 826 OID 16491)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2497 (class 826 OID 16486)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2501 (class 826 OID 16490)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 2510 (class 826 OID 16605)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 2511 (class 826 OID 16606)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 2509 (class 826 OID 16604)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- TOC entry 2505 (class 826 OID 16543)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2504 (class 826 OID 16542)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2503 (class 826 OID 16541)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- TOC entry 3687 (class 3466 OID 16619)
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- TOC entry 3692 (class 3466 OID 16698)
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- TOC entry 3686 (class 3466 OID 16617)
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- TOC entry 3693 (class 3466 OID 16701)
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- TOC entry 3688 (class 3466 OID 16620)
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- TOC entry 3689 (class 3466 OID 16621)
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

-- Completed on 2025-07-24 16:21:33

--
-- PostgreSQL database dump complete
--

