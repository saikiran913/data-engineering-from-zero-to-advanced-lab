# Boolean Operators

## `and`

Both conditions must be true.

```python
has_rows = True
has_required_columns = True

print(has_rows and has_required_columns)
```

| Left | Right | Result |
|---|---|---|
| `True` | `True` | `True` |
| `True` | `False` | `False` |
| `False` | `True` | `False` |
| `False` | `False` | `False` |

## `or`

At least one condition must be true.

```python
status = "FAILED"
print(status == "FAILED" or status == "REJECTED")
```

| Left | Right | Result |
|---|---|---|
| `True` | `True` | `True` |
| `True` | `False` | `True` |
| `False` | `True` | `True` |
| `False` | `False` | `False` |

## `not`

`not` reverses a Boolean.

```python
has_errors = False
print(not has_errors)
```

| Value | Result |
|---|---|
| `True` | `False` |
| `False` | `True` |

## Parentheses

Prefer parentheses when logic combines `and` and `or`.

```python
is_recent = True
status = "READY"

print(is_recent and (status == "READY" or status == "RETRY"))
```

## Short-Circuit Concept

At a beginner level:

- `and` may stop after a false condition
- `or` may stop after a true condition

Do not rely on side effects. Keep conditions simple and readable.

## Membership

```python
status = "READY"
print(status in ("READY", "RETRY"))
```

This checks whether `status` matches one of the allowed values.

```python
print(status not in ("FAILED", "CANCELLED"))
```

This checks whether `status` is not blocked. The tuple is only used here as a simple membership example.

## Avoid Overly Complex Expressions

If a condition is hard to read, break it into named parts.
