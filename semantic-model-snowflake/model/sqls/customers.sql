SELECT
  industry,
  region,
  account_manager,
  engagement_level,
  STATUS,
  CAST(discovery_session_start_date AS TIMESTAMP) AS discovery_session_start_date,
  total_discovery_sessions_conducted,
  CAST(last_discovery_session_conducted_date AS TIMESTAMP) AS last_discovery_session_conducted_date,
  catalog_address,
  CAST(created_at AS TIMESTAMP) AS created_at,
  id,
  name,
  TYPE,
  CAST(updated_at AS TIMESTAMP) AS updated_at
FROM
  DATAOS.public.customer
  
  
