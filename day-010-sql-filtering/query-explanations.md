# Day 010 Query Explanations

## Basic WHERE Filters

Basic `WHERE` filters use one condition.

Example purpose: find failed payments.

Table used: `orders`

Condition used: `payment_status = 'Failed'`

Expected result: only orders where payment failed.

Why it matters: data engineers often start investigations by isolating problem records.

## AND Filters

`AND` means all conditions must be true.

Example purpose: find paid high-value orders.

Table used: `orders`

Condition used: `payment_status = 'Paid' AND order_amount > 500`

Expected result: paid orders with amount greater than 500.

Why it matters: transformation logic often needs multiple rules.

## OR Filters

`OR` means at least one condition must be true.

Example purpose: find cancelled or returned orders.

Table used: `orders`

Condition used: `order_status = 'Cancelled' OR order_status = 'Returned'`

Expected result: orders with either status.

Why it matters: data engineers often review several related statuses together.

## Parentheses with AND and OR

Parentheses make mixed logic safer.

Example purpose: find UK orders where payment failed or was refunded.

Condition used: `country = 'UK' AND (payment_status = 'Failed' OR payment_status = 'Refunded')`

Expected result: only UK records matching either payment status.

Why it matters: without parentheses, the query may return more rows than intended.

## IN Filters

`IN` checks whether a value appears in a list.

Example purpose: find customers from UK, India, or USA.

Table used: `customers`

Condition used: `country IN ('UK', 'India', 'USA')`

Expected result: customers from any listed country.

Why it matters: `IN` is cleaner than writing many `OR` filters.

## BETWEEN Filters

`BETWEEN` filters values inside a range.

Example purpose: find orders between 100 and 500.

Table used: `orders`

Condition used: `order_amount BETWEEN 100 AND 500`

Expected result: orders with amounts in that range.

Why it matters: ranges are common for dates, prices, budgets, and transaction values.

## LIKE Filters

`LIKE` searches for text patterns. `%` means any number of characters.

Example purpose: find products containing `Book`.

Table used: `products`

Condition used: `product_name LIKE '%Book%'`

Expected result: product names containing Book.

Why it matters: pattern matching helps investigate names, emails, campaigns, and descriptions.

## IS NULL and IS NOT NULL Filters

`IS NULL` finds missing values. `IS NOT NULL` finds available values.

Example purpose: find customers with missing email.

Table used: `customers`

Condition used: `email IS NULL`

Expected result: customers where email is missing.

Why it matters: missing values are common data quality issues.

## Combined Filtering Examples

Real investigations often combine filters.

Example: active UK customers with email available.

Conditions used: `country = 'UK'`, `customer_status = 'Active'`, and `email IS NOT NULL`.

Expected result: UK active customers who can be contacted by email.

## How Data Engineers Use These Queries

Data engineers use filtering to troubleshoot failed records, validate data quality, prepare clean transformation logic, review recent records, check active or inactive status, and investigate dashboard issues.

