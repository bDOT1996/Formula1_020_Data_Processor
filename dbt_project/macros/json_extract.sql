{% macro json_extract(path, column) %}
  json_extract({{ column }}, '{{ path }}')
{% endmacro %}