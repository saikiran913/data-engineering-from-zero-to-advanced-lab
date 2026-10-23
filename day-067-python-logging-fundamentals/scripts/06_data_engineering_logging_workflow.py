"""Run a small in-memory order pipeline with stage-level console logs."""

import logging


logger = logging.getLogger(__name__)


def normalise(orders: list[dict[str, object]]) -> list[dict[str, object]]:
    return [
        {"amount": order.get("amount"), "status": str(order.get("status", "")).upper()}
        for order in orders
    ]


def classify(order: dict[str, object]) -> str:
    amount = order["amount"]
    status = order["status"]
    if status not in {"PAID", "PENDING"}:
        return "FAIL"
    if not isinstance(amount, (int, float)) or amount < 0:
        return "FAIL"
    if amount == 0 or status == "PENDING":
        return "REVIEW"
    return "PASS"


def summarise(orders: list[dict[str, object]]) -> dict[str, int]:
    counts = {"PASS": 0, "REVIEW": 0, "FAIL": 0}
    for order in orders:
        counts[classify(order)] += 1
    return counts


def main() -> None:
    logging.basicConfig(level=logging.INFO, format="%(levelname)s %(name)s %(message)s")
    run_id = "RUN-001"
    source = "orders_batch"
    orders: list[dict[str, object]] = [
        {"amount": 12, "status": "paid"}, {"amount": 0, "status": "paid"},
        {"amount": 8, "status": "paid"}, {"amount": "invalid", "status": "paid"},
        {"amount": 5, "status": "paid"}, {"amount": 21, "status": "paid"},
    ]
    logger.info("run_id=%s source=%s stage=START", run_id, source)
    logger.info("run_id=%s source=%s stage=READ record_count=%s", run_id, source, len(orders))
    normalised = normalise(orders)
    logger.info("run_id=%s source=%s stage=NORMALISE record_count=%s", run_id, source, len(normalised))
    counts = summarise(normalised)
    logger.info(
        "run_id=%s source=%s stage=VALIDATE pass_count=%s review_count=%s fail_count=%s",
        run_id, source, counts["PASS"], counts["REVIEW"], counts["FAIL"],
    )
    if counts["REVIEW"]:
        logger.warning("run_id=%s source=%s stage=VALIDATE review_count=%s", run_id, source, counts["REVIEW"])
    total = sum(counts.values())
    assert total == len(orders)
    logger.info("run_id=%s source=%s stage=SUMMARISE record_count=%s", run_id, source, total)
    logger.info("run_id=%s source=%s stage=COMPLETE accepted_count=%s", run_id, source, counts["PASS"])


if __name__ == "__main__":
    main()
