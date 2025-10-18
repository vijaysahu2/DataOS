SELECT
  practice_id,
  CAST(created_at AS TIMESTAMP) AS created_at,
  id,
  maturity_level,
  name,
  oproof_point_evidences,
  pade_environment,
  STATUS,
  TYPE,
  CAST(updated_at AS TIMESTAMP) AS updated_at
FROM
  DATAOS.public.offerings
  
  
  
