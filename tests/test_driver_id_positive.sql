-- Sprawdza, czy driver_number w clean_drivers zawsze > 0
SELECT *
FROM {{ ref('clean_drivers') }}
WHERE driver_number <= 0