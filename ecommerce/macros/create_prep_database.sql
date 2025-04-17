{% macro create_prep_database() %}
  {% set sql %}
    CREATE DATABASE IF NOT EXISTS PREP;
  {% endset %}
  
  {% do run_query(sql) %}
  
  {{ log("PREP database created", info=True) }}
{% endmacro %}

