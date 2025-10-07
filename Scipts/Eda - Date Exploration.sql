/*
====================================================
📒 FILE: Eda - Date Exploration.sql
PURPOSE: Analyze temporal coverage across Fact views.
PROJECT: Global Tourism Data Warehouse
====================================================

This script identifies the first and last available Year 
and computes the overall data range. 
It confirms that temporal keys in the Gold layer are complete 
and aligned with the expected 1995–2022 time frame.
*/


-- Determine the temporal coverage of the dataset by finding 
-- the earliest and latest available Year and calculating the span in years

DECLARE @FactViews NVARCHAR(MAX) = N'gold.fact_tourism_industries'; -- fact_domestic_tourism, fact_inbound_tourism, fact_outbound_tourism, fact_sdg, fact_tourism_industries
DECLARE @sql NVARCHAR(MAX);

SET @sql = N'
SELECT
	MIN(y.Year) AS first_date,
	MAX(y.Year) AS last_date,
	MAX(y.Year) - MIN(y.Year) AS range_years
FROM '+ @FactViews + N' f
INNER JOIN gold.dim_year y
ON f.Year_key = y.Year_key; ';

EXEC sp_executesql @sql;


