"""Day 062: validation helpers share one dictionary result contract."""


def validate_required_fields(record, required_fields):
    missing = [field for field in required_fields if not str(record.get(field, "")).strip()]
    return {"status": "FAIL", "reason": f"Missing: {', '.join(missing)}"} if missing else {"status": "PASS", "reason": "Required fields are present"}


def validate_status(status, allowed_statuses):
    return {"status": "PASS", "reason": "Status is allowed"} if status in allowed_statuses else {"status": "REVIEW", "reason": "Status is not allowed"}


def validate_amount(amount, minimum_amount=0):
    if amount is None:
        return {"status": "FAIL", "reason": "Amount is invalid"}
    return {"status": "PASS", "reason": "Amount is valid"} if amount >= minimum_amount else {"status": "FAIL", "reason": "Amount is below minimum"}


def validate_record(record, required_fields, allowed_statuses, minimum_amount=0):
    for result in (validate_required_fields(record, required_fields), validate_amount(record.get("amount"), minimum_amount)):
        if result["status"] == "FAIL":
            return result
    return validate_status(record.get("status"), allowed_statuses)


record = {"order_id": "ORD-1", "status": "READY", "amount": 12.0}
print(validate_record(record, ["order_id", "status"], {"READY", "COMPLETED"}))
