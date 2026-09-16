# Python Mappings and Sets Cheatsheet

```python
record = {"order_id": "ORD-1001", "amount": 125.50}
required_id = record["order_id"]
optional_note = record.get("review_note")
status = record.get("status", "UNKNOWN")
has_amount = "amount" in record

for key, value in record.items():
    print(key, value)

statuses = {"PENDING", "COMPLETED"}
empty_statuses = set()
is_allowed = "COMPLETED" in statuses
unique_ids = set(["A", "B", "A"])
missing = {"order_id", "status"} - set(record.keys())
```

| Pattern | Meaning |
| --- | --- |
| `record["key"]` | Required direct lookup |
| `record.get("key")` | Optional lookup |
| `.get("key", default)` | Optional lookup with fallback |
| `.items()` | Key and value pairs |
| `set()` | Empty set |
| `a | b` | Union of values |
| `a & b` | Shared values |
| `a - b` | Values in `a` but not `b` |

```text
key-based record
→ check required keys
→ lookup safely
→ validate values
→ summarize
```
