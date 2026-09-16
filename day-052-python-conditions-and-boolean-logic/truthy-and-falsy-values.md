# Truthy and Falsy Values

Python can treat values as true-like or false-like in a condition.

Common falsy values include:

- `False`
- `None`
- `0`
- `0.0`
- `""`
- empty containers conceptually

> Falsy does not mean semantically equivalent.

## Different Business Meanings

```python
value = 0
```

This could be valid business data.

```python
value = ""
```

This could mean blank input.

```python
value = None
```

This could mean missing.

## Explicit Validation Preference

When zero is specifically the rule:

```python
if row_count == 0:
    print("Source has zero rows")
```

When missing is specifically the rule:

```python
if row_count is None:
    print("Row count is missing")
```

Avoid this when `0` and `None` need different treatment:

```python
# if not row_count:
#     print("Missing or zero")
```

## `bool("False")`

```python
print(bool("False"))
```

This is `True` because `"False"` is a non-empty string. It is not the same as the Boolean value `False`.
