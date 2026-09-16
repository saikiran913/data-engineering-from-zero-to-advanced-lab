"""Day 056: create and change a simple named record."""

order = {"order_id": "ORD-1001", "status": "PENDING", "amount": 125.50}

print("Order ID:", order["order_id"])
print("Field count:", len(order))
print("Has status:", "status" in order)
order["country"] = "UK"
order["status"] = "COMPLETED"
print("Updated order:", order)
