-- Drop the existing admin policy as it was incomplete for INSERT/UPDATE
DROP POLICY IF EXISTS "Admins can manage all conductors" ON active_conductors;

-- Policy for INSERT: Admins can insert any active_conductors record
CREATE POLICY "Admins can insert any active_conductors record"
ON active_conductors FOR INSERT
TO authenticated
WITH CHECK ((auth.jwt() ->> 'user_metadata')::jsonb ->> 'role' = 'admin');

-- Policy for UPDATE: Admins can update any active_conductors record
CREATE POLICY "Admins can update any active_conductors record"
ON active_conductors FOR UPDATE
TO authenticated
USING ((auth.jwt() ->> 'user_metadata')::jsonb ->> 'role' = 'admin');

-- Policy for SELECT: Admins can view all active_conductors records
CREATE POLICY "Admins can view all active_conductors records"
ON active_conductors FOR SELECT
TO authenticated
USING ((auth.jwt() ->> 'user_metadata')::jsonb ->> 'role' = 'admin');
