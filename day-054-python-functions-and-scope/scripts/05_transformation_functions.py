"""Day 054: reusable transformation functions."""


def normalize_status(status):
    """Return status text with surrounding spaces removed and uppercase letters."""
    return status.strip().upper()


def normalize_source_name(source_name):
    """Return source name with surrounding spaces removed and lowercase letters."""
    return source_name.strip().lower()


def calculate_completeness(valid_count, total_count):
    """Return completeness percentage, or None when total is zero."""
    if total_count == 0:
        return None

    return (valid_count / total_count) * 100


clean_status = normalize_status(" ready ")
clean_source_name = normalize_source_name(" Orders ")
completeness_pct = calculate_completeness(95, 100)

print("Clean status:", clean_status)
print("Clean source name:", clean_source_name)
print("Completeness percentage:", completeness_pct)
