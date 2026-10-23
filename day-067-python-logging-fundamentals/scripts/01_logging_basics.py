"""Compare a deliberate printed result with console diagnostic logs."""

import logging


logger = logging.getLogger(__name__)


def main() -> None:
    logging.basicConfig(level=logging.INFO, format="%(levelname)s %(name)s %(message)s")
    run_id = "RUN-001"
    logger.info("run_id=%s stage=START source=orders_batch", run_id)
    accepted_count = 3
    logger.info("run_id=%s stage=COMPLETE accepted_count=%s", run_id, accepted_count)
    print(f"Accepted records: {accepted_count}")


if __name__ == "__main__":
    main()
