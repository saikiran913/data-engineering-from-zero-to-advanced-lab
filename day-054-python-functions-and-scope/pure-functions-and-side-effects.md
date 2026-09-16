# Pure Functions and Side Effects

## Pure Function Concept

```python
def normalize_status(status):
    return status.strip().upper()
```

The same input gives the same output, and the function does not secretly change external state.

## Same Input, Same Output

```python
normalize_status(" ready ")
```

This returns `"READY"` every time.

## No Hidden State

A pure function does not depend on hidden variables that the caller cannot see.

## Side Effect

Side effects include:

- `print()`
- writing a file
- database update
- network call

Only `print()` is used in Day 054 scripts, and printing happens in orchestration examples.

## Why Pure Transformations Are Valuable

Pure transformations are easier to test, reuse, reason about, and compose.

## Transformation Versus Orchestration

Transformation:

```python
clean_status = normalize_status(raw_status)
```

Orchestration:

```python
print(clean_status)
```

## Data Engineering Connection

Data pipelines often move from raw values to clean values. Pure transformation functions make that step explicit.
