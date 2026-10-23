"""Show the five logging levels and the effect of a threshold."""

import logging


logger = logging.getLogger(__name__)


def emit_levels() -> None:
    logger.debug("run_id=RUN-001 stage=NORMALISE input_count=3")
    logger.info("run_id=RUN-001 stage=START")
    logger.warning("run_id=RUN-001 stage=VALIDATE review_count=1")
    logger.error("run_id=RUN-001 stage=DEMO synthetic_operation_failed")
    logger.critical("run_id=RUN-001 stage=DEMO synthetic_pipeline_unavailable")


def main() -> None:
    logging.basicConfig(level=logging.INFO, format="%(levelname)s %(name)s %(message)s", force=True)
    logger.info("demonstration=INFO_threshold DEBUG_hidden")
    emit_levels()
    logging.getLogger().setLevel(logging.DEBUG)
    logger.info("demonstration=DEBUG_threshold DEBUG_visible")
    emit_levels()
    # ERROR and CRITICAL above are severity demonstrations, not real failures.


if __name__ == "__main__":
    main()
