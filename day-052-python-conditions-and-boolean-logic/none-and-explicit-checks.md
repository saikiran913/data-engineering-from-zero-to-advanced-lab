# None and Explicit Checks

## Check Missing Value

```python
review_note = None
print(review_note is None)
```

## Check Value Is Present

```python
print(review_note is not None)
```

## Why Not Use `== None`

Standard Python style prefers:

```python
value is None
```

`None` is a special singleton object, so identity checking is clear and conventional.

## None Versus Zero

```python
row_count = 0
missing_count = None
```

Zero is a known numeric value. `None` means no value is available.

## None Versus Empty String

```python
comment = ""
missing_comment = None
```

Empty text and missing value are different states.

## Optional Metric Scenario

```python
row_count = None

if row_count is None:
    print("Row count not available")
```

## Check Before Numeric Comparison

Do not compare a missing numeric value blindly to a threshold.

```python
row_count = None

if row_count is not None and row_count > 0:
    print("Rows are available")
else:
    print("Row count is missing or zero")
```

The order matters because Python checks the missing-state rule before the numeric comparison.

## Data Engineering Missing-State Examples

- metric not calculated
- source not received
- optional error message
- absent timestamp
