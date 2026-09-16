"""Day 057: an end-to-end in-memory controlled string workflow."""

status_map = {"complete": "COMPLETED", "completed": "COMPLETED", "done": "COMPLETED"}
raw_source_name = " Orders_Source "
raw_status = " done "
raw_record = " ORD-001 | CUST-001 | completed "

clean_source_name = raw_source_name.strip().lower()
clean_status = raw_status.strip().lower()
canonical_status = status_map.get(clean_status, "UNKNOWN")
parts = raw_record.strip().split("|")

print(f"Source: {clean_source_name}")
print(f"Raw status: {raw_status!r}")
print(f"Canonical status: {canonical_status}")
if len(parts) == 3:
    order_id = parts[0].strip()
    customer_id = parts[1].strip()
    record_status = parts[2].strip().upper()
    has_empty_field = order_id == "" or customer_id == "" or record_status == ""
    print(f"Record: order_id={order_id}, customer_id={customer_id}, status={record_status}")
    print(f"Empty field present: {has_empty_field}")
else:
    print(f"Unexpected field count: {len(parts)}")
