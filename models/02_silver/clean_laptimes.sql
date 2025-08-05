-- Silver: oczyszczone czasy okrążeń
SELECT
  driver_number,
  session_key,
  CAST(lap_time_ms AS DOUBLE) / 1000.0 AS lap_time_seconds,
  lap_number
FROM {{ ref('positions_bronze') }}
WHERE lap_time_ms IS NOT NULL
