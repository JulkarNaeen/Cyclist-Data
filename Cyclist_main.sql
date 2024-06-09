CREATE TABLE ride(
    ride_id VARCHAR(50),
    rideable_type VARCHAR(20),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(100),
    start_station_id VARCHAR(50),
    end_station_name VARCHAR(100),
    end_station_id VARCHAR(50),
    start_lat DECIMAL(9, 6),
    start_lng DECIMAL(9, 6),
    end_lat DECIMAL(9, 6),
    end_lng DECIMAL(9, 6),
    member_casual VARCHAR(10),
    ride_length TIME
);

#Total Number of Rides
SELECT COUNT(*) AS total_rides
FROM ride;

#Average Ride Length
SELECT AVG(TIME_TO_SEC(ride_length)) / 60 AS avg_ride_length_minutes
FROM ride;

# Number of Rides by Day of the Week
SELECT DAYOFWEEK(started_at) AS day_of_week, COUNT(*) AS number_of_rides
FROM ride
GROUP BY day_of_week
ORDER BY day_of_week;

#Number of Rides by Rideable Type
SELECT rideable_type, COUNT(*) AS number_of_rides
FROM ride
GROUP BY rideable_type
ORDER BY number_of_rides DESC;

# Number of Rides by Membership Type
SELECT member_casual, COUNT(*) AS number_of_rides
FROM ride
GROUP BY member_casual
ORDER BY number_of_rides DESC;

#Creating a Summary Table
CREATE TABLE ride_summary (
    summary_type VARCHAR(50),
    summary_value DECIMAL(10, 2)
);

#Inserting Summary Statistics into the Summary Table

#Total Number of Rides

INSERT INTO ride_summary (summary_type, summary_value)
SELECT 'Total Number of Rides', COUNT(*)
FROM ride;

#Average Ride Length
INSERT INTO ride_summary (summary_type, summary_value)
SELECT 'Average Ride Length (minutes)', AVG(TIME_TO_SEC(ride_length)) / 60
FROM ride;

#Number of Rides by ridable type
INSERT INTO ride_summary (summary_type, summary_value)
SELECT CONCAT('Rides of Type ', rideable_type), COUNT(*)
FROM ride
GROUP BY rideable_type;

CREATE TABLE IF NOT EXISTS ride_trends (
    trend_description VARCHAR(255),
    trend_value DECIMAL(10, 2)
);

#Ride Frequency by Day of the Week
INSERT INTO ride_trends (trend_description, trend_value)
SELECT CONCAT('Rides on Day ', day_of_week), COUNT(*)
FROM ride
GROUP BY day_of_week;

#Number of Rides by Membership Type
INSERT INTO ride_summary (summary_type, summary_value)
SELECT CONCAT('Rides by ', member_casual), COUNT(*)
FROM ride
GROUP BY member_casual;

CREATE TABLE ride_trends (
    trend_description VARCHAR(100),
    trend_value DECIMAL(10, 2)
);

#Investigate Trends
#Ride Frequency by Day of the Week
INSERT INTO ride_trends (trend_description, trend_value)
SELECT CONCAT('Rides on Day ', day_of_week), COUNT(*)
FROM ride
GROUP BY day_of_week;

ALTER TABLE ride
ADD COLUMN day_of_week INT;


#2. Ride Frequency by Hour of Day
INSERT INTO ride_trends (trend_description, trend_value)
SELECT CONCAT('Rides at Hour ', HOUR(started_at)), COUNT(*)
FROM ride
GROUP BY HOUR(started_at);


    
#Average Ride Length for Members vs. Casual Riders
INSERT INTO ride_trends (trend_description, trend_value)
SELECT CONCAT('Average Ride Length for ', member_casual), AVG(TIME_TO_SEC(ride_length)) / 60
FROM ride
GROUP BY member_casual;

#4. Most Popular Start Stations
INSERT INTO ride_trends (trend_description, trend_value)
SELECT CONCAT('Rides starting at ', start_station_name), COUNT(*)
FROM ride
GROUP BY start_station_name
ORDER BY COUNT(*) DESC
LIMIT 10;

#5. Most Popular End Stations

INSERT INTO ride_trends (trend_description, trend_value)
SELECT CONCAT('Rides ending at ', end_station_name), COUNT(*)
FROM ride
GROUP BY end_station_name
ORDER BY COUNT(*) DESC
LIMIT 10;

#6. Total Number of Rides
INSERT INTO ride_trends (trend_description, trend_value)
SELECT 'Total Number of Rides', COUNT(*)
FROM ride;

#7. Total Number of Rides by Rideable Type
INSERT INTO ride_trends (trend_description, trend_value)
SELECT CONCAT('Total Rides of Type ', rideable_type), COUNT(*)
FROM ride
GROUP BY rideable_type;

#8. Total Number of Rides by Membership Type

INSERT INTO ride_trends (trend_description, trend_value)
SELECT CONCAT('Total Rides by ', member_casual), COUNT(*)
FROM ride
GROUP BY member_casual;




