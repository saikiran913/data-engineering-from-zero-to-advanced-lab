# Query Plan Reading Guide

## Step 1: Start With the Business Question

Before reading a plan, state what the query is meant to answer. A scan may be fine for a full monthly report, but suspicious for a single-order lookup.

## Step 2: Identify the Source Tables

List the tables involved. More tables usually means more opportunities for filters, joins, and row growth.

## Step 3: Find Access Steps

Look for broad reads such as table scans and narrower reads such as lookup-style access. Do not judge them immediately.

| Access pattern | Beginner question |
|---|---|
| Table scan | Does the query need many rows? |
| Index lookup | Is the filter selective? |

## Step 4: Find Filters

Filters apply `WHERE` logic. Ask whether the filter is broad or selective.

Examples:

- `order_id = 'OP5001'` is usually selective.
- `order_status = 'Delivered'` may match many rows.

## Step 5: Find Joins

Joins combine inputs. Ask:

- What columns connect the tables?
- Is the relationship one-to-one or one-to-many?
- Could the join produce more rows than expected?

## Step 6: Find Sorts

Sorts order rows. Sorting ten rows is very different from sorting millions of rows. Check the estimated rows around the sort step.

## Step 7: Find Aggregates

Aggregates produce summaries. They may output fewer rows, but they can still process a large input.

## Step 8: Read Estimated Rows

Estimated rows are clues, not facts. Larger estimates can indicate more work. Very wrong estimates can lead to surprising plan choices.

## Step 9: Read Cost Carefully

Cost is an internal estimate. Compare it only within the same platform and query context. Cost is not seconds, milliseconds, or money.

## Step 10: Compare Plans Safely

When comparing two plans:

1. Confirm both answer the same business question.
2. Compare source tables.
3. Compare scan and lookup steps.
4. Compare filter placement.
5. Compare join inputs.
6. Compare sort and aggregate placement.
7. Compare estimated rows.
8. Compare cost only within the same environment.
9. Record remaining uncertainty.

## What Day 041 Does Not Do

This lesson does not teach production tuning, query hints, plan forcing, index creation, database configuration, or vendor-specific plan internals.

