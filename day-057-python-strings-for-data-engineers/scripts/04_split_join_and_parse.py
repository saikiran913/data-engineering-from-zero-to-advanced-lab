"""Day 057: parse one controlled pipe-delimited record."""

raw_record = " ORD-1001 | CUST-001 | completed "
parts = raw_record.strip().split("|")

print("Part count:", len(parts))
if len(parts) == 3:
    order_id = parts[0].strip()
    customer_id = parts[1].strip()
    status = parts[2].strip().upper()
    clean_parts = [order_id, customer_id, status]
    print("Order ID:", order_id)
    print("Customer ID:", customer_id)
    print("Status:", status)
    print("Rejoined:", "|".join(clean_parts))
else:
    print("Record requires review because the field count is unexpected.")
