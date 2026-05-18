-- =========================================================
-- PROJECT: Retail Sales Analysis Using SQL
-- DATABASE: PostgreSQL
-- =========================================================

-- =========================================================
-- CREATE TABLE
-- =========================================================

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

-- =========================================================
-- DATA PREVIEW
-- =========================================================

SELECT *
FROM retail_sales;

-- =========================================================
-- DATA CLEANING
-- =========================================================

-- Check total number of rows
SELECT COUNT(*) AS total_records
FROM retail_sales;

-- Check NULL values
SELECT *
FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- Delete NULL values
DELETE FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- =========================================================
-- DATA EXPLORATION
-- =========================================================

-- Total number of sales
SELECT COUNT(*) AS total_sales
FROM retail_sales;

-- Total number of unique customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM retail_sales;

-- Available product categories
SELECT DISTINCT category
FROM retail_sales;

-- Number of transactions by category
SELECT
    category,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category
ORDER BY total_transactions DESC;

-- =========================================================
-- BUSINESS PROBLEMS & ANALYSIS
-- =========================================================

-- Q1. Retrieve all sales made on '2022-11-05'

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- =========================================================

-- Q2. Retrieve all Clothing transactions where quantity sold
-- is greater than or equal to 3 in November 2022

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity >= 3
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';

-- =========================================================

-- Q3. Calculate total sales and total orders for each category

SELECT
    category,
    SUM(total_sale) AS total_sales,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;

-- =========================================================

-- Q4. Find the average age of customers who purchased
-- items from the Beauty category

SELECT
    ROUND(AVG(age), 2) AS average_age
FROM retail_sales
WHERE category = 'Beauty';

-- =========================================================

-- Q5. Find all transactions where total_sale is greater than 1000

SELECT *
FROM retail_sales
WHERE total_sale > 1000;

-- =========================================================

-- Q6. Find total number of transactions made by each gender
-- in each category

SELECT
    category,
    gender,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY category, gender;

-- =========================================================

-- Q7. Calculate average monthly sales and identify
-- the best-selling month in each year

WITH monthly_sales AS (
    SELECT
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS average_sales,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS sales_rank
    FROM retail_sales
    GROUP BY 1, 2
)

SELECT
    year,
    month,
    ROUND(average_sales, 2) AS average_sales
FROM monthly_sales
WHERE sales_rank = 1;

-- =========================================================

-- Q8. Find top 5 customers based on highest total sales

SELECT
    customer_id,
    SUM(total_sale) AS total_spent
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- =========================================================

-- Q9. Find the number of unique customers
-- who purchased items from each category

SELECT
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category
ORDER BY unique_customers DESC;

-- =========================================================

-- Q10. Create sales shifts and count number of orders
-- Morning  : Before 12 PM
-- Afternoon: Between 12 PM and 5 PM
-- Evening  : After 5 PM

WITH sales_shifts AS (

    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales

)

SELECT
    shift,
    COUNT(*) AS total_orders
FROM sales_shifts
GROUP BY shift
ORDER BY total_orders DESC;

-- =========================================================
-- END OF PROJECT
-- =========================================================