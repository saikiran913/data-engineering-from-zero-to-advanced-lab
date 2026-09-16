"""Day 057: basic in-memory string operations."""

order_id = "ORD-1001"
empty_value = ""
whitespace_value = "   "
raw_status = " ready "
clean_status = raw_status.strip()

print("Length:", len(order_id))
print("First character:", order_id[0])
print("Prefix slice:", order_id[:3])
print("Contains ORD:", "ORD" in order_id)
print("Empty string length:", len(empty_value))
print("Whitespace becomes blank:", whitespace_value.strip() == "")
print("Raw status:", repr(raw_status))
print("Clean status:", repr(clean_status))
