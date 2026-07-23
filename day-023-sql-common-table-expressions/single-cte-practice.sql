-- Day 023: Single CTE Practice
-- Topic: Use one named query step at a time.
-- Safety note: every query in this file is read-only.

-- 1. Active customers.
WITH active_customers AS (
    SELECT customer_id, customer_name, country, signup_date
    FROM customers
    WHERE customer_status = 'ACTIVE'
)
SELECT *
FROM active_customers
ORDER BY customer_id;

-- 2. Valid orders.
WITH valid_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        order_status,
        order_amount,
        updated_at,
        source_file
    FROM raw_orders
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
      AND order_status IN ('COMPLETED', 'PENDING')
)
SELECT *
FROM valid_orders
ORDER BY order_date, order_id;

-- 3. Successful payments.
WITH successful_payments AS (
    SELECT payment_id, order_id, payment_amount, payment_date
    FROM payments
    WHERE payment_status = 'SUCCESS'
)
SELECT *
FROM successful_payments
ORDER BY payment_date, payment_id;

-- 4. Daily sales summary.
WITH daily_sales_summary AS (
    SELECT
        sale_date,
        COUNT(*) AS sale_row_count,
        SUM(quantity) AS total_quantity,
        SUM(sales_amount) AS total_sales_amount
    FROM daily_sales
    WHERE quantity > 0
      AND sales_amount > 0
    GROUP BY sale_date
)
SELECT *
FROM daily_sales_summary
ORDER BY sale_date;

-- 5. Customer order summary.
WITH customer_order_summary AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count,
        SUM(order_amount) AS total_order_value
    FROM raw_orders
    WHERE customer_id IS NOT NULL
      AND order_status = 'COMPLETED'
      AND order_amount > 0
    GROUP BY customer_id
)
SELECT *
FROM customer_order_summary
WHERE total_order_value > 500
ORDER BY total_order_value DESC;

-- 6. Latest order version.
-- ROW_NUMBER is used only to connect with Day 021.
WITH ranked_orders AS (
    SELECT
        order_id,
        customer_id,
        order_status,
        order_amount,
        updated_at,
        source_file,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY updated_at DESC, source_file DESC
        ) AS row_num
    FROM raw_orders
)
SELECT
    order_id,
    customer_id,
    order_status,
    order_amount,
    updated_at,
    source_file
FROM ranked_orders
WHERE row_num = 1
ORDER BY order_id;

-- 7. Review queue for invalid raw order rows.
WITH order_review_queue AS (
    SELECT
        order_id AS record_id,
        CASE
            WHEN customer_id IS NULL THEN 'MISSING_CUSTOMER_ID'
            WHEN order_amount <= 0 THEN 'NON_POSITIVE_AMOUNT'
            WHEN order_status NOT IN ('COMPLETED', 'PENDING', 'CANCELLED', 'REFUNDED') THEN 'UNKNOWN_STATUS'
            ELSE 'REVIEW'
        END AS issue_type,
        'Review raw order before clean-layer use' AS issue_description,
        'Check source file and business rule' AS suggested_action
    FROM raw_orders
    WHERE customer_id IS NULL
       OR order_amount <= 0
       OR order_status NOT IN ('COMPLETED', 'PENDING', 'CANCELLED', 'REFUNDED')
)
SELECT *
FROM order_review_queue
ORDER BY record_id;
