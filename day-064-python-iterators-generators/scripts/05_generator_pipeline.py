"""A bounded source passes records through focused lazy stages."""


def normalize_records(records):
    for record in records:
        yield {**record, "status": record["status"].strip().upper()}


def valid_records(records):
    for record in records:
        if record["order_id"].strip():
            yield record


source_records = [
    {"order_id": "A-1", "status": " ready "},
    {"order_id": "", "status": " review "},
    {"order_id": "B-2", "status": " completed "},
]

pipeline = valid_records(normalize_records(source_records))
for record in pipeline:
    print(record)
print("Source is unchanged:", source_records)
