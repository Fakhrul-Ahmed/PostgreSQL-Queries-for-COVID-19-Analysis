# PostgreSQL-Queries-for-COVID-19-Analysis

## Project Overview
This project analyzes the global and country-specific COVID-19 data to derive meaningful insights. It uses SQL queries to process and analyze datasets related to COVID-19 deaths, cases, vaccinations, and population data. The goal is to understand trends, percentages, and rates related to COVID-19 at various geographic levels.

## Objectives
- To calculate the likelihood of dying from COVID-19 on a date-wise basis in India.
- To determine the total percentage of deaths out of the entire population in India.
- To find the death rate as a percentage of the population in India and globally.
- To calculate the percentage of COVID-positive cases in India and worldwide.
- To summarize continent-wide COVID cases and deaths.
- To analyze countrywide vaccination progress.

## Project Structure
The project consists of the following sections:
1. **SQL Queries**: Predefined SQL queries to analyze various aspects of the COVID-19 datasets.
2. **Datasets**: Contains two primary datasets:
   - `CovidDeaths`: Data on COVID-19 cases, deaths, and population information.
   - `CovidVaccinations`: Data on vaccinations worldwide.
3. **Reports**: Detailed findings and visualizations derived from the query results.
4. **Conclusion**: Summarized insights and final remarks based on the analysis.
5. **How to Use**: Instructions for running the SQL queries and interpreting the results.

## Findings
- The likelihood of dying due to COVID-19 varies significantly over time, with trends reflecting changes in medical interventions and policies.
- India’s death rate as a percentage of the population is relatively low compared to the global average.
- Continent-wide analysis reveals that some regions experienced higher case and death rates, which correlates with population density and healthcare infrastructure.
- Vaccination progress varies greatly between countries, with some achieving high coverage while others lag behind.

## Reports
The results of the queries are summarized into detailed reports. These reports include:
- Date-wise trends for India.
- Death and case rates by continent and globally.
- Vaccination progress by country.
- Tables and visualizations to illustrate key metrics.

## Conclusion
This analysis highlights the disparities in COVID-19 impact and response across different countries and regions. It underscores the importance of vaccination, timely interventions, and robust healthcare systems in managing pandemics.

## How to Use
1. **Setup**: Ensure you have access to a PostgreSQL database and import the `CovidDeaths` and `CovidVaccinations` datasets.
2. **Run Queries**: Copy and execute the provided SQL queries in your database management tool (e.g., pgAdmin, DBeaver).
3. **Interpret Results**: Use the query outputs to draw insights and create visualizations.
4. **Extend Analysis**: Modify the queries to focus on specific countries, dates, or metrics of interest.

## SQL Queries

### 1. Date-wise likelihood of dying due to COVID in India (Total cases vs. Total deaths):
```sql
SELECT 
    date, 
    total_cases, 
    total_deaths, 
    (total_deaths::FLOAT / NULLIF(total_cases, 0)) * 100 AS death_likelihood_percentage
FROM 
    "CovidDeaths"
WHERE 
    location = 'India'
ORDER BY 
    date;
```

### 2. Total percentage of deaths out of the entire population in India:
```sql
SELECT 
    location AS country, 
    (SUM(total_deaths::FLOAT) / NULLIF(MAX(population::FLOAT), 0)) * 100 AS death_percentage_of_population
FROM 
    "CovidDeaths"
WHERE 
    location = 'India'
GROUP BY 
    location;
```

### 3. Death rate as a percentage of the population in India:
```sql
SELECT 
    location AS country, 
    (MAX(total_deaths)::FLOAT / NULLIF(MAX(population::FLOAT), 0)) * 100 AS death_rate_percentage
FROM 
    "CovidDeaths"
WHERE
    location = 'India'
GROUP BY 
    location
ORDER BY 
    death_rate_percentage DESC
LIMIT 1;
```

### 4. Total percentage of COVID-positive cases in India:
```sql
SELECT 
    location AS country, 
    (MAX(total_cases)::FLOAT / NULLIF(MAX(population::FLOAT), 0)) * 100 AS covid_positive_percentage
FROM 
    "CovidDeaths"
WHERE 
    location = 'India'
GROUP BY
    location;
```

### 5. Total percentage of COVID-positive cases in the world:
```sql
SELECT 
    (SUM(total_cases)::FLOAT / NULLIF(SUM(population::FLOAT), 0)) * 100 AS world_covid_positive_percentage
FROM 
    "CovidDeaths";
```

### 6. Continent-wide COVID-positive cases:
```sql
SELECT 
    continent, 
    SUM(total_cases) AS total_positive_cases
FROM 
    "CovidDeaths"
WHERE 
    continent IS NOT NULL
GROUP BY 
    continent
ORDER BY 
    total_positive_cases DESC;
```

### 7. Continent-wide COVID deaths:
```sql
SELECT 
    continent, 
    SUM(total_deaths) AS total_deaths
FROM 
    "CovidDeaths"
WHERE 
    continent IS NOT NULL
GROUP BY 
    continent
ORDER BY 
    total_deaths DESC;
```

### 8. Countrywide total vaccinated persons:
```sql
SELECT 
    location AS country, 
    MAX(people_vaccinated) AS total_vaccinated
FROM 
    "CovidVaccinations"
WHERE 
    people_vaccinated IS NOT NULL
GROUP BY 
    location
ORDER BY 
    total_vaccinated DESC;
```

