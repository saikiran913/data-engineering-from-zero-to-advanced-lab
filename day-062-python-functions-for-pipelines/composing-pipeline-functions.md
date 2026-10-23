# Composing Pipeline Functions

```text
raw record → normalize → parse → validate → format
```

Composition means passing one focused function's result to the next stage. It avoids a giant function and supports direct-call debugging: print or test the normalized record, then the parsed values, then the validation result.

```python
clean = normalize_record(raw)
clean = {**clean, "amount": parse_amount(raw.get("amount"))}
result = validate_record(clean, required_fields, allowed_statuses)
message = format_record_result(clean["record_id"], result)
```

Failures are isolated: parsing can return `None`, validation can explain it, and formatting does not need to know how parsing worked.
