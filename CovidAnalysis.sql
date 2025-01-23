-- 1. Date-wise likelihood of dying due to COVID in India (Total cases vs. Total deaths):
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


-- 2. Total percentage of deaths out of the entire population in India:
SELECT 
    location AS country, 
    (SUM(total_deaths::FLOAT) / NULLIF(MAX(population::FLOAT), 0)) * 100 AS death_percentage_of_population
FROM 
    "CovidDeaths"
WHERE 
    location = 'India'
GROUP BY 
    location;


-- 3. Ddeath rate as a percentage of the population in India:
SELECT 
    location AS country, 
    (MAX(total_deaths)::FLOAT / NULLIF(MAX(population::Float), 0)) * 100 AS death_rate_percentage
FROM 
    "CovidDeaths"
WHERE
	location = 'India'
GROUP BY 
    location
ORDER BY 
    death_rate_percentage DESC
LIMIT 1;


-- 4. Total percentage of COVID-positive cases in India:
SELECT 
    location AS country, 
    (MAX(total_cases)::FLOAT / NULLIF(MAX(population::FLOAT), 0)) * 100 AS covid_positive_percentage
FROM 
    "CovidDeaths"
WHERE 
    location = 'India'
GROUP BY
	location;


-- 5. Total percentage of COVID-positive cases in the world:
SELECT 
    (SUM(total_cases)::FLOAT / NULLIF(SUM(population::FLOAT), 0)) * 100 AS world_covid_positive_percentage
FROM 
    "CovidDeaths";


-- 6. Continent-wide COVID-positive cases:
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


-- 7. Continent-wide COVID deaths:
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


-- 8. Countrywide total vaccinated persons:
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








