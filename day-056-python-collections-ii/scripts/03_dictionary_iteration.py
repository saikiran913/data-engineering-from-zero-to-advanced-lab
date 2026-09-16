"""Day 056: inspect dictionary keys, values, and pairs."""

record = {"order_id": "ORD-1003", "status": "COMPLETED", "amount": 75.00}

print("Type:", type(record).__name__)
print("Keys:", list(record.keys()))
print("Values:", list(record.values()))
for field_name, value in record.items():
    print(field_name, "=", value)
