# Iterate Through Data Engineering Checks with Python

## Part 1 — Verify Python

```bash
python --version
```

Use the Python 3 command from your own environment.

## Part 2 — Run For-Loop Basics

```bash
python scripts/01_for_loop_basics.py
```

## Part 3 — Run While-Loop Basics

```bash
python scripts/02_while_loop_basics.py
```

## Part 4 — Run Range and Counter Script

```bash
python scripts/03_range_and_counters.py
```

## Part 5 — Run Validation-Results Loop

```bash
python scripts/04_validation_results_loop.py
```

## Part 6 — Run File-Review Loop

```bash
python scripts/05_file_review_loop.py
```

## Part 7 — Run Data Engineering Loop Summary

```bash
python scripts/06_data_engineering_loop_summary.py
```

## Part 8 — REPL For Loop

```python
files = ["orders.csv", "customers.csv", "products.csv"]

for file_name in files:
    print(file_name)
```

## Part 9 — Range

```python
for number in range(1, 4):
    print(number)
```

## Part 10 — Counter

Count `PASS` values in:

```python
results = ["PASS", "REVIEW", "PASS"]
```

## Part 11 — Validation Classification

Use hard-coded row counts and classify:

- greater than zero as `PASS`
- zero as `FAIL`
- missing conceptually as `REVIEW`

## Part 12 — While Loop

Create a bounded 3-attempt loop.

## Part 13 — Break

Stop when a `FAIL` value appears.

## Part 14 — Continue

Skip `"SKIP"` status.

## Part 15 — Nested Loops

Use two files x two checks and count the printed pairs.

## Lab Checklist

- understands `for`
- understands `while`
- can use `range()`
- can use counters
- can use `break` and `continue`
- understands nested-loop growth
- can summarize validation outcomes
