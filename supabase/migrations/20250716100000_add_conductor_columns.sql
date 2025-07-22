-- Add conductor_id to profiles table
ALTER TABLE public.profiles
ADD COLUMN conductor_id UUID REFERENCES public.conductors(id);

-- Add assigned_conductor_id to reservations table
ALTER TABLE public.reservations
ADD COLUMN assigned_conductor_id UUID REFERENCES public.conductors(id);

-- Optionally, if you want to set a default value for existing rows, or make it NOT NULL later:
-- UPDATE public.profiles SET conductor_id = NULL WHERE conductor_id IS NULL;
-- UPDATE public.reservations SET assigned_conductor_id = NULL WHERE assigned_conductor_id IS NULL;