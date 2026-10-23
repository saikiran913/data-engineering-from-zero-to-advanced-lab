"""Validation helpers share a dictionary result contract."""


def validate_required_fields(record, required_fields):
    missing = [field for field in required_fields if not str(record.get(field, "")).strip()]
    if missing:
        return {"status": "FAIL", "reason": f"Missing required fields: {', '.join(missing)}"}
    return {"status": "PASS", "reason": "Required fields are present"}


def validate_status(status, allowed_statuses):
    if status in allowed_statuses:
        return {"status": "PASS", "reason": "Status is allowed"}
    return {"status": "REVIEW", "reason": "Status is not allowed"}


def validate_amount(amount, minimum_amount=0):
    if amount is None:
        return {"status": "FAIL", "reason": "Amount is invalid"}
    if amount < minimum_amount:
        return {"status": "FAIL", "reason": "Amount is below minimum"}
    return {"status": "PASS", "reason": "Amount is valid"}


def validate_record(record, required_fields, allowed_statuses, minimum_amount=0):
    """Return exactly {'status': ..., 'reason': ...} for every normal result."""
    required_result = validate_required_fields(record, required_fields)
    if required_result["status"] == "FAIL":
        return required_result
    amount_result = validate_amount(record.get("amount"), minimum_amount)
    if amount_result["status"] == "FAIL":
        return amount_result
    if record.get("event_date") is None:
        return {"status": "FAIL", "reason": "Event date is invalid"}
    return validate_status(record.get("status"), allowed_statuses)
