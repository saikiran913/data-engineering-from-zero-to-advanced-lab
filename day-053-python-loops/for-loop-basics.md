# For Loop Basics

## Basic Syntax

```python
files = ["orders.csv", "customers.csv"]

for file_name in files:
    print(file_name)
```

## Loop Variable

`file_name` is the loop variable. It refers to one current item from `files`.

## Indentation

The indented body runs once per item.

```python
for file_name in files:
    print(file_name)
```

## One Iteration Per Item

If `files` has two items, the loop body runs two times.

## Iterating Strings Conceptually

A string can be visited character by character.

```python
for character in "ABC":
    print(character)
```

## Tuple Iteration

Tuples can also be iterated.

```python
statuses = ("PASS", "REVIEW", "FAIL")

for status in statuses:
    print(status)
```

## Descriptive Loop Variables

Bad:

```python
for x in files:
    print(x)
```

Better:

```python
for file_name in files:
    print(file_name)
```

## Loop Variable After Loop

Python keeps the last loop-variable binding after the loop. Beginners should not rely on this behaviour for important logic.

## Practice Examples

```python
for file_name in ["orders.csv", "customers.csv"]:
    print(file_name)

for status in ("PASS", "REVIEW"):
    print(status)

for source_label in ["uk_orders", "india_orders", "usa_orders"]:
    print(source_label)

for column_name in ["order_id", "order_amount"]:
    print(column_name)

for validation_result in ["PASS", "FAIL"]:
    print(validation_result)

for character in "CSV":
    print(character)

for partition_label in ["2026-01", "2026-02"]:
    print(partition_label)

for table_name in ["orders", "customers"]:
    print(table_name)

for step_name in ["extract", "validate", "load"]:
    print(step_name)

for country_code in ["UK", "IN", "US"]:
    print(country_code)

for batch_label in ["batch_1", "batch_2"]:
    print(batch_label)

for check_name in ["row_count", "schema_check"]:
    print(check_name)

for issue_status in ["OPEN", "CLOSED"]:
    print(issue_status)

for record_label in ["record_1", "record_2"]:
    print(record_label)
```
