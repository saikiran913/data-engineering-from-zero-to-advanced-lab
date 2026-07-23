# Query Explanations

## Basic Single CTE

Problem: give one filtered result a clear name. The CTE input is a source table such as `customers`. The CTE output is a smaller result such as active customers. The final query reads from the CTE. Validate by running the CTE body alone.

## Multiple CTEs

Multiple CTEs allow a query to follow a logical sequence. Each CTE should have one clear responsibility. A common mistake is combining too many business rules into one step.

## Dependency Order

Later CTEs can reference earlier CTEs. Earlier CTEs cannot reference later CTEs. Put steps in the order a human would review them.

## Final Query

The final query consumes the prepared CTE outputs. It controls the final columns, filters, sorting, and output grain.

## CTE With Aggregation

Problem: summarise records after filtering. Example: `valid_orders` feeds `customer_totals`. Validate row counts before aggregation and totals after aggregation.

## CTE With ROW_NUMBER

Problem: keep the latest version per order. The CTE input is `raw_orders`. The output adds `row_num`. The final query filters `row_num = 1`. The common mistake is forgetting tie-breakers such as `source_file`.

## CTE With Joins

Problem: enrich prepared data with reference data. Join keys should be explicit and qualified, such as `c.customer_id = o.customer_id`. Validate that joins do not multiply rows unexpectedly.

## CTE Validation Workflow

Validation CTEs create review outputs for invalid orders, orphan payments, missing records, nulls, duplicates, and total differences. These outputs should be investigated before business action.

## CTE Reconciliation Workflow

Source-target checks usually prepare `source_data`, prepare `target_data`, match keys, then return missing or mismatched records. Count and total summaries help confirm whether the two sides align.

## CTE Clean-Layer Workflow

Clean-layer CTEs can rank records, keep latest versions, filter invalid records, standardise statuses, preserve audit columns, and create business-ready outputs. Day 023 stays read-only.

## CTE Versus Subquery

Subqueries may be shorter for small tasks. CTEs are often clearer when the logic has named stages.

## Line-by-Line Example

```sql
WITH valid_orders AS (
    SELECT
        order_id,
        customer_id,
        order_amount
    FROM raw_orders
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
),
customer_totals AS (
    SELECT
        customer_id,
        SUM(order_amount) AS total_order_value
    FROM valid_orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    total_order_value
FROM customer_totals
WHERE total_order_value > 500;
```

`valid_orders` is the first CTE. It filters raw orders to rows with a customer and positive amount. The comma separates CTE definitions. `customer_totals` is the second CTE and depends on `valid_orders`. The final `SELECT` reads from `customer_totals` and returns customers above the threshold.

## Pattern Summary

| Pattern | Number of Steps | Main Purpose | Main Risk |
| --- | ---: | --- | --- |
| Single CTE | 1 | Name one preparation step | Using a CTE when a simple filter is enough |
| Multiple CTEs | 2+ | Organise staged logic | Wrong dependency order |
| Validation CTEs | 2+ | Create review outputs | Treating review output as final truth |
| Reconciliation CTEs | 2+ | Compare source and target | Wrong key or null handling |
| Clean-layer CTEs | 3+ | Model transformations safely | Dropping audit columns too soon |
| CTE with deduplication | 2+ | Keep a selected record version | Missing tie-breaker |
