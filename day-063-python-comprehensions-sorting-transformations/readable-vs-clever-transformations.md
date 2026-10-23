# Readable vs Clever Transformations

A simple comprehension makes one operation easy to see:

```python
clean_ids = [value.strip() for value in ids if value.strip()]
```

When several conditions and business reasons must be recorded, a dense one-liner is harder to review. Use a loop and a helper:

```python
def classify_record(record):
    if not record.get('order_id', '').strip():
        return 'FAIL', 'Missing order ID'
    if record.get('amount') is None:
        return 'REVIEW', 'Amount needs investigation'
    return 'PASS', 'Ready'

results = []
for record in records:
    status, reason = classify_record(record)
    results.append({'order_id': record.get('order_id'), 'status': status, 'reason': reason})
```

Prefer one clear transformation and, where useful, one clear filter per comprehension. A named helper is worthwhile when a rule recurs. Choose a loop if the code needs multiple branches, logging, or a reason for each source record.
