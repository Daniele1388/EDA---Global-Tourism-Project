/*
====================================================
📗 FILE: Eda - Dimensions Exploration.sql
PURPOSE: Explore key dimensions across the Gold schema.
PROJECT: Global Tourism Data Warehouse
====================================================

This script retrieves all distinct values for Countries, 
Indicators, Units of Measure, and Years. 
It also counts how many unique keys each Fact view contains 
to validate dimensional consistency across the model.
*/


-- Explore All Countries

SELECT DISTINCT 
	Country_name
FROM gold.dim_country
ORDER BY Country_name

-- Explore All Indicators

SELECT DISTINCT 
	Indicator_name
FROM gold.dim_indicator
ORDER BY Indicator_name

-- Explore All Unit of the Measures

SELECT DISTINCT 
	Measure_Units
FROM gold.dim_unit_of_measure
ORDER BY Measure_Units

-- Explore All Years

SELECT DISTINCT 
	Year
FROM gold.dim_year
ORDER BY Year


-- Count distinct Countries, Indicators, Years, and Units per Fact view 
-- to validate data completeness

DECLARE @FactViews NVARCHAR(MAX) = N'gold.fact_tourism_industries'; -- fact_domestic_tourism, fact_inbound_tourism, fact_outbound_tourism, fact_tourism_industries
DECLARE @sql NVARCHAR(MAX);

SET @sql = N'
SELECT
	COUNT(*) AS Rows,
	COUNT(DISTINCT Country_key) AS n_countries,
	COUNT(DISTINCT Indicator_key) AS n_indicators,
	COUNT(DISTINCT Year_key) AS n_years,
	COUNT(DISTINCT Units_key) AS n_units
FROM '+ @FactViews + N'; ';

EXEC sp_executesql @sql;


SELECT 
	COUNT(*) AS Rows_sdg,
	COUNT(DISTINCT Country_key) AS n_countries,
	COUNT(DISTINCT Year_key) AS n_years,
	COUNT(DISTINCT Units_key) AS n_units
FROM gold.fact_sdg -- fact_sdg does not have the column 'Indicator_key', so we run this query separately



