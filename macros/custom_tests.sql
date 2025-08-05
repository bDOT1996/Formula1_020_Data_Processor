{% test test_lap_time_reasonable(model, column_name) %}
-- 
-- Testuje czy wartości czasu okrążenia mieszczą się w realistycznych granicach
--
SELECT *
FROM {{ model }}
WHERE {{ column_name }} < 50 OR {{ column_name }} > 180
{% endtest %}