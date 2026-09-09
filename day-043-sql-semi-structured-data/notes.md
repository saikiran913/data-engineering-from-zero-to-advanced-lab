# Day 043 Notes - SQL for Semi-Structured Data

## What Is Semi-Structured Data?

Semi-structured data has structure, but that structure may not be fixed into normal relational columns. It is often stored as JSON-like text inside a column such as `payload_text`.

## JSON Object

```json
{
  "event_id": "EVT-101",
  "customer": {
    "id": "C001",
    "country": "IN"
  },
  "amount": 499.0
}
```

`customer` is a key. Its value is a nested object. `amount` is a scalar numeric value.

## Nested Path

A nested path describes where a value lives:

```text
customer.id
customer.country
```

SQL platforms use different syntax to extract those values.

## Arrays

```json
{
  "tags": ["sql", "data-engineering", "beginner"]
}
```

An array contains zero, one, or many elements. Order may matter depending on the business meaning.

## Array of Objects

```json
{
  "items": [
    {"product_code": "P01", "quantity": 2},
    {"product_code": "P02", "quantity": 1}
  ]
}
```

Expanding this array changes the grain from one row per event to one row per event item.

## Schema-on-Read

Schema-on-read means the structure is interpreted when queried. A table can keep the same `payload_text` column while nested paths inside the payload change.

## Missing Key, Null, and Blank

`{}` means the key is missing.

`{"customer_id": null}` means the key exists with an explicit null.

`{"customer_id": ""}` means the key exists with a blank string.

These are different data-quality conditions.

## Malformed JSON

Malformed JSON has invalid syntax. Parsing may fail before business validation starts. Handling varies by SQL platform, so malformed payloads should be separated for review.

## Extracting Nested Values

The beginner flow is:

1. identify the path
2. extract raw or scalar value
3. cast if needed
4. validate
5. retain parent key

## String Versus Typed Extraction

Values may arrive inconsistently. A number may be `125.50` in one event and `"125.50"` in another. A boolean may be `true` or `"true"`. A date may be text. Validate before trusting the type.

## Casting

Casting converts a value to another type. A failed cast indicates inconsistent data. Safe-cast functions vary by platform.

## Nested Completeness

Some paths are required for all rows of an event type. Others are optional. Some are event-type-specific.

## Nested Schema Drift

V1:

```json
{"customer": {"id": "C001"}}
```

V2:

```json
{"customer": {"customer_id": "C001"}}
```

The relational column did not change, but the nested path changed.

## Arrays and Grain

Before expansion:

```text
one row per event
```

After expanding `items`:

```text
one row per event-item
```

Always preserve `event_id` and array index if the index has meaning.

## Safe Semi-Structured Workflow

1. Define parent grain.
2. Inspect payload shape.
3. Define expected paths.
4. Extract required scalars.
5. Distinguish missing, null, and blank.
6. Cast typed fields.
7. Validate values.
8. Expand arrays only if needed.
9. Preserve parent key.
10. Document new grain.
11. Reconcile array counts.
12. Validate nested schema.
13. Create exceptions.
14. Hand off clean output.

