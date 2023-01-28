/*
pizza Restaurant Sales Data Exploration

Skills used: Aggregate Functions, Updates, Joins, Creating Views 

*/

SELECT * FROM pizza_sales
ORDER BY 1

--- check null ---
SELECT count(*)
FROM pizza_sales
WHERE pizza_name IS NULL

--- check category ---
SELECT DISTINCT pizza_id
FROM pizza_sales
ORDER BY pizza_id

SELECT DISTINCT pizza_size
FROM pizza_sales
ORDER BY pizza_size

SELECT DISTINCT pizza_category
FROM pizza_sales
ORDER BY pizza_category

SELECT DISTINCT pizza_ingredients
FROM pizza_sales
ORDER BY pizza_ingredients

SELECT DISTINCT pizza_name
FROM pizza_sales
ORDER BY pizza_name

--- check duplicate row ---
SELECT 
    order_details_id,
    order_id,
    pizza_ingredients,
    pizza_name,
    pizza_size,
    COUNT(*)
FROM pizza_sales
GROUP BY order_details_id, order_id, pizza_ingredients, pizza_category, pizza_name, pizza_size
HAVING count(*) > 1
ORDER BY order_details_id

--- Looking at highest order pizza category ---
SELECT 
    pizza_category, 
    COUNT(*) AS order_no
FROM pizza_sales
GROUP BY pizza_category
ORDER BY order_no DESC

--- Looking at highest order pizza name ---
SELECT 
    pizza_name, 
    COUNT(*) AS order_no
FROM pizza_sales
GROUP BY pizza_name
ORDER BY order_no DESC

--- Looking at highest order pizza size ---
SELECT 
    pizza_size, 
    COUNT(*) AS order_no
FROM pizza_sales
GROUP BY pizza_size
ORDER BY order_no DESC

--- Looking at highest order pizza id ---
SELECT 
    pizza_id, 
    COUNT(*) AS order_no
FROM pizza_sales
GROUP BY pizza_id
ORDER BY order_no DESC

--- Looking at order by month ---
SELECT 
    EXTRACT(MONTH FROM order_date) AS month, 
    COUNT(*) AS order_by_month
FROM pizza_sales
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY month 

--- Looking at order by day of week  ---
SELECT 
    EXTRACT(DOW FROM order_date) AS day_of_week, 
    COUNT(*) AS order_by_day_week
FROM pizza_sales
GROUP BY EXTRACT(DOW FROM order_date)
ORDER BY day_of_week

---Looking at order by day of month ---
SELECT 
    EXTRACT(DAY FROM order_date) AS day_of_month, 
    COUNT(*) AS order_by_day_month
FROM pizza_sales
GROUP BY EXTRACT(DAY FROM order_date)
ORDER BY day_of_month

--- Looking at order by hour ---
SELECT 
    EXTRACT(HOUR FROM order_time) AS hour, 
    COUNT(*) AS order_by_hour
FROM pizza_sales
GROUP BY EXTRACT(HOUR FROM order_time)
ORDER BY hour

---Looking at highest sales of pizza category --- 
SELECT 
    pizza_category,
    SUM(total_price) AS gross_sales,
    SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_category
ORDER BY gross_sales DESC

---Looking at highest sales of pizza id --- 
SELECT 
    pizza_id,
    SUM(total_price) AS gross_sales,
    SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_id
ORDER BY gross_sales DESC
LIMIT 10

--- Adding month column to pizza_sales table ---
ALTER TABLE pizza_sales
ADD month INT;

UPDATE pizza_sales
SET month = EXTRACT(MONTH FROM order_date)

--- Adding hour column to pizza_sales table ---
ALTER TABLE pizza_sales
ADD hour INT;

UPDATE pizza_sales
SET hour = EXTRACT(HOUR FROM order_time)

--- Adding day of week coulumn to pizza_sales table ---
ALTER TABLE pizza_sales
ADD day_of_week_id INT;

UPDATE pizza_sales
SET day_of_week_id = EXTRACT(DOW FROM order_date)

--- Creating day_of_week table to express day of week id ---
CREATE TABLE day_of_week (
    day_of_week_id INT PRIMARY KEY,
    day_name VARCHAR(10)
);

INSERT INTO day_of_week (day_of_week_id, day_name) 
VALUES ('0', 'Sunday'),
       ('1', 'Monday'),
       ('2', 'Tuesday'),
       ('3', 'Wednesday'),
       ('4', 'Thursday'),
       ('5', 'Friday'),
       ('6', 'Saturday');
      
--- Join pizza_sales table with day_of_week table ---      
SELECT 
    a.order_id, a.order_details_id, a.pizza_id, a.quantity, a.order_date, a.order_time,
    a.unit_price, a.total_price, a.pizza_size, a.pizza_category, a.pizza_name, a.month,
    a.hour,
    b.day_name as day_of_week
FROM pizza_sales a
JOIN day_of_week b
ON a.day_of_week_id = b.day_of_week_id
ORDER BY 1 

--- Creating view to store data for later visualizations ---
Create View pizza_sales_dataset as
SELECT 
    a.order_id, a.order_details_id, a.pizza_id, a.quantity, a.order_date, a.order_time,
    a.unit_price, a.total_price, a.pizza_size, a.pizza_category, a.pizza_name, a.month,
    a.hour,
    b.day_name as day_of_week
FROM pizza_sales a
JOIN day_of_week b
ON a.day_of_week_id = b.day_of_week_id

SELECT *
FROM pizza_sales_dataset
ORDER BY 1















