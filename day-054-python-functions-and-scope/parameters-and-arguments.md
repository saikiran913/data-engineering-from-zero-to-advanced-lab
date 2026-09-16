# Parameters and Arguments

## Parameter

```python
def validate_status(status):
    return status == "READY"
```

`status` is the parameter.

## Argument

```python
validate_status("READY")
```

`"READY"` is the argument.

## Multiple Parameters

```python
def calculate_ratio(valid_count, total_count):
    return valid_count / total_count
```

## Positional Arguments

```python
calculate_ratio(95, 100)
```

Python matches by position: `95` goes to `valid_count`, and `100` goes to `total_count`.

## Keyword Arguments

```python
calculate_ratio(valid_count=95, total_count=100)
```

Keyword arguments name which parameter receives which value.

## Default Parameter Concept

```python
def classify_error_count(error_count, review_limit=5):
    if error_count <= review_limit:
        return "REVIEW"
```

The default is used if the caller omits that argument. The caller can override it.

## Parameter Naming

Use business meaning. `valid_count` is clearer than `x`.

## Argument Order

When using positional arguments, order matters.

## Avoid Too Many Parameters Conceptually

Too many parameters can make a function hard to understand. Keep beginner functions small and focused.

## Practice

```python
def validate_record_count(record_count):
    return record_count > 0

def normalize_status(status):
    return status.strip().upper()

def calculate_total(first_count, second_count):
    return first_count + second_count

def calculate_completeness(valid_count, total_count):
    return (valid_count / total_count) * 100

def classify_errors(error_count, review_limit=5):
    if error_count == 0:
        return "PASS"
    if error_count <= review_limit:
        return "REVIEW"
    return "FAIL"

def build_stage_name(source_name, prefix="staging"):
    return f"{prefix}_{source_name}"
```
