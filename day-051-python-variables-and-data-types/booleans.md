# Booleans

## Boolean Values

A boolean has only two possible values:

```python
is_valid = True
is_complete = False
```

Capitalisation matters. Python uses `True` and `False`, not `true` and `false`.

## Comparisons Produce Booleans

```python
row_count = 10
status = "READY"

print(row_count > 0)
print(status == "READY")
```

The result of each comparison is a boolean.

## Boolean Naming

Boolean names often sound like yes/no questions:

- `is_valid`
- `has_errors`
- `is_complete`
- `needs_review`

## Truthiness Concept

Python can convert values to booleans:

```python
print(bool(""))
print(bool("False"))
print(bool(0))
print(bool(1))
print(bool(None))
```

Critical warning: `bool("False")` is `True` because it is a non-empty string. Generic `bool()` is not a parser for textual true/false values.

## Data Engineering Examples

Booleans can represent validation passed, file found, load complete, review required, or error present.
