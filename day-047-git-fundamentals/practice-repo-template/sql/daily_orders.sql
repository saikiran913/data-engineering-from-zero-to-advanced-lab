-- Daily orders review query
-- Purpose: inspect completed sample orders without changing data.

SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    order_amount
FROM orders_sample
WHERE order_status = 'COMPLETED'
ORDER BY order_date;
