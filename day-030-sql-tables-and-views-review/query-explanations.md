# Query Explanations

## Table Versus View

Tables store rows. Views store reusable query definitions. Use a table-like stored interface when history or stored results matter. Use a view-like interface when reusable logic is enough and current source logic is acceptable.

## View Versus CTE

A view can be reused across statements. A CTE organises one statement. Use a CTE for one report, validation workflow, or staged calculation.

## CTE Versus Subquery

A CTE is easier to read for multi-step logic. A subquery is useful for small embedded logic such as filtering orders above average.

## Raw Layer

Raw data preserves source-aligned history and audit fields. The raw event examples keep repeated deliveries and source files so learners can investigate.

## Clean Layer

Clean interfaces apply documented rules and expose stable grain, such as one row per customer.

## Reporting Layer

Reporting interfaces serve consumer needs with stable columns, documented grain, and validation checks.

## Current-State Interface

A current-state interface selects the latest version or accepted current row. It is useful for convenience but should not replace raw history.

## History Interface

A history interface stores or exposes historical rows for audit, replay, and trend analysis.

## Consumer-Driven Design

Consumers influence interface choice. Dashboards need stable columns. Analysts may only need one-time queries. Pipelines may need raw history.

## Persistence and Reuse Decisions

Persistence asks whether rows must be stored. Reuse asks whether logic must be shared across statements or consumers.

## Validation Summary

Every interface needs row-count, key, null, total, date, consumer, dependency, and audit checks as appropriate.

## Mini-Project Design

The mini-project combines raw event review, clean customer logic, valid-order filtering, reporting summaries, consumer mapping, exception outputs, and validation summaries.

## Line-by-Line CTE Example

```sql
WITH valid_orders AS (
    SELECT
        order_id,
        customer_id,
        order_amount
    FROM order_transactions
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
)
SELECT
    customer_id,
    SUM(order_amount) AS customer_order_total
FROM valid_orders
GROUP BY customer_id;
```

`WITH valid_orders AS` creates a named step. The `SELECT` inside the CTE applies business rules. The final query groups valid rows by customer. The CTE exists only for this statement.

## Conceptual View Interface

```sql
CREATE VIEW vw_daily_sales_reporting AS
SELECT
    report_date,
    region,
    total_orders,
    total_sales,
    total_refunds
FROM daily_sales_reporting;
```

This illustrates a reusable reporting interface. It should only be executed after checking object names, platform rules, and review requirements.

## Interface Comparison

| Interface | Persists? | Stores rows? | Reusable across statements? | Typical use |
|---|---|---|---|---|
| Table | Yes | Yes | Yes | raw history, clean stored data, reporting snapshots |
| View | Yes as object logic | Usually no | Yes | reusable query interface |
| CTE | No | No | No | readable one-statement steps |
| Subquery | No | No | No | small embedded logic |
| Simple query | No | No | No | one-time lookup or validation |
