# Beginner Summary

Dictionaries and sets solve two different collection problems. A dictionary maps a meaningful key to a value. A set holds unique values. Both are built into Python and commonly appear in small data-processing tasks, validation logic, and record-oriented programs.

Day 055 used lists and tuples for ordered values. A list is useful when order can change, and a tuple is useful for a small fixed positional record. Day 056 moves from positions to names. In a tuple such as `("ORD-1001", "COMPLETED", 125.50)`, a reader must remember what each position means. In a dictionary such as `{"order_id": "ORD-1001", "status": "COMPLETED", "amount": 125.50}`, the field names explain the record.

Dictionary keys are unique and map to values. Use string keys with consistent snake_case names as a beginner convention. Direct lookup, such as `record["order_id"]`, is appropriate when `order_id` is required. A missing required key raises `KeyError`, which can reveal a record-contract problem early. Use `.get()` when an optional field may be absent: `record.get("review_note")`. A default such as `.get("status", "UNKNOWN")` can be useful, but it should not quietly hide a field that was required.

A missing key and a key with value `None` are different. `{}` has no `review_note` field. `{"review_note": None}` has the field but no value. `.get()` returns `None` in both cases, so use `"review_note" in record` when business logic needs to distinguish them.

Dictionaries are mutable. Assignment can add or update a field. This is helpful for a calculated validation result, but it can also change a record that another part of a program still expects. A shallow `.copy()` creates a new top-level dictionary, although nested dictionaries and lists remain shared. Be deliberate about changes and document side effects.

Use `.keys()`, `.values()`, and especially `.items()` to inspect a dictionary. `.items()` gives key-value pairs, so `for key, value in record.items()` is a clear way to print or validate fields. Dictionaries preserve insertion order in modern Python, but your business logic should use the key name rather than depending on field order.

Sets keep unique values. They suit allowed statuses, seen identifiers, and expected-column checks. Create a non-empty set with braces and an empty set with `set()`; `{}` is an empty dictionary. A set has no positional indexing, and its order is not a stable business contract. Converting a list to a set removes duplicates, but it also loses duplicate frequency and ordering. Do that only when those properties genuinely do not matter.

Set operations are useful for data quality. `expected - observed` gives expected fields that are missing. `expected & observed` gives shared fields. `expected | observed` gives all fields across both sets. Use these simple comparisons to validate required record keys or a conceptual schema.

Nested records describe related structures: an order may contain a `customer` dictionary and a list of `flags`. A list of dictionaries can represent several order records. Keep nesting shallow, show the expected shape, and inspect one level at a time. Optional nested fields need safe lookup patterns just as top-level fields do.

Collection choice follows meaning. Need names and lookup? Use a dictionary. Need uniqueness and membership? Use a set. Need ordering or duplicate frequency? Keep a list or tuple. Before Day 057, remember that a small, explicit record contract makes later file processing safer: define required keys, validate them, distinguish missing from blank values, and never discard data properties without understanding what they mean.
