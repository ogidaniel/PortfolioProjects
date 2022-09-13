

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

Select Location, date, total_cases, new_cases, total_deaths, population
From coviddeaths
Where continent is not null 
order by DESC

-- Total Cases vs Total Deaths

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From coviddeaths
Where location like '%states%'
and continent is not null 
order by DESC

-- Shows likelihood of dying if you contract covid in your country






