"""Copy and summarize small, already normalized record collections."""

from .cleaning import normalize_status


def build_clean_record(record: dict) -> dict:
    """Return a new record with a normalized status when that key exists."""
    clean = record.copy()
    if "status" in clean:
        clean["status"] = normalize_status(clean["status"])
    return clean


def count_statuses(records: list[dict]) -> dict[str, int]:
    """Count string statuses in already normalized records; do not mutate."""
    counts: dict[str, int] = {}
    for record in records:
        status = record.get("status")
        if not isinstance(status, str):
            raise ValueError("each record must have a string status")
        counts[status] = counts.get(status, 0) + 1
    return counts
