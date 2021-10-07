-- Showcasing the data in the tables

select *
from PortfolioProject..CovidDeaths
where continent!='Null'
order by 3,4

select *
from PortfolioProject..CovidVaccinations
where continent!='Null'
order by 3,4

-- Death percentage in India

select location, date, total_cases, total_deaths,(cast(total_deaths as float)/cast(nullif(total_cases,0) as float))*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where location ='India' and continent!='Null'
order by 1,2

-- Total cases vs Population

select location, date, total_cases,population,(cast(total_cases as float)/cast(nullif(population,0) as float))*100 as InfectionPercentage
from PortfolioProject..CovidDeaths
where continent!='Null'
order by 1,2

-- Countries with highest infection rates

select location, population, max(total_cases) as HighestInfectionCount, max((cast(total_cases as float)/cast(nullif(population,0) as float))*100) as InfectionPercentage
from PortfolioProject..CovidDeaths
where continent!='Null'
group by location,population
order by InfectionPercentage desc

-- Showing countries with highest death count

select location, max(total_deaths) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent!='Null'
group by location
order by TotalDeathCount desc

-- Showing continents with their respective death count

select location, max(total_deaths) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent='Null'
group by location
order by TotalDeathCount desc 

-- Global effects of covid(cases and deaths analysis)

select date,sum(new_cases) as TotalCases, sum(new_deaths) as TotalDeaths, (convert(float,sum(new_deaths))/convert(float,nullif(sum(new_cases),0)))*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where continent!='Null'
group by date
order by 1,2

-- Vaccinations vs Total Population
select dea.continent, dea.date , dea.location, vac.new_vaccinations,dea.population,sum(vac.new_vaccinations) over (partition by dea.location)
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent != 'Null'
order by 1,3