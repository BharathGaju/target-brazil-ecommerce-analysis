-- =========================================================
-- TARGET BRAZIL E-COMMERCE ANALYSIS
-- SECTION 4: REVENUE & FREIGHT ANALYSIS
-- =========================================================


-- 1. PERCENTAGE INCREASE IN ORDER VALUE
-- COMPARISON: JAN-AUG 2017 VS JAN-AUG 2018

WITH yearly_sales AS (

    SELECT
        EXTRACT(YEAR FROM o.order_purchase_timestamp) AS order_year,

        ROUND(SUM(p.payment_value), 2) AS total_sales

    FROM `Target.orders` o

    JOIN `Target.payments` p
        ON o.order_id = p.order_id

    WHERE EXTRACT(MONTH FROM o.order_purchase_timestamp)
          BETWEEN 1 AND 8

    GROUP BY order_year

)

SELECT
    *,

    ROUND(
        100 * (
            total_sales
            - LAG(total_sales) OVER(ORDER BY order_year)
        )
        / LAG(total_sales) OVER(ORDER BY order_year),
        2
    ) AS percentage_growth

FROM yearly_sales;


-- Insight:
-- Total order value increased significantly from 2017 to 2018,
-- reflecting rapid growth in e-commerce transactions.


-- =========================================================


-- 2. TOTAL & AVERAGE ORDER VALUE BY STATE

SELECT
    c.customer_state,

    ROUND(SUM(oi.price), 2) AS total_order_value,

    ROUND(AVG(oi.price), 2) AS average_order_value

FROM `Target.order_items` oi

JOIN `Target.orders` o
    ON oi.order_id = o.order_id

JOIN `Target.customers` c
    ON o.customer_id = c.customer_id

GROUP BY c.customer_state

ORDER BY total_order_value DESC;


-- Insight:
-- São Paulo (SP) generated the highest overall revenue contribution,
-- while some smaller states recorded higher average order values.


-- =========================================================


-- 3. TOTAL & AVERAGE FREIGHT VALUE BY STATE

SELECT
    c.customer_state,

    ROUND(SUM(oi.freight_value), 2) AS total_freight_value,

    ROUND(AVG(oi.freight_value), 2) AS average_freight_value

FROM `Target.order_items` oi

JOIN `Target.orders` o
    ON oi.order_id = o.order_id

JOIN `Target.customers` c
    ON o.customer_id = c.customer_id

GROUP BY c.customer_state

ORDER BY total_freight_value DESC;


-- Insight:
-- Freight costs varied widely across regions,
-- indicating differences in shipping distance
-- and logistics complexity.
