# Day 038 Practice Questions

## Section A: Concept Checks

1. What is a constraint?
2. Why do constraints matter in data engineering?
3. What does a primary key represent?
4. Why should a primary-key-like rule check both uniqueness and nulls?
5. What is a business key?
6. What is a surrogate key conceptually?
7. What is a composite key?
8. How does grain connect to keys?
9. What is a foreign key?
10. What is a parent table?
11. What is a child table?
12. What is an orphan record?
13. What does uniqueness mean?
14. How is a unique rule different from a primary key?
15. What is a check-like rule?
16. What is an allowed-value rule?
17. What is a range rule?
18. What does not-null mean?
19. Why can constraint enforcement vary by platform?
20. Why are validation queries useful even when constraints exist?
21. Why should violations become exception outputs?
22. Why should constraint validation remain non-destructive?

## Section B: Choose the Constraint Concept

Choose primary key, composite key, foreign key, unique, check, not null, validation-only rule, or no constraint needed.

1. `customer_id` should identify one customer.
2. `order_id + line_number` identifies one order-line row.
3. `orders.customer_id` should match `customers.customer_id`.
4. `payments.order_id` should match `orders.order_id`.
5. `product_code` should not duplicate.
6. `order_status` should be in an allowed list.
7. `order_amount` should be greater than or equal to 0.
8. `order_date` must be present.
9. Optional product description may be blank.
10. A report group is identified by `report_date + country_group`.
11. A customer can exist without orders.
12. `payment_id` should identify one payment.
13. Payment status should be `PAID`, `PENDING`, `FAILED`, or `REFUNDED`.
14. `product_code` must be present.
15. Some warehouse constraints are documented but not enforced.

## Section C: Complete the SQL

1. Check null customer IDs.
2. Check duplicate customer IDs.
3. Check duplicate order IDs.
4. Check duplicate payment IDs.
5. Check duplicate product codes.
6. Find orders with customer IDs not found in customers.
7. Find payments with order IDs not found in orders.
8. Find unsupported order statuses.
9. Find unsupported payment statuses.
10. Find negative order amounts.
11. Find zero or negative product prices.
12. Find missing order dates.
13. Find missing product codes.
14. Build a small exception output for orphan orders.
15. Summarise rules by constraint concept.

## Section D: Fix the Mistake

1. A key check uses only `COUNT(DISTINCT customer_id)`.
2. A duplicate check includes null keys.
3. A foreign-key check uses only an inner join.
4. An orphan query says rows should be deleted.
5. A check rule has no documented allowed list.
6. A range rule says all negative values are impossible.
7. A unique rule is called a primary key.
8. A not-null rule is applied to an optional field.
9. A query has no audit context.
10. A query has no severity.
11. A validation file contains executable constraint DDL.
12. A relationship check ignores parent duplicates.
13. A composite key check groups by only one column.
14. A constraint exception has no entity key.
15. A warehouse declaration is assumed enforced without validation.

## Section E: Design the Rule

For each scenario, define table grain, candidate key, relationship, constraint concept, columns, expected condition, nullable rule, validation query idea, severity, and exception output.

1. Customer master data.
2. Clean order table.
3. Payment transaction table.
4. Product reference table.
5. Conceptual order-line table.
6. Daily country report.
7. Customer-to-order relationship.
8. Order-to-payment relationship.
9. Product-code lookup.
10. Allowed order statuses.

## Section F: Mini Case Study

Using all supplied files:

1. Validate customer keys.
2. Validate order keys.
3. Validate payment keys.
4. Validate customer-order relationships.
5. Validate order-payment relationships.
6. Validate product-code uniqueness.
7. Validate allowed statuses.
8. Validate range rules.
9. Validate required fields.
10. Build exception output and summary.

## Answer Key

### Section A Answers

1. A constraint is a rule data is expected to follow.
2. Constraints protect keys, relationships, requiredness, and allowed values.
3. A primary key represents row identity.
4. A primary-key-like rule needs a value and no duplicates.
5. A business key has business meaning, such as `customer_id`.
6. A surrogate key is an internal identifier conceptually.
7. A composite key uses multiple columns.
8. Grain defines what one row represents, so it guides key choice.
9. A foreign key is a child value referencing a parent value.
10. A parent table is the referenced table.
11. A child table contains the reference.
12. An orphan record is a child row without a matching parent.
13. Uniqueness means values do not repeat under the rule.
14. A unique rule may not be the row identity and may have different null behaviour.
15. A check-like rule validates an allowed condition.
16. An allowed-value rule limits values to a documented list.
17. A range rule checks boundaries such as amount >= 0.
18. Not-null means a required field should contain a value.
19. SQL platforms differ in syntax and enforcement.
20. Validation queries provide evidence even when enforcement is uncertain.
21. Exceptions make violations reviewable.
22. Validation should preserve evidence and avoid unsafe changes.

### Section B Answers

| # | Concept | Reason |
|---|---|---|
| 1 | Primary key | Identifies one customer row |
| 2 | Composite key | Multiple columns identify one row |
| 3 | Foreign key | Child order references parent customer |
| 4 | Foreign key | Child payment references parent order |
| 5 | Unique | Product code should not duplicate |
| 6 | Check | Status must be in allowed list |
| 7 | Check | Amount must satisfy a range rule |
| 8 | Not null | Required date must be present |
| 9 | No constraint needed | Optional text can be blank |
| 10 | Composite key | Group is identified by two columns |
| 11 | Validation-only rule | Depends on business context |
| 12 | Primary key | Identifies one payment row |
| 13 | Check | Payment status allowed list |
| 14 | Not null | Product code is required |
| 15 | Validation-only rule | Enforcement may vary |

### Section C Sample Answers

```sql
-- 1. Null customer IDs.
SELECT customer_id, customer_name
FROM customers
WHERE customer_id IS NULL;
```

```sql
-- 2. Duplicate customer IDs.
SELECT customer_id, COUNT(*) AS row_count
FROM customers
WHERE customer_id IS NOT NULL
GROUP BY customer_id
HAVING COUNT(*) > 1;
```

```sql
-- 3. Duplicate order IDs.
SELECT order_id, COUNT(*) AS row_count
FROM orders
WHERE order_id IS NOT NULL
GROUP BY order_id
HAVING COUNT(*) > 1;
```

```sql
-- 4. Duplicate payment IDs.
SELECT payment_id, COUNT(*) AS row_count
FROM payments
WHERE payment_id IS NOT NULL
GROUP BY payment_id
HAVING COUNT(*) > 1;
```

```sql
-- 5. Duplicate product codes.
SELECT product_code, COUNT(*) AS row_count
FROM products
WHERE product_code IS NOT NULL
GROUP BY product_code
HAVING COUNT(*) > 1;
```

```sql
-- 6. Orphan orders.
SELECT o.order_id, o.customer_id
FROM orders AS o
LEFT JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE o.customer_id IS NOT NULL
  AND c.customer_id IS NULL;
```

```sql
-- 7. Orphan payments.
SELECT p.payment_id, p.order_id
FROM payments AS p
LEFT JOIN orders AS o
    ON p.order_id = o.order_id
WHERE p.order_id IS NOT NULL
  AND o.order_id IS NULL;
```

```sql
-- 8. Unsupported order statuses.
SELECT order_id, order_status
FROM orders
WHERE order_status NOT IN ('COMPLETED', 'PENDING', 'CANCELLED', 'REFUNDED');
```

```sql
-- 9. Unsupported payment statuses.
SELECT payment_id, payment_status
FROM payments
WHERE payment_status NOT IN ('PAID', 'PENDING', 'FAILED', 'REFUNDED');
```

```sql
-- 10. Negative order amounts.
SELECT order_id, order_amount
FROM orders
WHERE order_amount < 0;
```

```sql
-- 11. Zero or negative product prices.
SELECT product_id, product_code, unit_price
FROM products
WHERE unit_price <= 0;
```

```sql
-- 12. Missing order dates.
SELECT order_id, order_date
FROM orders
WHERE order_date IS NULL;
```

```sql
-- 13. Missing product codes.
SELECT product_id, product_code
FROM products
WHERE product_code IS NULL;
```

```sql
-- 14. Orphan order exception output.
SELECT
    'orders' AS table_name,
    o.order_id AS entity_key,
    'FOREIGN_KEY' AS constraint_concept,
    'ORPHAN_ORDER_CUSTOMER' AS issue_type,
    'HIGH_REVIEW' AS severity
FROM orders AS o
LEFT JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE o.customer_id IS NOT NULL
  AND c.customer_id IS NULL;
```

```sql
-- 15. Rules by concept.
SELECT constraint_concept, COUNT(*) AS rule_count
FROM constraint_rules
GROUP BY constraint_concept;
```

### Section D Answers

1. Add non-null and duplicate checks.
2. Exclude nulls from duplicate grouping and check nulls separately.
3. Use a left join from child to parent.
4. Report orphans for review.
5. Document the allowed list.
6. Tie range rules to business context.
7. Explain unique and primary-key concepts separately.
8. Confirm business requiredness.
9. Include source file and load timestamp where useful.
10. Add a documented severity.
11. Keep executable SQL read-only.
12. Validate parent key uniqueness first.
13. Group by all composite-key columns.
14. Add an entity key.
15. Validate important rules even when declarations exist.

### Section E Answer Guidance

Good rule designs state grain first, then choose candidate keys and relationships. They include expected condition, nullability, severity, audit context, and an exception output shape.

### Section F Answer Guidance

A complete answer should find duplicate and null keys, orphan order and payment records, duplicate product codes, unsupported statuses, negative or zero range cases, required-field failures, and a combined exception queue. It should explain that all results are review evidence, not automatic correction instructions.

