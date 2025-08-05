{% macro safe_divide(numerator, denominator) %}
-- 
-- Makro zwraca null, gdy denominator = 0, inaczej dzieli
--
CASE WHEN {{ denominator }} != 0 THEN {{ numerator }} / {{ denominator }} ELSE NULL END
{% endmacro %}