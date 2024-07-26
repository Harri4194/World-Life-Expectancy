# World Life Expectancy (DATA CLEANING) Project

select * 
from world_life_expectancy
;


select Country, year, concat(Country, year), count(concat(Country, year))
from world_life_expectancy
group by Country, year, concat(Country, year)
having count(concat(Country, year)) > 1
;

select *
from(
	select Row_ID,
	concat(Country, year),
	row_number() over (partition by concat(Country, year) order by concat(Country, year)) as Row_Num
	from world_life_expectancy
    ) as Row_table
where Row_Num > 1
;


delete from world_life_expectancy
where 
	Row_ID in (
	select Row_ID
from(
	select Row_ID,
	concat(Country, year),
	row_number() over (partition by concat(Country, year) order by concat(Country, year)) as Row_Num
	from world_life_expectancy
    ) as Row_table
where Row_Num > 1
)
;

select * 
from world_life_expectancy
where status = ''
;

select distinct(Status)
from world_life_expectancy
where status <> ''
;

select distinct (Country)
from world_life_expectancy
where Status = 'Developing';

update world_life_expectancy
set Status = 'Developing'
where Country in (select distinct (Country)
			     from world_life_expectancy
				 where Status = 'Developing');

update world_life_expectancy t1
join world_life_expectancy t2
	on t1.Country = t2.Country
set t1.Status = 'Developing'
where t1.Status = ''
and t2.Status <> ''
and t2.Status = 'Developing'
;

select * 
from world_life_expectancy
where Country = 'United States of America'
;

update world_life_expectancy t1
join world_life_expectancy t2
	on t1.Country = t2.Country
set t1.Status = 'Developed'
where t1.Status = ''
and t2.Status <> ''
and t2.Status = 'Developed'
;

select * 
from world_life_expectancy
where Status is null
;

select * 
from world_life_expectancy
# where `Life expectancy` = ''
;


select Country, year, `Life expectancy`
from world_life_expectancy
where `Life expectancy` = ''
;

select t1.Country, t1.year, t1.`Life expectancy`,
	   t2.Country, t2.year, t2.`Life expectancy`, 
       t3.Country, t3.year, t3.`Life expectancy`,
  round((t2.`Life expectancy` + t3.`Life expectancy`) / 2,1)     
from world_life_expectancy t1
join world_life_expectancy t2
	on t1.Country = t2.Country
    and t1.year = t2.year - 1
join world_life_expectancy t3
	on t1.Country = t3.Country
    and t1.year = t3.year + 1
where t1.`Life expectancy` = ''
;
	
update world_life_expectancy t1
join world_life_expectancy t2
	on t1.Country = t2.Country
    and t1.year = t2.year - 1
join world_life_expectancy t3
	on t1.Country = t3.Country
    and t1.year = t3.year + 1
set t1.`Life expectancy` = round((t2.`Life expectancy` + t3.`Life expectancy`) / 2,1)
where t1.`Life expectancy` = ''
;

select *
from world_life_expectancy
#where `Life expectancy` = ''
;


