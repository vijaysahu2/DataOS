SELECT
  lead_contact_person,
  core_capabilities,
  competency_area,
  CAST(created_at AS TIMESTAMP) AS created_at,
  id,
  name,
  CAST(updated_at AS TIMESTAMP) AS updated_at
FROM
 DATAOS.public.practice_data

