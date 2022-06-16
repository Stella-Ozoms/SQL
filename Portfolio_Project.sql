---Using the Master Database ,Schema dbo and the  tables to answer these sql qsts----

---List all suppliers in the UK---
select CompanyName,Country
from dbo.Supplier
where Country = 'UK'

--List the firstname,lastname,and city for all customers.Concatenate the first and last name,separated by a space and a comma as a single column--
  select FirstName,LastName,City,(FirstName +' '+','+ LastName) as FullName
  from dbo.Customer

  ---List all customers in Sweden---
  select FirstName , LastName, Country
  from dbo.Customer
  where Country = 'sweden'

 ---List all suppliers in alphabetical order---
 select  CompanyName
 from dbo.Supplier
 order by 1 ASC

--- List all suppliers with their products---
select CompanyName,ProductName
from dbo.Supplier as S
join dbo.Product as P
on S.Id = P.SupplierId

---List all orders with customers information---
select O.Id, O.OrderNumber, O.TotalAmount, C.FirstName, C.LastName, C.Phone, C.City, C.Country
from dbo.Customer as C
join dbo.[Order] as O
on	C.Id = O.CustomerId

---List all orders with product name, quantity, and price, sorted by order number---
select P.ProductName ,OI.Quantity, P.UnitPrice,O.OrderNumber
from dbo.[Order] as O
join dbo.OrderItem OI
on O.Id = OI.OrderId
join dbo.Product as P
on OI.ProductId = P.Id
order by 4 asc

---Using a case statement, list all the availability of products. When 0 then not available, else available---
select ProductName ,IsDiscontinued, case  IsDiscontinued when 0 then 'Not available'
else 'Avaiable'
end as 'ProductInStock'
from dbo.Product

--Using case statement, list all the suppliers and the language they speak.The language they speak should be their country E.g if UK,then English--
select  ContactName, CompanyName ,Country, 
case Country when 'UK' then 'English'
             when 'USA'then'English'
			 when 'Japan' then 'Japanese'
			 when 'spain' then 'spanish'
			 when 'Australia' then 'English'
			 when 'Sweden' then 'Swedish'
			 when 'Brazil' then 'Portuguese'
			 when 'Germany' then 'GermanDeutch'
			 when 'Italy'  then  'Italian'
			 when 'Norway' then 'Norwergian'
			 when 'France' then 'French'
			 when 'Singapore' then 'Mandarin'
			 when 'Denmark' then 'Danish'
			 when 'Netherlands'  then 'Deutch'
			 when 'Finland' then 'Finnish'
			 when 'Canada' then 'English'
end as 'Language'
from dbo.Supplier

---List all products that are packaged in Jars---
select ProductName , Package
from dbo.Product
where Package like '%ja%'

--List products name, unitprice and packages for products that starts with Ca--
select ProductName,UnitPrice,Package
from dbo.Product
where ProductName like 'Ca%'

---List the number of products for each supplier, sorted high to low.----
select S.CompanyName,  count(P.ProductName) as NumberOfProductSupplied
from dbo.Product as P
join dbo.Supplier as S
on S.Id = P.SupplierId
group by S.CompanyName
order by 2 desc

----List the number of customers in each country---
select Country, count(Id) as NumberOfCustomersPerCountry
from dbo.Customer
group by Country


---List the number of customers in each country, sorted high to low.---
select Country, count(Id) as NumberOfCustomersPerCountry
from dbo.Customer
group by Country
order by 2 desc

---List the total order amount for each customer, sorted high to low---
select (FirstName+','+' '+ LastName) as CustomerName , SUM(O.TotalAmount) as TotalOrderAmountPerCustomer
from dbo.Customer as C
join dbo.[Order]as O
on C.Id = O.CustomerId
group by (FirstName+','+' '+ LastName)
order by 2 desc

--List all countries with more than 2 suppliers--
select Country,count(CompanyName) as supplierPerCountry
from dbo.Supplier
group by Country
having count(CompanyName) > 2

---List the number of customers in each country Only include countries with more than 10 customers--
select Country,count(Id) as NummberOfCustomersPerCountry
from dbo.Customer
group by Country
having count(Id) > 10

---List the number of customers in each country, except the USA, sorted high to low. Only include countries with 9 or more customers--
select Country,count(Id) as  NummberOfCustomersPerCountry
from dbo.Customer
where Country <> 'USA' 
group by Country
having count(Id) > 9
order by 2 desc

---List customer with average orders between $1000 and $1200---
select (FirstName+','+' '+ LastName) as CustomerName ,AVG(TotalAmount) as AverageOrdersPerCustomers
from dbo.Customer as C
join dbo.[Order] as O
on C.Id = O.CustomerId
group by (FirstName+','+' '+ LastName)
Having AVG(TotalAmount)  between 1000 and 2000
 
 ---Get the number of orders and total amount sold between Jan 1, 2013 and Jan 31, 2013----
 select  (C.FirstName+','+' '+C. LastName) as CustomerName, count(O.Id) as NumberOfOrders, sum(O.TotalAmount) TotalAmountPerCustomer
 from dbo.[Order] AS O
 join dbo.Customer as C 
 on O.CustomerId = C.Id
 where OrderDate between '2013-01-01'and '2013-01-31'
 group by (C.FirstName+','+' '+C. LastName)
 order by 2 desc
 
 


 