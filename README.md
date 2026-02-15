# Exploratory Data Analysis (EDA) – Global Tourism Statistics

Welcome to the **Exploratory Data Analysis (EDA)** section of the **Global Tourism Statistics** project! 🧠  
This part of the repository focuses on analyzing the **Gold Layer** datasets to extract insights, validate data integrity, and prepare for reporting and visualization.  

The EDA was entirely developed in **T-SQL**, following a structured, repeatable, and documented workflow.  

---

##  Data Source Dependency

The datasets analyzed in this EDA are derived from the **Gold Layer** of the [Global Tourism Data Warehouse](https://github.com/Daniele1388/DWH---Global-Tourism-Project) project.  

To run these SQL scripts successfully, ensure that the **Data Warehouse** has been built and the **Gold Layer views** (`fact_domestic_tourism`, `fact_inbound_tourism`, `fact_outbound_tourism`, `fact_tourism_industries`, `fact_sdg`, and their related dimensions) are available in SQL Server.  

The EDA depends on these structures for querying and validation.

---

##  EDA Framework

The EDA process follows a systematic exploration approach, divided into key analytical areas:  

![EDA Map](docs/Eda_Map.png?v=2)

1. **Database Exploration** → Understanding the database structure and objects.  
2. **Dimensions Exploration** → Reviewing unique values and coverage for key dimensions.  
3. **Date Exploration** → Checking time span (1995–2022) and temporal consistency.  
4. **Measures Exploration** → Validating numerical measures and detecting anomalies.  
5. **Magnitude Analysis** → Comparing data magnitude by country, indicator, and year.  
6. **Ranking Analysis** → Identifying top-performing countries and indicators.

---

##  Objectives

The goal of this analysis is to:  

- Validate the **completeness and quality** of the Gold layer.  
- Understand **temporal, dimensional, and numerical distributions**.  
- Detect **outliers, missing data, and irregularities**.  
- Support the creation of **dashboards and KPIs** for global tourism and SDG indicators.  

---

##  EDA Scripts

All EDA modules are written in **T-SQL** and fully documented.  
Each script can be executed independently, using dynamic parameters (`@FactViews`, `@Unit`, `@Year`, `@Country`, etc.).  

| Category | Description |
|----------|-------------|
|  Database Exploration | Lists all objects and columns to understand schema design. |
|  Dimensions Exploration | Retrieves distinct Countries, Indicators, Years, and Units to verify data coverage. |
|  Date Exploration | Finds first and last year available; checks time range (1995–2022). |
|  Measures Exploration | Calculates totals by unit of measure and flags invalid percentage values. |
|  Magnitude Analysis | Compares total values by Indicator, Country, and Year to identify dominant contributors. |
|  Ranking Analysis | Produces Top-N/Bottom-N rankings by indicator, country, and year. |

---

##  Insights & Methodology

The EDA is designed to ensure that analytical outputs from the **Gold Layer** are both valid and meaningful.  

Key aspects validated include:
-  Referential integrity (matching dimension keys).  
-  Consistent units of measure across indicators.  
-  No negative or unrealistic percentage values.  
-  Uniform temporal coverage across fact tables.  
-  Logical magnitude relationships between inbound, outbound, and domestic datasets.  

---

##  Example Findings

- **Year coverage** confirmed: 1995 → 2022.  
- **Units** standardized to `NUMBER`, `THOUSANDS`, and `US$ MILLIONS`.  
- **Outliers** identified in SDG and Industries facts where percentages >100%.  
- **Top tourism spenders** (US$ MILLIONS): USA, China, Germany.  
- **Longest stay averages** observed in European and island countries.  

---

##  Tools & Environment

- **SQL Server (T-SQL)** — Analysis and validation queries.  
- **Draw.io** — EDA conceptual map (`docs/Eda_Map.png`).  
- **GitHub** — Repository management and documentation.  

---

##  Repository Structure

```
global-tourism-eda/
│
├── scripts/
│ └── eda/
│ ├── Eda - Database Exploration.sql
│ ├── Eda - Dimensions Exploration.sql
│ ├── Eda - Date Exploration.sql
│ ├── Eda - Measures Exploration.sql
│ ├── Eda - Magnitude Analysis.sql
│ └── Eda - Ranking.sql
│
├── docs/
│ ├── Eda_Map.png
│ ├── types_of_tourism.md
│ ├── tourism_indicators_glossary.md
│ └── ...
│
└── README_EDA.md
```

---

##  Next Steps

- [ ] Conduct advanced KPI analysis in SQL Server on Global Tourism datasets.  
- [ ] Build Tableau dashboards to visualize key tourism trends and indicators.  

---

##  License

This EDA documentation is part of the **Global Tourism Data** project and released under the **MIT License**.  

---

## About Me

Hi, I’m **Daniele Amoroso**   
I like working with data and I’m interested in Data Analytics, Data Science, and AI Automation. 
I build data projects to understand information and find insights.

Connect: [LinkedIn – Daniele Amoroso](https://www.linkedin.com/in/daniele-a-080786b7/)

