CREATE DATABASE supermarket;

USE supermarket;
CREATE TABLE sales (
    date DATE,
    branch VARCHAR(50),
    customer_type VARCHAR(20),
    gender VARCHAR(10),
    product_line VARCHAR(50),
    unit_price DECIMAL(10,2),
    quantity INT,
    payment VARCHAR(20),
    rating INT,
    sales DECIMAL(10,2)
);

# IMPORTING DATA FROM CSV FILE INTO TABLE USING DATA WIZARD 


-- Total number of transactions
SELECT COUNT(*) AS total_transactions
FROM sales_data;


-- Date range of data
SELECT MIN(date) AS start_date, MAX(date) AS end_date
FROM sales_data;


-- Distinct branches
SELECT DISTINCT branch FROM sales_data;
-- Distinct product categories
SELECT DISTINCT product_line FROM sales_data;
-- Distinct payment methods
SELECT DISTINCT payment FROM sales_data;


-- Total revenue
SELECT SUM(sales) AS total_revenue
FROM sales_data;

-- Revenue by branch
SELECT branch, SUM(sales) AS total_revenue
FROM sales_data
GROUP BY branch
ORDER BY total_revenue DESC;


-- Revenue by product line
SELECT product_line, SUM(sales) AS total_revenue
FROM sales_data
GROUP BY product_line
ORDER BY total_revenue DESC;


-- Revenue by customer type
SELECT customer_type,
       SUM(sales) AS total_revenue
FROM sales_data
GROUP BY customer_type;

-- Gender-based analysis
SELECT gender, SUM(sales) AS total_revenue,AVG(sales) AS avg_bill_value
FROM sales_data
GROUP BY gender;


-- Average unit price by product line
SELECT product_line, AVG(unit_price) AS avg_unit_price
FROM sales_data
GROUP BY product_line;


-- Total quantity sold by product line
SELECT product_line ,SUM(quantity) AS total_units_sold
FROM sales_data
GROUP BY product_line
ORDER BY total_units_sold DESC;


-- Transactions and revenue by payment method
SELECT payment, COUNT(*) AS total_transactions, SUM(sales) AS total_revenue
FROM sales_data
GROUP BY payment
ORDER BY total_revenue DESC;


-- Average rating by product line
SELECT product_line, AVG(rating) AS avg_rating
FROM sales_data
GROUP BY product_line
ORDER BY avg_rating DESC;


-- Average rating by branch
SELECT branch, AVG(rating) AS avg_rating
FROM sales_data
GROUP BY branch;


-- Daily sales_data trend
SELECT date, SUM(sales) AS daily_sales
FROM sales_data
GROUP BY date
ORDER BY date;



-- Monthly sales_data analysis
SELECT MONTH(date) AS month, SUM(sales) AS monthly_revenue
FROM sales_data
GROUP BY MONTH(date)
ORDER BY month;


-- Top 3 highest revenue days
SELECT date, SUM(sales) AS total_revenue
FROM sales_data
GROUP BY date
ORDER BY total_revenue DESC
LIMIT 3;


-- Identify unusually high sales_data (outliers)
SELECT *
FROM sales_data
WHERE sales > (
    SELECT AVG(sales) + 3 * STDDEV(sales)
    FROM sales_data
);


-- Average revenue per transaction
SELECT AVG(sales) AS avg_transaction_value
FROM sales_data;


-- Branch contribution percentage
SELECT branch, SUM(sales) AS branch_revenue, 
ROUND(SUM(sales) * 100 / (SELECT SUM(sales) FROM sales_data), 2) AS revenue_percentage
FROM sales_data
GROUP BY branch;



