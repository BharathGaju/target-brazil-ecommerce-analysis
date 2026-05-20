-- =========================================================
-- TARGET BRAZIL E-COMMERCE ANALYSIS
-- SECTION 1: DATA EXPLORATION
-- =========================================================


-- 1. CHECK DATA TYPES IN CUSTOMERS TABLE

SELECT
    column_name,
    data_type
FROM `Target.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'customers';


-- Insight:
-- Customer-related fields mainly contain string data types,
-- while zip code prefix is stored as an integer.


-- =========================================================


-- 2. FIND THE TIME RANGE OF ORDERS

SELECT
    MIN(order_purchase_timestamp) AS first_order_date,
    MAX(order_purchase_timestamp) AS last_order_date
FROM `Target.orders`;


-- Insight:
-- Orders were placed between September 2016 and October 2018.


-- =========================================================


-- 3. COUNT TOTAL CITIES AND STATES OF CUSTOMERS

SELECT
    COUNT(DISTINCT customer_city) AS total_cities,
    COUNT(DISTINCT customer_state) AS total_states
FROM `Target.customers` c
JOIN `Target.orders` o
    ON c.customer_id = o.customer_id;


-- Insight:
-- Customers placed orders from thousands of cities
-- across multiple Brazilian states.
