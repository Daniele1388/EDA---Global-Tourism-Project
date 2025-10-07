/*
====================================================
📔 FILE: Eda - Ranking.sql
PURPOSE: Rank and compare top-performing countries and indicators.
PROJECT: Global Tourism Data Warehouse
====================================================

This script retrieves the Top 10 results by Indicator and Year 
and explores indicator composition for specific countries. 
It supports benchmarking and outlier detection across inbound, outbound, 
and domestic tourism datasets.
*/


-- Retrieves the Top 10 country–indicator values for a given year and unit, ordered by the highest totals

DECLARE @FactViews NVARCHAR(MAX) = N'gold.fact_inbound_tourism'; -- fact_domestic_tourism, fact_inbound_tourism, fact_outbound_tourism, fact_tourism_industries
DECLARE @Year BIGINT = 2015; -- from 1995 to 2022 
DECLARE @Indicator NVARCHAR(MAX) = 'NATIONALS RESIDING ABROAD'; -- see Indicator Dictionary
DECLARE @Unit NVARCHAR(50) = 'THOUSANDS' -- NUMBER, THOUSANDS, US$ MILLIONS
DECLARE @sql NVARCHAR(MAX);

SET @sql = N' 
SELECT TOP 10
	c.Country_name,
	y.Year,
	i.Indicator_name,
	f.Value
FROM '+ @FactViews + N' f
INNER JOIN gold.dim_country c
ON f.Country_key = c.Country_key
INNER JOIN gold.dim_indicator i
ON f.Indicator_key = i.Indicator_key
INNER JOIN gold.dim_year y
ON f.Year_key = y.Year_key
INNER JOIN gold.dim_unit_of_measure m
ON f.Units_key = m.Units_key
WHERE y.Year = @Year AND i.Indicator_name = @Indicator AND m.Measure_Units = @Unit
ORDER BY f.Value DESC;';

EXEC sp_executesql @sql, N'@Year BIGINT, @Indicator NVARCHAR(MAX), @Unit NVARCHAR(50)', @Year=@Year, @Indicator=@Indicator, @Unit=@Unit;


-- Retrieves all inbound tourism indicators for a given country and year (filtered by unit), ordered by value in descending order

DECLARE @FactViews NVARCHAR(MAX) = N'gold.fact_inbound_tourism'; -- fact_domestic_tourism, fact_inbound_tourism, fact_outbound_tourism, fact_tourism_industries
DECLARE @Country NVARCHAR(MAX) = 'india'
DECLARE @Year BIGINT = 2000; -- from 1995 to 2022 
DECLARE @Unit NVARCHAR(50) = 'THOUSANDS' -- NUMBER, THOUSANDS, US$ MILLIONS
DECLARE @sql NVARCHAR(MAX);

SET @sql = N' 
SELECT
	c.Country_name,
	y.Year,
	i.Indicator_name,
	f.Value
FROM '+ @FactViews + N' f
INNER JOIN gold.dim_country c
ON f.Country_key = c.Country_key
INNER JOIN gold.dim_indicator i
ON f.Indicator_key = i.Indicator_key
INNER JOIN gold.dim_year y
ON f.Year_key = y.Year_key
INNER JOIN gold.dim_unit_of_measure m
ON f.Units_key = m.Units_key
WHERE c.Country_name = @Country AND y.Year = @Year AND m.Measure_Units = @Unit
ORDER BY f.Value DESC;';

EXEC sp_executesql @sql, N'@Country NVARCHAR(MAX), @Year BIGINT, @Unit NVARCHAR(50)', @Country=@Country, @Year=@Year, @Unit=@Unit;