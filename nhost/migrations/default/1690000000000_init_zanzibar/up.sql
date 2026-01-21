DROP VIEW IF EXISTS public.authz_effective_graph CASCADE;
DROP TABLE IF EXISTS public.invitations CASCADE;
DROP TABLE IF EXISTS public.crm_contacts CASCADE;
DROP TABLE IF EXISTS public.authz_model CASCADE;
DROP TABLE IF EXISTS public.authz_tuples CASCADE;
DROP TABLE IF EXISTS public.tenants CASCADE;

-- 1. Tenants
CREATE TABLE public.tenants (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  name text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- 2. Tuples (The Graph)
CREATE TABLE public.authz_tuples (
  tenant_id uuid NOT NULL REFERENCES public.tenants(id),
  object_ns text NOT NULL,
  object_id uuid NOT NULL,
  relation text NOT NULL,
  subject_id uuid NOT NULL REFERENCES auth.users(id),
  PRIMARY KEY (tenant_id, object_ns, object_id, relation, subject_id)
);

-- 3. Logic Config
CREATE TABLE public.authz_model (
  namespace text NOT NULL,
  relation text NOT NULL,
  computed_from text,
  PRIMARY KEY (namespace, relation, computed_from)
);

-- 4. Recursive Engine
CREATE OR REPLACE VIEW public.authz_effective_graph AS
WITH RECURSIVE graph_walk AS (
    SELECT tenant_id, object_ns, object_id, relation, subject_id
    FROM public.authz_tuples
    UNION ALL
    SELECT g.tenant_id, g.object_ns, g.object_id, m.relation, g.subject_id
    FROM graph_walk g
    JOIN public.authz_model m 
      ON g.object_ns = m.namespace AND g.relation = m.computed_from
)
SELECT DISTINCT * FROM graph_walk;

-- 5. Example Data
CREATE TABLE public.crm_contacts (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  tenant_id uuid NOT NULL REFERENCES public.tenants(id),
  name text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- 6. Invitations
CREATE TABLE public.invitations (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  tenant_id uuid NOT NULL REFERENCES public.tenants(id),
  email text NOT NULL,
  object_ns text NOT NULL,
  object_id uuid NOT NULL,
  relation text NOT NULL,
  invited_by uuid REFERENCES auth.users(id),
  created_at timestamptz DEFAULT now()
);