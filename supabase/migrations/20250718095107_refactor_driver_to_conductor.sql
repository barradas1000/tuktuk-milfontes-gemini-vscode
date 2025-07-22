
-- 1. Renomear a tabela drivers para conductor_locations
ALTER TABLE IF EXISTS public.drivers RENAME TO conductor_locations;

-- 2. Adicionar a coluna conductor_id e remover colunas desnecessárias
ALTER TABLE public.conductor_locations
  ADD COLUMN IF NOT EXISTS conductor_id UUID REFERENCES public.conductors(id),
  DROP COLUMN IF EXISTS name,
  DROP COLUMN IF EXISTS is_active;

-- 3. Atualizar as políticas RLS
DROP POLICY IF EXISTS "Public can view driver location" ON public.conductor_locations;
DROP POLICY IF EXISTS "Admins can update drivers" ON public.conductor_locations;
DROP POLICY IF EXISTS "Admins can insert drivers" ON public.conductor_locations;

CREATE POLICY "Public can view conductor location"
  ON public.conductor_locations
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Conductors can update their own location"
  ON public.conductor_locations
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = auth.uid()
      AND profiles.conductor_id = conductor_locations.conductor_id
    )
  );

CREATE POLICY "Admins can manage conductor locations"
  ON public.conductor_locations
  FOR ALL
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role = 'admin'
    )
  );

-- 4. Remover scripts de teste antigos
-- Os ficheiros em scripts/ devem ser eliminados manualmente.
