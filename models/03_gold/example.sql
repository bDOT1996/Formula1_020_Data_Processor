SELECT
  name,
  COUNT(*) as race_count
FROM {{ ref('example') }}
GROUP BY name;