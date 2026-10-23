# Common Mistakes

| # | What is wrong | Why it matters | Safer approach |
|---|---|---|---|
| 1 | Packing five rules into one comprehension | Reviewers miss conditions | Use a loop and named helper |
| 2 | Deeply nesting comprehensions | Output shape is hard to see | Split into stages |
| 3 | Printing inside a comprehension | Side effects obscure intent | Use a normal loop |
| 4 | Building a list only for side effects | Unused list wastes work | Use a normal loop |
| 5 | Putting the filter in the output expression | Condition may change output instead of excluding input | Use trailing `if` for filtering |
| 6 | Forgetting `None` status values | `.strip()` raises an error | Filter or handle `None` first |
| 7 | Treating whitespace as a real ID | Blank record survives | Check `.strip()` |
| 8 | Mutating the raw list with `.sort()` | Source order is lost | Use `sorted()` |
| 9 | Assigning `values.sort()` | Variable becomes `None` | Use `sorted(values)` |
| 10 | Ignoring `sorted(values)` result | Output stays unsorted | Assign the new list |
| 11 | Assuming `reverse=True` reverses only ties | Whole order reverses | Define a suitable key or staged sort |
| 12 | Sorting numeric strings | `'10'` may precede `'2'` | Convert to numeric values |
| 13 | Accessing a missing record key | `KeyError` stops pipeline | Validate schema or use documented fallback |
| 14 | Comparing `None` with numbers | Sorting raises `TypeError` | Explicit missing-value key |
| 15 | Sorting mixed strings and numbers | Types are incomparable | Normalize a common type |
| 16 | Writing a complex lambda | Key rule is hard to audit | Use a named key function |
| 17 | Choosing the wrong sort field | Report order is misleading | State the business order |
| 18 | Assuming set iteration order | Output changes unexpectedly | Use `sorted(unique_values)` |
| 19 | Converting list to set casually | Duplicates and order vanish | Confirm dedupe requirement |
| 20 | Reusing duplicate dictionary keys | Later value overwrites earlier | Check key uniqueness first |
| 21 | Normalizing a code to the wrong country | Business meaning changes | Use reviewed lookup mapping |
| 22 | Filtering all non-PASS rows | REVIEW evidence disappears | Retain review output separately |
| 23 | Projecting away required fields | Later validation cannot run | Validate before projection |
| 24 | Sorting before parsing amounts | Text order differs from numeric order | Parse before sort |
| 25 | Deduplicating before normalization | Variants stay duplicated | Normalize first |
| 26 | Hiding business rules in a one-liner | Changes are hard to review | Use functions and a loop |
| 27 | Changing raw record dictionaries | Audit trail is altered | Return new dictionaries |
| 28 | Misreading tuple key order | Wrong primary sort field | Put primary field first |
| 29 | Sorting dates in mixed text formats | Lexicographic order is wrong | Parse dates or use ISO format |
| 30 | Adding pandas for a tiny exercise | Adds unnecessary dependency | Use Python standard library |
| 31 | Optimizing for fewer characters | Bugs become easier to hide | Prefer explicit readable stages |
| 32 | Skipping output validation | Missing fields or rows go unnoticed | Compare counts and shape |
| 33 | Forgetting a comprehension creates a new list | Later code reads raw list | Use the assigned output |
| 34 | Treating `if value` as a blank check for numeric data | Zero is removed | Use an explicit condition |
| 35 | Building an ID mapping before checking duplicates | One record vanishes | Count or investigate repeated IDs |
| 36 | Assuming stable sorting fixes wrong keys | Stable sort preserves ties only | Choose the right key |
| 37 | Using a set for ordered reporting | Order is unpredictable | Sort the unique output |
| 38 | Catching parse errors by silently dropping rows | Data quality issue is hidden | Record a validation reason |
