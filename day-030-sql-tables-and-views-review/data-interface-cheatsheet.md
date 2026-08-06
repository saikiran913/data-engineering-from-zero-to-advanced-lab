# Day 030 Data Interface Cheatsheet

## Table Checklist

- rows must be stored
- history is required
- audit or replay matters
- output needs stable stored results
- validation and ownership are documented

## View Checklist

- logic must be reused
- copied rows are not required
- consumers need a clean query interface
- dependencies are documented
- output grain is stable

## CTE Checklist

- logic is needed inside one statement
- readability matters
- multiple steps make the query easier to validate
- no separate reusable object is needed

## Subquery Checklist

- logic is small and embedded
- one comparison or filter is needed
- the query remains readable

## Layer Checklists

| Layer | Check |
|---|---|
| Raw layer | preserve source grain, audit fields, and history |
| Clean layer | apply documented rules and stable keys |
| Reporting layer | serve consumer grain and columns |

## Interface-Choice Questions

- Must rows be stored?
- Must logic be reused?
- Is history required?
- How fresh must the output be?
- What is the grain?
- Who are the consumers?
- What are the dependencies?
- What validation is required?
- Are audit fields needed?
- How sensitive is the interface to change?

## Validation Templates

```sql
SELECT COUNT(*) AS row_count
FROM interface_name;
```

```sql
SELECT key_column, COUNT(*) AS row_count
FROM interface_name
GROUP BY key_column
HAVING COUNT(*) > 1;
```

```sql
SELECT SUM(amount_column) AS total_amount
FROM interface_name;
```

```sql
SELECT MIN(date_column), MAX(date_column)
FROM interface_name;
```
