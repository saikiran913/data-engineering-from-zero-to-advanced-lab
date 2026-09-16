# Practice Questions

## Section A — Concept Checks

1. What is a collection?
2. What is a sequence?
3. Which brackets create a list?
4. Which brackets usually create a tuple?
5. Are lists ordered?
6. Are tuples ordered?
7. What does mutable mean?
8. What does immutable mean?
9. Which is mutable: list or tuple?
10. Which is immutable: list or tuple?
11. What is zero-based indexing?
12. What does index `0` return?
13. What does index `-1` return?
14. What does `len()` return?
15. What does slicing do?
16. Is the slice stop included?
17. What does membership mean?
18. What does `in` check?
19. Can lists contain duplicates?
20. Can tuples contain duplicates?
21. What is a single-item tuple?
22. Why does it need a trailing comma?
23. What is tuple unpacking?
24. What is a record-like tuple?
25. Why must tuple positions be documented?
26. What is a nested sequence?
27. Why can out-of-range indexing fail?
28. Why should empty sequences be handled?
29. Why might list mutation surprise a caller?
30. Why make a copy before mutation?
31. When is a list a good choice?
32. When is a tuple a good choice?

## Section B — Predict the Value

Use:

```python
files = ["orders.csv", "customers.csv", "products.csv", "payments.csv"]
record = ("ORD-1001", "PASS", 125.50)
```

1. `files[0]`
2. `files[1]`
3. `files[-1]`
4. `files[-2]`
5. `files[0:2]`
6. `files[:2]`
7. `files[1:]`
8. `files[-2:]`
9. `files[:]`
10. `files[::2]`
11. `len(files)`
12. `"orders.csv" in files`
13. `"reviews.csv" in files`
14. `"reviews.csv" not in files`
15. `record[0]`
16. `record[1]`
17. `record[2]`
18. `len(record)`
19. `record[0:2]`
20. `record[-1]`

## Section C — List or Tuple?

1. Source files that may grow.
2. Fixed order record with order ID and status.
3. Validation statuses collected during a run.
4. A row-like record from a small example.
5. Pipeline steps that may be appended in a lab.
6. A fixed pair of source name and status.
7. A collection to mutate with `append()`.
8. A collection that should not be reassigned by position.
9. First two sample files for debugging.
10. Ordered table names.
11. Fixed schema position pair.
12. Empty changing collection.
13. Single fixed source label.
14. Duplicate validation results.
15. Order ID/status/amount record.
16. Collection returned conceptually by a helper function.

## Section D — Fix the Index

1. Get first item from `files`.
2. Get second item from `files`.
3. Get last item from `files`.
4. Avoid `files[10]` on four-item list.
5. Get first field from `record`.
6. Get status from `record`.
7. Get amount from `record`.
8. Check length before fixed access.
9. Replace index 1 in a list.
10. Do not replace index 1 in a tuple.
11. Get last two files.
12. Get first two files.
13. Get all files from index 1 onward.
14. Get full shallow list copy.
15. Use unpacking instead of `record[2]`.
16. Avoid magic index with documentation.

## Section E — Predict the Slice

Use:

```python
items = ["a", "b", "c", "d", "e"]
```

1. `items[0:2]`
2. `items[1:3]`
3. `items[:3]`
4. `items[2:]`
5. `items[-2:]`
6. `items[:-1]`
7. `items[:]`
8. `items[::2]`
9. `items[1:5:2]`
10. `items[0:0]`
11. `items[4:]`
12. `items[-1:]`
13. `items[3:10]`
14. `items[10:]`
15. `items[1:1]`
16. `items[2:4]`

## Section F — Mutation Reasoning

1. What does `append()` do?
2. What does `extend()` do?
3. What does `insert()` do?
4. What does `remove()` do?
5. What does `pop()` do?
6. Why can mutation be useful?
7. Why can mutation be risky?
8. Why copy before mutation?
9. What happens after `statuses[1] = "REVIEW"`?
10. Can tuple item assignment work?
11. Why avoid mutating shared input unexpectedly?
12. How can `append(["a", "b"])` surprise beginners?
13. How is `extend(["a", "b"])` different?
14. Why document mutation policy?

## Section G — Record Sequence Design

1. Design a tuple for order ID and status.
2. Design a tuple for source file and validation result.
3. Document positions for order ID/status/amount.
4. Explain why all record tuples need the same shape.
5. Explain when a tuple becomes too large.
6. Explain why dictionaries will help later.
7. Choose list or tuple for many order records.
8. Loop over order records.
9. Unpack order ID, status, amount.
10. Validate status inside loop.
11. Count PASS records.
12. Handle empty record sequence.
13. Avoid nested indexing where unpacking is clearer.
14. Document sequence contract.

## Section H — Tuple Unpacking

1. Unpack `("ORD-1", "PASS")`.
2. Unpack `("orders.csv", "REVIEW")`.
3. Unpack `("ORD-1", "PASS", 100.0)`.
4. What happens with too many variables?
5. What happens with too few variables?
6. Why is unpacking clearer than `record[1]`?
7. Unpack a source/status pair in a loop.
8. Unpack an order record in a loop.
9. Match variable order to tuple order.
10. Explain fixed record shape.
11. Avoid unpacking inconsistent tuple lengths.
12. Use readable variable names.

## Section I — Mini Case Study

Use source file names, validation statuses, and order tuples.

Tasks:

1. choose list or tuple for source files
2. choose list or tuple for one order record
3. inspect first source
4. inspect last source
5. slice first two sources
6. append new source
7. loop through sources
8. unpack order tuple
9. count validation statuses
10. identify positional-record risks
11. explain when dictionary would be better later

## Answer Key

### Section A

1. One value holding multiple values.
2. Ordered collection.
3. `[]`.
4. `()`.
5. Yes.
6. Yes.
7. Can be changed.
8. Cannot be changed.
9. List.
10. Tuple.
11. First index is `0`.
12. First item.
13. Last item.
14. Number of items.
15. Selects a range.
16. No.
17. Presence in a collection.
18. Whether value exists.
19. Yes.
20. Yes.
21. Tuple with one item.
22. To distinguish from grouping/string.
23. Assign tuple values to names.
24. Tuple whose positions represent fields.
25. Position carries meaning.
26. Sequence inside another sequence.
27. Position does not exist.
28. Loops may not run and indexing fails.
29. Same list can change.
30. Preserve original.
31. Changing ordered collection.
32. Fixed positional record.

### Section B

1. `"orders.csv"`
2. `"customers.csv"`
3. `"payments.csv"`
4. `"products.csv"`
5. `["orders.csv", "customers.csv"]`
6. `["orders.csv", "customers.csv"]`
7. `["customers.csv", "products.csv", "payments.csv"]`
8. `["products.csv", "payments.csv"]`
9. full list copy
10. `["orders.csv", "products.csv"]`
11. `4`
12. `True`
13. `False`
14. `True`
15. `"ORD-1001"`
16. `"PASS"`
17. `125.50`
18. `3`
19. `("ORD-1001", "PASS")`
20. `125.50`

### Section C

Use lists for changing collections and many collected values. Use tuples for fixed-position records and stable pairs. Source files may be a list; one order record is usually a tuple in Day 055 examples.

### Section D

Use indexes `0`, `1`, `-1`, length checks, slices such as `files[-2:]`, `files[:2]`, `files[1:]`, and tuple unpacking with documented field order.

### Section E

1. `["a", "b"]`
2. `["b", "c"]`
3. `["a", "b", "c"]`
4. `["c", "d", "e"]`
5. `["d", "e"]`
6. `["a", "b", "c", "d"]`
7. full list copy
8. `["a", "c", "e"]`
9. `["b", "d"]`
10. `[]`
11. `["e"]`
12. `["e"]`
13. `["d", "e"]`
14. `[]`
15. `[]`
16. `["c", "d"]`

### Section F

`append()` adds one item. `extend()` adds items from another sequence. `insert()` adds at a position. `remove()` removes first matching value. `pop()` removes and returns an item. Mutation is useful when lists change, but risky when shared or unexpected.

### Section G

Strong answers use documented tuple positions, consistent record shapes, clear unpacking, list of tuples for many records, explicit empty handling, and a note that named structures become better for complex records.

### Section H

Match variable count and order to tuple values. Use names such as `order_id`, `status`, and `amount`. Unpacking is clearer than magic indexes when the tuple shape is known.

### Section I

Use a list for source files, a tuple for one fixed order record, indexes for first/last, slices for samples, `append()` for new source, loops for iteration, tuple unpacking for records, counters for statuses, and named structures later when positional meaning becomes too complex.
