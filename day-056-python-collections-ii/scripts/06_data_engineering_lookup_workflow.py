"""Day 056: validate a simple key-based record without external I/O."""

record = {
    "order_id": "ORD-1007",
    "status": "COMPLETED",
    "amount": 125.50,
    "customer": {"country": "UK"},
}
required_keys = {"order_id", "status", "amount"}
allowed_statuses = {"PENDING", "COMPLETED", "FAILED"}
observed_keys = set(record.keys())
missing_keys = required_keys - observed_keys
optional_note = record.get("review_note")
customer = record.get("customer", {})
country = customer.get("country", "UNKNOWN")

print("Missing required keys:", missing_keys)
print("Optional review note:", optional_note)
print("Status allowed:", record["status"] in allowed_statuses)
print("Customer country:", country)
print("Validation summary:", "PASS" if not missing_keys else "CHECK REQUIRED KEYS")
