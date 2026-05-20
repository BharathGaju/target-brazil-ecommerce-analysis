-- =========================================================
-- TARGET BRAZIL E-COMMERCE ANALYSIS
-- SECTION 2: ORDER TREND ANALYSIS
-- =========================================================


-- 1. YEAR-WISE ORDER TREND

SELECT
    EXTRACT(YEAR FROM order_purchase_timestamp) AS order_year,
    COUNT(*) AS total_orders
FROM `Target.orders`
GROUP BY order_year
ORDER BY order_year;


-- Insight:
-- Order volume increased significantly between 2016 and 2018,
-- indicating strong e-commerce growth.


-- =========================================================


-- 2. MONTHLY ORDER ANALYSIS

SELECT
    FORMAT_TIMESTAMP('%Y-%m', order_purchase_timestamp) AS order_month,
    COUNT(*) AS total_orders
FROM `Target.orders`
GROUP BY order_month
ORDER BY order_month;


-- Insight:
-- Order activity fluctuated across months,
-- showing periods of higher customer demand.


-- =========================================================


-- 3. CUSTOMER PURCHASE TIMING ANALYSIS

WITH hourly_orders AS (

    SELECT
        EXTRACT(HOUR FROM order_purchase_timestamp) AS order_hour,
        COUNT(*) AS total_orders
    FROM `Target.orders`
    GROUP BY order_hour

)

SELECT
    CASE
        WHEN order_hour BETWEEN 0 AND 6 THEN 'Dawn'
        WHEN order_hour BETWEEN 7 AND 12 THEN 'Morning'
        WHEN order_hour BETWEEN 13 AND 18 THEN 'Afternoon'
        ELSE 'Night'
    END AS time_of_day,

    SUM(total_orders) AS total_orders

FROM hourly_orders
GROUP BY time_of_day
ORDER BY total_orders DESC;


-- Insight:
-- Most customers placed orders during afternoon hours.
