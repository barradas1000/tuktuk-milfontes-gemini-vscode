-- Policy for conductors to update their own is_active status
CREATE POLICY "Conductors can update their own is_active status"
  ON public.conductors
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE profiles.id = auth.uid()
      AND (profiles.role = 'condutor' OR profiles.role = 'admin')
      AND profiles.conductor_id = conductors.id
    )
  );
