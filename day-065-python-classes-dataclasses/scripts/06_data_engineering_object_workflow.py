"""Compose small record, configuration, and component objects in memory."""

from dataclasses import dataclass


@dataclass(frozen=True)
class ValidationConfig:
    allowed_statuses: tuple[str, ...]
    minimum_amount: float = 0.0


@dataclass
class OrderRecord:
    order_id: str
    status: str
    amount: float


class StatusNormalizer:
    def normalize(self, raw_status):
        return raw_status.strip().upper()


class RecordValidator:
    def __init__(self, config):
        self.config = config

    def classify(self, record):
        if not record.order_id.strip() or record.amount < self.config.minimum_amount:
            return "FAIL"
        if record.status not in self.config.allowed_statuses:
            return "REVIEW"
        return "PASS"


class RecordProcessor:
    def __init__(self, normalizer, validator):
        self.normalizer = normalizer
        self.validator = validator

    def process(self, raw):
        record = OrderRecord(
            order_id=raw["order_id"].strip(),
            status=self.normalizer.normalize(raw["status"]),
            amount=raw["amount"],
        )
        return record, self.validator.classify(record)


def main():
    raw_orders = [
        {"order_id": " ORD-1 ", "status": " ready ", "amount": 20.0},
        {"order_id": "ORD-2", "status": " unknown ", "amount": 5.0},
        {"order_id": "", "status": " completed ", "amount": 12.0},
        {"order_id": "ORD-4", "status": "ready", "amount": -3.0},
    ]
    raw_snapshot = [record.copy() for record in raw_orders]
    config = ValidationConfig(("READY", "COMPLETED"))
    processor = RecordProcessor(StatusNormalizer(), RecordValidator(config))
    counts = {"PASS": 0, "REVIEW": 0, "FAIL": 0}
    for raw in raw_orders:
        record, result = processor.process(raw)
        counts[result] += 1
        print(record.order_id or "(missing ID)", record.status, result)
    print("Summary:", counts)
    assert raw_orders == raw_snapshot
    print("Raw first record remains:", raw_orders[0])


if __name__ == "__main__":
    main()
