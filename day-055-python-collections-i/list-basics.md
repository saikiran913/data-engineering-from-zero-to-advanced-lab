# List Basics

## List Literal

```python
sources = ["orders", "customers", "products"]
```

## Empty List

```python
sources = []
```

An empty list has no items.

## Mixed Types Concept

```python
example = ["orders", 100, True]
```

Python allows mixed types, but Data Engineering collections should usually have clear semantic consistency.

## `len()`

```python
len(sources)
```

## Membership

```python
"orders" in sources
```

## List Order

Lists preserve order. The first item stays first unless the list is changed.

## Duplicate Values Allowed

```python
sources = ["orders", "orders"]
```

Duplicates are allowed.

## Lists Are Mutable

List contents can be changed after creation.

## Practice

```python
source_files = ["orders.csv", "customers.csv"]
table_names = ["orders", "customers", "products"]
validation_results = ["PASS", "REVIEW", "FAIL"]
pipeline_steps = ["extract", "validate", "load"]
batch_labels = ["batch_1", "batch_2"]
empty_sources = []
duplicate_sources = ["orders", "orders"]
country_codes = ["UK", "IN", "US"]
status_values = ["READY", "COMPLETED"]
row_counts = [100, 0, 50]
amounts = [10.5, 20.0, 30.25]
mixed_example = ["orders", 100, True]
first_source = source_files[0]
contains_orders = "orders" in table_names
```
