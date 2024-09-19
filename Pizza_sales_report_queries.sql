-- PIZZA COMPANY SALES REPORT (2022) SQL QUERIES--
-------------------------------------------

 --A.	Total Revenue (Sales)
 SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales

 --B.	Average amount spent per Order
 SELECT SUM(total_price) / COUNT(DISTINCT(order_id)) AS Avg_Order_Value FROM pizza_sales

 --C.	Total Pizzas Sold
 SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales

 --D.	Total no of Orders
 SELECT COUNT(DISTINCT(order_id)) AS Total_Orders FROM pizza_sales

 --E.	Average Pizzas per Order
 SELECT SUM(quantity) / COUNT(DISTINCT(order_id)) AS Avg_Pizza_Per_Order FROM pizza_sales
 SELECT CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT(order_id)) AS DECIMAL(10,2)) AS Avg_Pizza_Per_Order FROM pizza_sales
  SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT(order_id)) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizza_Per_Order FROM pizza_sales



 --a.	Daily Trend for Total Orders
 --'DW'is Day of the week.
SELECT DATENAME(DW, order_date) as order_day, COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales GROUP BY DATENAME(DW, order_date)

 --b.	Monthly Trend for Total Orders

SELECT DATENAME(MONTH, order_date) AS Month_Name, COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Orders DESC

--c.	Percentage of Sales by Pizza Category
 --Here, if you want to filter data monthwise then use 'where' clause with 'MONTH' function.

SELECT pizza_category,  SUM(total_price)  AS Total_Sales, SUM(total_price) * 100 / (SELECT SUM(Total_price) FROM pizza_sales WHERE MONTH(order_date)=1) AS Per_Total_Sales
FROM pizza_sales 
WHERE MONTH(order_date) = 1 -- '1' is 'Jan'
GROUP BY pizza_category

--d.	Percentage of Sales by Pizza Size
 --Use 'CAST' function for display numbers upto 2 'decimal'.

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales, CAST(SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(quarter, order_date) = 1) AS DECIMAL(10,2))  AS Per_Total_Sales
FROM pizza_sales
WHERE DATEPART(quarter, order_date) = 1
GROUP BY pizza_size
ORDER BY Per_Total_Sales DESC



--e.	 Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales 
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC

--f.	Top 5 Best Sellers by Revenue, Total Quantity and Total Orders
 --For top 5 order should be 'DESC' and bottom should 'ASC'
SELECT TOP 5 pizza_name, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

--g.	Bottom 5 Best Sellers by Revenue, Total Quantity and Total Orders
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC

--For Total Orders --
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id)AS Total_Orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders 

SELECT @@SERVERNAME AS ServerName;




































