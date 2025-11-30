use EcommerceDB

/*Customers signed up in the month of february*/
select *
from Customers
where MONTH(SignupDate) = 2

/*How many customers are from each country*/
select Country,count(*) as 'Unique customers per country'
from Customers
group by Country

/*Show customers who placed more than 1 order*/
SELECT c.CustomerID,c.FirstName,c.LastName,COUNT(o.OrderID) AS 'OrderCount'
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
HAVING COUNT(o.OrderID) > 1;

/*Could also be done with a subquery but not needed
select distinct c.FirstName
from Customers c join Orders o on c.CustomerID=o.CustomerID 
where o.CustomerID in 
(select CustomerID 
		from Orders 
		group by CustomerID 
		having count(CustomerID)>1)*/

/*Find the customer with the highest total spend.*/
select TOP 1 c.CustomerID,c.FirstName,c.LastName,sum(o.TotalAmount) as 'Total spent'
from Customers c join Orders o on c.CustomerID=o.CustomerID
where o.OrderStatus= 'Completed'
group by c.CustomerID,c.FirstName,c.LastName

/*Show a customer who never ordered anything. Using left join here because we're searching for null value*/
select c.CustomerID,C.FirstName,COUNT(o.OrderID) as 'OrderCount'
from Customers c left join Orders o on c.CustomerID=o.CustomerID
group by c.CustomerID,c.FirstName
having COUNT(o.OrderID) < 1

/*List all products with stock less than 5*/
select *
from Products
where StockQty < 5

/*Find the average price per product category*/
select Category,avg(Price) as'Average price'
from Products
group by Category

/*Show top 2 best-selling products*/
select top 2 p.ProductName,count(o.orderid) as 'Times bought'
from Products p join OrderItems o on p.ProductID=o.ProductID
group by p.ProductName
order by count(o.orderid) desc

/*Calculate total stock value (price * stock)*/
select ProductName,(Price*StockQty) as 'Value in stock'
from Products

/*Show unused products (never ordered). Same as with the customers,we're searching for null value,so we should use left join*/
select p.ProductName,COUNT(o.ProductID) as 'Times bought'
from Products p left join OrderItems o on p.ProductID=o.ProductID
group by p.ProductName
having COUNT(o.ProductID) < 1

/*Count orders per month*/
SELECT MONTH(OrderDate) AS OrderMonth,COUNT(*) AS 'Order count'
FROM Orders
GROUP BY MONTH(OrderDate)
ORDER BY OrderMonth;

/*List all completed orders with customer names*/
select c.FirstName,o.OrderID,o.OrderStatus,o.TotalAmount
from Customers c join Orders o on c.CustomerID=o.CustomerID
where o.OrderStatus = 'Completed'

/*Show total revenue*/
select sum(TotalAmount) as 'Total revenue'
from Orders

/*Find the biggest order amount*/
select top 1 with ties *
from Orders
order by TotalAmount desc

/*Show pending orders older than 7 days*/
select *
from Orders
where OrderStatus = 'Pending'
and OrderDate < DATEADD(day,-7,GETDATE())

/*Calculate total quantity sold per product*/
select o.productid,p.ProductName,SUM(o.Quantity) as 'Quantity per product'
from OrderItems o join Products p on o.ProductID=p.ProductID
group by o.ProductID,p.ProductName

/*Show orders where a discount was applied*/
select *
from OrderItems
where DiscountPercent > 0

/*Calculate total money lost to discounts*/
select SUM(quantity*unitprice*(discountpercent/100)) as total_discount
from OrderItems

/*Show total revenue per product*/
select ProductID,sum(quantity*unitprice) as 'Total revenue'
from OrderItems
group by ProductID

/*Count items bought per customer*/
select c.CustomerID,c.FirstName,sum(o.Quantity) as TotalBought
from orderitems o join Orders r on r.OrderID=o.OrderID join Customers c on c.CustomerID=r.CustomerID
group by c.CustomerID,c.FirstName
order by TotalBought

/*Show payment methods and how much each earned*/
select PaymentMethod,sum(Amount) as 'Total amount'
from Payments
group by PaymentMethod

/*List orders that have no payment yet.Again left join same reason explained as previously*/
SELECT o.OrderID
FROM Orders o
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.OrderID IS NULL;

/*Show average payment amount*/
select avg(Amount) as 'Average amount'
from Payments

/*Show all payments sorted by date*/
select *
from Payments
order by PaymentDate asc

/*Find the largest single payment*/
select top 1 with ties *
from Payments
order by Amount desc

/*Revenue month-over-month,could also be done with CTE*/
SELECT 
    t.Yr,
    t.Mo,
    t.Revenue,
    LAG(t.Revenue) OVER (ORDER BY t.Yr, t.Mo) AS PrevMonthRevenue,
    CASE 
        WHEN LAG(t.Revenue) OVER (ORDER BY t.Yr, t.Mo) IS NULL THEN NULL
        ELSE ROUND((t.Revenue - LAG(t.Revenue) OVER (ORDER BY t.Yr, t.Mo)) * 100.0 
                   / LAG(t.Revenue) OVER (ORDER BY t.Yr, t.Mo), 2)
    END AS MoM_Growth_Percent
FROM
(
    SELECT 
        YEAR(OrderDate) AS Yr,
        MONTH(OrderDate) AS Mo,
        SUM(TotalAmount) AS Revenue
    FROM Orders
    WHERE OrderStatus = 'Completed'
    GROUP BY YEAR(OrderDate), MONTH(OrderDate)
) AS t
ORDER BY t.Yr, t.Mo;