# Day 056 Notes

## Two Mental Models

```text
record
→ lookup key
→ validate value
→ classify
```

```text
many identifiers
→ set
→ deduplicate
→ membership check
```

A dictionary maps a meaningful **key** to a **value**. `order["status"]` is clearer than remembering that a status is at position `1` in a tuple. Keys are unique; repeating a key in a literal overwrites the earlier value.

A set holds unique values. It is useful for allowed statuses, seen identifiers, and comparing expected columns to observed columns. It is not a sequence: it has no useful positional order and cannot be indexed.

`record["order_id"]` is direct access for a required field. `record.get("review_note")` intentionally allows an optional field to be absent. A missing key differs from `{"review_note": None}`: the first means no field was supplied, while the second means the field was supplied without a value.

Nested data can describe a customer inside an order, a list of flags, or a list of order records. Keep shapes shallow and document required versus optional fields. Before combining or processing records, validate the required keys and use consistent names such as `order_id`.

In ETL and ELT work, dictionaries model small records and configuration values; sets support schema checks and duplicate awareness. Choose the collection based on business meaning, not merely because a conversion is easy.
