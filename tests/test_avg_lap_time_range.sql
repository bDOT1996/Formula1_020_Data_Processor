-- Sprawdza, czy avg_lap_time w modelu driver_avg_laptime_vs_position jest w [50,180]
SELECT *
FROM {{ ref('driver_avg_laptime_vs_position') }}
WHERE avg_lap_time < 50 OR avg_lap_time > 180