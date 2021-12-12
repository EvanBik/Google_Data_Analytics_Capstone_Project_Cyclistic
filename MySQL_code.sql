CREATE DATABASE cyclistic_project;
USE cyclistic_project;
DROP TABLE IF EXISTS trips;

CREATE TABLE trips (
ride_type VARCHAR(255), 
start_lat DECIMAL(10,8),
start_lng DECIMAL(11,8),
end_lat DECIMAL(10,8),
end_lng DECIMAL(11,8),
customer_type VARCHAR(255),
ride_minutes DECIMAL(10,2),
ride_day VARCHAR(255),
ride_hour INT, 
part_day VARCHAR(255),
ride_month VARCHAR(255),
ride_season VARCHAR(255)
);

#Add the appropriate path and use the same code for all the csv files, just replace the name of the file
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/trips_202009.csv" 
INTO TABLE trips
FIELDS TERMINATED BY "," ENCLOSED BY '"'
LINES TERMINATED BY "\n"
IGNORE 1 ROWS;

#Check imported data
SELECT COUNT(*) AS Total_Rows, 
SUM(ride_min) AS Total_Ride_Length_Minutes 
FROM trips;

#Summary statistics
SELECT 
customer_type,
COUNT(*) AS total_num,
MAX(ride_minutes) AS Longest_ride,
MIN(ride_minutes) AS Shortest_ride,
AVG(ride_minutes) AS Average_ride 
FROM trips
GROUP BY 1
ORDER BY 2 DESC;

SELECT 
ride_type,
COUNT(*) AS total_type,
MAX(ride_minutes) AS Longest_ride,
MIN(ride_minutes) AS Shortest_ride,
AVG(ride_minutes) AS Average_ride 
FROM trips
GROUP BY 1
ORDER BY 5 DESC;

(SELECT 
customer_type, 
ride_day, 
COUNT(ride_day) AS num_days 
FROM trips
GROUP BY 1,2
HAVING customer_type = "casual"
ORDER BY 3 DESC LIMIT 1)
UNION
(SELECT 
customer_type, 
ride_day, 
COUNT(ride_day) AS num_days 
FROM trips
GROUP BY 1,2
HAVING customer_type = "member"
ORDER BY 3 DESC LIMIT 1);

(SELECT 
customer_type, 
ride_type, 
COUNT(ride_type) AS top_ride_type
FROM trips
GROUP BY 1,2
HAVING customer_type = "casual"
ORDER BY 3 DESC LIMIT 1)
UNION
(SELECT 
customer_type, 
ride_type, 
COUNT(ride_type) AS top_ride_type
FROM trips
GROUP BY 1,2
HAVING customer_type = "member"
ORDER BY 3 DESC LIMIT 1);

(SELECT 
customer_type, 
ride_day, 
COUNT(ride_day) AS top_ride_day
FROM trips
GROUP BY 1,2
HAVING customer_type = "casual"
ORDER BY 3 DESC LIMIT 1)
UNION
(SELECT 
customer_type, 
ride_day, 
COUNT(ride_day) AS top_ride_day
FROM trips
GROUP BY 1,2
HAVING customer_type = "member"
ORDER BY 3 DESC LIMIT 1);

(SELECT 
customer_type, 
part_day, 
COUNT(part_day) AS top_part_day
FROM trips
GROUP BY 1,2
HAVING customer_type = "casual"
ORDER BY 3 DESC LIMIT 1)
UNION
(SELECT 
customer_type, 
part_day, 
COUNT(part_day) AS top_part_day
FROM trips
GROUP BY 1,2
HAVING customer_type = "member"
ORDER BY 3 DESC LIMIT 1);

(SELECT 
customer_type, 
ride_month, 
COUNT(ride_month) AS top_ride_month
FROM trips
GROUP BY 1,2
HAVING customer_type = "casual"
ORDER BY 3 DESC LIMIT 1)
UNION
(SELECT 
customer_type, 
ride_month, 
COUNT(ride_month) AS top_ride_month
FROM trips
GROUP BY 1,2
HAVING customer_type = "member"
ORDER BY 3 DESC LIMIT 1);

(SELECT 
customer_type, 
ride_season, 
COUNT(ride_season) AS top_season
FROM trips
GROUP BY 1,2
HAVING customer_type = "casual"
ORDER BY 3 DESC LIMIT 1)
UNION
(SELECT 
customer_type, 
ride_season, 
COUNT(ride_season) AS top_season
FROM trips
GROUP BY 1,2
HAVING customer_type = "member"
ORDER BY 3 DESC LIMIT 1);

#Export all the dataset to a single csv file
SELECT *
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Tripsclean.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
FROM trips;
