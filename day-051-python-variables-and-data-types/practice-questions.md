# Practice Questions

## Section A — Concept Checks

1. What is a variable?
2. What does assignment mean?
3. Which symbol performs assignment?
4. What is the left side of `record_count = 100`?
5. What is the right side of `record_count = 100`?
6. Why is `record_count` clearer than `x`?
7. What is `snake_case`?
8. Can a Python variable name start with a number?
9. Why is `source-name` invalid?
10. Why should reserved keywords not be used as variable names?
11. What is reassignment?
12. What does dynamic typing mean?
13. Does dynamic typing mean types are unimportant?
14. What type is `100`?
15. What type is `100.0`?
16. What type is `"100"`?
17. What type is `True`?
18. What does `None` represent?
19. What is `NoneType`?
20. What does `type()` do?
21. Why is `"100"` different from `100`?
22. Why is `"False"` different from `False`?
23. Why is `None` different from `0`?
24. Why is `None` different from `""`?
25. Why is `None` different from `False`?
26. What does `int("100")` produce?
27. What does `float("42.5")` produce?
28. Why can conversion fail?
29. Why might an ID remain a string?
30. What is type drift?

## Section B — Identify the Type

Identify the Python type:

1. `100`
2. `100.0`
3. `"100"`
4. `True`
5. `False`
6. `None`
7. `""`
8. `" "`
9. `"orders.csv"`
10. `"ORD-001"`
11. `0`
12. `-5`
13. `45.75`
14. `"False"`
15. `"UK"`
16. `"00125"`
17. `0.0`
18. `"0"`
19. `"2026-01-01"`
20. `bool("False")`

## Section C — Valid or Invalid Variable Name

1. `record_count`
2. `2records`
3. `source-name`
4. `source_name`
5. `is_valid`
6. `has_errors`
7. `class`
8. `daily_total`
9. `order id`
10. `order_id`
11. `_temporary_value`
12. `retry_count`
13. `True`
14. `table_name`
15. `file.name`
16. `country_code`
17. `average-amount`
18. `average_amount`

## Section D — Predict the Output

1. `type(100)`
2. `type("100")`
3. `type(45.5)`
4. `type(True)`
5. `type(None)`
6. `"100" + "20"`
7. `100 + 20`
8. `bool("")`
9. `bool("False")`
10. `bool(0)`
11. `bool(1)`
12. `bool(None)`
13. `int("100")`
14. `float("42.5")`
15. `str(100)`
16. `None is None`

## Section E — Choose the Right Type

1. Row count
2. File size in bytes
3. Order amount
4. Conversion rate
5. Order ID
6. Customer ID `"00125"`
7. Source filename
8. Load status text
9. Validation passed flag
10. Has errors flag
11. Optional error message when no error exists
12. Empty optional comment
13. Country code
14. Retry count
15. Percentage ratio
16. Schema version `"001"`

## Section F — Fix the Mistake

1. `2records = 10`
2. `source-name = "orders"`
3. `class = "orders"`
4. `x = 5000` for row count
5. `record_count == 100` when assigning
6. `"100" + 20`
7. `int("00125")` for customer ID
8. `last_error = ""` when no error value exists by rule
9. `missing_amount = 0` when amount is unknown
10. `is_valid = "False"`
11. `bool("False")` used as text parser
12. `int("one hundred")`
13. `float("unknown")`
14. `int(None)`
15. `value = 100` then `value = "100"` with no reason
16. `true`
17. `none`
18. `"orders.csv`

## Section G — Conversion Thinking

Classify each as safe, unsafe, loses business meaning, missing value, or malformed value.

1. `int("100")` for row count
2. `float("45.75")` for amount
3. `int("00125")` for customer ID
4. `int(None)`
5. `int("one hundred")`
6. `float("unknown")`
7. `str(100)` for label text
8. `bool("False")` for API text flag
9. `int("0")` for retry count
10. `float("0.0")` for amount
11. keeping `"ORD-1001"` as string
12. treating `""` as `None` without rule
13. converting `"2026-01-01"` with `int()`
14. keeping `"001"` as schema version string

## Section H — Mini Case Study

Source record:

```python
order_id = "ORD-1001"
amount_text = "250.75"
status = "PAID"
is_valid_text = "False"
review_note = None
```

Answer:

1. What are the observed types?
2. What are the expected business types?
3. Which values should remain strings?
4. Which values need conversion?
5. Which values are missing?
6. Which conversions are risky?
7. What downstream risk comes from wrong types?

## Answer Key

### Section A

1. A name that refers to a value.
2. Giving a value to a variable name.
3. `=`.
4. `record_count`.
5. `100`.
6. It shows business meaning.
7. Lowercase words separated by underscores.
8. No.
9. Hyphen is read as subtraction.
10. They already have Python meaning.
11. Giving a variable a new value.
12. A variable can later refer to another type.
13. No. Types still matter.
14. `int`.
15. `float`.
16. `str`.
17. `bool`.
18. No-value or missing-state concept.
19. The type of `None`.
20. Shows the type of a value.
21. Text versus integer.
22. Text versus boolean.
23. Missing state versus numeric zero.
24. Missing state versus empty text.
25. Missing state versus known false value.
26. Integer `100`.
27. Float `42.5`.
28. Input may be malformed or missing.
29. Formatting or leading zeros may matter.
30. A field changes type across time or sources.

### Section B

1. `int`
2. `float`
3. `str`
4. `bool`
5. `bool`
6. `NoneType`
7. `str`
8. `str`
9. `str`
10. `str`
11. `int`
12. `int`
13. `float`
14. `str`
15. `str`
16. `str`
17. `float`
18. `str`
19. `str`
20. `bool`

### Section C

Valid: 1, 4, 5, 6, 8, 10, 11, 12, 14, 16, 18.

Invalid: 2, 3, 7, 9, 13, 15, 17.

### Section D

1. `int`
2. `str`
3. `float`
4. `bool`
5. `NoneType`
6. `"10020"`
7. `120`
8. `False`
9. `True`
10. `False`
11. `True`
12. `False`
13. `100`
14. `42.5`
15. `"100"`
16. `True`

### Section E

1. `int`
2. `int`
3. `float`
4. `float`
5. `str`
6. `str`
7. `str`
8. `str`
9. `bool`
10. `bool`
11. `NoneType` when no error exists
12. `str`
13. `str`
14. `int`
15. `float`
16. `str`

### Section F

1. `record_count = 10`
2. `source_name = "orders"`
3. `dataset_class = "orders"`
4. `row_count = 5000`
5. `record_count = 100`
6. Convert safely or keep both as strings intentionally.
7. Keep `customer_id = "00125"`.
8. Use `None` if the business rule means no error value exists.
9. Use `None` if amount is unknown.
10. Use `False` if it is a real boolean.
11. Do not use `bool()` as text parser.
12. Validate before converting.
13. Validate before converting.
14. Check `is None` before converting.
15. Use separate names or document the type change.
16. Use `True`.
17. Use `None`.
18. Close the quote: `"orders.csv"`.

### Section G

1. safe
2. safe
3. loses business meaning
4. missing value
5. malformed value
6. malformed value
7. safe
8. unsafe
9. safe
10. safe
11. safe
12. unsafe without business rule
13. malformed value
14. safe

### Section H

Observed types: `order_id` is `str`, `amount_text` is `str`, `status` is `str`, `is_valid_text` is `str`, `review_note` is `NoneType`. `order_id` and `status` should remain strings. `amount_text` may need safe conversion to `float`. `is_valid_text` needs deliberate parsing later, not plain `bool()`. `review_note` is missing. Wrong types can break calculations, validation, filtering, and reporting.
