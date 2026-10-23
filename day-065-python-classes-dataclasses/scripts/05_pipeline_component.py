"""A configured component reuses its methods for two records."""


class StatusNormalizer:
    def __init__(self, allowed_statuses):
        self.allowed_statuses = tuple(allowed_statuses)

    def normalize(self, raw_status):
        return raw_status.strip().upper()

    def is_allowed(self, status):
        return status in self.allowed_statuses


def main():
    normalizer = StatusNormalizer(("READY", "COMPLETED"))
    records = [
        {"order_id": "ORD-1", "status": " ready "},
        {"order_id": "ORD-2", "status": " unknown "},
    ]
    for record in records:
        clean_status = normalizer.normalize(record["status"])
        print(record["order_id"], clean_status, normalizer.is_allowed(clean_status))


if __name__ == "__main__":
    main()
