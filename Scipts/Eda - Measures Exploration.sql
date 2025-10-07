/*
====================================================
📙 FILE: Eda - Measures Exploration.sql
PURPOSE: Validate numerical measures and detect anomalies.
PROJECT: Global Tourism Data Warehouse
====================================================

This script computes total values by unit of measure 
(NUMBER, THOUSANDS, US$ MILLIONS) and checks data integrity 
by identifying invalid percentage values (<0 or >100).
Useful for early quality control in the analytical pipeline.
*/


-- Find the Total Values

DECLARE @FactViews NVARCHAR(MAX) = N'gold.fact_domestic_tourism'; -- fact_domestic_tourism, fact_inbound_tourism, fact_outbound_tourism, fact_sdg, fact_tourism_industries
DECLARE @sql NVARCHAR(MAX);

SET @sql = N'
SELECT
	SUM(f.Value) AS Total_value_sdg,
	d.Measure_Units
FROM '+ @FactViews + N' f
INNER JOIN gold.dim_unit_of_measure d
ON f.Units_key = d.Units_key
WHERE d.Measure_Units IN(''NUMBER'',''THOUSANDS'', ''US$ MILLIONS'')
GROUP BY d.Measure_Units;';

EXEC sp_executesql @sql


-- Percent out of bounds

SELECT
	f.Year_key,
	f.Indicator_key,
	f.Units_key,
	f.value,
	CASE WHEN f.Value < 0 OR f.Value > 100 THEN 1 ELSE 0 END AS out_of_bounds
FROM gold.fact_tourism_industries f
WHERE f.Units_key = 3 AND CASE WHEN f.Value < 0 OR f.Value > 100 THEN 1 ELSE 0 END = 1

SELECT
	f.Year_key,
	f.Units_key,
	f.value,
	CASE WHEN f.Value < 0 OR f.Value > 100 THEN 1 ELSE 0 END AS out_of_bounds
FROM gold.fact_sdg f
WHERE f.Units_key = 3 AND CASE WHEN f.Value < 0 OR f.Value > 100 THEN 1 ELSE 0 END = 1