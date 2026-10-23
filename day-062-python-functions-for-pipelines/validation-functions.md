# Validation Functions

Validation applies business rules after parsing and normalization. This lesson uses one predictable result contract:

```python
{"status": "PASS", "reason": "Record is valid"}
```

```python
def validate_required_fields(record, required_fields): ...
def validate_status(status, allowed_statuses): ...
def validate_amount(amount, minimum_amount=0): ...
def validate_record(record, required_fields, allowed_statuses, minimum_amount=0): ...
```

`validate_record` composes focused validators. A missing required value or invalid amount is FAIL; an unconfigured status can be REVIEW so the source remains visible. Every normal branch returns the same two keys, allowing callers to inspect results without guessing their type.
