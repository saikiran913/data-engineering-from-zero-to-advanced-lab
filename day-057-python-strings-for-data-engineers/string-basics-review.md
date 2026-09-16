# String Basics Review

A string is text in quotes. An empty string is `""`; a whitespace-only string such as `"   "` contains characters but may be blank after cleaning.

```python
order_id = "ORD-1001"
customer_id = "00125"  # Keep meaningful leading zeros.
print(order_id[0])
print(order_id[:3])
print(len(order_id))
print("ORD" in order_id)
```

Strings are immutable. `order_id.upper()` returns a new string; it does not change `order_id`. Store identifiers as text when their formatting is meaningful. Converting `"00125"` to a number would lose its leading zeros.
