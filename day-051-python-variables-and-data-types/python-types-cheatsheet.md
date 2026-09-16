# Python Types Cheatsheet

| Type | Example | Typical DE use |
|---|---|---|
| `int` | `100` | row count |
| `float` | `42.5` | measurement/amount |
| `str` | `"ORD-001"` | IDs/status/text |
| `bool` | `True` | validation state |
| `NoneType` | `None` | missing/not available |

## Inspect Type

```python
type(value)
```

## Convert

```python
int("100")
float("45.5")
str(100)
```

## None Check

```python
value is None
```

## Remember

```text
100 is not the same type/value as "100"
False is not the same as "False"
None is not the same as 0
None is not the same as ""
```

## Beginner Best Practices

- use descriptive variable names
- use `snake_case`
- inspect surprising values with `type()`
- keep IDs as strings when leading zeros or formatting matter
- check `None` before conversion
- do not use `bool()` as a text parser for `"True"` or `"False"`
