# Validation Functions

Validation functions package reusable business rules.

## Record Count

```python
def validate_record_count(record_count):
    if record_count is None:
        return "REVIEW"

    if record_count == 0:
        return "FAIL"

    return "PASS"
```

Contract:

- expected input: record count as integer or `None`
- possible outputs: `PASS`, `REVIEW`, `FAIL`
- rule meaning: missing counts need review, zero rows fail, positive rows pass

## Status Validation

```python
def validate_status(status):
    allowed_statuses = ("READY", "COMPLETED")

    if status in allowed_statuses:
        return "PASS"

    return "FAIL"
```

Tuple membership is used lightly here to check allowed values.

## Threshold Validation

```python
def classify_error_count(error_count, review_limit=5):
    if error_count == 0:
        return "PASS"

    if error_count <= review_limit:
        return "REVIEW"

    return "FAIL"
```

## Return Reason

Day 054 keeps return values simple. The function returns the outcome, and orchestration code can print the reason.

## Missing Inputs

Document how the function handles missing values.

## Clear Rule Contract

For each validation function, document expected input, possible outputs, and rule meaning.
