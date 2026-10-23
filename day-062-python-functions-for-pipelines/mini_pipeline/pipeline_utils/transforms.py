"""Normalization helpers that return new values and records."""


def normalize_status(raw_status):
    return raw_status.strip().upper() if isinstance(raw_status, str) else None


def normalize_country_code(raw_country):
    mapping = {"uk": "GB", "united kingdom": "GB", "usa": "US", "united states": "US", "india": "IN"}
    return mapping.get(raw_country.strip().lower()) if isinstance(raw_country, str) else None


def normalize_record(record):
    """Return a copy; never mutate the raw record."""
    return {**record, "status": normalize_status(record.get("status")), "country": normalize_country_code(record.get("country"))}
