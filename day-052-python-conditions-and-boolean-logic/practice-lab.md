# Build Clear Python Validation Decisions

## Part 1 — Verify Python

```bash
python --version
```

Use the Python 3 command from your own environment.

## Part 2 — Run Comparison Script

```bash
python scripts/01_comparison_basics.py
```

## Part 3 — Run Branch Script

```bash
python scripts/02_if_elif_else.py
```

## Part 4 — Run Boolean Operators Script

```bash
python scripts/03_boolean_operators.py
```

## Part 5 — Run None Validation Script

```bash
python scripts/04_none_validation.py
```

## Part 6 — Run Data-Quality Rules

```bash
python scripts/05_data_quality_rules.py
```

## Part 7 — Run Validation Summary

```bash
python scripts/06_validation_decision_summary.py
```

## Part 8 — REPL Comparisons

```python
record_count = 100
record_count > 0
record_count == 100
record_count != 0
```

## Part 9 — Boolean Combinations

```python
has_rows = True
schema_valid = True
has_rows and schema_valid
```

## Part 10 — None Check

```python
row_count = None
row_count is None
```

## Part 11 — Build Threshold Logic

Use:

- `PASS` at 0 errors
- `REVIEW` at 1-5 errors
- `FAIL` above 5 errors

## Part 12 — Test Boundaries

Use:

- `0`
- `1`
- `5`
- `6`

## Part 13 — Build Combined Validation

Variables:

- `has_rows`
- `schema_valid`
- `is_fresh`

## Part 14 — Explain Result in Plain English

Write one sentence explaining why your validation passed, needs review, or failed.

## Lab Checklist

- understands comparisons
- understands `if` / `elif` / `else`
- understands Boolean operators
- understands `None` checks
- understands rule order
- tests boundaries
- can explain validation decisions
