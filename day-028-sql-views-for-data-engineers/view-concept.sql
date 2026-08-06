-- Day 028: View Concept
-- Purpose: Introduce SQL views as named reusable query definitions.
-- Safety: This file contains example view definitions only and does not deploy objects automatically.
-- Before running CREATE VIEW, check whether the object name already exists in your database.

-- Preview source data.
SELECT
    customer_id,
    customer_name,
    country,
    customer_status,
    signup_date,
    updated_at,
    source_file
FROM raw_customers
ORDER BY customer_id, updated_at;

-- Underlying SELECT before it becomes a view.
SELECT
    customer_id,
    customer_name,
    country,
    signup_date,
    updated_at,
    source_file
FROM raw_customers
WHERE customer_status = 'ACTIVE';

-- First CREATE VIEW example.
-- Source: raw_customers.
-- Output grain: one row per active customer version.
-- Exposed columns: business identifiers, signup date, and useful audit columns.
-- Excluded columns: email_address.
CREATE VIEW vw_active_customers AS
SELECT
    customer_id,
    customer_name,
    country,
    signup_date,
    updated_at,
    source_file
FROM raw_customers
WHERE customer_status = 'ACTIVE';

-- Query the view like a table.
-- Consumer ordering belongs here, outside the view definition.
SELECT
    customer_id,
    customer_name,
    country,
    signup_date,
    updated_at,
    source_file
FROM vw_active_customers
ORDER BY customer_id, updated_at;

-- Compare with a CTE.
-- This CTE can be reused only inside this single statement.
WITH active_customers AS (
    SELECT
        customer_id,
        customer_name,
        country,
        signup_date,
        updated_at,
        source_file
    FROM raw_customers
    WHERE customer_status = 'ACTIVE'
)
SELECT
    customer_id,
    customer_name,
    country
FROM active_customers
ORDER BY customer_id;

-- Validation query: active customer source count.
SELECT
    COUNT(*) AS source_active_customer_rows
FROM raw_customers
WHERE customer_status = 'ACTIVE';

-- Validation query: view row count.
SELECT
    COUNT(*) AS view_active_customer_rows
FROM vw_active_customers;

-- Practice tasks:
-- 1. Explain the output grain of vw_active_customers.
-- 2. Identify which column was excluded and why.
-- 3. Compare source row count and view row count.
-- 4. Query the view with an ORDER BY in the consumer query.
