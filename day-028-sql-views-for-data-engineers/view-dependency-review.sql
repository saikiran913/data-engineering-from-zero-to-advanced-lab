-- Day 028: View Dependency Review
-- Purpose: Teach dependency thinking for SQL views without platform-specific metadata catalogs.
-- Safety: This file contains read-only examples and documented view definitions only.
-- No database object is deployed automatically by this repository.

-- Base-table dependency list.
SELECT
    view_name,
    source_objects,
    output_grain,
    dependency_risk
FROM view_definition_examples
ORDER BY view_name;

-- Column dependency list.
-- Example: vw_active_customers needs customer_id, customer_name, country,
-- customer_status, signup_date, updated_at, and source_file from raw_customers.
SELECT
    'vw_active_customers' AS view_name,
    'raw_customers' AS source_object,
    'customer_id, customer_name, country, customer_status, signup_date, updated_at, source_file' AS required_columns;

-- Simple view-to-view dependency example.
-- Avoid long chains of views. This example is intentionally shallow.
CREATE VIEW vw_active_customer_country_summary AS
SELECT
    country,
    COUNT(*) AS active_customer_rows
FROM vw_active_customers
WHERE country IS NOT NULL
GROUP BY country;

-- Upstream rename scenario:
-- If raw_customers.customer_status is renamed, vw_active_customers can break.

-- Upstream type-change scenario:
-- If raw_orders.order_amount changes from numeric to text, amount totals can fail or change behaviour.

-- Upstream row-grain change scenario:
-- If raw_customers changes from one row per version to one row per customer,
-- duplicate-version validation expectations must change.

-- Dependency review output.
SELECT
    view_name,
    source_objects,
    output_grain,
    dependency_risk,
    main_validation AS validation_requirement
FROM view_definition_examples
ORDER BY view_name;

-- Dependency checklist:
-- 1. Source object exists.
-- 2. Columns exist.
-- 3. Types are compatible.
-- 4. Grain is unchanged.
-- 5. Joins remain valid.
-- 6. Filters remain valid.
-- 7. Audit columns remain available.
-- 8. Downstream consumers are documented.
