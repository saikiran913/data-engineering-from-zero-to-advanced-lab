# Day 008 Validation Checks Guide

## What is a Validation Check?

A validation check is a rule used to confirm whether data looks correct, complete, and usable.

## Why Validation Checks Are Needed

Validation checks are needed because data can be missing, duplicated, invalid, stale, or inconsistent.

Example: a sales file may arrive, but if it has zero rows, the dashboard may show zero sales even though orders happened.

## File-Level Checks

- File exists
- File is not empty
- Expected file name
- Expected file size
- Expected arrival time
- Correct file format

## Schema-Level Checks

- Expected columns exist
- Column count matches
- Column names are correct
- Data types are correct
- Schema did not unexpectedly change

## Row-Level Checks

- Required fields are not null
- Row has valid values
- Row has valid date
- Row has valid amount
- Row is not duplicated

## Column-Level Checks

- Null percentage
- Unique values
- Accepted value list
- Minimum and maximum range
- Data type
- Format pattern

## Table-Level Checks

- Row count
- Duplicate count
- Total amount check
- Source-to-target comparison
- Freshness
- Completeness

## Business Rule Checks

- Shipped order must have shipment date.
- Completed payment must have payment amount.
- Cancelled order should not count as revenue.
- Refund amount should not exceed original order amount.
- Delivery date should not be before order date.

## Warning vs Failure

Warning: pipeline can continue, but the issue should be reviewed.

Example: a small number of optional phone numbers are missing.

Failure: pipeline should stop or data should not be trusted.

Example: the order table has zero rows for a busy sales day.

## Validation Result Actions

| Action | Simple Meaning | Example |
| --- | --- | --- |
| Pass | Check succeeded | File has expected columns |
| Warning | Issue needs review but may not block | Country missing for a few records |
| Failure | Issue is serious | Required order ID is missing |
| Quarantine | Store bad records separately | Invalid rows moved to review area |
| Alert | Notify someone | Send message that pipeline failed |
| Retry | Try again | Rerun after source file arrives |
| Manual review | Human checks issue | Business team confirms unusual value |

