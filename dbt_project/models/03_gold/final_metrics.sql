{{ config(materialized='table') }}

SELECT
  city,
  COUNT(*) as resident_count,
  AVG(age) as average_age
FROM {{ ref('stg_sample') }}
GROUP BY city