-- Silver: standaryzacja nazwisk i usunięcie null
SELECT
  driver_number,
  lower(full_name) AS full_name,
  team_name,
  session_key
FROM {{ ref('drivers_bronze') }}
WHERE driver_number IS NOT NULL