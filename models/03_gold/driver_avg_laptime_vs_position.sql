-- Gold: korelacja średniego czasu okrążenia z pozycją
WITH avg_laptimes AS (
  SELECT
    driver_number,
    session_key,
    avg(lap_time_seconds) AS avg_lap_time
  FROM {{ ref('clean_laptimes') }}
  GROUP BY driver_number, session_key
),
final_positions AS (
  SELECT
    driver_number,
    session_key,
    position
  FROM {{ ref('clean_positions') }}
  QUALIFY ROW_NUMBER() OVER (
    PARTITION BY driver_number, session_key
    ORDER BY date DESC) = 1
)
SELECT
  a.driver_number,
  a.session_key,
  a.avg_lap_time,
  p.position
FROM avg_laptimes a
JOIN final_positions p
  ON a.driver_number = p.driver_number
 AND a.session_key   = p.session_key