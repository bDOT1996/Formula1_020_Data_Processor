{{ config(materialized='view') }}

SELECT
  id,
  name,
  age,
  city
FROM read_json_auto('/app/data/sample_data.json')