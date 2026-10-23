# Dictionary and Set Comprehensions

Dictionary comprehensions produce key/value pairs. Set comprehensions produce unique values.

```python
status_lengths = {
    status: len(status)
    for status in statuses
}

unique_clean_statuses = {
    status.strip().upper()
    for status in statuses
}
```

If two items produce the same dictionary key, the later value overwrites the earlier one. For example, `{'a': 1, 'a': 2}` ends with one key mapped to `2`. Check for collisions before building an ID lookup. A set removes duplicate values, but its iteration order is not a reliable business order; use `sorted(set_values)` when ordered output is needed.

```python
records = [{'id': 'A', 'status': 'READY'}, {'id': 'B', 'status': 'REVIEW'}]
status_by_id = {record['id']: record['status'] for record in records}
source_names = ['east', 'east', 'west']
unique_sources = {name.upper() for name in source_names}
```

Both produce new collections. Avoid deep nesting and multiple hidden conditions. A loop is clearer when duplicate keys require investigation or a review status.
