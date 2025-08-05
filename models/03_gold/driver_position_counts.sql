SELECT
  driver_number,
  position,
  COUNT(*) AS position_count
FROM {{ ref('clean_positions') }}
GROUP BY driver_number, position
ORDER BY driver_number, position