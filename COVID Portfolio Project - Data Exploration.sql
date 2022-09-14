/*
-- Table: public.coviddeaths

-- DROP TABLE IF EXISTS public.coviddeaths;

CREATE TABLE coviddeaths
(
    iso_code character varying,
    continent character varying,
    location character varying(50),
    date date,
    total_cases‌ integer,
    new_cases integer,
    new_cases_smoothed numeric(10,3),
    total_deaths integer,
    new_deaths integer,
    new_deaths_smoothed numeric(10,3),
    total_cases_per_million numeric(10,3),
    new_cases_per_million numeric(10,3),
    new_cases_smoothed_per_million numeric(10,3),
    total_deaths_per_million numeric(10,3),
    new_deaths_per_million numeric(10,3),
    new_deaths_smoothed_per_million numeric(10,3),
    reproduction_rate numeric(10,2),
    icu_patients numeric(10,3),
    icu_patients_per_million numeric(10,3),
    hosp_patients integer,
    hosp_patients_per_million numeric(10,3),
    weekly_icu_admissions numeric(10,3),
    weekly_icu_admissions_per_million numeric(10,3),
    weekly_hosp_admissions numeric(10,3),
    weekly_hosp_admissions_per_million numeric(10,3),
    new_tests bigint,
    total_tests bigint,
    total_tests_per_thousand numeric(10,3),
    new_tests_per_thousand numeric(10,3),
    new_tests_smoothed bigint,
    new_tests_smoothed_per_thousand numeric(10,3),
    positive_rate numeric(10,3),
    tests_per_case numeric(10,2),
    tests_units character varying(25),
    total_vaccinations bigint,
    people_vaccinated bigint,
    people_fully_vaccinated bigint,
    new_vaccinations bigint,
    new_vaccinations_smoothed bigint,
    total_vaccinations_per_hundred numeric(10,3),
    people_vaccinated_per_hundred numeric(10,2),
    people_fully_vaccinated_per_hundred numeric(10,0),
    new_vaccinations_smoothed_per_million bigint,
    stringency_index numeric(10,3),
    population bigint,
    population_density numeric(10,3),
    median_age numeric(10,2),
    aged_65_older numeric(10,3),
    aged_70_older numeric(10,3),
    gdp_per_capita numeric(10,2),
    extreme_poverty numeric(10,2),
    cardiovasc_death_rate numeric(10,3),
    diabetes_prevalence numeric(10,2),
    female_smokers numeric(10,2),
    male_smokers numeric(10,2),
    handwashing_facilities numeric(10,3),
    hospital_beds_per_thousand numeric(10,3),
    life_expectancy numeric(10,2),
    human_development_index numeric(10,3)
)

*/
##################################################
/*
Covid 19 Data Exploration 
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/

/*
Kudos to AlexTheAnalyst###

Covid 19 Data Exploration

i import coviddeaths and covidvaccination .csv file that was saved in the postgreql installation directory

*/

COPY coviddeaths FROM 'C:\Program Files\PostgreSQL\14\titan\coviddeaths.csv'
DELIMITERS ','  CSV HEADER;  (sample....to import to postgres dmbs)

/*
Selecting where conitinent is not null
Selecting where all the people vaccinated

order operations
*/

Select *
From coviddeaths
Where continent is not null 
order by continent DESC

Select *
From coviddeaths
Where people_fully_vaccinated is not null 
order by continent DESC


/*

-- Select Data that we are going to be starting with
*/

Select Location, date, coviddeaths.total_cases, new_cases, total_deaths, population
From coviddeaths
Where continent is not null 
order by continent DESC


-- Total Cases vs Total Deaths

Select Location, date, coviddeaths.total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From coviddeaths
Where location like '%states%'
and continent is not null 
order by DESC

#here

Select Location, date, coviddeaths."total_cases‌", total_deaths, (total_deaths/coviddeaths."total_cases‌")*100 as DeathPercentage
From coviddeaths
Where location Ilike '%States%'
and continent is not null order by location DESC

-- Shows likelihood of dying if you contract covid in your country



Select Location, date, coviddeaths."total_cases‌",
coviddeaths."total_deaths", (total_deaths/coviddeaths."total_cases‌")*100 AS DeathPercentage
From coviddeaths
Where location ilike '%states%'
and continent is not null order by location DESC


-- Total Cases vs Population
-- Shows what percentage of population infected with Covid in a specific state

Select Location, date, Population, coviddeaths."total_cases‌",  (coviddeaths."total_cases‌"/population)*100 as PercentPopulationInfected
From coviddeaths
Where location like '%states%'
order by location DESC

--where assumed percentagepopulation of infected is 1.5 will be likely to be affected

Select Location, date, Population, coviddeaths."total_cases‌",  (coviddeaths."total_cases‌"/population)*100 as PercentPopulationInfected
From coviddeaths
Where  ((coviddeaths."total_cases‌"/population)*100) <= 1.5
order by location;


-- Countries with Highest Infection Rate compared to Population (united states)

-- Select Location, Population, MAX(coviddeaths."total_cases‌")
 as HighestInfectionCount,
 Max((coviddeaths."total_cases‌"/coviddeaths.population))*100 as PercentPopulationInfected
 From coviddeaths
 Where location ilike '%united%'
 Group by Location, Population
 order by PercentPopulationInfected desc



-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population

Select Location, Population, MAX(coviddeaths."total_cases‌") as HighestInfectionCount, 
Max((coviddeaths."total_cases‌"/coviddeaths.population))*100 as PercentPopulationInfected
From coviddeaths
Where location ilike '%united%'
Group by Location, Population
order by PercentPopulationInfected DESC

-- GLOBAL NUMBERS


Select continent, MAX(cast(coviddeaths.total_deaths as int)) as TotalDeathCount
From coviddeaths
--Where location like '%states%'
Where continent is not null 
Group by continent
order by TotalDeathCount desc






