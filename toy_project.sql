-- top-performing products based on total sales and profit.

with temp as
(select s.units,p.*, (s.Units *p.Product_Price) as total_price,
(s.Units *p.Profit) as total_profit
from sales s
inner join products p
on s.Product_ID = p.Product_ID )

select product_id,product_name,product_category,
round(sum(total_price), 2) as sum_price, sum(total_profit) as sum_profit
from temp group by 1,2,3 order by sum_profit desc ;



with temp as
(select s.units,p.*, (s.Units *p.Product_Price) as total_price,
(s.Units *p.Profit) as total_profit
from sales s
inner join products p
on s.Product_ID = p.Product_ID )

select product_id,product_name,product_category,
round(sum(total_price), 2) as sum_price, round(sum(total_profit), 2) as sum_profit
from temp group by 1,2,3 order by sum_price desc ;




-- sales performance for each store, including total revenue and profit margin.

with temp_t as
(select t.store_name,t.store_city,t.store_location,t.store_open_date,
l.sale_id,l.date,l.store_id,l.units,p.*,
(l.Units *p.Product_Price) as total_price,
(l.Units *p.Profit) as total_profit
 from sales l
inner join stores t on t.Store_ID = l.Store_ID 
inner join products p on p.Product_ID = l.Product_ID)

select store_id,store_name,store_city,store_location, round(sum(total_price), 2) as sum_price,
round(sum(total_profit), 2) as sum_profit
from temp_t group by 1,2,3,4 order by sum_price desc;






--  monthly sales trends analysis

with temp as
(select s.units,s.date,p.*, (s.Units *p.Product_Price) as total_sale_price,
(s.Units *p.Profit) as total_profit
from sales s
inner join products p
on s.Product_ID = p.Product_ID )


select year(STR_TO_DATE(date, '%d-%m-%Y')) as year_order,
month(STR_TO_DATE(date, '%d-%m-%Y')) as month_order,
round(sum(total_sale_price), 2) as total_sales
from temp
where year(STR_TO_DATE(date, '%d-%m-%Y')) is not null
group by 1,2 order by round(sum(total_sale_price), 2) desc;




-- monthly sales trends analysis, considering the rolling 3-month average

with temp as
(select s.units,s.date,p.*, (s.Units *p.Product_Price) as total_price,
(s.Units *p.Profit) as total_profit
from sales s
inner join products p
on s.Product_ID = p.Product_ID ),
temp_2 as
(select year(STR_TO_DATE(date, '%d-%m-%Y')) as year_order,
month(STR_TO_DATE(date, '%d-%m-%Y')) as month_order,
round(sum(total_price), 2) as total_sales
from temp
where year(STR_TO_DATE(date, '%d-%m-%Y')) is not null and month(STR_TO_DATE(date, '%d-%m-%Y')) is not null
group by 1,2)

select *,
avg(total_sales) over (order by year_order asc, month_order asc rows between 2 preceding and 0 following) as rolling_avg
from temp_2;






-- category wise profit

with temp as
(select s.units,s.date,p.*, (s.Units *p.Product_Price) as total_price,
(s.Units *p.Profit) as total_profit
from sales s
inner join products p
on s.Product_ID = p.Product_ID )

select product_category, round(sum(total_price), 2) as price, round(sum(total_profit), 2) as profit from temp
group by product_category;




-- Inventory Turnover Ratio.


with sales_t as
(select s.units,s.store_id as store_id,p.*, (s.Units *p.Product_Price) as total_price,
(s.Units *p.Profit) as total_profit
from sales s
inner join products p
on s.Product_ID = p.Product_ID ),
sales_f as
(select store_id, round(sum(total_price),2) as sales_price from sales_t group by store_id),
inv_t as 
(select i.Store_ID as store_id , i.Stock_On_Hand, p.*,
(p.Product_Price * i.Stock_On_Hand) as total_inv_cost
from inventory i 
inner join products p 
on i.Product_ID = p.product_id
),
inv_f as
(select store_id, round(sum(total_inv_cost),2) as inv_price from inv_t group by store_id )

select fi.store_id,fi.inv_price, fs.sales_price,
round((fs.sales_price/fi.inv_price), 2) as ratio
from inv_f fi
inner join sales_f fs
on fs.store_id = fi.store_id









