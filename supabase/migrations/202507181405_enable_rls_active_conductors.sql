-- Enable RLS for active_conductors table
ALTER TABLE active_conductors ENABLE ROW LEVEL SECURITY;

-- Create policy for INSERT
CREATE POLICY "Conductors can insert their own active status" 
ON active_conductors FOR INSERT
TO authenticated
WITH CHECK (conductor_id = auth.uid());

-- Create policy for UPDATE  
CREATE POLICY "Conductors can update their own active status"
ON active_conductors FOR UPDATE
TO authenticated
USING (conductor_id = auth.uid());

-- Create policy for SELECT
CREATE POLICY "Conductors can view their own active status" 
ON active_conductors FOR SELECT
TO authenticated
USING (conductor_id = auth.uid());

-- Additional policy for admin access
CREATE POLICY "Admins can manage all conductors"
ON active_conductors
TO authenticated
USING (auth.role() = 'admin');