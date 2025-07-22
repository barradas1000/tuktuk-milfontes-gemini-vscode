-- Implementar Sistema de Permissões Granulares para Admins
-- Data: 21/07/2025
-- Objetivo: Controlar melhor as permissões de admin sobre condutores

-- 1. Criar enum para níveis de admin
CREATE TYPE admin_level AS ENUM ('super_admin', 'admin_regional', 'admin_local');

-- 2. Adicionar colunas à tabela profiles para controle granular
ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS admin_level admin_level DEFAULT 'admin_local',
ADD COLUMN IF NOT EXISTS region VARCHAR(100),
ADD COLUMN IF NOT EXISTS permissions JSONB DEFAULT '{}',
ADD COLUMN IF NOT EXISTS created_by UUID REFERENCES auth.users(id),
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW();

-- 3. Criar tabela de auditoria para mudanças de status de condutores
CREATE TABLE IF NOT EXISTS public.conductor_status_audit (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  conductor_id UUID NOT NULL REFERENCES public.conductors(id),
  changed_by UUID NOT NULL REFERENCES auth.users(id),
  previous_status BOOLEAN,
  new_status BOOLEAN NOT NULL,
  reason TEXT,
  region VARCHAR(100),
  admin_level admin_level,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  metadata JSONB DEFAULT '{}'
);

-- 4. Adicionar região aos condutores
ALTER TABLE public.conductors 
ADD COLUMN IF NOT EXISTS region VARCHAR(100) DEFAULT 'milfontes',
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
ADD COLUMN IF NOT EXISTS updated_by UUID REFERENCES auth.users(id);

-- 5. Função para verificar permissões de admin
CREATE OR REPLACE FUNCTION check_admin_permissions(
  target_conductor_id UUID,
  admin_user_id UUID
) RETURNS BOOLEAN AS $$
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
  
  -- Buscar região do condutor
  SELECT region INTO conductor_region 
  FROM public.conductors 
  WHERE id = target_conductor_id;
  
  -- Admin regional pode gerenciar condutores da sua região
  IF admin_profile.admin_level = 'admin_regional' THEN
    RETURN admin_profile.region = conductor_region;
  END IF;
  
  -- Admin local só pode gerenciar condutores da mesma região
  IF admin_profile.admin_level = 'admin_local' THEN
    RETURN admin_profile.region = conductor_region;
  END IF;
  
  RETURN FALSE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 6. Função para registrar mudanças de status
CREATE OR REPLACE FUNCTION log_conductor_status_change() RETURNS TRIGGER AS $$
DECLARE
  admin_profile public.profiles;
BEGIN
  -- Buscar perfil do admin que fez a mudança
  SELECT * INTO admin_profile 
  FROM public.profiles 
  WHERE id = auth.uid();
  
  -- Registrar a mudança se o status mudou
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
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 7. Criar trigger para auditoria
DROP TRIGGER IF EXISTS conductor_status_audit_trigger ON public.conductors;
CREATE TRIGGER conductor_status_audit_trigger
  BEFORE UPDATE ON public.conductors
  FOR EACH ROW
  EXECUTE FUNCTION log_conductor_status_change();

-- 8. Atualizar política RLS para conductors com controle granular
DROP POLICY IF EXISTS "Admins can update conductors" ON public.conductors;
CREATE POLICY "Admins can update conductors with permission check"
  ON public.conductors
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles 
      WHERE profiles.id = auth.uid() 
      AND profiles.role = 'admin'
      AND check_admin_permissions(conductors.id, auth.uid())
    )
  );

-- 9. Política para visualizar condutores baseada em região
DROP POLICY IF EXISTS "Admins can view all conductors" ON public.conductors;
CREATE POLICY "Admins can view conductors by region"
  ON public.conductors
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles 
      WHERE profiles.id = auth.uid() 
      AND profiles.role = 'admin'
      AND (
        profiles.admin_level = 'super_admin' OR
        profiles.region = conductors.region OR
        profiles.region IS NULL
      )
    )
  );

-- 10. Política para auditoria - apenas super admins podem ver tudo
CREATE POLICY "Admins can view audit logs"
  ON public.conductor_status_audit
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles 
      WHERE profiles.id = auth.uid() 
      AND profiles.role = 'admin'
      AND (
        profiles.admin_level = 'super_admin' OR
        profiles.id = conductor_status_audit.changed_by
      )
    )
  );

-- 11. Habilitar RLS na tabela de auditoria
ALTER TABLE public.conductor_status_audit ENABLE ROW LEVEL SECURITY;

-- 12. Inserir dados iniciais - definir você como super admin
UPDATE public.profiles 
SET 
  admin_level = 'super_admin',
  region = 'milfontes',
  permissions = jsonb_build_object(
    'can_manage_all_conductors', true,
    'can_view_audit_logs', true,
    'can_create_admins', true,
    'can_delete_conductors', true
  ),
  updated_at = NOW()
WHERE email = 'carlosbarradas111@gmail.com' AND role = 'admin';

-- 13. Atualizar condutores existentes com região padrão
UPDATE public.conductors 
SET 
  region = 'milfontes',
  updated_at = NOW()
WHERE region IS NULL;

-- 14. Comentários e documentação
COMMENT ON TYPE admin_level IS 'Níveis de administrador: super_admin (acesso total), admin_regional (região específica), admin_local (área local)';
COMMENT ON FUNCTION check_admin_permissions IS 'Verifica se um admin tem permissão para modificar um condutor específico';
COMMENT ON TABLE conductor_status_audit IS 'Log de auditoria para mudanças de status de condutores';
COMMENT ON COLUMN profiles.admin_level IS 'Nível de permissão do administrador';
COMMENT ON COLUMN profiles.region IS 'Região de responsabilidade do administrador';
COMMENT ON COLUMN profiles.permissions IS 'Permissões específicas em formato JSON';
