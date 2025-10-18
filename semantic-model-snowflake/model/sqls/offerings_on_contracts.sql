SELECT
  offering_id,
  contract_id,
  assignedat,
  offer_value,
  offer_cost,
  concat(cast(offering_id as varchar), '-', cast(contract_id as varchar)) as unique_id
FROM
  DATAOS.public.offerings_on_contract
  
