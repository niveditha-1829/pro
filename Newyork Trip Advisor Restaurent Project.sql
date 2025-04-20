CREATE DATABASE tripadvisor;
USE tripadvisor;

CREATE TABLE Trip_Advisor_Restaurants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    number_of_review INT,
    catagory VARCHAR(255),
    review_comment TEXT,
    popular_food VARCHAR(255),
    online_order VARCHAR(10)
);

-- Top 10 Most Reviewed Restaurants
SELECT title, number_of_review
FROM Trip_Advisor_Restaurants
ORDER BY number_of_review DESC
LIMIT 10;

-- Restaurants That Support Online Orders
SELECT title
FROM Trip_Advisor_Restaurants
WHERE online_order = 'Yes';


-- Count of Restaurants per Category
SELECT catagory, COUNT(*) AS restaurant_count
FROM Trip_Advisor_Restaurants
GROUP BY catagory
ORDER BY restaurant_count DESC;


-- Restaurants Serving 'Italian' Cuisine
SELECT *
FROM Trip_Advisor_Restaurants
WHERE catagory LIKE '%Italian%';


-- Restaurants with More Than 1000 Reviews
SELECT title, number_of_review
FROM Trip_Advisor_Restaurants
WHERE number_of_review > 1000;


-- Popular Foods That Appear More Than Once
SELECT popular_food, COUNT(*) AS count
FROM Trip_Advisor_Restaurants
GROUP BY popular_food
HAVING count > 1;


-- Average Number of Reviews
SELECT AVG(number_of_review) AS avg_reviews
FROM Trip_Advisor_Restaurants;


-- Most Popular Food Overall
SELECT popular_food, COUNT(*) AS appearances
FROM Trip_Advisor_Restaurants
GROUP BY popular_food
ORDER BY appearances DESC
LIMIT 1;


-- Number of Restaurants That Don’t Offer Online Orders
SELECT COUNT(*) AS no_online_order
FROM Trip_Advisor_Restaurants
WHERE online_order = 'No';


-- Longest Review Comment
SELECT title, LENGTH(review_comment) AS comment_length
FROM Trip_Advisor_Restaurants
ORDER BY comment_length DESC
LIMIT 1;


-- Find All Restaurants With 'Lobster' in Reviews
SELECT title, review_comment
FROM Trip_Advisor_Restaurants
WHERE review_comment LIKE '%lobster%';


-- Top 5 Most Common Categories
SELECT catagory, COUNT(*) AS freq
FROM Trip_Advisor_Restaurants
GROUP BY catagory
ORDER BY freq DESC
LIMIT 5;


-- Restaurants with 'Steakhouse' in Category
SELECT title
FROM Trip_Advisor_Restaurants
WHERE catagory LIKE '%Steakhouse%';


-- Show Title and Popular Food for Restaurants with Over 500 Reviews
SELECT title, popular_food
FROM Trip_Advisor_Restaurants
WHERE number_of_review > 500;


-- Restaurants With Popular Food 'cacio e pepe'
SELECT title
FROM Trip_Advisor_Restaurants
WHERE LOWER(popular_food) = 'cacio e pepe';


-- Online Order Availability by Category
SELECT catagory, 
       SUM(CASE WHEN online_order = 'Yes' THEN 1 ELSE 0 END) AS online_yes,
       SUM(CASE WHEN online_order = 'No' THEN 1 ELSE 0 END) AS online_no
FROM Trip_Advisor_Restaurants
GROUP BY catagory;


-- Top 3 Categories with Most Reviews
SELECT catagory, SUM(number_of_review) AS total_reviews
FROM Trip_Advisor_Restaurants
GROUP BY catagory
ORDER BY total_reviews DESC
LIMIT 3;


-- Count of Distinct Food Items
SELECT COUNT(DISTINCT popular_food) AS distinct_food_items
FROM Trip_Advisor_Restaurants;


-- Percentage of Restaurants Offering Online Orders
SELECT 
  ROUND(SUM(CASE WHEN online_order = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS percent_online_order
FROM Trip_Advisor_Restaurants;


-- Restaurants That Mention ‘cheese’ in Review
SELECT title, review_comment
FROM Trip_Advisor_Restaurants
WHERE review_comment LIKE '%cheese%';


-- Category and Average Reviews Per Category
SELECT catagory, ROUND(AVG(number_of_review), 2) AS avg_reviews
FROM Trip_Advisor_Restaurants
GROUP BY catagory;
