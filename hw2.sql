use db_countries;
select * from countries_of_the_world;
#Q1
# 77 rows returned
SELECT 
    Country
FROM
    countries_of_the_world
WHERE
    GDP > (SELECT 
            AVG(GDP)
        FROM
            countries_of_the_world);

#Q2
# illustrated as a table
SELECT 
    Region, COUNT(Country) AS Number_of_countries
FROM
    countries_of_the_world
WHERE
    Area > (SELECT 
            AVG(Area)
        FROM
            countries_of_the_world) 
	and
            GDP > (SELECT 
            AVG(GDP)
        FROM
            countries_of_the_world)
	and 
	Literacy > (SELECT 
            AVG(Literacy)
        FROM
            countries_of_the_world)
GROUP BY Region;

# Q3
# 4 Regions
DROP  TABLE IF EXISTS new_tbl;
CREATE TEMPORARY TABLE new_tbl
   select Region as Region1,count(Country) as rich_country from countries_of_the_world where GDP>6000 group by Region;
  select * from new_tbl;
DROP  TABLE IF EXISTS new_tbl2;
CREATE TEMPORARY TABLE new_tbl2
	select Region,count(Country) as total_country from countries_of_the_world  group by Region;
  select * from new_tbl2;
DROP  TABLE IF EXISTS new_tbl3;
CREATE TEMPORARY TABLE new_tbl3
SELECT Region, rich_country,total_country
FROM new_tbl2
LEFT JOIN new_tbl rich_country ON Region = Region1;
select count(Region) from new_tbl3 where rich_country/total_country>0.65;

# Q4
# 170 rows
SELECT 
    Country,GDP
FROM
    countries_of_the_world
WHERE
    GDP < 0.4*(SELECT 
            AVG(GDP)
        FROM
            countries_of_the_world);
            
# Q5
# 29 rows returned
SELECT 
    Country,GDP
FROM
    countries_of_the_world
WHERE
    GDP between (0.4*(select
            AVG(GDP)
        FROM
            countries_of_the_world)) and (0.6*(select
            AVG(GDP) FROM
            countries_of_the_world));
            
# Q6
# Letter S
DROP  TABLE IF EXISTS new_tbl;
CREATE TEMPORARY TABLE new_tbl
select Country, REGEXP_SUBSTR( Country, '[A-Z]') as 'First_letter' from countries_of_the_world;
    SELECT * FROM new_tbl;
    select First_letter,count(First_letter) from new_tbl group by First_letter order by count(first_letter) DESC limit 1;
  
#7
#a 4 countries
select A.country,A.CA_ratio,B.GDP from(select country, round(Coastline/Area,3) as CA_ratio from countries_of_the_world order by CA_ratio DESC LIMIT 50) as A
inner join (select country,GDP from countries_of_the_world order by GDP  LIMIT 30) as B on A.Country=B.Country;

#b 7 countries
select A.country,A.CA_ratio,B.GDP from(select country, round(Coastline/Area,3) as CA_ratio from countries_of_the_world order by CA_ratio DESC LIMIT 50) as A
inner join (select country,GDP from countries_of_the_world order by GDP DESC  LIMIT 30) as B on A.Country=B.Country;

#8
# They are different. The top 20 countries are more spreadout among three fields, on the other hand, the lowerst 20 countries concentrate mainly on service.
DROP  TABLE IF EXISTS new_tbl;
CREATE TEMPORARY TABLE new_tbl
	SELECT Country, 
		   Agriculture,
           Industry,
           Service,
           RANK() OVER (ORDER BY GDP) rank_increasing,
           RANK() OVER (ORDER BY GDP DESC) rank_decreasing
	FROM countries_of_the_world;

SELECT rank_group,
       round(avg(Agriculture),3) as 'mean_agriculture',
       round(avg(Industry),3)    as 'mean_Industry' ,
       round(avg(Service),3)     as 'mean_Service' 
from(
SELECT *, 
	1*(rank_increasing<21)                         +
	2*(rank_increasing>208)  
	AS rank_group 
from new_tbl) as t1
group by t1.rank_group order by rank_group;

#9
# the literacy level difference is 96.78-59.043=37.737
DROP  TABLE IF EXISTS new_tbl;
CREATE TEMPORARY TABLE new_tbl
	SELECT Country, Literacy,
           RANK() OVER (ORDER BY GDP) rank_increasing,
           RANK() OVER (ORDER BY GDP DESC) rank_decreasing
	FROM countries_of_the_world;
select * from new_tbl;
SELECT rank_group,
       round(avg(Literacy),3) as 'mean_literacy'
from(
SELECT *, 
	1*(rank_increasing<227*0.2)                         +
	2*(rank_increasing>227*0.8)  
	AS rank_group 
from new_tbl) as t1
group by t1.rank_group order by rank_group;

#10
# 26.76% of them are in Africa, 9.39% of them start with C
DROP  TABLE IF EXISTS new_tbl;
CREATE TEMPORARY TABLE new_tbl
	select country, Region, round(Coastline/Area,3) as CA_ratio from countries_of_the_world 
    where round(Coastline/Area,3)<0.5*(select avg(round(Coastline/Area,3)) from countries_of_the_world)
    and Region REGEXP 'Africa';
    select * from new_tbl ;

DROP  TABLE IF EXISTS new_tbl2;
CREATE TEMPORARY TABLE new_tbl2
select country, Region, round(Coastline/Area,3) as CA_ratio from countries_of_the_world 
    where round(Coastline/Area,3)<0.5*(select avg(round(Coastline/Area,3)) from countries_of_the_world);
select * from new_tbl2;
DROP  TABLE IF EXISTS new_tbl3;
CREATE TEMPORARY TABLE new_tbl3
	select country, Region, round(Coastline/Area,3) as CA_ratio from countries_of_the_world 
    where round(Coastline/Area,3)<0.5*(select avg(round(Coastline/Area,3)) from countries_of_the_world)
    and country REGEXP '^C';
    select * from new_tbl3 ;
select (select count(country) from new_tbl)/(select count(country) from new_tbl2);
select (select count(country) from new_tbl3)/(select count(country) from new_tbl2);

