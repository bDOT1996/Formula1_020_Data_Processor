-- Silver: filtrowanie null i poprawa formatu daty
SELECT
  driver_number,
  session_key,
  position,
  DATE(date) AS date
FROM {{ ref('positions_bronze') }}
WHERE position IS NOT NULL