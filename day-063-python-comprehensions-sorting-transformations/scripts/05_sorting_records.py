"""Order dictionaries with explicit keys and a missing-value rule."""

records = [
    {"order_id": "ORD-3", "status": "READY", "amount": 25},
    {"order_id": "ORD-2", "status": "REVIEW", "amount": None},
    {"order_id": "ORD-1", "status": "READY", "amount": 10},
]


def amount_key(record):
    amount = record.get("amount")
    return (amount is None, 0 if amount is None else amount)


by_amount = sorted(records, key=amount_key)
known_amounts = [record for record in records if record["amount"] is not None]
descending_known = sorted(known_amounts, key=lambda record: record["amount"], reverse=True)
by_status_then_id = sorted(records, key=lambda record: (record["status"], record["order_id"]))

print("Ascending amount; missing last:", by_amount)
print("Descending known amounts:", descending_known)
print("Status then ID:", by_status_then_id)
print("Original order remains:", [record["order_id"] for record in records])
