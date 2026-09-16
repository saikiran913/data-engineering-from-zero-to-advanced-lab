"""Day 054: reusable validation functions."""


def validate_record_count(record_count):
    """Classify a record count as PASS, REVIEW, or FAIL."""
    if record_count is None:
        return "REVIEW"

    if record_count == 0:
        return "FAIL"

    return "PASS"


def validate_status(status):
    """Return PASS when status is allowed."""
    allowed_statuses = ("READY", "COMPLETED")

    if status in allowed_statuses:
        return "PASS"

    return "FAIL"


def classify_error_count(error_count, review_limit=5):
    """Classify an error count."""
    if error_count == 0:
        return "PASS"

    if error_count <= review_limit:
        return "REVIEW"

    return "FAIL"


record_count_result = validate_record_count(120)
status_result = validate_status("READY")
error_count_result = classify_error_count(3)

print("record_count input: 120")
print("function result:", record_count_result)
print("reason: positive row count")

print("status input: READY")
print("function result:", status_result)
print("reason: status is allowed")

print("error_count input: 3")
print("function result:", error_count_result)
print("reason: small error count needs review")
