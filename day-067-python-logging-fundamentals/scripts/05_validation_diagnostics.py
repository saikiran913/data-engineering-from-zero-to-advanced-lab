"""Summarise business validation outcomes without per-record logs."""

import logging


logger = logging.getLogger(__name__)


def classify(record: dict[str, object]) -> str:
    amount = record.get("amount")
    if not isinstance(amount, (int, float)) or amount < 0:
        return "FAIL"
    if amount == 0:
        return "REVIEW"
    return "PASS"


def main() -> None:
    logging.basicConfig(level=logging.INFO, format="%(levelname)s %(name)s %(message)s")
    records: list[dict[str, object]] = [
        {"amount": 25}, {"amount": 0}, {"amount": 12},
        {"amount": -4}, {"amount": 8}, {"amount": "invalid"},
        {"amount": 5},
    ]
    counts = {"PASS": 0, "REVIEW": 0, "FAIL": 0}
    for record in records:
        counts[classify(record)] += 1
    logger.info(
        "run_id=%s stage=VALIDATE input_count=%s pass_count=%s review_count=%s fail_count=%s",
        "RUN-001", len(records), counts["PASS"], counts["REVIEW"], counts["FAIL"],
    )
    if counts["REVIEW"]:
        logger.warning("run_id=%s stage=VALIDATE review_count=%s", "RUN-001", counts["REVIEW"])
    assert len(records) == sum(counts.values())


if __name__ == "__main__":
    main()
