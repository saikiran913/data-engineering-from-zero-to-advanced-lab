# Tuple Basics

## Tuple Literal

```python
order_record = ("ORD-1001", "CUST-001", "COMPLETED")
```

## Empty Tuple

```python
empty = ()
```

## Single-Item Tuple

```python
single = ("orders",)
```

The trailing comma makes it a tuple.

## Tuple Order

Tuple order matters because positions carry meaning.

## Duplicate Values Allowed

```python
statuses = ("PASS", "PASS")
```

## Immutable

Tuple positions cannot be reassigned after creation.

## Typical Record Use

Tuples are useful for fixed-position records.

```text
position 0 → order_id
position 1 → customer_id
position 2 → status
```

## Why Meaning Should Be Documented

Without documentation, `record[2]` is difficult to understand.

## Practice

```python
order_record = ("ORD-1001", "CUST-001", "COMPLETED")
status_pair = ("orders.csv", "PASS")
empty_tuple = ()
single_item = ("orders",)
amount_record = ("ORD-1002", 80.00)
country_record = ("UK", "READY")
schema_field = ("order_id", 0)
pipeline_step = ("extract", 1)
validation_pair = ("row_count", "PASS")
duplicate_tuple = ("PASS", "PASS")
first_value = order_record[0]
second_value = order_record[1]
```
