create database sales;
use sales;
select count(*) from sales_data;
select * from sales_data limit 10;

 SET SQL_SAFE_UPDATES = 0;
 
 UPDATE sales_data
 SET ORderDateFixed = STR_TO_DATE(ORDERDATE, '%m/%d/%Y %H:%i');
 
 SET SQL_SAFE_UPDATES = 1;
 
select count(*) as unparsed_dates
from sales_data
where OrderDateFixed is null;

# Question 1 : What are 10 highest-value single orders, and what product line were they from?.
Select 
	ORDERNUMBER,
    CUSTOMERNAME,
    PRODUCTLINE,
    SALES, 
    OrderDateFixed 
from sales_data
where SALES > 5000 
order by SALES desc
limit 10;

# Question 2. Which product lines generates the most total revenue?
select
	PRODUCTLINE,
    count(*) as TotalOrders,
    sum(SALES) as TotalRevenue
from sales_data 
group by PRODUCTLINE
having sum(SALES) > 10000
order by TotalRevenue desc;

# Question 3. What's the average order value and total revenue by country?
select
	COUNTRY,
    count(*) as TotalOrders,
    round(avg(SALES), 2) as AvgOrderValue,
    round(sum(SALES), 2) as TotalRevenue 
from sales_data
group by COUNTRY
order by TotalRevenue desc;    

# Question 4. which customer are the highest revenue generator?
select
	CUSTOMERNAME,
    sum(SALES) as TotalRevenue ,
    rank() over ( order by
sum(SALES) desc) as CustomerRank
from sales_data
group by CUSTOMERNAME;

# 5. Rank all orders from highest to lowest sales values
select
	ORDERNUMBER,
    CUSTOMERNAME,
    PRODUCTLINE, 
    SALES,
    row_number() over (order by
SALES desc) as SalesRank
from sales_data;

# Question 6. Who are the top customer in each country?
select 
	COUNTRY,
    CUSTOMERNAME, 
    sum(SALES) as TotalRevenue, 
    rank() over (
		partition by COUNTRY
        order by sum(SALES) desc
	) as CountryRank
from sales_data
group by COUNTRY, CUSTOMERNAME;

#  7. Revenue Trend Over Time 
select
	year(OrderDateFixed) as Year,
    Month(OrderDateFixed) as month,
    round(sum(SALES), 2) as Revenue
from sales_data 
group by Year(OrderDateFixed), 
		Month (OrderDateFixed)
order by  Year, Month;

# 8. Customer Purchasing Behaviour 
select
	CUSTOMERNAME,
    count(*) as TotalOrders, 
    round(sum(SALES),2) as TotalSpent
from sales_data
group by CUSTOMERNAME
order by TotalSpent desc
limit  10;

