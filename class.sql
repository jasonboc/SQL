use db_countries;
show tables;
-- STR_TO_DATE
 
select * from intl_football;
describe intl_football;


select country,date from intl_football group by country;
select country,DATEDIFF(curdate(),date),away_score from intl_football where away_team='Italy' and away_score<3;
