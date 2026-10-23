"""Day 062: pure transformations return new values without printing or mutation."""


def normalize_status(raw_status):
    return raw_status.strip().upper() if isinstance(raw_status, str) else None


def normalize_country_code(raw_country):
    mapping = {"uk": "GB", "united kingdom": "GB", "usa": "US", "united states": "US", "india": "IN"}
    return mapping.get(raw_country.strip().lower()) if isinstance(raw_country, str) else None


def parse_amount(raw_amount):
    try:
        return float(raw_amount)
    except (TypeError, ValueError):
        return None


def build_clean_record(record):
    return {**record, "status": normalize_status(record.get("status")), "country": normalize_country_code(record.get("country")), "amount": parse_amount(record.get("amount"))}


raw_record = {"order_id": "ORD-1", "status": " ready ", "country": "UK", "amount": "14.50"}
clean_record = build_clean_record(raw_record)
print(raw_record)
print(clean_record)
