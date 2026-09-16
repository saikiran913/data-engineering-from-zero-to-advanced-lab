"""Day 053: review hard-coded source labels and row counts."""

file_checks = (
    ("orders.csv", 120),
    ("customers.csv", 0),
    ("products.csv", 75),
)

for file_name, row_count in file_checks:
    if row_count > 0:
        decision = "PASS"
        reason = "source has rows"
    else:
        decision = "FAIL"
        reason = "source has zero rows"

    print(f"File: {file_name}")
    print(f"Row count: {row_count}")
    print(f"Decision: {decision}")
    print(f"Reason: {reason}")
