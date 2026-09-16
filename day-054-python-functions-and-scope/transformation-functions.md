# Transformation Functions

Transformation functions change raw values into cleaner or more useful values.

## Normalize Status

```python
def normalize_status(status):
    return status.strip().upper()
```

## Normalize File Label

```python
def normalize_source_name(source_name):
    return source_name.strip().lower()
```

## Calculate Completeness

```python
def calculate_completeness(valid_count, total_count):
    if total_count == 0:
        return None

    return (valid_count / total_count) * 100
```

This validates before division. Returning `None` for an undefined case is one possible business rule. Another project may choose a different rule.

## Add Prefix

```python
def build_stage_name(source_name):
    return f"staging_{source_name}"
```

## Transformation Functions Should Not Silently Print or Write

A transformation function should return the transformed value. Printing or writing should happen in orchestration code when needed.
