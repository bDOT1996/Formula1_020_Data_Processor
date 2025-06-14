SELECT
  id,
  name,
  date
FROM {{ ref('example') }}
WHERE date IS NOT NULL;