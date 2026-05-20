-- =========================================================
-- TARGET BRAZIL E-COMMERCE ANALYSIS
-- SECTION 3: CUSTOMER & REGIONAL ANALYSIS
-- =========================================================


-- 1. MONTH-ON-MONTH ORDERS BY STATE

SELECT
    c.customer_state,

    FORMAT_TIMESTAMP(
        '%Y-%m',
        o.order_purchase_timestamp
    ) AS order_month,

    COUNT(o.order_id) AS total_orders

FROM `Target.customers` c

JOIN `Target.orders` o
    ON c.customer_id = o.customer_id

GROUP BY
    c.customer_state,
    order_month

ORDER BY
    c.customer_state,
    order_month;


-- Insight:
-- Order activity varied significantly across states,
-- with some regions showing consistently higher order volumes.


-- =========================================================


-- 2. CUSTOMER DISTRIBUTION ACROSS STATES

SELECT
    c.customer_state,

    COUNT(DISTINCT c.customer_unique_id) AS total_customers

FROM `Target.customers` c

JOIN `Target.orders` o
    ON c.customer_id = o.customer_id

GROUP BY c.customer_state

ORDER BY total_customers DESC;


-- Insight:
-- São Paulo (SP) had the highest customer concentration,
-- indicating stronger e-commerce penetration in the region.


-- =========================================================


-- 3. TOP 10 STATES BY TOTAL ORDERS

SELECT
    c.customer_state,

    COUNT(o.order_id) AS total_orders

FROM `Target.customers` c

JOIN `Target.orders` o
    ON c.customer_id = o.customer_id

GROUP BY c.customer_state

ORDER BY total_orders DESC
LIMIT 10;


-- Insight:
-- A small number of states contributed a large share
-- of overall order volume.


-- =========================================================


-- 4. CUSTOMER GROWTH TREND BY YEAR

SELECT
    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS order_year,

    COUNT(DISTINCT c.customer_unique_id) AS total_customers

FROM `Target.customers` c

JOIN `Target.orders` o
    ON c.customer_id = o.customer_id

GROUP BY order_year

ORDER BY order_year;


-- Insight:
-- The customer base expanded steadily over time,
-- reflecting growing adoption of online shopping.
