-- =========================================================
-- TARGET BRAZIL E-COMMERCE ANALYSIS
-- SECTION 6: PAYMENT ANALYSIS
-- =========================================================


-- 1. MONTH-ON-MONTH ORDERS BY PAYMENT TYPE

SELECT
    FORMAT_TIMESTAMP(
        '%Y-%m',
        o.order_purchase_timestamp
    ) AS order_month,

    p.payment_type,

    COUNT(DISTINCT o.order_id) AS total_orders

FROM `Target.orders` o

JOIN `Target.payments` p
    ON o.order_id = p.order_id

GROUP BY
    order_month,
    p.payment_type

ORDER BY
    order_month,
    total_orders DESC;


-- Insight:
-- Credit cards remained the most commonly used payment method
-- across the observed time period.


-- =========================================================


-- 2. ANALYSIS OF PAYMENT INSTALLMENTS

SELECT
    payment_installments,

    COUNT(DISTINCT order_id) AS total_orders

FROM `Target.payments`

GROUP BY payment_installments

ORDER BY payment_installments;


-- Insight:
-- Many customers preferred installment-based payments,
-- indicating demand for flexible purchasing options.


-- =========================================================


-- 3. AVERAGE PAYMENT VALUE BY PAYMENT TYPE

SELECT
    payment_type,

    ROUND(AVG(payment_value), 2) AS average_payment_value

FROM `Target.payments`

GROUP BY payment_type

ORDER BY average_payment_value DESC;


-- Insight:
-- Different payment methods showed noticeable differences
-- in average transaction value.
