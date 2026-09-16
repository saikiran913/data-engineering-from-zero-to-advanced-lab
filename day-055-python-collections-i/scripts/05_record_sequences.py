"""Day 055: record-like tuple sequences."""

order_records = [
    ("ORD-1001", "COMPLETED", 125.50),
    ("ORD-1002", "PENDING", 80.00),
    ("ORD-1003", "CANCELLED", 0.00),
]

for order_id, order_status, order_amount in order_records:
    if order_status == "COMPLETED" and order_amount > 0:
        decision = "PASS"
    elif order_status == "PENDING":
        decision = "REVIEW"
    else:
        decision = "FAIL"

    print("Order:", order_id)
    print("Status:", order_status)
    print("Amount:", order_amount)
    print("Decision:", decision)
