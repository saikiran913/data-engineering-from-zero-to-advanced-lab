# Practice Questions

## Section A — Concept Checks

1. What is a function?
2. What keyword defines a function?
3. What is a parameter?
4. What is an argument?
5. What is a function call?
6. What is a return value?
7. What does `return` do?
8. How is `print()` different from `return`?
9. What is local scope?
10. What is global scope conceptually?
11. What is variable shadowing?
12. Why are hidden global dependencies risky?
13. What is a pure function?
14. What is a side effect?
15. Why are docstrings useful?
16. What is a function interface?
17. What is a function signature conceptually?
18. What is a positional argument?
19. What is a keyword argument?
20. What is a default parameter?
21. Why should parameter names describe business meaning?
22. Why should return values be consistent?
23. What is an implicit `None` return?
24. Why should validation functions return outcomes?
25. Why should transformation functions return transformed values?
26. What does orchestration mean?
27. What does composition mean?
28. Why should functions stay focused?
29. Why does repeated business logic belong in one function?
30. Why should side effects be deliberate?
31. Why can functions help testing?
32. Why should a function contract mention missing-value rules?

## Section B — Identify Parameter vs Argument

For each, identify the parameter and argument.

1. `def validate_status(status):`
2. `validate_status("READY")`
3. `def calculate_total(a, b):`
4. `calculate_total(10, 20)`
5. `def classify_errors(error_count, review_limit=5):`
6. `classify_errors(3)`
7. `classify_errors(error_count=3, review_limit=10)`
8. `def normalize_source_name(source_name):`
9. `normalize_source_name(" Orders ")`
10. `def calculate_completeness(valid_count, total_count):`
11. `calculate_completeness(95, 100)`
12. `calculate_completeness(valid_count=95, total_count=100)`
13. `def build_stage_name(source_name, prefix="staging"):`
14. `build_stage_name("orders")`
15. `build_stage_name(source_name="orders", prefix="raw")`
16. `def validate_record_count(record_count):`

## Section C — Predict the Output

1. Function returns `"PASS"` and caller prints result.
2. Function prints `"PASS"` but has no return.
3. `double(5)` returns `10`.
4. `classify_errors(0)` with default limit 5.
5. `classify_errors(3)` with default limit 5.
6. `classify_errors(8)` with default limit 5.
7. `classify_errors(error_count=8, review_limit=10)`.
8. `normalize_status(" ready ")`.
9. `normalize_source_name(" Orders ")`.
10. `calculate_completeness(95, 100)`.
11. `calculate_completeness(10, 0)`.
12. local `status = "LOCAL"` inside function.
13. module-level `status = "GLOBAL"` after local shadowing.
14. function without `return`.
15. `validate_record_count(None)`.
16. `validate_record_count(0)`.
17. `validate_record_count(120)`.
18. `validate_status("UNKNOWN")`.

## Section D — Complete the Function

1. Define `show_source_name`.
2. Define `validate_record_count`.
3. Define `normalize_status`.
4. Define `calculate_total`.
5. Define `calculate_completeness`.
6. Define `classify_error_count`.
7. Define `build_stage_name`.
8. Define `validate_status`.
9. Add a default review limit.
10. Add a keyword argument call.
11. Add a docstring.
12. Return instead of print.
13. Call a function and store the result.
14. Compose normalize then validate.
15. Add `main()`.
16. Add the `__name__` guard.
17. Avoid hidden global threshold.
18. Return `None` for undefined completeness.

## Section E — Fix the Mistake

1. `show_pipeline_name` without parentheses.
2. Function defined but never called.
3. `def validate_status(status)` missing colon.
4. Bad indentation in function body.
5. Function named `do_it`.
6. Parameter named `x`.
7. One function validates, transforms, writes, and controls workflow.
8. Calculation function only prints.
9. Returned value ignored.
10. One branch has no return.
11. One branch returns string and another returns number.
12. Local variable expected outside function.
13. Function depends on hidden `threshold`.
14. Function changes module-level state.
15. Local and module-level variable with same name misunderstood.
16. Positional arguments passed in wrong order.
17. Wrong keyword argument name.
18. `global` keyword used as shortcut.

## Section F — Return or Print?

Choose return, print, or both in orchestration.

1. Calculate total rows for later use.
2. Display final summary to learner.
3. Normalize a status.
4. Validate row count.
5. Show debug message during a lab.
6. Calculate completeness percentage.
7. Build staging label.
8. Reuse result in another function.
9. Produce validation outcome.
10. Explain result at script end.
11. Transformation function.
12. Orchestration `main()` summary.
13. Function meant for testing.
14. One-off display script.

## Section G — Scope Reasoning

1. Can caller access `local_total` created inside function?
2. What happens when local and module-level names match?
3. Why pass `review_limit` as parameter?
4. Why avoid hidden global threshold?
5. Does returning a value expose it to caller?
6. Does printing expose a reusable value?
7. Why can local scope reduce accidental changes?
8. Why can shadowing confuse beginners?
9. Why avoid `global` keyword here?
10. Where should orchestration variables live?
11. Where should transformation calculations live?
12. What should a function do with a needed external value?
13. Why inspect each return path?
14. Why test one small input first?

## Section H — Design a Function Interface

For each scenario, choose a function name, parameters, expected output, missing-value rule, and side effects.

1. Normalize status.
2. Normalize source name.
3. Validate row count.
4. Classify error count.
5. Calculate completeness.
6. Build staging label.
7. Validate negative amount.
8. Normalize country code.
9. Validate schema flag.
10. Classify freshness.
11. Convert text label to lowercase.
12. Return `None` for undefined ratio.
13. Combine normalize and validate.
14. Reuse validator across several sources.

## Section I — Mini Case Study

Use:

```text
raw_source_name
raw_status
record_count
error_count
valid_count
total_count
```

Design functions for:

1. normalize source
2. normalize status
3. validate status
4. validate row count
5. classify error count
6. calculate completeness
7. compose workflow
8. identify local variables
9. identify outputs
10. explain why no globals are required

## Answer Key

### Section A

1. Named reusable logic.
2. `def`.
3. Input name in definition.
4. Value supplied by caller.
5. Running a function.
6. Value sent back.
7. Sends value to caller.
8. `print()` displays; `return` sends back.
9. Names inside a function.
10. Module-level names conceptually.
11. Local name hides outer name.
12. Inputs are unclear.
13. Same input, same output, no hidden external change.
14. External action such as printing.
15. They document intent.
16. Name, inputs, output, and side effects.
17. Function name plus parameters.
18. Matched by order.
19. Matched by parameter name.
20. Fallback value in definition.
21. It shows business meaning.
22. Caller can rely on result.
23. Function returns `None` when no return exists.
24. Reusable validation decisions.
25. Reusable clean values.
26. Coordinating steps.
27. Connecting functions.
28. Easier review and testing.
29. Avoid duplicated inconsistent rules.
30. Hidden changes are risky.
31. Small inputs can be checked.
32. Missing values affect rules.

### Section B

Parameters are names inside `def`. Arguments are values in calls. Keyword arguments name the parameter explicitly; positional arguments rely on order.

### Section C

1. Prints `PASS`.
2. Caller receives `None`.
3. `10`.
4. `PASS`.
5. `REVIEW`.
6. `FAIL`.
7. `REVIEW`.
8. `READY`.
9. `orders`.
10. `95.0`.
11. `None`.
12. Local value is `LOCAL`.
13. Module-level value remains `GLOBAL`.
14. `None`.
15. `REVIEW`.
16. `FAIL`.
17. `PASS`.
18. `FAIL`.

### Section D

Good answers use `def`, clear parameters, a docstring for reusable rules, explicit `return`, simple branch logic, and a caller that stores returned values.

### Section E

Fix with parentheses, function calls, colons, indentation, descriptive names, focused jobs, `return`, complete return paths, consistent return types, explicit parameters, correct argument order, matching keyword names, and no `global` shortcut.

### Section F

Use `return` for 1, 3, 4, 6, 7, 8, 9, 11, and 13. Use `print()` in orchestration for 2, 5, 10, 12, and 14. Some scripts may return values from functions and print them in `main()`.

### Section G

Local variables stay inside functions. Returning values gives the caller reusable output. Shadowing can hide outer names. Passing inputs explicitly is clearer than hidden globals. The Day 054 style avoids `global` because parameters and returns are easier to reason about.

### Section H

Strong interfaces use names like `normalize_status(status)`, `validate_record_count(record_count)`, and `calculate_completeness(valid_count, total_count)`, return reusable values, document missing-value rules, and avoid side effects except intentional orchestration printing.

### Section I

A strong design uses small functions: normalize source, normalize status, validate status, validate record count, classify errors, and calculate completeness. Local variables live inside functions or `main()`. Outputs are returned values. No globals are required because every needed value is passed as a parameter.
