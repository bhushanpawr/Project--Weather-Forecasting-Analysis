CREATE DATABASE HiCounselor;

USE HiCounselor;

# drop column
ALTER TABLE WEATHER_CLEANED DROP MyUnknownColumn;

# rename column 
ALTER TABLE  WEATHER_CLEANED RENAME COLUMN DATE TO  curr_date;

# change datatype
ALTER TABLE WEATHER_CLEANED MODIFY COLUMN curr_date date;


# 1. Give the count of the minimum number of days for the time when temperature reduced

SELECT COUNT(distinct(curr_date))FROM WEATHER_CLEANED
WHERE Minimum_temperature_Â°F <31.22
ORDER BY Minimum_temperature_Â°F ;

-------------------------------------------------------------------------------------------------------------------------------------------

# 2. Find the temperature as Cold / hot by using the case and avg of values of the given data set
SELECT AVG(Temperature) FROM WEATHER_CLEANED;
SELECT temperature,curr_date,
CASE
    WHEN Temperature<44 THEN 'COLD'
    WHEN Temperature>=44 THEN'HOT'
END AS HOT_OR_COLD
FROM WEATHER_CLEANED;


-------------------------------------------------------------------------------------------------------------------------------------------

# 3. Can you check for all 4 consecutive days when the temperature was below 30 Fahrenheit

WITH cte AS (
  SELECT curr_date, Temperature
  FROM weather_cleaned
  where Temperature<30
)
SELECT curr_date, Temperature
FROM cte
WHERE Temperature<30 and curr_date BETWEEN (SELECT MIN(curr_date) FROM cte) AND DATE_ADD((SELECT MIN(curr_date) FROM cte), INTERVAL 4 DAY);


-------------------------------------------------------------------------------------------------------------------------------------------

# 4. Can you find the maximum number of days for which temperature dropped
SELECT COUNT(Temperature) FROM  WEATHER_CLEANED WHERE Temperature<0;


-------------------------------------------------------------------------------------------------------------------------------------------
# 5. Can you find the average of average humidity from the dataset 
SELECT AVG(`Average_humidity_%`) FROM WEATHER_CLEANED;


-------------------------------------------------------------------------------------------------------------------------------------------
# 6. Use the GROUP BY clause on the Date column and make a query to fetch details for average windspeed ( which is now windspeed done in task 3 )

SELECT Average_gustspeed_mph,curr_date
 FROM WEATHER_CLEANED 
 GROUP BY CURR_DATE;

------------------------------------------------------------------------------------------------------------------------------------------
# ( NOTE: data consistency and uniformity should be maintained )
# 8. If the maximum gust speed increases from 55mph, fetch the details for the next 4 days

SELECT Maximum_gust_speed_mph,curr_date FROM WEATHER_CLEANED
 WHERE Maximum_gust_speed_mph>55
 order by curr_date
 limit 4;



-------------------------------------------------------------------------------------------------------------------------------------------
# 9. Find the number of days when the temperature went below 0 degrees Celsius

SELECT COUNT(Temperature) FROM WEATHER_CLEANED WHERE Temperature<0;

-------------------------------------------------------------------------------------------------------------------------------------------
# 10. Create another table with a “Foreign key” relation with the existing given data set.

alter table WEATHER_CLEANED add primary key (curr_date);

CREATE TABLE TABLE2 
( new_date DATE primary key,
 temperature float(2,2) ,
 month_name varchar(255),
FOREIGN KEY (new_date) REFERENCES weather_cleaned(curr_date)
 );