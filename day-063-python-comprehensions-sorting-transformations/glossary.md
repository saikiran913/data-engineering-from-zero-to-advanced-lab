# Glossary

| Term | Simple meaning | Example |
|---|---|---|
| Ascending | Smallest or earliest first | `sorted([3, 1])` |
| Comprehension | Expression that builds a collection from an iterable | `[x * 2 for x in values]` |
| Data transformation | Changing data into a useful shape or value | Trim status text |
| Deduplication | Removing repeated values under a defined rule | `set(sources)` |
| Descending | Largest or latest first | `reverse=True` |
| Dictionary comprehension | Build key/value pairs | `{r['id']: r['status'] for r in rows}` |
| Filter | Keep items matching a condition | `if amount >= 0` |
| Filtered comprehension | Build a collection from selected items | `[x for x in values if x]` |
| In-place operation | Changes the existing object | `values.sort()` |
| Key function | Chooses a comparison value for sorting | `key=get_amount` |
| Lambda | Small unnamed function | `lambda r: r['amount']` |
| List comprehension | Builds a new list | `[s.upper() for s in statuses]` |
| Map/transform | Apply a change to each item | Uppercase each status |
| Multi-field sort | Sort by primary then tie-breaker field | `(status, order_id)` |
| Mutation | Change an existing object | `.sort()` changes a list |
| Output collection | New list, dictionary, or set produced | `clean_statuses` |
| Projection | Select only needed fields | Keep `order_id` and `status` |
| Raw order | Order received from the source | File delivery sequence |
| Set comprehension | Builds unique values | `{r['source'] for r in rows}` |
| Sort | Arrange items by a rule | Order amounts |
| Sort key | Value returned by a key function | `record['amount']` |
| Sorted | Function that returns a new ordered list | `sorted(values)` |
| Stable sort | Equal keys retain their earlier relative order | Equal amount rows |
| Transformation pipeline | Ordered sequence of data preparation steps | Clean, filter, sort |
