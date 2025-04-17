-- macros/dim_time.sql

{% macro generate_dates_dimension(start_date) %}

WITH dates AS (
  SELECT 
    DATEADD(day, SEQ4(), '{{ start_date }}'::DATE) AS date
  FROM 
    TABLE(GENERATOR(ROWCOUNT => 10000))
),
dates_fin AS( 
SELECT 
  date AS Calendar_Date,
  EXTRACT(DAYOFWEEK FROM date) as Day_Of_Week,
  TO_CHAR(date,'DY') as Day_Of_Week_Name,
  DATE_TRUNC('WEEK', date) AS Cal_Week_Start_Date, 
  EXTRACT(DAY FROM date) AS Day_Of_Month,
  EXTRACT(MONTH FROM date) AS Cal_Month,
  TO_CHAR(date,'MMMM') AS Cal_Mon_Name,
  TO_CHAR(date,'MON') AS Cal_Mon_Name_Short,
  EXTRACT(quarter FROM date) AS Cal_Quarter,
  CONCAT('Q',EXTRACT(quarter FROM date)) AS Cal_Quarter_Name,
  EXTRACT(year FROM date) AS Cal_Year,
  CASE EXTRACT(DAYOFWEEK FROM date)
    WHEN 6 THEN TRUE
    WHEN 7 THEN TRUE
    ELSE FALSE
  END AS Is_Weekend,
FROM 
  dates
WHERE
  date <= DATEADD(MONTH, 12, CURRENT_DATE()) -- including 12 months in the future for forecasting purpose
)
SELECT 
  ROW_NUMBER() OVER (ORDER BY Calendar_Date) AS date_id,
  Calendar_Date,
  Day_Of_Week,
  Day_Of_Week_Name,
  Cal_Week_Start_Date,
  Day_Of_Month,
  Cal_Month,
  Cal_Mon_Name,
  Cal_Mon_Name_Short,
  Cal_Quarter,
  Cal_Quarter_Name,
  Cal_Year,
  Is_Weekend

FROM dates_fin

{% endmacro %}
