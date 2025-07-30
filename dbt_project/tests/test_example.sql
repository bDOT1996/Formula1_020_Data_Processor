SELECT *
FROM {{ ref('example') }}
WHERE date IS NULL;