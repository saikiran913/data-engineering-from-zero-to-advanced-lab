# Dictionary Basics

A dictionary is a mutable mapping written with braces. Each key names a value.

```python
order = {"order_id": "ORD-1001", "status": "COMPLETED", "amount": 125.50}
empty_record = {}
print(order["order_id"])
print(len(order))
print("status" in order)  # Membership checks keys.
```

String keys are a good beginner pattern. Use direct lookup for fields required by the record contract. Keys must be unique: in `{"status": "PENDING", "status": "COMPLETED"}`, the final value is `COMPLETED`.

## Practice Examples

1. Create an order dictionary.
2. Create an empty dictionary with `{}`.
3. Look up `order_id`.
4. Look up `status`.
5. Count fields with `len()`.
6. Check whether `amount` is a key.
7. Check whether `country` is absent.
8. Add `country`.
9. Update `status`.
10. Print the dictionary.
11. Use snake_case keys.
12. Explain why a tuple position is less clear.
13. Identify a key-value pair.
14. Explain why duplicate keys are risky.
