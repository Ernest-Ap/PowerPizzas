
Select *
From PortfolioP..pizzas
order by 3,4

Select *
From PortfolioP..orders
Where order_id = '1'

Select *
From PortfolioP..order_details
Where order_id = '1'
order by 3,4


Select timeO, CONVERT(int,timeO)
From PortfolioP..orders


Update orders
SET timeO = CONVERT(Time,timeO)


--ALTER TABLE orders
--Add timeO time;

--Update orders
--SET timeO = CONVERT(Time,timeO)


Select dateO, CONVERT(Date,dateOr)
From PortfolioP..orders

Update orders
SET dateOr = CONVERT(Date,dateOr)


ALTER TABLE orders
Add dateO Date;

Update orders
SET dateO = CONVERT(Date,dateOr)



Select *
From PortfolioP..orders


ALTER TABLE PortfolioP..orders
Drop COLUMN timeOr;

ALTER TABLE PortfolioP..orders
Drop COLUMN dateOr;

ALTER TABLE PortfolioP..orders
Drop COLUMN timeOr;

EXEC sp_rename 'orders.date', 'dateOr', 'COLUMN';

EXEC sp_rename 'orders.time', 'timeOr', 'COLUMN';
-------------------------------------------------------------------------------------------------


Select p.pizza_id, name, COUNT(p.pizza_type_id) AS Medium_Size
From pizzas p
JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
JOIN order_details od
ON od.pizza_id = p.pizza_id
Where size = 'M'
GROUP BY name,
p.pizza_id;




Select category, AVG(price) AS Avg_Large_Size
From pizzas p
JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
JOIN order_details od
ON od.pizza_id = p.pizza_id
Where size = 'L' 
GROUP BY category
--pt.pizza_type_id
order by 1,2; 


Select category, name, SUM(price) AS Total_Veg_Pizza
From pizzas p
JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
JOIN order_details od
ON od.pizza_id = p.pizza_id
Where category = 'Veggie'
GROUP BY category, name
order by 1,2; 



WITH pizzas_by_Group AS (
Select 
pizza_id, 
CASE 
  WHEN price > 17 THEN 'Expensive'
  WHEN price > 14 THEN 'Affordable'
  ELSE 'Cheap'
 END AS Cost 
 FROM pizzas)
Select
  Cost,
  COUNT(pizza_id) AS  pizza_count
 FROM pizzas_by_Group
 GROUP BY Cost;


 
Select dateO, timeO, category, COUNT(od.order_id) AS march_pizzasCo, SUM(price) AS march_pizzasSum
From orders o
JOIN order_details od
ON od.order_id = o.order_id
JOIN pizzas p
ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
ON pt.pizza_type_id = p.pizza_type_id
Where dateO BETWEEN '2015-03-01' AND '2015-03-7' AND timeO BETWEEN '11:00:00' AND '14:15:00' AND category = 'Supreme' 
GROUP BY dateO, timeO, category 
order by 1,2; 

