"""Day 062: an in-memory workflow with visible pipeline stages."""
from datetime import date


def normalize_status(value):
    return value.strip().upper() if isinstance(value, str) else None


def parse_amount(value):
    try:
        return float(value)
    except (TypeError, ValueError):
        return None


def parse_date(value):
    try:
        return date.fromisoformat(value)
    except (TypeError, ValueError):
        return None


def validate(record, required_fields, allowed_statuses, minimum_amount=0):
    for field in required_fields:
        if not str(record.get(field, "")).strip():
            return {"status": "FAIL", "reason": f"Missing {field}"}
    if record["amount"] is None or record["amount"] < minimum_amount:
        return {"status": "FAIL", "reason": "Invalid amount"}
    if record["event_date"] is None:
        return {"status": "FAIL", "reason": "Invalid date"}
    if record["status"] not in allowed_statuses:
        return {"status": "REVIEW", "reason": "Unexpected status"}
    return {"status": "PASS", "reason": "Record is valid"}


raw_records = [
    {"record_id": "R-1", "status": " ready ", "amount": "12.50", "event_date": "2026-01-10"},
    {"record_id": "R-2", "status": "unknown", "amount": "9", "event_date": "2026-01-11"},
    {"record_id": "R-3", "status": "completed", "amount": "bad", "event_date": "not-a-date"},
]
results = []
for raw in raw_records:
    clean = {**raw, "status": normalize_status(raw["status"]), "amount": parse_amount(raw["amount"]), "event_date": parse_date(raw["event_date"])}
    result = validate(clean, ["record_id", "status"], {"READY", "COMPLETED"})
    results.append({"record_id": raw["record_id"], **result})

for result in results:
    print(result)
print({key: sum(row["status"] == key for row in results) for key in ("PASS", "REVIEW", "FAIL")})
