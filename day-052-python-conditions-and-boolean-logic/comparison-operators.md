# Comparison Operators

Comparisons create Boolean results.

## Equality

```python
status = "COMPLETED"
print(status == "COMPLETED")
```

## Inequality

```python
status = "READY"
print(status != "CANCELLED")
```

## Greater Than

```python
record_count = 10
print(record_count > 0)
```

## Less Than

```python
error_count = 3
print(error_count < 5)
```

## Boundaries

```python
completeness_pct = 99.0
print(completeness_pct >= 99.0)
```

## String Comparisons

String equality is useful for statuses, country codes, and labels.

```python
source_status = "READY"
print(source_status == "READY")
```

Do not rely on advanced string ordering yet.

## Type Mismatch Awareness

```python
print(100 == "100")
```

This is `False` because one value is an integer and the other is a string. Ordering comparisons between incompatible types can fail in Python 3.

```python
# 100 > "50" would raise TypeError.
```

## Chained Comparisons

```python
error_count = 4
print(0 <= error_count <= 10)
```

This is a readable range check.

## Boundary Testing

Test below, exactly at, and above the boundary.

| Example | Condition | Why test it |
|---|---|---|
| `record_count = 0` | `record_count > 0` | empty source |
| `record_count = 1` | `record_count > 0` | first valid value |
| `error_count = 5` | `error_count <= 5` | exact review threshold |
| `error_count = 6` | `error_count <= 5` | just above threshold |
| `completeness_pct = 98.9` | `>= 99.0` | below boundary |
| `completeness_pct = 99.0` | `>= 99.0` | exact boundary |
| `amount = -1` | `amount >= 0` | invalid negative |
| `amount = 0` | `amount >= 0` | zero value |
| `status = "READY"` | `== "READY"` | allowed status |
| `status = "ready"` | `== "READY"` | case mismatch |
| `value = None` | `is None` | missing state |
| `value = ""` | `== ""` | empty text |
