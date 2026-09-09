# JSON Validation Guide

## Step 1: Define Parent Record Grain

State what one source row represents, such as one event.

## Step 2: Identify JSON-Bearing Column

Find the column that stores the payload, such as `payload_text`.

## Step 3: Define Expected Event Types

Different event types can require different paths.

## Step 4: Define Expected Nested Paths

Document paths such as `customer.id` and `order.amount`.

## Step 5: Mark Required Versus Optional

Required paths create exceptions when missing. Optional paths may be allowed to be absent.

## Step 6: Define Expected Value Type

Examples include `STRING`, `NUMBER`, `DATE_TEXT`, `BOOLEAN`, `ARRAY`, and `OBJECT`.

## Step 7: Validate Extraction

Separate extraction failures from business nulls.

## Step 8: Validate Missing, Null, and Blank Separately

Do not collapse these conditions into one bucket.

## Step 9: Validate Typed Values

Check numeric, date, boolean, and status-like values before downstream use.

## Step 10: Review Arrays

Decide whether array expansion is needed.

## Step 11: Preserve Parent Key

Keep `event_id`, `order_id`, or another parent business key.

## Step 12: Document Expanded Grain

State whether the result is one row per event, item, tag, or another element.

## Step 13: Reconcile Element Counts

Compare parent records with expanded array element rows.

## Step 14: Validate Schema Drift

Check added, removed, renamed, and type-changed paths.

## Step 15: Build Exception Output

Create a review-friendly table shape with event, path, issue, severity, and message.

## Nested-Field Contract Template

| Field | Value |
|---|---|
| Event type |  |
| Parent grain |  |
| Path |  |
| Required flag |  |
| Expected type |  |
| Array flag |  |
| Business meaning |  |
| Null allowed? |  |
| Blank allowed? |  |
| Expected element shape |  |
| Severity |  |
| Review rule |  |

