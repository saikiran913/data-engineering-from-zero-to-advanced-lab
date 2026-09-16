# Python Functions Cheatsheet

## Define

```python
def function_name():
    print("hello")
```

## Parameter

```python
def validate_status(status):
    return status == "READY"
```

## Call

```python
validate_status("READY")
```

## Return

```python
def double(value):
    return value * 2
```

## Default Parameter

```python
def classify_errors(error_count, review_limit=5):
    if error_count <= review_limit:
        return "REVIEW"
    return "FAIL"
```

## Keyword Argument

```python
classify_errors(error_count=3, review_limit=5)
```

## Scope

```text
inside function → local
outside function → module/global concept
```

## Data Engineering Pattern

```text
input
→ transform
→ validate
→ return result
```

## Function Design Checklist

- clear name
- clear inputs
- clear output
- limited side effects
- one focused job
