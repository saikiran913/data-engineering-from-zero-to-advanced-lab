# Set Deduplication and Membership

Converting a list to a set removes repeated values.

```python
source_ids = ["SRC-1", "SRC-2", "SRC-1"]
unique_ids = set(source_ids)
```

This is useful only when duplicate frequency and original order do not matter. Use sets for allowed values and schema comparisons.

```python
expected = {"order_id", "status", "amount"}
observed = {"order_id", "status"}
missing = expected - observed
all_fields = expected | observed
shared = expected & observed
```

`|` is union, `&` is intersection, and `-` is difference. Read difference left to right: `expected - observed` means expected fields that were not observed.
