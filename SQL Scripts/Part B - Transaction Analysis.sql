---------------------------
--B. Transaction Analysis--
---------------------------

--Author: Ela Wajdzik
--Date: 25.11.2024
--Tool used: Microsoft SQL Server


-- 1. How many unique transactions were there?

SELECT 
	COUNT(DISTINCT txn_id) AS number_of_txn
FROM sales;

-- 2. What is the average unique products purchased in each transaction?

WITH txn_with_products AS (
	SELECT 
		txn_id,
		COUNT(DISTINCT prod_id) AS number_of_uq_products
	FROM sales
	GROUP BY txn_id)

SELECT 
	CAST(AVG(number_of_uq_products * 1.0) AS NUMERIC(3,1)) AS avg_number_of_products
FROM txn_with_products;

-- 3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?

WITH txn_with_revenue AS (
	SELECT 
		txn_id,
		SUM(qty * price - discount) AS txn_revenue,
		SUM(qty * price) AS txn_revenue_before_discount
	FROM sales
	GROUP BY txn_id)

SELECT DISTINCT
	PERCENTILE_DISC(0.25) WITHIN GROUP (ORDER BY txn_revenue) OVER () AS percentile_25th,
	PERCENTILE_DISC(0.50) WITHIN GROUP (ORDER BY txn_revenue) OVER () AS percentile_50th,
    PERCENTILE_DISC(0.75) WITHIN GROUP (ORDER BY txn_revenue) OVER () AS percentile_75th,
	PERCENTILE_DISC(0.25) WITHIN GROUP (ORDER BY txn_revenue_before_discount) OVER () AS percentile_25th_without_discount,
	PERCENTILE_DISC(0.50) WITHIN GROUP (ORDER BY txn_revenue_before_discount) OVER () AS percentile_50th_without_discount,
    PERCENTILE_DISC(0.75) WITHIN GROUP (ORDER BY txn_revenue_before_discount) OVER () AS percentile_75th_without_discount
FROM txn_with_revenue

-- 4. What is the average discount value per transaction?

WITH txn_with_discount AS (
	SELECT 
		txn_id,
		SUM(discount) AS total_discount_per_txn
	FROM sales
	GROUP BY txn_id)

SELECT 
	CAST(AVG(total_discount_per_txn * 1.0) AS NUMERIC(5,2)) AS avg_disciunt_per_txn
FROM txn_with_discount;

-- 5. What is the percentage split of all transactions for members vs non-members?

WITH total_sales AS (
	SELECT 
		COUNT(DISTINCT txn_id) AS total_txn,
		SUM(qty * price - discount) AS total_revenue
	FROM sales),

member_sales AS (
SELECT 
	member,
	COUNT(DISTINCT txn_id) AS number_of_txn,
	SUM(qty * price - discount) AS total_revenue_after_discount
FROM sales 
GROUP BY member
)

SELECT 
	CASE ms.member WHEN 1 THEN 'members' ELSE 'non-members' END AS group_member,
	CAST(ms.number_of_txn * 100.0 / ts.total_txn AS NUMERIC (4,1))  AS perc_of_transactions,
	CAST(ms.total_revenue_after_discount * 100.0 / ts.total_revenue AS NUMERIC(4,1)) AS perc_of_revenue
FROM member_sales ms
CROSS JOIN total_sales ts


-- 6. What is the average revenue for member transactions and non-member transactions?

SELECT 
	CASE member WHEN 1 THEN 'members' ELSE 'non-members' END AS group_member,
	CAST(AVG(qty * price - discount * 1.0) AS NUMERIC(5,2)) AS avg_price_of_transaction
FROM sales 
GROUP BY mem
