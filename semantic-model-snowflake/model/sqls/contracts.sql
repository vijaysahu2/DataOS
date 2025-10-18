SELECT
  program_name,
  program_manager,
  contract_number,
  STATUS,
  ongoing_support_details,
  contract_value,
  customerid,
  CAST(end_date AS TIMESTAMP) AS end_date,
  id,
  CAST(start_date AS TIMESTAMP) AS start_date,
  TYPE,
  CAST(updated_at AS TIMESTAMP) AS updated_at
FROM
  DATAOS.public.contracts
  



