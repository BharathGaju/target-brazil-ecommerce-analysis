-- =========================================================
-- TARGET BRAZIL E-COMMERCE ANALYSIS
-- SECTION 5: DELIVERY PERFORMANCE ANALYSIS
-- =========================================================


-- 1. DELIVERY TIME ANALYSIS

SELECT
    order_id,

    order_purchase_timestamp,

    order_delivered_customer_date,

    order_estimated_delivery_date,

    DATE_DIFF(
        DATE(order_delivered_customer_date),
        DATE(order_purchase_timestamp),
        DAY
    ) AS delivery_time_days,

    DATE_DIFF(
        DATE(order_delivered_customer_date),
        DATE(order_estimated_delivery_date),
        DAY
    ) AS estimated_vs_actual_delivery_days

FROM `Target.orders`

WHERE order_delivered_customer_date IS NOT NULL;


-- Insight:
-- This analysis helps measure actual delivery duration
-- and compare it against estimated delivery timelines.


-- =========================================================


-- 2. TOP 5 STATES WITH HIGHEST AVERAGE FREIGHT VALUE

SELECT
    customer_state,

    ROUND(AVG(freight_value), 2) AS average_freight_value

FROM (

    SELECT
        c.customer_state,
        oi.freight_value

    FROM `Target.order_items` oi

    JOIN `Target.orders` o
        ON oi.order_id = o.order_id

    JOIN `Target.customers` c
        ON o.customer_id = c.customer_id

)

GROUP BY customer_state

ORDER BY average_freight_value DESC
LIMIT 5;


-- Insight:
-- Some states experienced significantly higher average freight costs,
-- likely due to longer delivery distances and logistics complexity.


-- =========================================================


-- 3. TOP 5 STATES WITH LOWEST AVERAGE FREIGHT VALUE

SELECT
    customer_state,

    ROUND(AVG(freight_value), 2) AS average_freight_value

FROM (

    SELECT
        c.customer_state,
        oi.freight_value

    FROM `Target.order_items` oi

    JOIN `Target.orders` o
        ON oi.order_id = o.order_id

    JOIN `Target.customers` c
        ON o.customer_id = c.customer_id

)

GROUP BY customer_state

ORDER BY average_freight_value
LIMIT 5;


-- Insight:
-- States with lower freight costs may benefit from
-- stronger logistics infrastructure and shorter shipping routes.


-- =========================================================


-- 4. TOP 5 STATES WITH HIGHEST AVERAGE DELIVERY TIME

SELECT
    customer_state,

    ROUND(AVG(delivery_time_days), 2) AS average_delivery_time

FROM (

    SELECT
        c.customer_state,

        DATE_DIFF(
            DATE(o.order_delivered_customer_date),
            DATE(o.order_purchase_timestamp),
            DAY
        ) AS delivery_time_days

    FROM `Target.orders` o

    JOIN `Target.customers` c
        ON o.customer_id = c.customer_id

    WHERE o.order_delivered_customer_date IS NOT NULL

)

GROUP BY customer_state

ORDER BY average_delivery_time DESC
LIMIT 5;


-- Insight:
-- Certain regions experienced longer delivery times,
-- indicating possible operational or geographical challenges.


-- =========================================================


-- 5. TOP 5 STATES WITH LOWEST AVERAGE DELIVERY TIME

SELECT
    customer_state,

    ROUND(AVG(delivery_time_days), 2) AS average_delivery_time

FROM (

    SELECT
        c.customer_state,

        DATE_DIFF(
            DATE(o.order_delivered_customer_date),
            DATE(o.order_purchase_timestamp),
            DAY
        ) AS delivery_time_days

    FROM `Target.orders` o

    JOIN `Target.customers` c
        ON o.customer_id = c.customer_id

    WHERE o.order_delivered_customer_date IS NOT NULL

)

GROUP BY customer_state

ORDER BY average_delivery_time
LIMIT 5;


-- Insight:
-- Faster-delivery states may indicate stronger transportation
-- networks and better warehouse accessibility.


-- =========================================================


-- 6. STATES WHERE DELIVERIES ARRIVED FASTER
-- THAN ESTIMATED DELIVERY DATE

SELECT
    customer_state,

    ROUND(AVG(early_delivery_days), 2) AS average_early_delivery_days

FROM (

    SELECT
        c.customer_state,

        DATE_DIFF(
            DATE(o.order_estimated_delivery_date),
            DATE(o.order_delivered_customer_date),
            DAY
        ) AS early_delivery_days

    FROM `Target.orders` o

    JOIN `Target.customers` c
        ON o.customer_id = c.customer_id

    WHERE o.order_delivered_customer_date IS NOT NULL

)

GROUP BY customer_state

ORDER BY average_early_delivery_days DESC
LIMIT 5;


-- Insight:
-- Some states consistently received deliveries earlier
-- than estimated, indicating efficient delivery operations.
