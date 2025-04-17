{% macro show_columns(database_name, schema_name, table_name) %}
  {% set sql %}
    SELECT 
      COLUMN_NAME,
      DATA_TYPE
    FROM 
      {{ database_name }}.INFORMATION_SCHEMA.COLUMNS
    WHERE 
      TABLE_SCHEMA = '{{ schema_name }}'
      AND TABLE_NAME = '{{ table_name }}'
    ORDER BY 
      ORDINAL_POSITION;
  {% endset %}
  
  {% set results = run_query(sql) %}
  
  {% if execute %}
    {% for row in results %}
      {{ log("Column: " ~ row.COLUMN_NAME ~ ", Type: " ~ row.DATA_TYPE, info=True) }}
    {% endfor %}
  {% endif %}
{% endmacro %}

