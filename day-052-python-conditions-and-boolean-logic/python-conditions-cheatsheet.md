# Python Conditions Cheatsheet

## Comparison

```python
a == b
a != b
a > b
a < b
a >= b
a <= b
```

## If

```python
if condition:
    print("condition is true")
```

## If / Else

```python
if condition:
    print("true branch")
else:
    print("fallback branch")
```

## If / Elif / Else

```python
if condition_a:
    print("first branch")
elif condition_b:
    print("second branch")
else:
    print("fallback")
```

## Boolean

```python
condition_a and condition_b
condition_a or condition_b
not condition_a
```

## None

```python
value is None
value is not None
```

## Membership

```python
status in ("READY", "RETRY")
status not in ("FAILED", "CANCELLED")
```

## Data Engineering Habit

```text
observe
→ evaluate
→ classify
→ explain
```

## Remember

- `=` assigns
- `==` compares
- indentation defines the branch body
- rule order matters
- use named conditions for readability
- test missing values and boundaries
