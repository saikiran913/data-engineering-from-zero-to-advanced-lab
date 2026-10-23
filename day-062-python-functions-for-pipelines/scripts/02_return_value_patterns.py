"""Day 062: common, consistent return contracts."""


def normalize_text(value):
    return value.strip().upper() if isinstance(value, str) else None


def has_required_value(value):
    return value is not None and str(value).strip() != ""


def validate_amount(amount):
    if amount is None:
        return "FAIL", "Amount is missing"
    return ("PASS", "Amount is valid") if amount >= 0 else ("FAIL", "Amount is negative")


def validate_status(status, allowed_statuses):
    if status in allowed_statuses:
        return {"status": "PASS", "reason": "Status is allowed"}
    return {"status": "REVIEW", "reason": "Status is not configured"}


print(normalize_text(" ready "))
print(has_required_value("ORD-1"))
print(validate_amount(-1))
print(validate_status("READY", {"READY", "COMPLETED"}))
