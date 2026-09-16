# Key-Based Records

Compare a positional tuple with a named record.

```python
tuple_order = ("ORD-1001", "COMPLETED", 125.50)
record_order = {"order_id": "ORD-1001", "status": "COMPLETED", "amount": 125.50}
```

The dictionary is more readable and makes optional fields possible. It also needs a contract: define required keys, expected value types, and consistent snake_case names.

```python
required_keys = {"order_id", "status", "amount"}
observed_keys = set(record_order.keys())
missing_keys = required_keys - observed_keys
extra_keys = observed_keys - required_keys
```

Extra keys are not automatically invalid; they may be useful additions. Investigate them according to the record contract. A technically present key can still have the wrong type, so key validation is the first check, not the only check.
