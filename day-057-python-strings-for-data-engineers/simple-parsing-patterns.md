# Simple Parsing Patterns

Use controlled parsing only when the record contract is known.

```text
ORD-1001|CUST-001|COMPLETED|125.50
```

1. Strip the whole record.
2. Split on the agreed delimiter.
3. Verify the field count.
4. Strip individual fields.
5. Assign field names.
6. Check required fields.
7. Convert a type only after the text is known valid.

```python
raw_record = " ORD-1001 | CUST-001 | COMPLETED | 125.50 "
parts = raw_record.strip().split("|")
if len(parts) == 4:
    order_id = parts[0].strip()
    customer_id = parts[1].strip()
    status = parts[2].strip().upper()
    amount_text = parts[3].strip()
```

Keep `raw_record` available for traceability. Do not index a parsed list until its length is validated. This is a parsing pattern, not a general-purpose parser.
