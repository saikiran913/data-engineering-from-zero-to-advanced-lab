# Counters and Accumulators

## Counter

A counter tracks how many times something happens.

```python
results = ["PASS", "REVIEW", "PASS"]
review_count = 0

for result in results:
    if result == "REVIEW":
        review_count += 1
```

## Multiple Counters

```python
pass_count = 0
review_count = 0
fail_count = 0
```

Use one counter for each outcome.

## Accumulator

An accumulator collects a running value.

```python
row_counts = [100, 50, 75]
total_rows = 0

for row_count in row_counts:
    total_rows += row_count
```

## Initialize Before Loop

Counters and accumulators should start before the loop.

## Update Inside Loop

Update them inside the loop body when the current item matches the rule.

## Final Summary After Loop

Print the summary after the loop, not accidentally inside every iteration.

## Running Total Versus Final Total

A running total changes during the loop. The final total is used after the loop has finished.

## Data Engineering Examples

- files reviewed
- records checked
- failures found
- total rows
- total error count
