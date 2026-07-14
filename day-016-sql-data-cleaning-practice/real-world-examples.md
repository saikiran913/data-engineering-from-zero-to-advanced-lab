# Real-World Examples

Each example shows how a beginner data engineer might use `CASE` and derived columns in real reporting work.

## 1. Standardise Customer Statuses

Business situation: the customer success team wants one version of each status.

Raw problem: `active`, ` Active `, and `ACTIVE` appear as different values.

Table: `raw_customers`

SQL concept: `CASE` with `LOWER` and `TRIM`.

Sample query:

```sql
SELECT customer_id, customer_status, CASE WHEN LOWER(TRIM(customer_status)) = 'active' THEN 'Active' ELSE 'Unknown' END AS clean_customer_status FROM raw_customers;
```

Expected result: messy active values become `Active`.

Why use it: status counts become more reliable.

Common mistake: forgetting `ELSE`, which can leave unclear output values.

## 2. Standardise Country Values

Business situation: regional reporting needs one country label.

Raw problem: `UK`, `U.K.`, and `United Kingdom` mean the same thing.

Table: `raw_customers`

SQL concept: `CASE` with `IN`.

Sample query:

```sql
SELECT customer_id, country, CASE WHEN UPPER(TRIM(country)) IN ('UK','U.K.','UNITED KINGDOM') THEN 'UK' ELSE 'Unknown' END AS clean_country FROM raw_customers;
```

Expected result: all UK variants become `UK`.

Why use it: dashboards do not split one country into several categories.

Common mistake: standardising only one spelling.

## 3. Standardise Marketing Opt-In Values

Business situation: marketing needs a simple eligibility field.

Raw problem: opt-in values may be `yes`, `Y`, `true`, `no`, or blank.

Table: `raw_customers`

SQL concept: boolean-like standardisation.

Sample query:

```sql
SELECT customer_id, marketing_opt_in, CASE WHEN LOWER(TRIM(marketing_opt_in)) IN ('true','yes','y') THEN 'true' WHEN LOWER(TRIM(marketing_opt_in)) IN ('false','no','n') THEN 'false' ELSE 'unknown' END AS clean_marketing_opt_in FROM raw_customers;
```

Expected result: many raw values become three clear outcomes.

Why use it: campaign lists are easier to review.

Common mistake: treating blanks as `false` without checking the business rule.

## 4. Create Customer Region Label

Business situation: leaders want a broad view of customer regions.

Raw problem: country values are too detailed for a simple dashboard.

Table: `raw_customers`

SQL concept: derived business label.

Sample query:

```sql
SELECT customer_id, country, CASE WHEN UPPER(TRIM(country)) IN ('UK','U.K.','UNITED KINGDOM','GERMANY') THEN 'Europe' WHEN UPPER(TRIM(country)) IN ('USA','U.S.A','UNITED STATES','CANADA') THEN 'North America' ELSE 'Other or Unknown' END AS customer_region FROM raw_customers;
```

Expected result: rows receive a simple region label.

Why use it: region summaries are easier to scan.

Common mistake: mixing country cleaning and region rules without documenting them.

## 5. Create Order Value Band

Business situation: finance wants to compare order sizes.

Raw problem: raw amounts are too detailed for a quick summary.

Table: `raw_orders`

SQL concept: numeric bands with `CASE`.

Sample query:

```sql
SELECT order_id, order_amount, CASE WHEN order_amount < 50 THEN 'Low' WHEN order_amount < 200 THEN 'Medium' WHEN order_amount < 500 THEN 'High' ELSE 'Premium' END AS order_value_band FROM raw_orders;
```

Expected result: each order receives a value band.

Why use it: order value distribution becomes easier to explain.

Common mistake: using overlapping ranges.

## 6. Create Order Health Label

Business situation: operations wants to spot problem orders.

Raw problem: payment status and order status need to be read together.

Table: `raw_orders`

SQL concept: multiple conditions in one `CASE`.

Sample query:

```sql
SELECT order_id, order_status, payment_status, CASE WHEN LOWER(TRIM(payment_status)) = 'failed' THEN 'Payment Issue' WHEN LOWER(TRIM(order_status)) IN ('cancelled','returned') THEN 'Needs Review' ELSE 'Standard' END AS order_health_label FROM raw_orders;
```

Expected result: risky orders receive a review label.

Why use it: teams can prioritise follow-up.

Common mistake: placing a broad condition before a more specific condition.

## 7. Standardise Payment Status

Business situation: payment reports need consistent labels.

Raw problem: `paid`, `Paid`, and blank values appear.

Table: `raw_orders`

SQL concept: text standardisation.

Sample query:

```sql
SELECT order_id, payment_status, CASE WHEN LOWER(TRIM(payment_status)) = 'paid' THEN 'Paid' ELSE 'Unknown' END AS clean_payment_status FROM raw_orders;
```

Expected result: recognised values get a standard label.

Why use it: payment reporting becomes cleaner.

Common mistake: hiding unknown payment values instead of labelling them.

## 8. Create Product Price Band

Business situation: merchandising wants simple product price groups.

Raw problem: prices vary widely.

Table: `raw_products`

SQL concept: numeric bands.

Sample query:

```sql
SELECT product_id, price, CASE WHEN price < 20 THEN 'Low' WHEN price < 100 THEN 'Medium' WHEN price < 300 THEN 'High' ELSE 'Premium' END AS product_price_band FROM raw_products;
```

Expected result: each product receives a price label.

Why use it: product reports are easier to compare.

Common mistake: forgetting a rule for missing prices.

## 9. Standardise Product Active Flag

Business situation: product teams need a clear active flag.

Raw problem: `yes`, `Y`, `true`, and `no` all appear.

Table: `raw_products`

SQL concept: boolean-like standardisation.

Sample query:

```sql
SELECT product_id, is_active, CASE WHEN LOWER(TRIM(is_active)) IN ('true','yes','y') THEN 'true' WHEN LOWER(TRIM(is_active)) IN ('false','no','n') THEN 'false' ELSE 'unknown' END AS clean_is_active FROM raw_products;
```

Expected result: active flags become consistent.

Why use it: active product counts become more trustworthy.

Common mistake: using mixed output values like `Yes`, `true`, and `1` in the same column.

## 10. Create Campaign Budget Band

Business situation: marketing wants to compare campaign sizes.

Raw problem: budgets are numeric but need readable categories.

Table: `raw_campaigns`

SQL concept: budget bands.

Sample query:

```sql
SELECT campaign_id, budget, CASE WHEN budget < 1000 THEN 'Small' WHEN budget < 5000 THEN 'Medium' ELSE 'Large' END AS campaign_budget_band FROM raw_campaigns;
```

Expected result: campaigns receive size labels.

Why use it: budget reviews are easier to discuss.

Common mistake: not checking whether bands match the business definition.

## 11. Standardise Marketing Channel

Business situation: channel performance needs clean categories.

Raw problem: `social`, ` Social `, and `SOCIAL` are counted separately.

Table: `raw_campaigns`

SQL concept: channel standardisation.

Sample query:

```sql
SELECT campaign_id, channel, CASE WHEN LOWER(TRIM(channel)) = 'social' THEN 'Social' WHEN LOWER(TRIM(channel)) = 'search' THEN 'Search' ELSE 'Unknown' END AS clean_channel FROM raw_campaigns;
```

Expected result: channel names become consistent.

Why use it: channel charts become accurate.

Common mistake: not reviewing the `Unknown` rows after cleaning.

## 12. Create Campaign Performance Label

Business situation: marketing wants a quick performance signal.

Raw problem: cost and revenue need interpretation.

Table: `raw_campaign_performance`

SQL concept: business label from two numeric columns.

Sample query:

```sql
SELECT campaign_id, cost, revenue, CASE WHEN revenue > cost THEN 'Profitable' WHEN revenue = cost THEN 'Break Even' ELSE 'Needs Review' END AS performance_label FROM raw_campaign_performance;
```

Expected result: each campaign row receives a performance label.

Why use it: teams can spot weak campaigns quickly.

Common mistake: not handling zero revenue separately when that matters.

## 13. Create Conversion Label

Business situation: marketers want to understand conversion volume.

Raw problem: raw conversion counts need context.

Table: `raw_campaign_performance`

SQL concept: numeric classification.

Sample query:

```sql
SELECT campaign_id, conversions, CASE WHEN conversions = 0 THEN 'No Conversions' WHEN conversions <= 5 THEN 'Low Conversions' WHEN conversions <= 20 THEN 'Medium Conversions' ELSE 'High Conversions' END AS conversion_label FROM raw_campaign_performance;
```

Expected result: conversion counts become readable categories.

Why use it: performance tables are easier to scan.

Common mistake: using labels without agreeing the thresholds.

## 14. Build Business-Ready Order Output

Business situation: operations wants one clean order extract.

Raw problem: raw status values and raw amounts are not dashboard-friendly.

Table: `raw_orders`

SQL concept: multiple derived columns in one output.

Sample query:

```sql
SELECT order_id, order_amount, CASE WHEN order_amount >= 500 THEN 'Premium' ELSE 'Standard' END AS order_value_label, CASE WHEN LOWER(TRIM(payment_status)) = 'paid' THEN 'Paid' ELSE 'Review' END AS payment_review_label FROM raw_orders;
```

Expected result: each order has business-friendly labels.

Why use it: downstream users receive columns they can read immediately.

Common mistake: giving derived columns unclear names.
