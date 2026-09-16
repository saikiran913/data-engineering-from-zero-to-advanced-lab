# Safe Dictionary Lookups

Use direct access for a required field:

```python
order_id = record["order_id"]
```

If `order_id` is absent, Python raises `KeyError`. That can be useful: a required-field problem should not silently pass.

Use `.get()` when a field is genuinely optional:

```python
review_note = record.get("review_note")
status = record.get("status", "UNKNOWN")
```

`.get()` is not automatically better. A default can hide a data-quality issue when a field is required. Validate first when needed:

```python
if "order_id" in record:
    print(record["order_id"])
```

## Missing Is Not `None`

```python
missing_note = {}
blank_note = {"review_note": None}
```

Both calls to `.get("review_note")` return `None`, but their shapes differ. Check membership when that distinction matters. For nested records, inspect one level at a time: `customer = record.get("customer")`, then use `customer.get("country")` only after confirming `customer` is a dictionary.
