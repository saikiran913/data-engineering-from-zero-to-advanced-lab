# Generator Pipeline Patterns

Each generator stage receives an iterable and yields records. A downstream consumer drives the work.

```python
def normalize_records(records):
    for record in records:
        yield {
            **record,
            "status": record["status"].strip().upper(),
        }

def valid_records(records):
    for record in records:
        if record["order_id"]:
            yield record

raw_records = [
    {"order_id": "A-1", "status": " ready "},
    {"order_id": "", "status": " review "},
]
for record in valid_records(normalize_records(raw_records)):
    print(record)
```

```text
source → normalize_records → valid_records → consumer
```

The consumer asks for a record. The filter asks the normalizer; the normalizer asks the source. One record travels through the stages before the next is requested. Keep stages small. If a rejected record needs a reason, add a focused classification stage rather than silently dropping it.
