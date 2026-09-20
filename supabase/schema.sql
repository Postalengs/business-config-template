-- Generic business configuration starter for Supabase.
-- This contains placeholder data only.

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS public.business_config (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  config_key text NOT NULL UNIQUE DEFAULT 'default',
  business_name text NOT NULL DEFAULT 'Example Business',
  phone text,
  email text,
  logo_url text,
  primary_color text NOT NULL DEFAULT '#111827',
  secondary_color text NOT NULL DEFAULT '#6B7280',
  accent_color text NOT NULL DEFAULT '#2563EB',
  default_location text,
  extras jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

INSERT INTO public.business_config (
  config_key,
  business_name,
  phone,
  email,
  logo_url,
  default_location
)
VALUES (
  'default',
  'Example Business',
  '(555) 555-0100',
  'hello@example.com',
  '/logo-placeholder.svg',
  'Main Location'
)
ON CONFLICT (config_key) DO NOTHING;

CREATE OR REPLACE FUNCTION public.set_business_config_updated_at()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS business_config_updated_at ON public.business_config;

CREATE TRIGGER business_config_updated_at
BEFORE UPDATE ON public.business_config
FOR EACH ROW
EXECUTE FUNCTION public.set_business_config_updated_at();

ALTER TABLE public.business_config ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "business config public read" ON public.business_config;

CREATE POLICY "business config public read"
ON public.business_config
FOR SELECT
USING (true);

GRANT SELECT ON public.business_config TO anon;
