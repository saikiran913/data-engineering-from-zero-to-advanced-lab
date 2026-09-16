# None and Missing Values

## What Is `None`?

`None` represents a no-value or missing-state concept in Python.

```python
last_error = None
```

This can mean no error is currently available.

## `NoneType`

```python
print(type(None))
```

The type of `None` is `NoneType`.

## Missing Versus Zero

```python
amount = 0
missing_amount = None
```

Zero is a real numeric value. `None` means no value is available.

## Missing Versus Empty String

```python
comment = ""
missing_comment = None
```

An empty string is text with no characters. `None` means no value.

## Missing Versus False

```python
is_valid = False
validation_result = None
```

`False` is a known no/false state. `None` means the value is not available.

## Checking `None`

Prefer `is None`:

```python
value = None

if value is None:
    print("Value is missing")
```

## Cross-System Mapping

JSON has `null`, SQL has `NULL`, and Python has `None`. These are related ideas across systems, but they are not identical implementations.

## Data Engineering Examples

`None` can represent an optional error message, a not-yet-calculated metric, a missing upstream value, or an optional timestamp.
