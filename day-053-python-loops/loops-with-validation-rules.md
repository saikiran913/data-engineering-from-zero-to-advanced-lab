# Loops with Validation Rules

Loops often combine with Day 052 conditions.

## Example Statuses

```python
validation_results = ["PASS", "PASS", "REVIEW", "FAIL"]
```

## Classify Each Result

```python
for result in validation_results:
    if result == "PASS":
        print("Passed")
    elif result == "REVIEW":
        print("Needs review")
    else:
        print("Failed")
```

## Count Outcomes

```python
pass_count = 0
review_count = 0
fail_count = 0

for result in validation_results:
    if result == "PASS":
        pass_count += 1
    elif result == "REVIEW":
        review_count += 1
    else:
        fail_count += 1
```

## Numeric Validation Loop

```python
row_counts = [100, 0, 75, 120]

for row_count in row_counts:
    if row_count > 0:
        print("PASS")
    elif row_count == 0:
        print("FAIL")
```

If `None` is possible, handle it before numeric comparison.

## Named Rule Inside Loop

```python
for row_count in row_counts:
    has_rows = row_count > 0

    if has_rows:
        print("PASS: source has rows")
```

## Summary After Loop

Example output:

```text
PASS: 2
REVIEW: 1
FAIL: 1
```

## Preserve Each Item's Meaning

Do not overwrite source labels or input values accidentally.

## Avoid One Giant Loop Body

Keep each loop easy to read. Long loop bodies are harder to test.

## Validation Reason

Each item should print:

- input
- decision
- reason

## Full Scan Versus Early Stop

A full scan checks every item and produces a full summary. A fail-fast loop stops early after a serious issue. They are different strategies.
