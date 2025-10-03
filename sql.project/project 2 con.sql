-- checking the total row from the dataset
select count(*) 
from car_prices_edited;

select*
from car_prices_edited;
-- checking for duplicate 
select *,
row_number() over(partition by 'year',make,model,vin,seller) row_num
from car_prices_edited;

with duplicate_cte as 
( select *,
row_number() over(partition by 'year',
make,model,vin,seller) row_num
from car_prices_edited)

select *
from duplicate_cte 
where row_num  > 1;

-- creating a table to delect the duplicate 
CREATE TABLE `car_prices_edited2` (
  `year` int DEFAULT NULL,
  `make` text,
  `model` text,
  `trim` text,
  `body` text,
  `transmission` text,
  `vin` text,
  `state` text,
  `condition` int DEFAULT NULL,
  `odometer` int DEFAULT NULL,
  `color` text,
  `interior` text,
  `seller` text,
  `mmr` int DEFAULT NULL,
  `sellingprice` int DEFAULT NULL,
  `saledate` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select* 
from car_prices_edited2;

insert into car_prices_edited2
 select *,
row_number() over(partition by 'year',make,model,vin,seller) row_num
from car_prices_edited;

select* 
from car_prices_edited2
where row_num > 1;

delete 
from car_prices_edited2
where row_num > 1;

-- checking for blank colunms
select *
from car_prices_edited2
where make = ' ';

-- identifying the best seller irrespective of the year
select distinct seller
from car_prices_edited;

select seller , sum(sellingprice) total_sale
from car_prices_edited
group by seller
order by total_sale desc;

/* looking for blank colunm and null value, 
after spoting some, so trying to run a quick check 
again*/

select *
from car_prices_edited2
where (make is null or trim(make) = ' ')
and (model is null or trim(model) =' ')
and(trim is null or trim(trim) =' ')
and (body is null or trim(body) =' ');

-- highest brand maker 
select make , sum(sellingprice) highest_maker
from car_prices_edited
group by make
order by highest_maker desc ;

/*transforming the abbreviate value to full name 
in the state colunm*/
  
select distinct state
from car_prices_edited; 

create table state (
abbr char(2) primary key ,full_name varchar(50)
);
insert into state(abbr, full_name )values
('fl', 'florida'),
('ny', 'new_york'),
('tx' , 'texas'),
('ca','california'),
('nm','new mexico'),
('ms','missimsippi'),
('ok','oklahoma'),
('hi','hawaii'),
('wa', 'washington'),
('la', 'louisiana'),
('or','oregon'),
('nc', 'north carolina'),
('ma','massachusetts'),
('nv', 'neveda'),
('mo', 'missouri'),
('ut', 'utah'),
('il','illinois'),
('in', 'indiana'),
('sc','southcarolina'),
('va', 'varginia'),
('ga','georgia'),
('mi', 'michigan'),
('0h', 'ohio'),
('nj', 'new jersy'),
('ne','nebraska'),
('md', 'maryland'),
('tn', 'tennessee'),
('wi', 'wisconsin'),
('az', 'arizona'),
('mm', 'minnesota'),
('pa','pennsylvania');

update car_prices_edited as CP
join state as ST on cp.state = ST.abbr
set cp.state = st.full_name;

select state
from car_prices_edited ;

select *
from car_prices_edited ;-- finally checking for any error before calling it a day ^_^
