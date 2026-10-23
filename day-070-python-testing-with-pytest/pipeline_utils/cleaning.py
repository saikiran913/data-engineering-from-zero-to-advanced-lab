"""String cleaning functions with explicit None and type contracts."""


def normalize_status(value: str | None) -> str | None:
    """Strip and uppercase a status; preserve None and reject other types."""
    if value is None:
        return None
    if not isinstance(value, str):
        raise TypeError("status must be a string or None")
    return value.strip().upper()


def normalize_country_code(value: str | None) -> str | None:
    """Strip and uppercase a code without changing its business meaning."""
    if value is None:
        return None
    if not isinstance(value, str):
        raise TypeError("country code must be a string or None")
    return value.strip().upper()
