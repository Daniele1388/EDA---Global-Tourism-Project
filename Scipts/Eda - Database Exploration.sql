/*
====================================================
📘 FILE: Eda - Database Exploration.sql
PURPOSE: Explore and document the database structure.
PROJECT: Global Tourism Data Warehouse
====================================================

This script inspects all database objects and their columns 
to understand the overall schema design and available fields.
It helps verify the Gold layer views before starting analysis.
*/


-- Explore All Objects in the Database

SELECT * FROM INFORMATION_SCHEMA.TABLES ORDER BY TABLE_SCHEMA


-- Explore All Columns in the Database

DECLARE @ViewsName NVARCHAR(MAX) = 'dim_country'; -- dim_country, dim_indicator, dim_unit_of_measure, dim_year, fact_domestic_tourism, fact_inbound_tourism, fact_outbound_tourism, fact_sdg, fact_tourism_industries

SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @ViewsName