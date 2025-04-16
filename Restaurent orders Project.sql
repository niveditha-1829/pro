CREATE DATABASE restaurant_db;
USE restaurant_db;

-- Top 5 Most Ordered Items 
SELECT 
    mi.item_name, 
    COUNT(*) AS total_orders
FROM 
    order_details od
JOIN 
    menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY 
    mi.item_name
ORDER BY 
    total_orders DESC
LIMIT 5;

-- Total Revenue by Day
SELECT 
    order_date, 
    SUM(mi.price) AS daily_revenue
FROM 
    order_details od
JOIN 
    menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY 
    order_date
ORDER BY 
    order_date;

-- Most Popular Categories 
SELECT 
    mi.category,
    COUNT(*) AS items_ordered
FROM 
    order_details od
JOIN 
    menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY 
    mi.category
ORDER BY 
    items_ordered DESC;

-- Order Volume by Hour 
SELECT 
    HOUR(order_time) AS order_hour,
    COUNT(*) AS orders
FROM 
    order_details
GROUP BY 
    order_hour
ORDER BY 
    orders DESC;
    
--   Monthly Revenue Trend 
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(mi.price) AS revenue
FROM 
    order_details od
JOIN 
    menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY 
    month
ORDER BY 
    month;
    
-- Which day had the highest total revenue 
SELECT 
    order_date, 
    SUM(mi.price) AS total_revenue
FROM 
    order_details od
JOIN 
    menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY 
    order_date
ORDER BY 
    total_revenue DESC
LIMIT 1;

--  What is the average number of items per order
SELECT 
    AVG(item_count) AS avg_items_per_order
FROM (
    SELECT 
        order_id, 
        COUNT(*) AS item_count
    FROM 
        order_details
    GROUP BY 
        order_id
) sub;

-- What is the average revenue per order
SELECT 
    AVG(order_total) AS avg_order_value
FROM (
    SELECT 
        od.order_id, 
        SUM(mi.price) AS order_total
    FROM 
        order_details od
    JOIN 
        menu_items mi ON od.item_id = mi.menu_item_id
    GROUP BY 
        od.order_id
) sub;

-- What are the top 3 most popular items in each category
SELECT 
    category, 
    item_name, 
    total_orders
FROM (
    SELECT 
        mi.category,
        mi.item_name,
        COUNT(*) AS total_orders,
        RANK() OVER (PARTITION BY mi.category ORDER BY COUNT(*) DESC) AS rnk
    FROM 
        order_details od
    JOIN 
        menu_items mi ON od.item_id = mi.menu_item_id
    GROUP BY 
        mi.category, mi.item_name
) ranked
WHERE rnk <= 3;

-- Which month had the highest number of orders
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    order_details
GROUP BY 
    month
ORDER BY 
    total_orders DESC
LIMIT 1;

-- What is the busiest time slot (per hour)
SELECT 
    HOUR(order_time) AS hour_slot,
    COUNT(*) AS total_items_ordered
FROM 
    order_details
GROUP BY 
    hour_slot
ORDER BY 
    total_items_ordered DESC
LIMIT 1;

-- How many unique items are on the menu per category
SELECT 
    category,
    COUNT(DISTINCT item_name) AS unique_items
FROM 
    menu_items
GROUP BY 
    category;

-- What's the price range per menu category
SELECT 
    category,
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    AVG(price) AS avg_price
FROM 
    menu_items
GROUP BY 
    category;

-- List all orders with more than 5 items (large orders)
SELECT 
    order_id,
    COUNT(*) AS item_count
FROM 
    order_details
GROUP BY 
    order_id
HAVING 
    item_count > 5
ORDER BY 
    item_count DESC;
    
-- What is the distribution of orders across weekdays
SELECT 
    DAYNAME(order_date) AS weekday,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    order_details
GROUP BY 
    weekday
ORDER BY 
    total_orders DESC;

