"""Use small, stable context fields instead of raw records."""

import logging


logger = logging.getLogger(__name__)


def log_stage(run_id: str, source: str, stage: str, count: int) -> None:
    logger.info(
        "run_id=%s source=%s stage=%s record_count=%s",
        run_id, source, stage, count,
    )


def main() -> None:
    logging.basicConfig(level=logging.INFO, format="%(levelname)s %(name)s %(message)s")
    run_id = "RUN-001"
    source = "orders_batch"
    log_stage(run_id, source, "START", 4)
    log_stage(run_id, source, "VALIDATE", 4)
    logger.info(
        "run_id=%s source=%s stage=VALIDATE validation_status=%s record_count=%s",
        run_id, source, "REVIEW", 1,
    )
    log_stage(run_id, source, "COMPLETE", 4)


if __name__ == "__main__":
    main()
