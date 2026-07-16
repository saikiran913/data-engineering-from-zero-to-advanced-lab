# Schema Compatibility Before UNION Operations

## What is a Schema?

A schema describes columns, their order, and their data types. For `UNION` operations, the selected output schema matters.

## Why Schemas Must Align

`UNION` and `UNION ALL` stack rows vertically. The first selected column from one source is placed under the first selected column from another source.

## Column Count

Each `SELECT` must return the same number of columns.

## Column Order

SQL matches by position, not by name. `order_date` should be selected under `order_date`, not under `order_amount`.

## Data Types

Matching positions should have compatible types:

- ID under ID
- date under date
- amount under amount
- status under status

Some platforms convert values automatically. Others return errors.

## Column Names

Names may differ in source tables. Aliases can align output names.

```sql
SELECT amount AS order_amount
FROM india_orders;
```

## Missing Columns

If a source lacks a column, use a placeholder only when that is meaningful.

```sql
NULL AS revenue
```

## Extra Columns

Either omit the extra column from every query or provide matching placeholders across sources.

## Standardising Values

Clean country, status, and channel values before combining when source values differ.

## Business Grain

Technically similar schemas may still represent different grains. One row per order and one row per order item should not be combined casually.

## Schema Compatibility Checklist

- same business entity
- same grain
- same number of selected columns
- same logical column order
- compatible types
- consistent units
- consistent date meaning
- consistent status definitions
- source label included
- row counts recorded
- known duplicates documented

## Schema Mapping Template

| Output Column | Source A Column | Source B Column | Source C Column | Data Type | Cleaning Rule | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| order_amount | order_amount | amount | order_value | numeric | Keep two decimals | Example |
