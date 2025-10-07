/*
====================================================
📕 FILE: Eda - Magnitude Analysis.sql
PURPOSE: Quantify and compare data magnitudes across dimensions.
PROJECT: Global Tourism Data Warehouse
====================================================

This script calculates total values by Indicator, Country, and Year 
to assess data scale and identify dominant contributors. 
It also retrieves yearly distributions and specific country-level trends.
Ideal for understanding the relative weight of each tourism component.
*/


-- Find Total Values for each Indicator in Fact Views

DECLARE @FactViews NVARCHAR(MAX) = N'gold.fact_domestic_tourism'; -- fact_domestic_tourism, fact_inbound_tourism, fact_outbound_tourism, fact_tourism_industries
DECLARE @Unit NVARCHAR(50) = 'US$ MILLIONS' -- NUMBER, THOUSANDS, US$ MILLIONS
DECLARE @sql NVARCHAR(MAX);

SET @sql = N'
SELECT
	f.Indicator_key,
	i.Indicator_name,
	m.Measure_Units,
	SUM(f.Value) AS TotValue_Indicator
FROM '+ @FactViews + N' f
INNER JOIN gold.dim_indicator i
ON f.Indicator_key = i.Indicator_key
INNER JOIN gold.dim_unit_of_measure m
ON f.Units_key = m.Units_key
WHERE m.Measure_Units = @Unit
GROUP BY f.Indicator_key,
	     i.Indicator_name,
	     m.Measure_Units
ORDER BY SUM(f.Value) DESC;';

EXEC sp_executesql @sql, N'@Unit NVARCHAR(50)', @Unit=@Unit;


-- Find Total Values for each Country in Fact Views

DECLARE @FactViews NVARCHAR(MAX) = N'gold.fact_outbound_tourism'; -- fact_domestic_tourism, fact_inbound_tourism, fact_outbound_tourism, fact_sdg, fact_tourism_industries
DECLARE @Unit NVARCHAR(50) = 'US$ MILLIONS' -- NUMBER, THOUSANDS, US$ MILLIONS
DECLARE @sql NVARCHAR(MAX);

SET @sql = N'
SELECT
	f.Country_key,
	c.Country_name,
	m.Measure_Units,
	SUM(f.Value) AS TotValue_Country
FROM '+ @FactViews + N' f
INNER JOIN gold.dim_country c
ON f.Country_key = c.Country_key
INNER JOIN gold.dim_unit_of_measure m
ON f.Units_key = m.Units_key
WHERE m.Measure_Units = @Unit
GROUP BY f.Country_key, c.Country_name, m.Measure_Units
ORDER BY SUM(f.Value) DESC;';

EXEC sp_executesql @sql, N'@Unit NVARCHAR(50)', @Unit=@Unit;


-- How is distribute the volume through the years?

DECLARE @FactViews NVARCHAR(MAX) = N'gold.fact_domestic_tourism';
DECLARE @sql NVARCHAR(MAX);

SET @sql = N'
SELECT
	d.Year,
	COUNT(*) AS Number_Rows,
	COUNT(DISTINCT Country_key) AS Number_countries
FROM '+ @FactViews + N' f
INNER JOIN gold.dim_year d
ON f.Year_key = d.Year_key
GROUP BY d.Year
ORDER BY d.Year;';

EXEC sp_executesql @sql;


-- Which years has the most volumes in each Fact Views?

DECLARE @FactViews NVARCHAR(MAX) = N'gold.fact_tourism_industries'; -- fact_domestic_tourism, fact_inbound_tourism, fact_outbound_tourism, fact_sdg, fact_tourism_industries
DECLARE @sql NVARCHAR(MAX);

SET @sql = N'
SELECT TOP 1
	t.Year,
	t.Number_Rows AS MaxRows,
	t.n_countries
FROM
(
SELECT
	d.Year,
	COUNT(*) AS Number_Rows,
	COUNT(DISTINCT Country_key) AS n_countries
FROM '+ @FactViews + N' f
INNER JOIN gold.dim_year d
ON f.Year_key = d.Year_key
GROUP BY d.Year
)t
ORDER BY t.Number_Rows DESC;';

EXEC sp_executesql @sql;


-- Totals by indicator and unit for a country

DECLARE @FactViews NVARCHAR(MAX) = N'gold.fact_tourism_industries'; -- fact_domestic_tourism, fact_inbound_tourism, fact_outbound_tourism, fact_tourism_industries
DECLARE @Unit NVARCHAR(50) = 'NUMBER' -- NUMBER, THOUSANDS, US$ MILLIONS
DECLARE @Country NVARCHAR(MAX) = 'Italy';
DECLARE @sql NVARCHAR(MAX);

SET @sql = N'
SELECT
	c.Country_name,
	i.Indicator_name,
	SUM(f.Value) AS TotalIndicatorValue,
	m.Measure_Units
FROM '+ @FactViews + N' f
INNER JOIN gold.dim_country c
ON f.Country_key = c.Country_key
INNER JOIN gold.dim_indicator i
ON f.Indicator_key = i.Indicator_key
INNER JOIN gold.dim_unit_of_measure m
ON f.Units_key = m.Units_key
WHERE m.Measure_Units = @Unit AND c.country_name = @Country
GROUP BY c.Country_name, i.Indicator_name, m.Measure_Units
ORDER BY SUM(f.Value) DESC;';

EXEC sp_executesql @sql, N'@Country NVARCHAR(MAX), @Unit NVARCHAR(50)', @Unit=@Unit, @Country=@Country;


-- Retrieves percentage and average-stay indicators for all countries (industries)

DECLARE @Unit NVARCHAR(50) = 'PERCENT' -- PERCENT, AVG_NIGHTS
DECLARE @Country NVARCHAR(MAX) = 'Italy'

SELECT
	c.Country_name,
	y.Year,
	i.Indicator_name,
	m.Measure_Units,
	f.Value
FROM gold.fact_tourism_industries f
INNER JOIN gold.dim_country c
ON f.Country_key = c.Country_key
INNER JOIN gold.dim_indicator i
ON f.Indicator_key = i.Indicator_key
INNER JOIN gold.dim_year y
ON f.Year_key = y.Year_key
INNER JOIN gold.dim_unit_of_measure m
ON f.Units_key = m.Units_key
WHERE m.Measure_Units = @Unit AND c.Country_name = @Country
ORDER BY c.Country_name


-- Retrieves a specific indicator value for a country and year

DECLARE @FactViews NVARCHAR(MAX) = N'gold.fact_domestic_tourism'; -- fact_domestic_tourism, fact_inbound_tourism, fact_outbound_tourism, fact_tourism_industries
DECLARE @Country NVARCHAR(MAX) = 'France'
DECLARE @Year BIGINT = 1998; -- from 1995 to 2022 
DECLARE @Indicator NVARCHAR(MAX) = 'GUESTS (HOTELS AND SIMILAR ESTABLISHMENTS)'; -- see Indicator Dictionary
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
WHERE c.Country_name = @Country AND y.Year = @Year AND i.Indicator_name = @Indicator AND m.Measure_Units = @Unit
ORDER BY f.Value DESC;';

EXEC sp_executesql @sql, N'@Country NVARCHAR(MAX), @Year BIGINT, @Indicator NVARCHAR(MAX), @Unit NVARCHAR(50)', @Country=@Country, @Year=@Year, @Indicator=@Indicator, @Unit=@Unit;