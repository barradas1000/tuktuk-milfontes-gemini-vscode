-- Remove broad RLS policies from reservations table
DROP POLICY IF EXISTS "Enable read access for all users" ON reservations;
DROP POLICY IF EXISTS "Enable insert for all users" ON reservations;
DROP POLICY IF EXISTS "Enable update for all users" ON reservations;