# Query Explanations

## Simple Filtered View

Business purpose: expose useful source rows through a cleaner interface.

Source objects: `raw_customers`, `raw_orders`, `raw_payments`, `product_catalog`, and `campaign_daily_metrics`.

Source grain: usually one raw source row. Output grain: one filtered row from the source. Exposed columns are chosen explicitly. Excluded columns should be intentional and documented.

Common risk: filtering rows without explaining the business rule.

## Joined View

Business purpose: reduce repeated joins for consumers.

Source objects: orders, customers, and payments.

Output grain depends on the join. An order-payment view may be one row per payment attempt, not one row per order. Validate row multiplication with grouped counts.

## Aggregate View

Business purpose: provide summary-ready data.

Source grain changes from detailed rows to grouped rows. For example, `vw_customer_order_summary` has one row per customer. Reconcile view totals against the source filter.

## CTE-Based View

CTEs make the saved view definition easier to read. The CTEs are not separate permanent objects; they become part of the view logic.

## Latest-Record View

Latest-record views use `ROW_NUMBER` to choose one current version. The tie-breaker must be documented and validated.

## Reporting-Layer View

Reporting views expose stable, business-friendly column names. They should not expose unnecessary sensitive fields. They should preserve audit columns when investigation matters.

## Exception View

Exception views show rows needing review. They are useful because clean views should not silently hide unresolved data-quality problems.

## Validation Query

Validation queries compare source logic and view results. Common checks include row counts, uniqueness, nulls, totals, key coverage, and dependency review.

## Dependency Review

Every view depends on source objects and columns. If a source column is renamed, type-changed, or changes grain, the view may break or change results.

## Line-by-Line Example

```sql
CREATE VIEW vw_customer_sales_summary AS
WITH valid_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        order_amount
    FROM raw_orders
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
      AND order_status = 'COMPLETED'
),
customer_totals AS (
    SELECT
        customer_id,
        COUNT(*) AS completed_order_count,
        SUM(order_amount) AS completed_order_amount
    FROM valid_orders
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.customer_name,
    c.country,
    t.completed_order_count,
    t.completed_order_amount
FROM raw_customers AS c
JOIN customer_totals AS t
    ON c.customer_id = t.customer_id
WHERE c.customer_status = 'ACTIVE';
```

`CREATE VIEW` saves the query definition. `valid_orders` applies the order business rule. `customer_totals` changes the grain to one row per customer. The final `SELECT` joins active customers to their totals. The expected grain is one row per active customer with completed order totals, but duplicate customer versions can multiply rows unless current customer logic is applied first.

## Comparison Table

| SQL object or pattern | Reusable across statements? | Usually stores rows? | Main use |
|---|---|---|---|
| Subquery | No | No | Embed logic inside one query |
| CTE | No | No | Organise one query |
| View | Yes | Usually no | Reuse a named query definition |
| Table | Yes | Yes | Store rows |
| Materialized view concept | Yes | Often yes | Store view-like results where supported |
