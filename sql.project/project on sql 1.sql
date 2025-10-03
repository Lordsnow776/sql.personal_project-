select * 
from clean_dataset;
 
 create table clean_dataset_2 like clean_dataset;
 
insert into clean_dataset_2 
select *
from clean_dataset;

select * 
from  clean_dataset_2;

-- each individual price for airline 
select distinct airline, price 
from  clean_dataset_2;

-- checking for airline with same price 
select price , count(distinct airline) airline_count 
from clean_dataset_2
group by price
having count(distinct airline) > 1;
/*difference betweeen the  early onboarding
 and late onboarding proces with price */
 
select avg(price)late_bird
from  clean_dataset_2
where days_left in (1,2);

select avg(price)early_bird
from  clean_dataset_2
where days_left > 2;

-- flight with the same route and time of A and D comparing the price range 

select departure_time,arrival_time,
avg(price) avg_price, count(*) no_flight
from  clean_dataset_2
group by departure_time,arrival_time
order by avg_price desc;

-- confirm all source city are from delhi
select *
from clean_dataset_2
where source_city != 'Delhi';

-- avg price of each airline
select distinct(airline),avg(price) 
from  clean_dataset_2
group by airline;

-- total income from airline from source city and destination 

select distinct(airline), source_city,destination_city, sum(price) 
from  clean_dataset_2
group by airline,source_city,destination_city;

select *
from clean_dataset_2;

-- changing colunm name to serial number 
alter table clean_dataset_2
change column  MyUnknownColumn 
flight_serial_num int;
