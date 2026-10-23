# Practice Questions

Try each section before reading the answer key. Use synthetic in-memory values and preserve the raw inputs unless the task explicitly calls for mutation.

## Section 1: Concepts (32)

1. What does a list comprehension produce?
2. What does a dictionary comprehension produce?
3. What does a set comprehension produce?
4. Where does a filter condition appear in a simple comprehension?
5. What is the expression in `[x * 2 for x in values]`?
6. What is the loop variable in that expression?
7. What is the iterable in that expression?
8. Does a comprehension change its source list by itself?
9. When is a loop clearer than a comprehension?
10. Why can `if value` wrongly discard numeric zero?
11. What is projection?
12. What is normalization?
13. What is deduplication?
14. Why might set deduplication be unsafe for raw events?
15. What can happen when two dictionary-comprehension items share a key?
16. Does a set promise a stable reporting order?
17. What does `sorted()` return?
18. What does `.sort()` return?
19. Which form preserves the original list order?
20. What does `reverse=True` do?
21. What does a sort key function return?
22. What does a tuple sort key control?
23. What is a stable sort?
24. Why can numeric strings sort incorrectly?
25. Why can `None` break numeric sorting?
26. Why should a missing-value rule be documented?
27. Why normalize before deduplicating labels?
28. Why validate before projecting away fields?
29. Why compare source and output row counts?
30. How can a named helper improve a sort key?
31. Why keep REVIEW rows visible?
32. What is the final verification in a transformation pipeline?

## Section 2: Rewrite Loops as Comprehensions (16)

Write one comprehension for each simple loop outcome. Assume named collections already exist.

1. Trim every string in `labels`.
2. Uppercase every string in `statuses`.
3. Double every value in `counts`.
4. Add one to each value in `days`.
5. Extract `order_id` from each `record` in `records`.
6. Extract `country` from each record.
7. Build `"src:"` plus each source in `sources`.
8. Find each string length in `codes`.
9. Copy each record with `{**record}`.
10. Convert each numeric string in `amount_texts` to `float`.
11. Round each value in `amounts` to two decimals.
12. Get the first character of each nonempty `code` in `codes`.
13. Build a list of `record['status'].upper()`.
14. Project `id` and `status` from each record into a new dictionary.
15. Call `normalize_status` once for each status.
16. Build `(record['id'], record['amount'])` tuples.

## Section 3: Filtered Comprehensions (16)

Write a comprehension for each outcome.

1. Keep amounts at least zero.
2. Keep amounts greater than 100.
3. Keep non-`None` statuses.
4. Keep nonblank status strings, including whitespace checks.
5. Uppercase non-`None` statuses.
6. Trim and uppercase nonblank statuses.
7. Keep records with nonblank `order_id`.
8. Keep records whose status is `PASS`.
9. Project IDs from PASS records.
10. Keep dates beginning with `2026-01`.
11. Keep names that begin with `A`.
12. Keep even integer counts.
13. Double only positive counts.
14. Keep rows with a numeric amount at least `minimum`.
15. Keep source names except the empty string.
16. Keep records with a present, nonnegative amount.

## Section 4: Dictionary and Set Comprehensions (12)

1. Build `order_id` to status from `records`.
2. Build `country` to its string length from `countries`.
3. Build unique statuses from `records`.
4. Build unique uppercase source labels from `sources`.
5. Build ID to numeric amount from `records`.
6. Build a mapping of each code to `code.upper()`.
7. Keep only positive amount entries in an ID-to-amount mapping.
8. Build unique nonblank countries.
9. Build a mapping of status to `len(status)`.
10. Build a set of the first character of each nonempty source.
11. State what happens when two records share `order_id` in task 1.
12. State how to display the set from task 3 in predictable order.

## Section 5: Sorting Questions (18)

1. Sort `[4, 1, 3]` ascending without mutation.
2. Sort the same list descending without mutation.
3. Sort a working list in place.
4. What value is assigned by `result = values.sort()`?
5. What happens to `values` after `sorted(values)` without assignment?
6. Sort `['UK', 'India', 'USA']` by normal string order.
7. Why does `sorted(['10', '2'])` differ from numeric order?
8. Show a numeric sort for `['10', '2']` using `key=`.
9. Sort `amounts` largest first.
10. Preserve the original list while producing an ordered one.
11. Name the argument that reverses sorting.
12. Name the argument that extracts record comparison values.
13. Does sorting create new dictionary objects inside a list?
14. What happens when a sort key returns `None` and numbers?
15. What is stable sorting?
16. Why should date text be ISO formatted before lexical sorting?
17. What should be checked after sorting a report?
18. When is `.sort()` a reasonable choice?

## Section 6: Sorting Records (14)

Write a `sorted(...)` expression or a short named helper as requested.

1. Sort records by numeric `amount` ascending.
2. Sort records by `amount` descending.
3. Sort records by `order_id`.
4. Sort records by `status`, then `order_id`.
5. Sort records by `country`, then `amount`.
6. Use a named `get_amount(record)` key.
7. Put missing `amount=None` after numeric amounts.
8. Explain what happens if `amount` is `'10'` in one row and `2` in another.
9. Sort ISO `order_date` strings ascending.
10. Sort ISO `order_date` strings descending.
11. Sort by source and then event ID.
12. Explain the tie order for records with identical keys.
13. Decide whether a missing `order_id` should be sorted or rejected first.
14. State how to check raw input order was preserved.

## Section 7: Readable or Clever? (14)

Choose comprehension, normal loop, named helper, or built-in; explain briefly.

1. Uppercase ten status strings.
2. Validate five fields and record a reason for each row.
3. Calculate `sum(amounts)`.
4. Extract IDs from valid records.
5. Sort by a missing-last amount rule.
6. Print each record.
7. Make a set of source names.
8. Convert a status with a reviewed lookup mapping.
9. Handle several exception types and report reasons.
10. Normalize each record using an existing `normalize_record` function.
11. Build an ID lookup while detecting collisions.
12. Sort records by two simple fields.
13. Count PASS and REVIEW outcomes.
14. Filter records while retaining rejected-row reasons.

## Integrated Case Study

Given:

```python
raw_orders = [
    {'order_id': ' B-2 ', 'status': ' ready ', 'amount': 20, 'source': 'east'},
    {'order_id': '', 'status': 'ready', 'amount': 4, 'source': 'east'},
    {'order_id': ' A-1 ', 'status': 'done', 'amount': -1, 'source': 'west'},
    {'order_id': ' C-3 ', 'status': 'done', 'amount': 12, 'source': 'west'},
]
```

Normalize statuses (`done` means `COMPLETED`), remove blank IDs, keep valid nonnegative amounts, project `order_id`, `status`, `amount`, and `source`, deduplicate source names, then sort by status and order ID. State where a loop is better if excluded rows need reason codes. Confirm raw data remains unchanged.

## Answer Key

### Section 1

1. New list. 2. New mapping. 3. New set. 4. At the end, after `for`. 5. `x * 2`. 6. `x`. 7. `values`. 8. No. 9. When rules or reasons are complex. 10. Zero is false-like. 11. Selecting fields. 12. Converting values to canonical form. 13. Removing repeats under a rule. 14. Repeated events may be real data. 15. Later value overwrites. 16. No. 17. New ordered list. 18. `None`. 19. `sorted()`. 20. Reverses the entire ordering. 21. One comparison value per item. 22. Primary and tie-breaker field order. 23. Equal keys keep earlier relative order. 24. Character order differs from numeric order. 25. `None` and a number cannot be compared. 26. It makes results predictable. 27. Variants collapse consistently. 28. Validation may need those fields. 29. To detect dropped or duplicated rows. 30. It names and isolates the rule. 31. They need investigation. 32. Check count, fields, values, and order.

### Section 2

1. `[s.strip() for s in labels]`
2. `[s.upper() for s in statuses]`
3. `[n * 2 for n in counts]`
4. `[n + 1 for n in days]`
5. `[record['order_id'] for record in records]`
6. `[record['country'] for record in records]`
7. `[f'src:{source}' for source in sources]`
8. `[len(code) for code in codes]`
9. `[{**record} for record in records]`
10. `[float(text) for text in amount_texts]` after validating input.
11. `[round(amount, 2) for amount in amounts]`
12. `[code[0] for code in codes if code]`
13. `[record['status'].upper() for record in records]`
14. `[{'id': record['id'], 'status': record['status']} for record in records]`
15. `[normalize_status(status) for status in statuses]`
16. `[(record['id'], record['amount']) for record in records]`

### Section 3

1. `[a for a in amounts if a >= 0]`
2. `[a for a in amounts if a > 100]`
3. `[s for s in statuses if s is not None]`
4. `[s for s in statuses if s is not None and s.strip()]`
5. `[s.upper() for s in statuses if s is not None]`
6. `[s.strip().upper() for s in statuses if s is not None and s.strip()]`
7. `[r for r in records if r.get('order_id', '').strip()]`
8. `[r for r in records if r['status'] == 'PASS']`
9. `[r['order_id'] for r in records if r['status'] == 'PASS']`
10. `[d for d in dates if d.startswith('2026-01')]`
11. `[n for n in names if n.startswith('A')]`
12. `[n for n in counts if n % 2 == 0]`
13. `[n * 2 for n in counts if n > 0]`
14. `[r for r in records if r['amount'] >= minimum]` after checking amounts are numeric.
15. `[s for s in sources if s]`
16. `[r for r in records if r.get('amount') is not None and r['amount'] >= 0]`

### Section 4

1. `{r['order_id']: r['status'] for r in records}`
2. `{c: len(c) for c in countries}`
3. `{r['status'] for r in records}`
4. `{s.upper() for s in sources}`
5. `{r['id']: r['amount'] for r in records}`
6. `{code: code.upper() for code in codes}`
7. `{r['id']: r['amount'] for r in records if r['amount'] > 0}`
8. `{c for c in countries if c and c.strip()}`
9. `{s: len(s) for s in statuses}`
10. `{s[0] for s in sources if s}`
11. The later record overwrites the earlier value for that ID; investigate before building the lookup.
12. `sorted(unique_statuses)`.

### Section 5

1. `sorted(values)` gives `[1, 3, 4]`.
2. `sorted(values, reverse=True)` gives `[4, 3, 1]`.
3. `working.sort()` mutates `working`.
4. `None`.
5. The original `values` remains in its prior order; the returned list is lost.
6. `sorted(countries)` gives `['India', 'UK', 'USA']`.
7. Strings compare characters; `'1'` precedes `'2'`.
8. `sorted(texts, key=int)` gives `['2', '10']`.
9. `sorted(amounts, reverse=True)`.
10. `ordered = sorted(values)`; `values` remains unchanged.
11. `reverse=True`.
12. `key=`.
13. No; it reorders references to the same dictionaries, so changing a dictionary later can affect both lists.
14. Comparing `None` with numeric keys can raise `TypeError`.
15. Equal keys keep their previous relative order.
16. `YYYY-MM-DD` text follows chronological order when valid and consistent.
17. Check field values, missing-value placement, row count, and intended direction.
18. When mutating a working list is intended and raw order is not needed.

### Section 6

1. `sorted(records, key=lambda r: r['amount'])`.
2. `sorted(records, key=lambda r: r['amount'], reverse=True)`.
3. `sorted(records, key=lambda r: r['order_id'])`.
4. `sorted(records, key=lambda r: (r['status'], r['order_id']))`.
5. `sorted(records, key=lambda r: (r['country'], r['amount']))` when amounts are numeric and present.
6. `def get_amount(record): return record['amount']`; then `sorted(records, key=get_amount)`.
7. `def amount_key(r): return (r.get('amount') is None, 0 if r.get('amount') is None else r['amount'])`; then `sorted(records, key=amount_key)`.
8. Mixed `str` and `int` keys raise `TypeError`; parse amounts to one numeric type first.
9. `sorted(records, key=lambda r: r['order_date'])` for valid ISO dates.
10. `sorted(records, key=lambda r: r['order_date'], reverse=True)`.
11. `sorted(records, key=lambda r: (r['source'], r['event_id']))`.
12. Their earlier relative order is retained because sorting is stable.
13. Reject or review the missing ID first if it is required; otherwise document a missing-last rule.
14. Save `[r['order_id'] for r in records]` before sorting and compare it afterward; use `sorted()` so the list order stays intact.

### Section 7

1. Comprehension; one simple change.
2. Normal loop with helper; several decisions and reasons.
3. Built-in `sum`; clearer than creating another list.
4. Filtered comprehension; one selection and one projection.
5. Named key helper; missing-value rule needs a name.
6. Normal loop; printing is a side effect.
7. Set comprehension; unique values are intended.
8. Helper or simple comprehension with an explicit unknown-code rule.
9. Normal loop/helper with specific exception handling and reasons.
10. Comprehension calling the named helper; one operation per item.
11. Normal loop; collisions need investigation before a dictionary is built.
12. `sorted()` with a simple tuple key.
13. Built-in `sum` for each clearly defined status count, or a loop for many categories.
14. Normal loop; retain a reason for each excluded row.

### Integrated Case Study

```python
raw_snapshot = [dict(row) for row in raw_orders]

def normalize_record(row):
    raw_status = row['status'].strip().upper()
    status = 'COMPLETED' if raw_status == 'DONE' else raw_status
    return {**row, 'order_id': row['order_id'].strip(), 'status': status,
            'source': row['source'].strip().upper()}

clean = [normalize_record(row) for row in raw_orders]
retained = [row for row in clean if row['order_id'] and row['amount'] >= 0]
projected = [
    {'order_id': row['order_id'], 'status': row['status'],
     'amount': row['amount'], 'source': row['source']}
    for row in retained
]
unique_sources = {row['source'] for row in projected}
ordered = sorted(projected, key=lambda row: (row['status'], row['order_id']))
assert raw_orders == raw_snapshot
```

The output contains `B-2` (READY) and `C-3` (COMPLETED), with `C-3` first in status order; the unique sources are `EAST` and `WEST`. A normal loop is better when the blank ID and negative amount need individual FAIL reasons.
