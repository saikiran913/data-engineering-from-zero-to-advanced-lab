"""Day 056: required and optional dictionary lookup."""

record = {"order_id": "ORD-1002", "status": "PENDING", "review_note": None}

print("Required order ID:", record["order_id"])
print("Optional note:", record.get("review_note"))
print("Optional campaign:", record.get("campaign", "NOT PROVIDED"))
print("Has review_note key:", "review_note" in record)
print("Has campaign key:", "campaign" in record)
