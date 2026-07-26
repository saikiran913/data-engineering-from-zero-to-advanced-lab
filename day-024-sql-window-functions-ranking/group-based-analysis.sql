-- Day 024: Group-Based Analysis
-- Topic: Rank records inside meaningful business groups.
-- Safety note: every query in this file is read-only.

-- Customers within countries.
SELECT customer_id, country, sales_period, total_sales,
    DENSE_RANK() OVER (
        PARTITION BY country
        ORDER BY total_sales DESC
    ) AS country_sales_level
FROM customer_sales
WHERE total_sales IS NOT NULL
ORDER BY country, country_sales_level, customer_id;

-- Products within categories.
SELECT product_id, category, sales_period, total_sales,
    RANK() OVER (
        PARTITION BY category
        ORDER BY total_sales DESC
    ) AS category_sales_rank
FROM product_sales
WHERE total_sales IS NOT NULL
ORDER BY category, category_sales_rank, product_id;

-- Campaigns within channel-country groups.
SELECT campaign_id, channel, country, conversions,
    RANK() OVER (
        PARTITION BY channel, country
        ORDER BY conversions DESC
    ) AS channel_country_rank
FROM campaign_performance
ORDER BY channel, country, channel_country_rank, campaign_id;

-- Sales days within regions.
SELECT sale_date, region, total_sales,
    RANK() OVER (
        PARTITION BY region
        ORDER BY total_sales DESC
    ) AS region_sales_rank
FROM regional_daily_sales
WHERE total_sales IS NOT NULL
ORDER BY region, region_sales_rank, sale_date;

-- Departments across periods.
SELECT employee_id, department, review_period, performance_score,
    RANK() OVER (
        PARTITION BY department, review_period
        ORDER BY performance_score DESC
    ) AS department_period_rank
FROM employee_performance
WHERE performance_score IS NOT NULL
ORDER BY department, review_period, department_period_rank, employee_id;

-- Issue categories by frequency.
SELECT dataset_name, recommended_function, review_required,
    DENSE_RANK() OVER (
        PARTITION BY dataset_name
        ORDER BY review_required DESC, recommended_function
    ) AS rule_review_level
FROM ranking_rule_examples
ORDER BY dataset_name, rule_review_level;

-- Global rank and group rank side by side.
SELECT customer_id, country, total_sales,
    RANK() OVER (
        ORDER BY total_sales DESC
    ) AS global_sales_rank,
    RANK() OVER (
        PARTITION BY country
        ORDER BY total_sales DESC
    ) AS country_sales_rank
FROM customer_sales
WHERE total_sales IS NOT NULL
ORDER BY global_sales_rank, country, customer_id;

-- Multi-period ranking.
-- Adding sales_period to PARTITION BY restarts ranking per period.
SELECT product_id, category, sales_period, total_sales,
    DENSE_RANK() OVER (
        PARTITION BY category, sales_period
        ORDER BY total_sales DESC
    ) AS category_period_rank
FROM product_sales
WHERE total_sales IS NOT NULL
ORDER BY category, sales_period, category_period_rank, product_id;
