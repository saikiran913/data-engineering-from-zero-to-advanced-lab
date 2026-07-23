# Real-World Examples

## Scenario 1: Clean Current Order Table

Business question: which order version should be used for clean reporting?

CTE steps: `ranked_orders`, `latest_orders`, `valid_orders`, `standardised_orders`.

Final output: one current business-ready row per order. Main risk: missing tie-breakers. Validate duplicate groups and latest timestamps.

## Scenario 2: Customer Revenue Summary

Steps: filter valid orders, aggregate totals, join customers.

Final output: one row per customer with order count and total order value. Validate the grain changes from order to customer.

## Scenario 3: Orders Without Successful Payment

Steps: successful payment order keys, completed orders, unmatched completed orders.

Final output: exception report. Validate payment statuses and order keys.

## Scenario 4: Payments Without Matching Orders

Steps: order keys, payment rows, orphan payments.

Final output: payments needing review. Main risk: incomplete order extract.

## Scenario 5: Source Records Missing From Target

Steps: source data, target data, missing target records.

Final output: source records not loaded to target. Validate row counts before investigation.

## Scenario 6: Target-Only Records

Steps: target data, source data, missing source records.

Final output: target records that cannot be traced to source.

## Scenario 7: Value Mismatch Report

Steps: matched records, mismatch records, review queue.

Final output: source and target values side by side. Validate null handling.

## Scenario 8: Daily Sales Anomaly Report

Steps: raw sales, valid sales, sales anomalies, daily totals.

Final output: review queue plus daily totals. Validate negative amounts and zero quantities.

## Scenario 9: Multi-Check Validation Dashboard Input

Steps: invalid orders, orphan payments, reconciliation mismatches, combined review summary.

Final output: validation names, issue counts, and review statuses.

CTE outputs can feed data-quality reports, exception queues, transformation logic, reconciliation summaries, and business-ready outputs.
