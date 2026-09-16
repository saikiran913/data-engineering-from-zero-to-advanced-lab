"""Day 056: safely inspect shallow nested order records."""

orders = [
    {"order_id": "ORD-1004", "customer": {"country": "UK"}, "flags": ["REVIEWED"]},
    {"order_id": "ORD-1005", "customer": {"country": "India"}, "flags": []},
    {"order_id": "ORD-1006", "flags": ["CHECK_STATUS"]},
]

for order in orders:
    customer = order.get("customer", {})
    country = customer.get("country", "UNKNOWN")
    print(order["order_id"], "country=", country, "flags=", order.get("flags", []))
