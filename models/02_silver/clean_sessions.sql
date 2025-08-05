-- Silver: oczyszczanie kolumn daty i filtracja null
SELECT
  session_key,
  circuit_key,
  session_name,
  DATE(date_start) AS date_start,
  DATE(date_end) AS date_end,
  year
FROM {{ ref('sessions_bronze') }}
WHERE session_key IS NOT NULL