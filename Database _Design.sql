----Database design Project -----

create database Project
create Schema MKT

drop table MKT.territory;

Create TABLE MKT.territory(
territory_key  int primary key identity(1,1),
region varchar (20) not null,
subregion varchar(20) not null,
segment varchar (20) not null,
territory varchar (20) not null);

INSERT INTO MKT.territory VALUES(
'UKIR' ,'UK', 'ENT', 'ENT-UK-1')

INSERT INTO MKT.territory VALUES
('UKIR', 'IE', 'MMT', 'MMT-IE-1')

INSERT INTO MKT.territory VALUES
('DACH', 'DE', 'ENT' , 'ENT-DE-2'),
('DACH', 'IT', 'MMT', 'MMT-IT-1')

INSERT INTO MKT.territory VALUES
('DACH', 'CH ', 'MMT', 'MMT-CH-6'),
('FR', 'FR', 'FCD ', 'FCD-FR-1'),
 ('ITALY', 'ITALY', 'MMN ','MMN-ITALY-5'),
 ('UKIR', 'UK', 'MMN','MMN-UK-2') ,  
 ('UKIR', 'IE ','FCD', 'FCD-IE-2'),
(' DACH', 'DE','MMT', 'MMT-DE-9'), 
 ('UKIR', 'UK', 'ENT', 'NULL'),        
 ('UKIR', 'UK', 'MMT', 'Whitespace '),   
 ('UKIR', 'UK', 'ENT', 'Whitespace'),  
 ('DACH', 'DE','ENT', 'Whitespace')
 
 
 
 CREATE TABLE MKT.Calendar(
calender_key  int primary key not null,
calendardate date  not null)

Insert into MKT.Calendar values
('20190101',' 2019-01-01'),
('20190201', '2019-02-01'),
('20190301', '2019-03-01'),
('20190401', '2019-04-01'),
('20180101' ,'2018-01-01'),
('20180201', '2018-02-01'),
(' 20180301', '2018-03-01'),
 ('20180401', '2018-04-01'),
 ('20170101', '2017-01-01'),
 ('20170201', '2017-02-01'),
 ('20170301', '2017-03-01'),
 ( '20170401', '2017-04-01')



CREATE TABLE MKT.Revenue(
revenue_key  int primary key  identity(1,1),
territory_key  int  not null,
calender_key  int not null,
revenue int not null)


Insert into MKT.Revenue values
(1,20190101,20000.00),
(1 ,20190201 ,22000.00),
(1, 20190301, 23500.00),
 (1, 20190401 ,25000.00),
( 2, 20190101, 6000.00),
(2 ,20190201, 6500.00),
(2, 20190201, 6500.00),
(2, 20190401, 6600.00),
(3, 20190101, 18500.00),
(3, 20190201, 19000.00),
( 3, 20190301 ,20000.00),
 (3, 20190401 ,25000.00),
 (1, 20180101,19000.00),
 (1 ,20180201 ,19500.00)




-----SQL queries to test the various tables and columns created in the database -----

----write a query that returns unique regions in table----

select distinct(region)
from MKT.territory


----write a query that returns all the subregions in UKIR---

SELECT subregion,region
from  MKT.territory
WHERE region='UKIR'

---Write a query that shows how many territories exist per region,order the result based on the highest number of territories.----

SELECT region, count (territory)as  TerritoriesPerRegion
from MKT.territory
group by region
order by 2 desc

---Write a query that returns the total revenue for the current year---

select   SUM (revenue) AS TotalEarning
from MKT.Revenue
where calender_key  like '2019%'

---Write a query that returns the total revenue per region,take current year  into account and show the region that has the highest revenue ---

select t.region , SUM(R.revenue) AS TotalEarningPerRegion 
from MKT.Revenue as R
JOIN MKT.territory as t
ON R.territory_key = t.territory_key
where R.calender_key like '2019%'
group by t.region
 order by 2 desc

--- Write a query that returns the region, subregion, segment, territory and total revenue,Only take current year into account. Filter the--
 --result to only show ENT segment,Only return total revenues greater than 85,000.----


select T.region,T.subregion,T.segment,T.territory,sum (R.Revenue) as TotalEarning
from MKT.territory as T
join MKT.Revenue as R
on T.territory_key= R.territory_key
WHERE R.calender_key LIKE '2019%'
GROUP BY T.region,T.subregion,T.segment,T.territory 
HAVING sum (R.Revenue)>85000

 ---Write a query that calculates Month over Month growth using----

 select R.calender_key,SUM (R.revenue) AS revenue, 
 round(SUM (R.revenue)/ LAG(SUM (R.revenue)) OVER (ORDER BY  R.calender_key), 2) -1 ) * 100 as "MOM%"
 from Mkt.Revenue AS R 
 JOIN MKT.territory as T 
 ON T.territory_key = R.territory_key
 where T.subregion ='UK'
 AND R.calender_key like '2019%' 
 group by R.calender_key



 
 

 create TABLE MKT.Sales(
Month Date not null,
Division varchar (20) not null,
Employee varchar (20) not null,
Product varchar(20) not null,
sales int not null)

insert into MKT.Sales VALUES
('2001-01-01','A','John','Eggs', 50), 
('2001-01-01','B','Paul' ,'Milk', 25 ),
('2001-01-01','A','John' ,'Apples' ,50 ),
('2001-02-01','B', 'Paul' ,'Milk' ,10 ),
('2001-02-01','A' ,'John', 'Apples', 20 ),
('2001-02-01','B' ,'Paul', 'Bread' ,30)

Create TABLE MKT.CCalender(
Date DATE NOT NULL,
Month DATE  NOT NULL,
DaysInMonth int not null)


Insert into MKT.CCalender VALUES
 ('2019-01-01 ', '2001-01-01', 31),
 ('2019-01-02', '2001-01-01', 31),
 ('2019-01-03' , '2001-01-01', 31),
 ('2019-01-04' , '2001-01-01' ,31),
 ('2019-01-05' , '2001-02-01' ,28),
 ('2019-01-06',  '2001-02-01', 28),
('2019-01-07', '2001-02-01', 28),
('2019-01-08' , '2001-02-01', 28)


---Write a query that calculates the total sale for each month and amount of sales per day for each month---


select S.[Month],SUM(S.sales) as Sales,SUM(S.sales)/C.DaysInMonth as SalesPerDay
from MKT.Sales as S
JOIN MKT.CCalender as C
ON S.[Month]= C.[Month]
GROUP BY  S.[Month] ,C.DaysInMonth
Order by  S.[Month] ASC



 



