# Memory-Aware Record Processing

An eager workflow builds an intermediate list:

```python
clean_records = []
for record in records:
    clean_records.append(normalize_record(record))
```

A lazy workflow yields one clean record when requested:

```python
def generate_clean_records(records):
    for record in records:
        yield normalize_record(record)
```

Imagine a source with 1,000,000 records. If the source and consumer both work incrementally, a generator stage need not hold 1,000,000 transformed records at once. If `records` is already a list of 1,000,000 dictionaries, that original list still occupies memory. Calling `list(generate_clean_records(records))` then creates another materialised collection.

One-record-at-a-time processing still needs correct parsing, validation, and error reporting. Memory awareness is a workflow decision, not a reason to skip data quality checks. All runnable examples in this lesson use only a handful of records.
