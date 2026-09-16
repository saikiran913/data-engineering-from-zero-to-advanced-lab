# Practice Questions

## Concept Checks

1. What does a dictionary map?
2. What is a key-value pair?
3. Why are named fields useful?
4. What happens when a dictionary literal repeats a key?
5. What does dictionary membership check?
6. When is direct lookup appropriate?
7. When is `.get()` appropriate?
8. What error can direct access raise?
9. How is a missing key different from `None`?
10. Are dictionaries mutable?
11. What does `.items()` return while iterating?
12. What collection stores unique values?
13. How do you create an empty set?
14. Can a set be indexed?
15. What can list-to-set conversion lose?
16. What does `expected - observed` show?
17. What does intersection show?
18. What does union show?
19. Why document nested data shapes?
20. When is a list of dictionaries useful?
21. Why use snake_case keys?
22. What is a required key?
23. What is an extra key?
24. Are extra keys always invalid?
25. Why avoid resizing a dictionary while iterating?
26. Why not rely on dictionary order for semantics?
27. Why not rely on set order?
28. When is a tuple preferable?
29. When is a list preferable?
30. When is a dictionary preferable?
31. When is a set preferable?
32. What is a shallow copy warning?
33. Why can a default value be risky?
34. What is record grain?

## Lookup Predictions

Predict each result for `record = {"id": "A1", "note": None, "status": "OK"}`.

1. `record["id"]`
2. `record.get("id")`
3. `record.get("country")`
4. `record.get("country", "UK")`
5. `"id" in record`
6. `"A1" in record`
7. `"note" in record`
8. `record.get("note")`
9. `len(record)`
10. `set(record.keys())`
11. `"status" in record`
12. `record["status"]`
13. What happens with `record["country"]`?
14. Is `note` missing?
15. Is its value missing?
16. Which check distinguishes those states?
17. What does `record.items()` provide?
18. What does `record.values()` provide?
19. Add `record["country"] = "UK"`; what changes?
20. Update `record["status"] = "HOLD"`; what changes?

## Direct Access or `.get()`?

For each, choose direct access or `.get()`: 1. required order ID; 2. optional review note; 3. required amount; 4. optional campaign tag; 5. required status; 6. optional customer phone; 7. required source ID; 8. optional comment; 9. required event timestamp; 10. optional quality flag; 11. required country; 12. optional promotion code; 13. required batch ID; 14. optional reviewer; 15. required schema version; 16. optional retry note.

## Fix the Dictionary

Fix or explain: 1. `record[0]`; 2. `{}  # empty set`; 3. `record["optional_note"]`; 4. `"OK" in record`; 5. repeated `"status"` key; 6. `for key, value in record`; 7. change keys during iteration; 8. assume `.get()` proves presence; 9. use `remove` for optional set value; 10. `observed - expected` for missing fields; 11. deep chain without checks; 12. `orderId` mixed with `order_id`; 13. set indexing; 14. list-to-set for ordered steps; 15. discard duplicate counts; 16. mutate shared source record.

## Predict the Set

Let `a = {"A", "B", "B"}` and `b = {"B", "C"}`. Predict: 1. `a`; 2. `len(a)`; 3. `"A" in a`; 4. `a | b`; 5. `a & b`; 6. `a - b`; 7. `b - a`; 8. `a.add("C")`; 9. `a.discard("Z")`; 10. `set(["A", "A", "B"])`; 11. empty set syntax; 12. indexing outcome; 13. order guarantee; 14. unique count; 15. appropriate use; 16. inappropriate frequency use.

## Collection Choice

Choose list, tuple, dictionary, or set for: 1. ordered stages; 2. fixed coordinates; 3. named order; 4. allowed statuses; 5. duplicate event IDs; 6. ordered source files; 7. named configuration; 8. unique columns; 9. fixed three-value record; 10. changing queue; 11. required keys; 12. unique countries; 13. ordered results; 14. validation outcome by rule; 15. duplicate frequency; 16. optional fields; 17. stable positional values; 18. observed schema fields.

## Required-Key Validation

For each record, identify missing and extra keys using expected `{ "order_id", "status", "amount" }`: 1. all three; 2. no amount; 3. only ID; 4. all plus country; 5. typo `orderId`; 6. status is `None`; 7. empty record; 8. amount plus ID; 9. extra note; 10. status only; 11. all plus source; 12. all correct; 13. wrong key case; 14. nested customer only.

## Nested Data Navigation

Given the mini case below, write expressions to: 1. order ID; 2. status; 3. optional note; 4. customer dictionary; 5. customer ID; 6. country; 7. flags; 8. first flag after checking length; 9. required top-level keys; 10. observed keys; 11. missing keys; 12. allowed-status membership.

```python
order = {
    "order_id": "ORD-1001",
    "status": "COMPLETED",
    "amount": 125.50,
    "customer": {"customer_id": "CUST-001", "country": "UK"},
    "flags": ["REVIEWED"],
}
```

## Mini Case Study

Explain the record shape, access required fields, read an optional note safely, validate required keys, validate status against a set, inspect the nested country, add a validation result to a working copy, and explain why this is a dictionary rather than a tuple.

## Answer Key

Concept checks: 1. keys to values; 2. one named field and value; 3. clarity; 4. last value wins; 5. keys; 6. required field; 7. intentional optional field; 8. `KeyError`; 9. absent field versus present blank value; 10. yes; 11. pairs; 12. set; 13. `set()`; 14. no; 15. order and frequency; 16. missing expected values; 17. shared values; 18. all values; 19. safe navigation; 20. multiple records; 21. consistency; 22. mandatory field; 23. uncontracted supplied field; 24. no; 25. unsafe resizing; 26. keys carry meaning; 27. no positional contract; 28. fixed positional values; 29. ordered changing values; 30. named fields; 31. unique membership; 32. nested values can remain shared; 33. it can hide a missing requirement; 34. what one record represents.

Lookup predictions: 1–2 `A1`; 3 `None`; 4 `UK`; 5 true; 6 false; 7 true; 8 `None`; 9 three; 10 keys as a set; 11 true; 12 `OK`; 13 `KeyError`; 14 no; 15 yes; 16 membership; 17 pairs; 18 values; 19 adds country; 20 changes status.

Direct-access scenarios: use direct access for 1, 3, 5, 7, 9, 11, 13, 15; use `.get()` for the remaining optional fields.

Fixes: use keys rather than indexes; use `set()` for an empty set; use `.get()` for optional data; membership checks keys; unique keys; use `.items()` for two variables; mutate after loop; check membership for presence; use `discard()` when absence is acceptable; use `expected - observed`; inspect levels; standardise key names; do not index sets; preserve list for order; preserve list/count for frequency; copy before deliberate mutation.

Set predictions: 1 `{A, B}`; 2 two; 3 true; 4 `{A, B, C}`; 5 `{B}`; 6 `{A}`; 7 `{C}`; 8 adds C; 9 no error or change; 10 `{A, B}`; 11 `set()`; 12 not indexable; 13 none; 14 two; 15 membership/deduplication; 16 frequency or order.

Collection choices: list for 1, 6, 10, 13; tuple for 2, 9, 17; dictionary for 3, 7, 11, 14, 16; set for 4, 5 when frequency is irrelevant, 8, 12, 18. Keep a list for duplicate frequency in 15.

Required keys: missing means expected minus observed; extra means observed minus expected. `None` is a value, so it does not make a key missing; validate it separately. The typo and wrong-case examples make `order_id` missing and create an extra key.

Nested navigation: direct lookup is suitable for required keys; `order.get("review_note")` is safe for the optional note; use `order["customer"]["country"]` only when both levels are required and known present; compare `set(order.keys())` with the required-key set.
