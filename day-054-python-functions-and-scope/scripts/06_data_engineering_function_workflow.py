"""Day 054: small function-based Data Engineering workflow."""


def normalize_source_name(source_name):
    """Return a normalized source label."""
    return source_name.strip().lower()


def normalize_status(status):
    """Return a normalized status value."""
    return status.strip().upper()


def validate_status(status):
    """Return PASS when status is allowed."""
    if status in ("READY", "COMPLETED"):
        return "PASS"

    return "FAIL"


def validate_record_count(record_count):
    """Return a validation outcome for a record count."""
    if record_count is None:
        return "REVIEW"

    if record_count == 0:
        return "FAIL"

    return "PASS"


def calculate_completeness(valid_count, total_count):
    """Return completeness percentage, or None when total is zero."""
    if total_count == 0:
        return None

    return (valid_count / total_count) * 100


def main():
    """Coordinate a small in-memory validation workflow."""
    raw_source_label = " Orders "
    raw_status = " ready "
    record_count = 120
    valid_count = 118
    total_count = 120

    source_label = normalize_source_name(raw_source_label)
    status = normalize_status(raw_status)
    status_result = validate_status(status)
    record_count_result = validate_record_count(record_count)
    completeness_pct = calculate_completeness(valid_count, total_count)

    print("Source:", source_label)
    print("Status:", status)
    print("Status validation:", status_result)
    print("Record count validation:", record_count_result)
    print("Completeness percentage:", completeness_pct)


if __name__ == "__main__":
    main()
