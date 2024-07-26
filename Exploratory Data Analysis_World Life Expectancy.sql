# World Life Expectancy Project (Exploratory Data Analysis)

select *
from world_life_expectancy
;

select Country, 
min(`Life expectancy`), 
max(`Life expectancy`),
round (max(`Life expectancy`) - min(`Life expectancy`), 1) as Life_Increase_15_Years
from world_life_expectancy
group by Country
having min(`Life expectancy`) <> 0
and max(`Life expectancy`) <> 0
order by Life_Increase_15_Years desc
;

select Year, round(avg(`Life expectancy`), 2)
from world_life_expectancy
where `Life expectancy` <> 0
and `Life expectancy` <> 0
group by Year
order by Year
;


# correlation

select Country, round(avg(`Life expectancy`),1) as Life_Exp, round(avg(GDP), 1) as GDP
from world_life_expectancy
group by Country
having Life_Exp > 0 
and GDP > 0 
order by GDP asc
;


select 
sum(case when GDP >= 1500 then 1 else 0 end) High_GDP_Count,
avg(case when GDP >= 1500 then `Life expectancy` else null end) High_GDP_Life_expectancy,
sum(case when GDP <= 1500 then 1 else 0 end) Low_GDP_Count,
avg(case when GDP <= 1500 then `Life expectancy` else null end) Low_GDP_Life_expectancy
from world_life_expectancy
;


select Status, round(avg(`Life expectancy`), 1)
from world_life_expectancy
group by Status
;


select Status, count(distinct Country), round(avg(`Life expectancy`), 1)
from world_life_expectancy
group by Status
;

select Country, round(avg(`Life expectancy`),1) as Life_Exp, round(avg(BMI), 1) as BMI
from world_life_expectancy
group by Country
having Life_Exp > 0 
and BMI > 0 
order by BMI desc
;


# rolling total

select Country, Year, `Life expectancy`, `Adult Mortality`,
sum( `Adult Mortality`) over (partition by Country order by Year) as Rolling_Total
from world_life_expectancy
where Country like '%United%'
;