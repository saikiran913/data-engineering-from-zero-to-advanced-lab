# Notes — Python Conditions and Boolean Logic

## What Is a Condition?

A condition is a question that evaluates to either `True` or `False`.

```python
record_count > 0
```

If `record_count` is greater than zero, the result is:

```python
True
```

Otherwise, the result is:

```python
False
```

## Comparison Operators

| Operator | Meaning |
|---|---|
| `==` | equal |
| `!=` | not equal |
| `>` | greater than |
| `<` | less than |
| `>=` | greater than or equal |
| `<=` | less than or equal |

## Assignment Versus Comparison

```python
status = "READY"
```

This assigns the text `"READY"` to `status`.

```python
status == "READY"
```

This checks whether `status` equals `"READY"`.

## `if`

```python
record_count = 10

if record_count > 0:
    print("Rows are available")
```

The indented line runs only when the condition is true.

## `if` / `else`

```python
if record_count > 0:
    print("Rows are available")
else:
    print("No rows found")
```

## `if` / `elif` / `else`

```python
error_count = 3

if error_count == 0:
    print("PASS")
elif error_count <= 5:
    print("REVIEW")
else:
    print("FAIL")
```

Python checks branches in order and runs the first matching branch.

## Indentation

Python uses indentation to define code blocks. Four spaces is common style.

## Boolean Operators

- `and`: both conditions must be true
- `or`: at least one condition must be true
- `not`: reverses a Boolean value

## Explicit Business-Rule Variables

Readable:

```python
has_rows = record_count > 0
has_required_columns = True

if has_rows and has_required_columns:
    print("Validation passed")
```

This is easier to review than one long unreadable condition.

## Decision Flow

In an `if` / `elif` / `else` chain, Python follows the first matching branch and skips the rest.

## Data Engineering Validation

```text
observation
→ rule
→ Boolean result
→ validation outcome
→ review message
```
