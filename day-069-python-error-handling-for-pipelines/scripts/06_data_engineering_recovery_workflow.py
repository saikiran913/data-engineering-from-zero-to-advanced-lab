"""Integrate fail-fast config, bounded transient retry, and record outcomes."""

import logging
import math


logger = logging.getLogger(__name__)


class TransientOperationError(Exception):
    """A synthetic retryable stage failure."""


def validate_config(source_name: object, max_attempts: object) -> tuple[str, int]:
    if not isinstance(source_name, str) or not source_name.strip():
        raise ValueError("source_name is required")
    if type(max_attempts) is not int or max_attempts < 1:
        raise ValueError("max_attempts must be a positive integer")
    return source_name.strip(), max_attempts


def make_source(failures_before_success: int):
    calls = 0

    def fetch() -> list[dict[str, object]]:
        nonlocal calls
        calls += 1
        if calls <= failures_before_success:
            raise TransientOperationError("synthetic source temporarily unavailable")
        return [
            {"record_id": "REC-001", "amount": 10},
            {"record_id": "REC-002"},
            {"record_id": "REC-003", "amount": "invalid"},
            {"record_id": "REC-004", "amount": 7},
        ]

    return fetch


def retry_source(fetch, max_attempts: int) -> tuple[list[dict[str, object]], int]:
    for attempt in range(1, max_attempts + 1):
        try:
            return fetch(), attempt
        except TransientOperationError:
            if attempt == max_attempts:
                raise
            logger.warning("run_id=RUN-001 stage=SOURCE transient_failure attempt=%s", attempt)
    raise AssertionError("bounded retry ended without an outcome")


def classify(record: dict[str, object]) -> dict[str, str]:
    record_id = str(record["record_id"])
    if "amount" not in record:
        return {"record_id": record_id, "status": "FAIL", "reason": "amount is required"}
    if isinstance(record["amount"], bool):
        return {"record_id": record_id, "status": "REVIEW", "reason": "amount is not numeric"}
    try:
        amount = float(record["amount"])
    except (TypeError, ValueError):
        return {"record_id": record_id, "status": "REVIEW", "reason": "amount is not numeric"}
    if not math.isfinite(amount) or amount < 0:
        return {"record_id": record_id, "status": "FAIL", "reason": "amount is not finite and non-negative"}
    return {"record_id": record_id, "status": "PASS", "reason": "valid"}


def run_pipeline(source_name: object, max_attempts: object, failures_before_success: int) -> dict[str, object]:
    source, attempts_limit = validate_config(source_name, max_attempts)
    records, attempts = retry_source(make_source(failures_before_success), attempts_limit)
    results = [classify(record) for record in records]
    counts = {status: sum(result["status"] == status for result in results) for status in ("PASS", "REVIEW", "FAIL")}
    assert sum(counts.values()) == len(records)
    return {
        "source": source, "processed": len(records), "counts": counts,
        "attempts": attempts, "retries": attempts - 1,
        "run_status": "PARTIAL" if counts["REVIEW"] or counts["FAIL"] else "SUCCESS",
    }


def main() -> None:
    logging.basicConfig(level=logging.INFO, format="%(levelname)s %(name)s %(message)s")
    try:
        result = run_pipeline("demo_orders", max_attempts=3, failures_before_success=1)
    except (ValueError, TransientOperationError):
        logger.exception("run_id=RUN-001 stage=PIPELINE run_status=FAILED")
        return
    counts = result["counts"]
    logger.info(
        "run_id=RUN-001 source=%s stage=COMPLETE run_status=%s processed=%s pass=%s review=%s fail=%s retries=%s",
        result["source"], result["run_status"], result["processed"],
        counts["PASS"], counts["REVIEW"], counts["FAIL"], result["retries"],
    )
    print("The source stage recovered on attempt 2; malformed business rows were classified, not retried.")


if __name__ == "__main__":
    main()
