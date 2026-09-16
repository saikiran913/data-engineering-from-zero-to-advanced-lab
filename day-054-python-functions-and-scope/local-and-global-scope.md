# Local and Global Scope

## Local Variable

```python
def calculate_total():
    local_total = 100
    return local_total
```

`local_total` exists inside the function.

## Outside Access Fails Conceptually

A local variable is not available outside the function that created it.

## Global or Module-Level Variable Concept

```python
default_status = "UNKNOWN"
```

This name exists at module level.

## Reading Global Value Conceptually

Functions can read names from outside, but hidden dependencies make interfaces less clear.

## Avoid Hidden Dependencies

Bad:

```python
threshold = 5

def classify_errors(error_count):
    if error_count <= threshold:
        return "REVIEW"
```

Better:

```python
def classify_errors(error_count, review_threshold):
    if error_count <= review_threshold:
        return "REVIEW"
```

Explicit parameters improve interface clarity.

## Variable Shadowing

```python
status = "GLOBAL"

def example():
    status = "LOCAL"
    return status
```

The local `status` does not overwrite the module-level `status` unless explicit global mutation mechanisms are used.

Python has a `global` keyword, but Day 054 intentionally avoids using it because explicit parameters and return values are clearer for beginner Data Engineering code.

## Scope Debugging

When a value surprises you, inspect where it is defined, where it is passed, and where it is returned.
