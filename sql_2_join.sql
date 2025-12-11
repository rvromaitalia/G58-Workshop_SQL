# SQL Join exercise
#

#
# 1: Get the cities with a name starting with ping sorted by their population
# with the least populated cities first
select * from world.city
where Name like 'Ping%'
order by  Population asc;

# 2: Get the cities with a name starting with ran sorted by their population
#with the most populated cities first
select * from world.city
where Name like 'Ran%'
order by Population DESC;

# 3: Count all cities
select count(*) as city_count
from city;

# 4: Get the average population of all cities
select avg(Population) as avg_population
from world.city;

# 5: Get the biggest population found in any of the cities
select MAX(Population) as max_city_population
from world.city;

# 6: Get the smallest population found in any of the cities
select min(Population) as min_city_population
from world.city;

# 7: Sum the population of all cities with a population below 10000
select sum(Population) as sum_of_pouplation_below10000
from world.city
where Population < 10000;

# 8: Count the cities with the countrycodes MOZ and VNM
select count(*) from world.city
where CountryCode = 'MOZ' or 'VNM';

# 9: Get individual count of cities for the countrycodes MOZ and VNM
select CountryCode,
count(*) as city_count
from world.city
where CountryCode in ('MOZ', 'VNM')
group by CountryCode;

# 10: Get average population of cities in MOZ and VNM
select CountryCode,
avg(Population) as avg_population
from world.city
where CountryCode in ('MOZ', 'VNM')
group by CountryCode;
#
#
# 11: Get the countrycodes with more than 200 cities
  select CountryCode
  from world.city
  group by CountryCode
  having count(*)>200;

 # 12: Get the countrycodes with more than 200 cities ordered by city count
  select CountryCode, count(*) as city_counter
  from world.city
  group by CountryCode
  having count(*)>200
  order by city_counter;

# 13: What language(s) is spoken in the city with a population between 400 and 500 ?
select distinct cl.Language
 from world.city c
 join world.countrylanguage cl
   on c.CountryCode = cl.CountryCode
 where c.Population between 400 and 500;
#
# #14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them
  select c.CountryCode, cl.Language
  from world.city c
  join world.countrylanguage cl
  on c.CountryCode = cl.CountryCode;

  # 15: What names of the cities are in the same country as the city with a population of 122199 (including the that city itself)
  select c.Name from world.city c
  where CountryCode = (
  select CountryCode
  from world.city
  where Population = 122199
  limit  1
  );

  # 16: What names of the cities are in the same country as the city with a population of 122199 (excluding the that city itself)
  select c.name from world.city c
  where CountryCode =(
  select CountryCode from world.city
  where Population = 122199
  limit 1
  ) and
  c.Population<> 122199;

  # 17: What are the city names in the country where Luanda is capital?
  select c.Name from world.city as c
  where c.CountryCode = (
  	select co.Code from world.country co
  	join world.city as cap
  		on co.Capital = cap.ID
  	where cap.Name = 'Luanda'
  );

  # 18: What are the names of the capital cities in countries in the same region as the city named Yaren
  #1. List the capital city names for all countries in that region.”
  select cap.Name
  from world.country AS co
  join world.city as cap
      on co.Capital = cap.ID
  where co.Region = (
  #2. Find the region of the country where the city name is 'Yaren'
      select co2.Region
      from world.country AS co2
      join world.city AS y
          on y.CountryCode = co2.Code
      where y.Name = 'Yaren'
      limit 1
  );

  # 19: What unique languages are spoken in the countries in the same region as the city named Riga
  select distinct cl.language
  from world.countrylanguage as cl
  join world.country as co
      on cl.countrycode = co.code
  where co.region = (
      select co2.region
      from world.country as co2
      join world.city as ci
          on ci.countrycode = co2.code
      where ci.name = 'riga'
      limit 1
  );

  # 20: Get the name of the most populous city
  select Name, Population from world.city
  where Population = (
  select max(Population) from world.city
  )
#