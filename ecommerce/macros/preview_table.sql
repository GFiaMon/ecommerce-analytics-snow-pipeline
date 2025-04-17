{% macro preview_table(table_name) %}
  {% set sql %}
    SELECT * FROM {{ table_name }} LIMIT 1;
  {% endset %}
  
  {% set results = run_query(sql) %}
  
  {% if execute %}
    {% set column_names = results.column_names %}
    {{ log("Column names: " ~ column_names, info=True) }}
    
    {% for row in results %}
      {% for col in column_names %}
        {{ log(col ~ ": " ~ row[col], info=True) }}
      {% endfor %}
    {% endfor %}
  {% endif %}
{% endmacro %}

