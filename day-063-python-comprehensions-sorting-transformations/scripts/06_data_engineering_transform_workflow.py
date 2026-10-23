"""A readable, in-memory record transformation workflow."""


def normalize_status(raw_status):
    return raw_status.strip().upper() if isinstance(raw_status, str) else None


def clean_record(raw):
    return {**raw, "order_id": raw.get("order_id", "").strip(), "status": normalize_status(raw.get("status")), "source": raw.get("source", "").strip().upper()}


raw_records = [
    {"order_id": " B-2 ", "status": " ready ", "amount": 20, "source": "east"},
    {"order_id": " A-1 ", "status": "complete", "amount": 12, "source": "west"},
    {"order_id": "", "status": "ready", "amount": 5, "source": "east"},
    {"order_id": " C-3 ", "status": "review", "amount": -1, "source": "west"},
]
clean_records = [clean_record(record) for record in raw_records]
valid_records = [record for record in clean_records if record["order_id"] and record["amount"] >= 0]
projected = [{"order_id": record["order_id"], "status": record["status"], "amount": record["amount"], "source": record["source"]} for record in valid_records]
unique_sources = {record["source"] for record in projected}
ordered = sorted(projected, key=lambda record: (record["status"], record["order_id"]))

print("Transformed records:", ordered)
print("Unique sources:", sorted(unique_sources))
print("Input rows:", len(raw_records), "retained rows:", len(ordered))
print("Raw first record is unchanged:", raw_records[0])
