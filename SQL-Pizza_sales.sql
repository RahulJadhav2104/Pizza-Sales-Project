select * from pizza_sales

----> To find total revenue
select sum(total_price) as Total_Revenue from pizza_sales;

----> Average order value
select sum(total_price)/Count(Distinct order_id) as Average_order_value from pizza_sales;

----> Total Pizza sold
select sum(quantity) as Total_Pizza_Sold from pizza_sales;

----> Total orders placed
select Count(Distinct order_id) as Total_orders from pizza_sales;

----> Average Pizzas per order
select sum(quantity)/count(Distinct order_id) as Average_Pizza_order from pizza_sales;
--or
select cast(sum(quantity) as decimal(10,2))/cast(count(Distinct order_id) as decimal(10,2)) as Average_Pizza_order 
from pizza_sales;
--or
select cast(cast(sum(quantity) as decimal(10,2))/cast(count(Distinct order_id) as decimal(10,2)) as decimal(10,2)) as Average_Pizza_order 
from pizza_sales;



----> Daily Trend
select DATENAME(DW,order_date) as order_day, count(Distinct order_id) as Total_orders 
from pizza_sales 
group by DATENAME(DW,order_date);


----> Hourly Trend
select DATEPART(HOUR,order_time) as order_hours, count(Distinct order_id) as Total_orders 
from pizza_sales 
group by DATEPART(HOUR,order_time) 
order by DATEPART(HOUR,order_time);

----> Percentage of Sales by Pizza Category
select pizza_category, sum(total_price) as Total_sales, sum(total_price)*100/(select sum(total_price) from pizza_sales) as Percentage_of_sales 
from pizza_sales 
Group by pizza_category;

--or (for January month)
select pizza_category, sum(total_price) as Jan_Total_sales, sum(total_price)*100/(select sum(total_price) from pizza_sales Where Month(order_date)=1) as Percentage_of_Jan_sales 
from pizza_sales 
where Month(order_date)=1 
Group by pizza_category;

--or (for quarter)
select pizza_category, sum(total_price) as Total_Qut1_sales, sum(total_price)*100/(select sum(total_price) from pizza_sales Where Datepart(Quarter,order_date)=1) as Percentage_of_Qut1
from pizza_sales 
where Datepart(Quarter,order_date)=1 
Group by pizza_category;


---->  Percentage of sales by pizza size
select pizza_size, sum(total_price) as Total_sales, sum(total_price)*100/(select sum(total_price) from pizza_sales) as Percentage_of_sales 
from pizza_sales 
Group by pizza_size
order by Percentage_of_sales desc;

--or (to see upto 2 decimal points use cast function)
select pizza_size, cast(sum(total_price) as decimal(10,2)) as Total_sales, cast(sum(total_price)*100/(select sum(total_price) from pizza_sales) as decimal(10,2)) as Percentage_of_sales 
from pizza_sales 
Group by pizza_size
order by Percentage_of_sales desc;

-- or(for quarter)
select pizza_size, cast(sum(total_price) as decimal(10,2)) as Total_sales, cast(sum(total_price)*100/(select sum(total_price) from pizza_sales where Datepart(Quarter,order_date)=1) as decimal(10,2)) as Percentage_of_sales 
from pizza_sales 
where Datepart(Quarter,order_date)=1
Group by pizza_size
order by Percentage_of_sales desc;

----> Total Pizza sold by pizza category
select pizza_category, sum(quantity) as Total_pizza_sold from pizza_sales
Group by pizza_category

----> Top 5 best sellers by total pizza sold
select Top 5 pizza_name,sum(quantity) as Total_pizza_sold from pizza_sales
Group by pizza_name
order by sum(quantity) desc

----> Bottom 5 worst sellers by total pizza sold
select Top 5 pizza_name,sum(quantity) as Total_pizza_sold from pizza_sales
Group by pizza_name
order by sum(quantity) asc

--or (for October month)
select Top 5 pizza_name,sum(quantity) as Total_pizza_sold from pizza_sales
where month(order_date)=10
Group by pizza_name
order by sum(quantity) asc