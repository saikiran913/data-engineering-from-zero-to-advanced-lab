# Rule Order and Precedence

## Business Rule Order

Check severe rules before broader rules when conditions overlap.

```python
error_count = 120

if error_count > 100:
    status = "FAIL"
elif error_count > 0:
    status = "REVIEW"
else:
    status = "PASS"
```

This works because the severe rule appears first.

Bad order:

```python
error_count = 120

if error_count > 0:
    status = "REVIEW"
elif error_count > 100:
    status = "FAIL"
else:
    status = "PASS"
```

The `error_count > 100` branch is unreachable because values above 100 also match `error_count > 0`.

## Boolean Operator Precedence

At a beginner level, Python evaluates:

1. `not`
2. `and`
3. `or`

Prefer parentheses instead of relying on memory.

```python
is_valid = schema_valid and (is_fresh or is_recoverable)
```

## Overlapping Conditions

Two rules overlap when one value can satisfy both. Order then affects the final outcome.

## Unreachable Branch Concept

A branch is unreachable when an earlier condition already captures every value that could reach it.

## Boundary Gaps

Example mistake:

```python
if error_count < 0:
    status = "INVALID"
elif error_count > 0:
    status = "HAS_ERRORS"
```

This forgets `error_count == 0`.

## Exhaustive Outcomes

Use `else` when a fallback should be explicit.

## Review Checklist

1. do rules overlap?
2. does order matter?
3. are boundaries complete?
4. is missing data handled?
5. is fallback explicit?
6. is outcome explainable?
