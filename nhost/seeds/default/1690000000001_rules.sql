INSERT INTO public.authz_model (namespace, relation, computed_from) VALUES
('crm_contact', 'viewer', 'editor'),
('crm_contact', 'editor', 'owner'),
('crm_contact', 'owner', 'null')
ON CONFLICT DO NOTHING;