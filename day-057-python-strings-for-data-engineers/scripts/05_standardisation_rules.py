"""Day 057: use an approved status map with clear states."""

status_map = {"complete": "COMPLETED", "completed": "COMPLETED", "done": "COMPLETED"}
allowed_statuses = {"COMPLETED", "PENDING", "FAILED"}
raw_values = [" done ", "PENDING", "   ", None, "unknown"]

for raw_status in raw_values:
    if raw_status is None:
        result = "MISSING"
        canonical_status = None
    else:
        clean_status = raw_status.strip()
        if clean_status == "":
            result = "BLANK"
            canonical_status = None
        else:
            normalized_status = clean_status.lower()
            canonical_status = status_map.get(normalized_status, clean_status.upper())
            result = "ALLOWED" if canonical_status in allowed_statuses else "UNKNOWN"
    print(f"raw={raw_status!r}, canonical={canonical_status!r}, result={result}")
