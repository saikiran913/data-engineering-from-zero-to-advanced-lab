"""Day 055: tuple basics."""

order_record = ("ORD-1001", "CUST-001", "COMPLETED", 125.50)
single_source = ("orders",)

order_id = order_record[0]
customer_id = order_record[1]
order_status = order_record[2]
order_amount = order_record[3]

print("Order record:", order_record)
print("Order ID:", order_id)
print("Customer ID:", customer_id)
print("Order status:", order_status)
print("Order amount:", order_amount)
print("Single-item tuple:", single_source)

unpacked_order_id, unpacked_customer_id, unpacked_status, unpacked_amount = order_record

print("Unpacked values:")
print(unpacked_order_id, unpacked_customer_id, unpacked_status, unpacked_amount)

# order_record[2] = "PENDING" would raise TypeError because tuples are immutable.
