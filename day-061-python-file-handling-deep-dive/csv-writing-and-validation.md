# CSV Writing and Validation

Use `csv.DictWriter` with an explicit field order when a pipeline produces a CSV. Explicit fields make the output schema predictable.

```python
writer = csv.DictWriter(file, fieldnames=["order_id", "amount", "validation_status"])
writer.writeheader()
writer.writerow({"order_id": "O-1001", "amount": "25.50", "validation_status": "PASS"})
```

Validate before writing: required IDs should not be blank, amounts should be numeric and non-negative, and statuses should match the allowed values from configuration. Keep the original row values plus `validation_status` and `validation_reason` so a reviewer can trace every decision.

After writing, read the output again with `DictReader`, confirm the header, and compare the output row count with the input row count. A validation output should not silently lose source records.
