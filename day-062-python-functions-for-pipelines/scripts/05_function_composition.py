"""Day 062: compose small stages in a visible order."""


def normalize_status(value):
    return value.strip().upper() if isinstance(value, str) else None


def parse_amount(value):
    try:
        return float(value)
    except (TypeError, ValueError):
        return None


def validate(status, amount):
    if amount is None or amount < 0:
        return {"status": "FAIL", "reason": "Invalid amount"}
    if status not in {"READY", "COMPLETED"}:
        return {"status": "REVIEW", "reason": "Unexpected status"}
    return {"status": "PASS", "reason": "Record is valid"}


def format_result(record_id, result):
    return f"{record_id}: {result['status']} - {result['reason']}"


raw = {"order_id": "ORD-1", "status": " ready ", "amount": "25.00"}
status = normalize_status(raw["status"])
amount = parse_amount(raw["amount"])
result = validate(status, amount)
print(format_result(raw["order_id"], result))
