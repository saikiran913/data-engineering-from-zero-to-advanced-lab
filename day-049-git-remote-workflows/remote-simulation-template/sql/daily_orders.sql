-- Daily orders remote workflow example
-- Purpose: inspect completed sample orders without changing data.

SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    order_amount
FROM orders_sample
WHERE order_date >= '2026-08-01'
  AND order_status = 'COMPLETED'
ORDER BY order_date;
