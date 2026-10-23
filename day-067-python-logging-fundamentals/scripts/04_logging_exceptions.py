"""Distinguish a handled data condition from an unexpected stage exception."""

import logging


logger = logging.getLogger(__name__)


def demonstrate_expected_invalid_amount() -> None:
    invalid_count = 0
    try:
        float("invalid")
    except ValueError:
        invalid_count += 1
    logger.warning(
        "run_id=%s stage=VALIDATE invalid_amount_count=%s validation_status=FAIL",
        "RUN-001", invalid_count,
    )


def demonstrate_stage_failure() -> None:
    try:
        raise RuntimeError("synthetic stage failure")
    except RuntimeError:
        logger.exception("run_id=%s stage=SUMMARISE failed", "RUN-001")


def main() -> None:
    logging.basicConfig(level=logging.INFO, format="%(levelname)s %(name)s %(message)s")
    demonstrate_expected_invalid_amount()
    demonstrate_stage_failure()
    logger.info("run_id=%s stage=DEMO complete; failure was intentionally handled", "RUN-001")


if __name__ == "__main__":
    main()
