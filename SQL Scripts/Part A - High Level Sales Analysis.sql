--------------------------------
--A. High Level Sales Analysis--
--------------------------------

--Author: Ela Wajdzik
--Date: 24.11.2024
--Tool used: Microsoft SQL Server

-- 1. What was the total quantity sold for all products?
-- 2. What is the total generated revenue for all products before discounts?
-- 3. What was the total discount amount for all products?

SELECT 
	COUNT(DISTINCT txn_id) AS number_of_txn,
	SUM(qty) AS total_quantity,
	SUM(qty * price) AS total_revenue_before_discount,
	SUM(discount) AS total_discount
FROM sales;
