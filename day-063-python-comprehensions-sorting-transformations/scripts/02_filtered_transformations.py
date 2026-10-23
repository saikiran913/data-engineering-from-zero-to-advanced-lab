"""Filter simple values; keep complex classification in a normal loop."""

amounts = [-2, 0, 5, 12]
non_negative = [amount for amount in amounts if amount >= 0]

statuses = [None, " ready ", "  ", "completed"]
clean_statuses = [status.strip().upper() for status in statuses if status is not None and status.strip()]

records = [
    {"id": "A", "amount": 10, "status": "READY"},
    {"id": "", "amount": 3, "status": "READY"},
    {"id": "C", "amount": -1, "status": "UNKNOWN"},
]
results = []
for record in records:
    if not record["id"]:
        result = ("FAIL", "Missing ID")
    elif record["amount"] < 0:
        result = ("FAIL", "Negative amount")
    elif record["status"] == "UNKNOWN":
        result = ("REVIEW", "Unknown status")
    else:
        result = ("PASS", "Valid record")
    results.append({"id": record["id"], "status": result[0], "reason": result[1]})

print("Non-negative amounts:", non_negative)
print("Clean statuses:", clean_statuses)
print("Classified records:", results)
