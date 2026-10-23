"""Consume a bounded lazy pipeline and count results without a final list."""


def generate_source_records():
    records = (
        ("A-1", " ready ", 20, True),
        ("B-2", " unfamiliar ", 5, True),
        ("", " completed ", 12, True),
        ("C-3", " ready ", -2, True),
        ("D-4", " completed ", 8, False),
    )
    for order_id, status, amount, active in records:
        yield {"order_id": order_id, "status": status, "amount": amount, "active": active}


def normalize_records(records):
    for record in records:
        yield {**record, "status": record["status"].strip().upper()}


def active_records(records):
    for record in records:
        if record["active"]:
            yield record


def classify_records(records):
    for record in records:
        if not record["order_id"] or record["amount"] < 0:
            result = "FAIL"
        elif record["status"] not in {"READY", "COMPLETED"}:
            result = "REVIEW"
        else:
            result = "PASS"
        yield {"order_id": record["order_id"], "result": result}


counts = {"PASS": 0, "REVIEW": 0, "FAIL": 0}
pipeline = classify_records(active_records(normalize_records(generate_source_records())))
for result in pipeline:
    counts[result["result"]] += 1
    print(result)
print("Processed active records:", sum(counts.values()))
print("Result counts:", counts)
