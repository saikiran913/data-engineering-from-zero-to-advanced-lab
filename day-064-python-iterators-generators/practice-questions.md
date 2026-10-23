# Practice Questions

Answer each section before checking the answer key. All code examples should stay bounded and in memory.

## Section 1: Concepts (32)

1. What is an iterable?
2. Name five built-in iterables.
3. What does `iter(values)` return for a list?
4. What does an iterator remember?
5. What does `next(iterator)` do?
6. What signals no more values?
7. What does a `for` loop handle automatically?
8. What is a generator?
9. What makes a function a generator function?
10. What does `yield` do?
11. Does calling a generator function execute every `yield` immediately?
12. What state is retained between yields?
13. How does a generator expression differ from a list comprehension?
14. Which one produces a full list eagerly?
15. What does lazy evaluation mean?
16. What does eager evaluation mean?
17. What does one-pass consumption mean?
18. Can a generator be indexed like a list?
19. Can `len(generator)` usually be called directly?
20. What does `list(generator)` do?
21. Does a second `list(generator)` restart it?
22. How do you rerun a generator function?
23. Does `iter(exhausted_generator)` reset it?
24. Why can debugging change a lazy flow?
25. When does code inside a generator run?
26. Why can errors appear late?
27. Why is lazy processing memory-aware?
28. Does a full source list disappear when wrapped in a generator?
29. Why might sorting require a list?
30. When is a list clearer than a generator?
31. What is a pipeline consumer?
32. Why keep generator stages focused?

## Section 2: Iterable vs Iterator (14)

1. Is `[1, 2]` iterable?
2. Is `(1, 2)` iterable?
3. Is `"AB"` iterable?
4. Is a dictionary iterable by default over its keys?
5. Is a set iterable, and can you rely on its order?
6. What is returned by `iter([1, 2])`?
7. What changes after `next(iterator)`?
8. Can two fresh iterators be made from one list?
9. If one iterator is halfway through, what does `iter(iterator)` do?
10. What does a `for` loop ask an iterable for?
11. Is a generator itself an iterator?
12. Can the original list be looped over again after one iterator ends?
13. Does the same exhausted iterator contain a rewind button?
14. Which is suitable for two independent consumers: one shared iterator or two fresh iterators?

## Section 3: `iter()` and `next()` (14)

1. Write code to get an iterator from `["a", "b"]`.
2. Request the first value.
3. Request the second value.
4. What happens on the third request?
5. Write `try/except` to handle that request.
6. Obtain a fresh iterator from the original list.
7. What is its first value?
8. Does `next()` peek without consuming?
9. What does `next(iter([]))` do?
10. How does a loop stop without crashing?
11. If one value was manually requested, what will a following loop over the same iterator see?
12. What happens if you pass an exhausted iterator to another function?
13. Can `iter(iterator)` restart it?
14. When is manual `next()` useful in this lesson?

## Section 4: Generator Functions (16)

1. Write a function that yields `"READY"` and `"REVIEW"`.
2. What is returned when that function is called?
3. When does its first `yield` run?
4. What happens immediately after `yield`?
5. How is local state maintained?
6. Write a bounded ID generator for IDs 1 through 3.
7. Why include a `limit`?
8. What if a function uses only `return`?
9. Why is `yield record` suitable for a record stream?
10. What happens after the final yield?
11. How can you rerun the same sequence?
12. How can a consumer stop early?
13. Should a generator mutate its input dictionary silently?
14. How can a generator yield a clean copy?
15. Why might a generator's error appear during iteration?
16. What does `for record in generator:` do?

## Section 5: Generator Expressions (14)

1. Write a list comprehension that squares `values`.
2. Write a generator expression that squares `values`.
3. Which one is a list?
4. Which one is lazy?
5. Does `(x for x in values)` create a tuple of values?
6. How do you consume it one item at a time?
7. How do you materialise its remaining items deliberately?
8. What is left after `list(generator)` consumes everything?
9. Write a generator expression for positive amounts.
10. Write one that uppercases statuses.
11. What happens when the consumer requests only one item?
12. Is the source list itself removed from memory?
13. When would `[x for x in values]` be simpler?
14. Why should `list(generator)` be a deliberate choice?

## Section 6: Eager or Lazy? (16)

Choose a list or generator and give one reason.

1. Three values need indexing.
2. Many records need one-pass normalization.
3. A report needs sorted results.
4. A tiny list is reused five times.
5. A consumer may stop after one matching event.
6. A full source list already exists; only intermediate copies should be avoided.
7. Two independent reports need the same transformed data.
8. Count PASS results without keeping records.
9. Inspect every transformed item repeatedly.
10. Process a bounded synthetic source one record at a time.
11. Obtain item number 20 directly.
12. Produce a list that a UI will index later.
13. Chain normalization and filtering once.
14. Sort all records by date.
15. Read only the first few values of a source.
16. Keep a stable audit snapshot of all results.

## Section 7: Exhaustion and Debugging (14)

1. Predict `list(g)` twice for `g = (x for x in [1, 2])`.
2. Does printing `g` show its values?
3. What does `next(g)` change?
4. Why is a second loop over `g` empty?
5. How do you repeat a generator function's output?
6. Why can `list(stage)` break a later stage?
7. When can a parsing exception surface?
8. What should be tested first if a pipeline yields no rows?
9. What should be checked next if the source has rows?
10. Why is a small test source useful?
11. How can you inspect one stage without losing a full run?
12. Why does `sorted(g)` exhaust `g`?
13. Why can two consumers sharing one iterator give surprising results?
14. What should replace a generator when repeated indexed access is essential?

## Integrated Mini Case

Design a bounded synthetic record source, a lazy status-normalization stage, a lazy validation/filter stage, and a one-at-a-time consumer that counts PASS, REVIEW, and FAIL. Explain why the consumer needs no final list, and when a list would be preferable. Preserve raw records where possible.

## Answer Key

### Section 1

1. An object that can provide an iterator. 2. List, tuple, string, dictionary, set. 3. A fresh list iterator. 4. Its current position. 5. Returns and consumes one value. 6. `StopIteration`. 7. Requesting values and handling exhaustion. 8. A convenient iterator made by a generator function or expression. 9. It contains `yield`. 10. Provides one value and pauses. 11. No. 12. Local variables and execution position. 13. It computes on demand instead of building a list. 14. List comprehension. 15. Compute when requested. 16. Compute or collect before later use. 17. Same iterator does not restart. 18. No. 19. No. 20. Collects remaining values. 21. No. 22. Call the function again. 23. No. 24. `next()`, loops, and `list()` consume values. 25. On requests from a consumer. 26. The relevant item may be requested later. 27. It can avoid full intermediate lists. 28. No. 29. Full ordering needs all items. 30. Small data, repeated passes, indexing, or sorting. 31. Code that requests and uses values. 32. Each stage is easier to inspect and reuse.

### Section 2

1. Yes. 2. Yes. 3. Yes. 4. Yes. 5. Yes; no reliable business order. 6. A list iterator. 7. Its position advances. 8. Yes. 9. It returns the same current iterator. 10. An iterator. 11. Yes. 12. Yes. 13. No. 14. Two fresh iterators from the list.

### Section 3

1. `values = ['a', 'b']; iterator = iter(values)`.
2. `next(iterator)` gives `'a'`.
3. `next(iterator)` gives `'b'`.
4. `StopIteration` is raised.
5. Use a handled request:

   ```python
   try:
       next(iterator)
   except StopIteration:
       print("done")
   ```
6. `fresh = iter(values)`.
7. `'a'`.
8. No; it consumes the returned item.
9. It raises `StopIteration`.
10. It handles `StopIteration` internally.
11. Only remaining items.
12. It has no remaining values to provide.
13. No.
14. To observe one-step advancement and exhaustion explicitly.

### Section 4

1. `def statuses(): yield 'READY'; yield 'REVIEW'` with each yield on its own indented line.
2. A generator object.
3. On first `next()` or loop request.
4. Function pauses and retains state.
5. Python keeps local variables and execution position.
6. `def ids(limit):` then `for number in range(1, limit + 1): yield f'REC-{number:03d}'`; call `ids(3)`.
7. To guarantee a bounded sequence.
8. It is an ordinary function returning one result, not a generator.
9. It sends each record to a consumer without creating a full output list.
10. The iterator becomes exhausted.
11. Call the generator function again.
12. Stop requesting values or break a loop.
13. No; yield a copy if normalization is needed.
14. `yield {**record, 'status': clean_status}`.
15. Its body runs when an item is requested.
16. It repeatedly requests records until exhaustion.

### Section 5

1. `[x * x for x in values]`.
2. `(x * x for x in values)`.
3. The bracketed comprehension.
4. The parenthesized generator expression.
5. No; it creates a generator.
6. `for item in generator: ...` or `next(generator)`.
7. `list(generator)`.
8. Nothing; later iteration is empty.
9. `(a for a in amounts if a > 0)`.
10. `(s.upper() for s in statuses)`.
11. Only enough upstream work is done to produce that item.
12. No.
13. When a small collection needs repeated use or indexing.
14. It materialises all remaining items and exhausts the generator.

### Section 6

1. List; indexing. 2. Generator; one-pass incremental transformation. 3. List; sorting materialises. 4. List; repeated reuse. 5. Generator; stop early. 6. Generator stages; avoid extra intermediates, though source remains a list. 7. List or two fresh generator calls; independent passes are needed. 8. Generator; count at consumer. 9. List; repeated inspection. 10. Generator; demonstrates demand-driven flow. 11. List; indexing. 12. List; later indexing. 13. Generator; one-pass chain. 14. List; full ordering. 15. Generator; early stop. 16. List; reusable audit snapshot.

### Section 7

1. First `[1, 2]`, then `[]`.
2. No; it shows the object representation.
3. It consumes one value and advances state.
4. The first loop exhausted it.
5. Call its generator function again.
6. The inspection consumes all remaining stage values.
7. During consumption of the problematic item.
8. Check whether the source is empty or already exhausted.
9. Test the filter and each stage separately.
10. It makes each requested value easy to trace.
11. Recreate the generator after a small diagnostic sample.
12. It must collect all values to order them.
13. Their requests advance the same shared state.
14. A list.

### Integrated Mini Case

```python
def source():
    for record in (
        {'id': 'A', 'status': ' ready ', 'amount': 8, 'active': True},
        {'id': 'B', 'status': ' unknown ', 'amount': 3, 'active': True},
        {'id': '', 'status': ' ready ', 'amount': 4, 'active': True},
        {'id': 'C', 'status': ' ready ', 'amount': 2, 'active': False},
    ):
        yield record

def normalize(records):
    for record in records:
        yield {**record, 'status': record['status'].strip().upper()}

def active(records):
    for record in records:
        if record['active']:
            yield record

def classify(records):
    for record in records:
        if not record['id'] or record['amount'] < 0:
            status = 'FAIL'
        elif record['status'] not in {'READY', 'COMPLETED'}:
            status = 'REVIEW'
        else:
            status = 'PASS'
        yield status

counts = {'PASS': 0, 'REVIEW': 0, 'FAIL': 0}
for status in classify(active(normalize(source()))):
    counts[status] += 1
assert counts == {'PASS': 1, 'REVIEW': 1, 'FAIL': 1}
```

The consumer retains only three counts, so it needs no final record list. A list is preferable when all classified records must later be sorted, indexed, or reused in several reports. The normalization stage returns a new dictionary and leaves the source record unchanged.
