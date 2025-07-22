-- Policies for public.conductors
CREATE POLICY "Conductors can view their own conductor profile"
  ON public.conductors
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = auth.uid()
      AND (profiles.role = 'condutor' OR profiles.role = 'admin')
      AND profiles.conductor_id = conductors.id
    )
  );

-- Policies for public.active_conductors
CREATE POLICY "Conductors can view their own active status"
  ON public.active_conductors
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = auth.uid()
      AND (profiles.role = 'condutor' OR profiles.role = 'admin')
      AND profiles.conductor_id = active_conductors.conductor_id
    )
  );

CREATE POLICY "Conductors can insert their own active status"
  ON public.active_conductors
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = auth.uid()
      AND (profiles.role = 'condutor' OR profiles.role = 'admin')
      AND profiles.conductor_id = active_conductors.conductor_id
    )
  );

CREATE POLICY "Conductors can update their own active status"
  ON public.active_conductors
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = auth.uid()
      AND (profiles.role = 'condutor' OR profiles.role = 'admin')
      AND profiles.conductor_id = active_conductors.conductor_id
    )
  );

-- Policies for public.blocked_periods
CREATE POLICY "Conductors can view their own blocked periods"
  ON public.blocked_periods
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = auth.uid()
      AND (profiles.role = 'condutor' OR profiles.role = 'admin')
      AND blocked_periods.created_by = (SELECT name FROM public.conductors WHERE id = (SELECT conductor_id FROM public.profiles WHERE id = auth.uid()))
    )
  );

CREATE POLICY "Conductors can insert their own blocked periods"
  ON public.blocked_periods
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = auth.uid()
      AND (profiles.role = 'condutor' OR profiles.role = 'admin')
      AND blocked_periods.created_by = (SELECT name FROM public.conductors WHERE id = (SELECT conductor_id FROM public.profiles WHERE id = auth.uid()))
    )
  );

CREATE POLICY "Conductors can delete their own blocked periods"
  ON public.blocked_periods
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = auth.uid()
      AND (profiles.role = 'condutor' OR profiles.role = 'admin')
      AND blocked_periods.created_by = (SELECT name FROM public.conductors WHERE id = (SELECT conductor_id FROM public.profiles WHERE id = auth.uid()))
    )
  );

-- Policies for public.reservations
CREATE POLICY "Conductors can view reservations assigned to them"
  ON public.reservations
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = auth.uid()
      AND (profiles.role = 'condutor' OR profiles.role = 'admin')
      AND reservations.assigned_conductor_id = profiles.conductor_id
    )
  );
