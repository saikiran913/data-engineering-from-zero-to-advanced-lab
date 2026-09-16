# Nested Data Structures

Real records often have a shallow nested shape.

```python
order = {
    "order_id": "ORD-1001",
    "customer": {"customer_id": "CUST-001", "country": "UK"},
    "flags": ["REVIEWED"],
}
```

A dictionary inside a dictionary models related named fields. A dictionary containing a list models several values such as flags. A list of dictionaries models several records.

```python
orders = [order, {"order_id": "ORD-1002", "customer": {"country": "India"}, "flags": []}]
for item in orders:
    customer = item.get("customer", {})
    print(item.get("order_id"), customer.get("country"))
```

Document the record shape, required nested keys, and optional nested keys. Avoid deep unreadable chains such as repeated bracket access. Keep nesting shallow and inspect one level at a time.
