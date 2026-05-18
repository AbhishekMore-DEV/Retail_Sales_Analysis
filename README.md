# Retail Sales SQL Analysis Documentation

## Project Title
Retail Sales Analysis Using SQL

---

# 1. Project Overview

This project focuses on analyzing retail sales data using SQL.
The main objective is to extract business insights related to:

- Sales performance
- Customer behavior
- Product category trends
- Monthly sales analysis
- Revenue generation

The project demonstrates practical SQL skills used in real-world data analysis projects.

---

# 2. Objectives

The objectives of this project are:

- Perform data cleaning using SQL
- Analyze retail transaction data
- Solve business-related questions
- Generate insights from raw sales data
- Practice SQL querying techniques

---

# 3. Tools & Technologies Used

| Tool | Purpose |
|---|---|
| SQL | Data Analysis |
| PostgreSQL | Database Management |
| CSV Dataset | Source Data |
| GitHub | Project Hosting |

---

# 4. Dataset Description

The dataset contains retail transaction records.

## Columns Used

| Column Name | Description |
|---|---|
| transactions_id | Unique transaction ID |
| sale_date | Date of purchase |
| sale_time | Time of purchase |
| customer_id | Unique customer ID |
| gender | Customer gender |
| age | Customer age |
| category | Product category |
| quantity | Number of products sold |
| price_per_unit | Price per item |
| cogs | Cost of goods sold |
| total_sale | Total sales amount |

---

# 5. Database Schema

```sql
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
```

---

# 6. Data Cleaning Process

The following data cleaning operations were performed:

- Checked total records
- Identified NULL values
- Removed incomplete records
- Verified dataset consistency

## NULL Value Check

```sql
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
```

---

# 7. Business Problems Solved

## Q1. Retrieve all sales made on '2022-11-05'

```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

### Objective
Analyze transactions for a specific day.

---

## Q2. Retrieve all Clothing transactions where quantity sold is greater than or equal to 3 in November 2022

```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity >= 3
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';
```

### Objective
Identify bulk clothing purchases during November 2022.

---

## Q3. Calculate total sales and total orders for each category

```sql
SELECT
    category,
    SUM(total_sale) AS total_sales,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

### Objective
Evaluate category-wise sales performance.

---

## Q4. Find the average age of customers who purchased items from the Beauty category


```sql
SELECT
    ROUND(AVG(age), 2) AS average_age
FROM retail_sales
WHERE category = 'Beauty';
```

### Objective
Understand customer demographics.

---

## Q5. Find all transactions where total_sale is greater than 1000


```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

### Objective
Identify high-value transactions.

---

## Q6. Find total number of transactions made by each gender in each category


```sql
SELECT
    category,
    gender,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category, gender;
```

### Objective
Analyze purchasing behavior by gender.

---

## Q7. Calculate average monthly sales and identify the best-selling month in each year


```sql
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
    GROUP BY 1,2
)

SELECT *
FROM monthly_sales
WHERE sales_rank = 1;
```

### Objective
Identify top-performing months.

---

## Q8. Find top 5 customers based on highest total sales


```sql
SELECT
    customer_id,
    SUM(total_sale) AS total_spent
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;
```

### Objective
Identify high-value customers.

---

## Q9. Find the number of unique customers who purchased items from each category


```sql
SELECT
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```

### Objective
Measure customer engagement across categories.

---

## Q10. Create sales shifts and count number of orders


```sql
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
GROUP BY shift;
```

### Objective
Analyze customer purchasing patterns based on time of day.

---

# 8. Key SQL Concepts Used

The project demonstrates the following SQL concepts:

- SELECT Statement
- WHERE Clause
- GROUP BY
- ORDER BY
- Aggregate Functions
- CASE WHEN
- Common Table Expressions (CTEs)
- Window Functions
- Date Functions
- Filtering & Sorting
- Data Cleaning

---

# 9. Key Insights

Some major insights from the analysis:

- Certain product categories generated higher revenue.
- High-value customers contributed significantly to total sales.
- Monthly sales trends varied throughout the year.
- Customer purchase behavior changed based on time of day.
- Clothing and Beauty categories showed strong transaction volumes.

---

# 10. Project Structure

```text
Retail-Sales-SQL-Analysis/
│
├── dataset/
│   └── retail_sales.csv
│
├── sql_queries/
│   └── retail_sales_analysis.sql
│
├── Result/
│
└── README.md
```

---

# 11. Conclusion

This project demonstrates how SQL can be used to clean, analyze, and extract business insights from retail sales data.

The analysis helps understand:

- Customer purchasing behavior
- Sales trends
- Revenue contribution
- Product performance

This project also strengthens practical SQL skills required for data analyst roles.

---

# 12. Future Improvements

Potential future enhancements:

- Build interactive dashboard using Power BI
- Add advanced SQL optimization
- Create stored procedures and views
- Perform customer segmentation analysis
- Integrate Python for deeper analysis

---

# 13. Author

Abhishek More
Aspiring Data Analyst

