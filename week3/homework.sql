-- Preparation
CREATE OR REPLACE EXTERNAL TABLE `ny_taxi.external_green_tripdata`
OPTIONS (
  format = 'parquet',
  uris = ['gs://mage-zoomcamp-fdireito-eu/green_taxi_2022/lpep_pickup_date=2022*']
);

CREATE OR REPLACE TABLE ny_taxi.green_taxi_tripdata_2022 AS
SELECT * FROM ny_taxi.external_green_tripdata;

ALTER TABLE `ny_taxi.green_taxi_tripdata_2022`
ADD COLUMN lpep_pickup_date DATE;

UPDATE `ny_taxi.green_taxi_tripdata_2022`
SET lpep_pickup_date = DATE(TIMESTAMP_MICROS(CAST(lpep_pickup_datetime / 1000 AS INT64)))
WHERE TRUE;

select column_name, data_type
from `pivotal-bonbon-411719.ny_taxi.INFORMATION_SCHEMA.COLUMNS`
where table_name = 'green_taxi_tripdata_2022'
order by ordinal_position;

SELECT *
FROM ny_taxi.green_taxi_tripdata_2022
LIMIT 50;

-- Question 1
SELECT COUNT(*)
FROM ny_taxi.external_green_tripdata;

-- Question 2
SELECT COUNT(DISTINCT pulocation_id)
FROM ny_taxi.external_green_tripdata;

SELECT COUNT(DISTINCT pulocation_id)
FROM ny_taxi.green_taxi_tripdata_2022;

--Question 3
SELECT COUNT(*)
FROM  ny_taxi.external_green_tripdata
WHERE fare_amount = 0;

--Question 4
CREATE OR REPLACE TABLE ny_taxi.green_taxi_tripdata_2022_partition_clustereed
PARTITION BY lpep_pickup_date
CLUSTER BY pulocation_id AS
SELECT * FROM ny_taxi.green_taxi_tripdata_2022;

--Question 5
SELECT DISTINCT pulocation_id
FROM ny_taxi.green_taxi_tripdata_2022_partition_clustereed
WHERE DATE(lpep_pickup_date) BETWEEN '2022-06-01' AND '2022-06-30';

SELECT DISTINCT pulocation_id
FROM ny_taxi.green_taxi_tripdata_2022
WHERE DATE(lpep_pickup_date) BETWEEN '2022-06-01' AND '2022-06-30';