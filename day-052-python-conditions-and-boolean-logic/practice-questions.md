# Practice Questions

## Section A — Concept Checks

1. What does a condition evaluate to?
2. What does `==` mean?
3. What does `=` mean?
4. What does `!=` mean?
5. What does `>=` mean?
6. What does `<=` mean?
7. What is an `if` branch?
8. What does `elif` do?
9. What does `else` do?
10. Why does indentation matter?
11. What does `and` require?
12. What does `or` require?
13. What does `not` do?
14. Why can rule order matter?
15. What is a fallback branch?
16. Why should `None` be checked explicitly?
17. What does `is None` check?
18. What does `is not None` check?
19. What is a truthy value?
20. What is a falsy value?
21. Why is `if not row_count` risky?
22. Why is `bool("False")` surprising?
23. What is a boundary value?
24. Why test exact thresholds?
25. What is an unreachable branch?
26. What is an overlapping condition?
27. Why are named conditions useful?
28. Why should validation outcomes include reasons?
29. Why can correct syntax still produce wrong business logic?
30. What does `in` check?
31. What does `not in` check?
32. Why does Day 051 type awareness matter before comparisons?

## Section B — Predict True or False

1. `100 == 100`
2. `100 == "100"`
3. `100 != "100"`
4. `5 > 3`
5. `5 < 3`
6. `5 >= 5`
7. `4 <= 5`
8. `"READY" == "READY"`
9. `"ready" == "READY"`
10. `None is None`
11. `0 is None`
12. `"" == ""`
13. `True and True`
14. `True and False`
15. `True or False`
16. `False or False`
17. `not True`
18. `not False`
19. `"READY" in ("READY", "RETRY")`
20. `"FAILED" not in ("READY", "RETRY")`

## Section C — Predict the Branch

1. `record_count = 10`; if `record_count > 0` then?
2. `record_count = 0`; if `record_count > 0` else?
3. `error_count = 0`; PASS/REVIEW/FAIL threshold.
4. `error_count = 3`; PASS/REVIEW/FAIL threshold.
5. `error_count = 6`; PASS/REVIEW/FAIL threshold.
6. `status = "READY"` with allowlist.
7. `status = "PAUSED"` with allowlist fallback.
8. `row_count = None` with `is None`.
9. `amount = -1` with negative check.
10. `amount = 0` with zero review check.
11. `schema_valid = False` in required checks.
12. `is_fresh = False` in required checks.
13. `completeness_pct = 99.0` with `>= 99.0`.
14. `completeness_pct = 98.9` with `>= 99.0`.
15. `has_errors = False`; `not has_errors`.
16. `error_count = 120` with severe rule first.
17. `error_count = 120` with broad rule first.
18. `source_status = "UNKNOWN"` with `else`.

## Section D — Fix the Syntax

1. `if record_count > 0 print("PASS")`
2. `if record_count > 0`
3. `if record_count > 0:\nprint("PASS")`
4. `else status == "FAIL":`
5. `elif:`
6. `if status = "READY":`
7. `if status == "READY"`
8. `if row_count is None print("missing")`
9. `if not has_errors\n    print("PASS")`
10. `if status in "READY", "RETRY":`
11. `if (schema_valid and is_fresh:`
12. `if status == "READY":\n  print("A")\n    print("B")`
13. `if row_count > 0:\nprint("rows")`
14. `if status == "READY":\nelse:`
15. `if True\n    print("yes")`
16. `if source_status == "READY": print("ok"` 

## Section E — Fix the Business Logic

1. `if error_count > 0` before `elif error_count > 100`.
2. `if not row_count` when `0` and `None` differ.
3. `if status == "READY" or "RETRY"`.
4. `if status == "READY" and status == "RETRY"`.
5. `if row_count > 0` when row_count may be `None`.
6. `if bool("False")` for a text flag.
7. `if completeness_pct > 99.0` when exact 99.0 should pass.
8. No `else` for unsupported status.
9. `PASS` printed without reason.
10. One long condition with five checks.
11. `elif` used for independent null-rate and duplicate-rate checks.
12. Separate `if`s used for mutually exclusive PASS/REVIEW/FAIL.
13. Numeric string compared to integer.
14. Missing schema rule ignored.
15. `not` used on entire expression instead of one condition.
16. Review threshold overlaps fail threshold without clear order.

## Section F — Choose `and`, `or`, or `not`

1. Has rows and schema is valid.
2. Status is READY or RETRY.
3. No errors.
4. Not fresh.
5. Schema valid and source fresh.
6. Status failed or cancelled.
7. Amount is not negative.
8. Required column present and not blank.
9. Either null rate high or duplicate count high.
10. No review note.
11. Has rows and no errors.
12. Source is late or status is held.
13. Not in blocklist.
14. Completeness ok and error count low.
15. Missing row count or zero rows.
16. Not schema valid.

## Section G — Boundary Testing

1. PASS at `error_count == 0`; test `0`.
2. REVIEW at `1 <= error_count <= 5`; test `1`.
3. REVIEW at `1 <= error_count <= 5`; test `5`.
4. FAIL above `5`; test `6`.
5. Completeness must be at least `99.0`; test `98.9`.
6. Completeness must be at least `99.0`; test `99.0`.
7. Amount must not be negative; test `-1`.
8. Amount must not be negative; test `0`.
9. Row count must be positive; test `0`.
10. Row count must be positive; test `1`.
11. Error count severe above `100`; test `100`.
12. Error count severe above `100`; test `101`.

## Section H — Validation Design

For each rule, write a named condition, decision, and reason.

1. Source must have rows.
2. Row count is missing.
3. Schema must be valid.
4. Source must be fresh.
5. Error count must be zero for PASS.
6. Error count from 1 to 5 needs REVIEW.
7. Error count above 5 is FAIL.
8. Status must be READY or RETRY.
9. Status CANCELLED is FAIL.
10. Amount below zero is FAIL.
11. Completeness below 99.0 is REVIEW.
12. Required country code is blank.

## Section I — Mini Case Study

Use:

```text
record_count
error_count
null_rate
schema_valid
is_fresh
source_status
```

Tasks:

1. define a PASS rule
2. define a REVIEW rule
3. define a FAIL rule
4. handle missing `record_count`
5. handle unsupported `source_status`
6. order rules safely
7. test boundary values
8. explain each outcome

## Answer Key

### Section A

1. `True` or `False`.
2. Equality comparison.
3. Assignment.
4. Not equal.
5. Greater than or equal.
6. Less than or equal.
7. Code path under an `if`.
8. Checks another condition.
9. Handles fallback.
10. It defines blocks.
11. Both true.
12. At least one true.
13. Reverses a Boolean.
14. Earlier branches can capture values.
15. Final default path.
16. Missing is not the same as zero or false.
17. Whether value is `None`.
18. Whether value is present.
19. Behaves like true.
20. Behaves like false.
21. It can mix zero and missing.
22. Non-empty strings are truthy.
23. A threshold value.
24. To catch `>` versus `>=` mistakes.
25. A branch that cannot run.
26. Conditions that can both match.
27. They make rules readable.
28. Reasons help debugging.
29. Business rule may be wrong.
30. Membership in a group.
31. Absence from a group.
32. Wrong types can break or mislead comparisons.

### Section B

1. True
2. False
3. True
4. True
5. False
6. True
7. True
8. True
9. False
10. True
11. False
12. True
13. True
14. False
15. True
16. False
17. False
18. True
19. True
20. True

### Section C

1. true branch
2. else branch
3. PASS
4. REVIEW
5. FAIL
6. PASS
7. fallback REVIEW
8. missing branch
9. FAIL
10. REVIEW
11. FAIL or REVIEW depending rule
12. REVIEW
13. PASS
14. REVIEW
15. True condition
16. FAIL
17. REVIEW bug
18. fallback branch

### Section D

Add colons, indentation, valid `elif` conditions, `==` for comparisons, balanced parentheses/quotes, and valid membership syntax such as `status in ("READY", "RETRY")`.

### Section E

Use severe rules first, explicit `None` and zero checks, proper `or` syntax, membership checks, boundary-inclusive operators, fallback branches, named conditions, and separate independent checks only when multiple outcomes are intended.

### Section F

1. `and`
2. `or`
3. `not`
4. `not`
5. `and`
6. `or`
7. `not`
8. `and`
9. `or`
10. `is None`
11. `and` plus `not`
12. `or`
13. `not in`
14. `and`
15. `or`
16. `not`

### Section G

1. PASS
2. REVIEW
3. REVIEW
4. FAIL
5. REVIEW
6. PASS
7. FAIL
8. PASS or REVIEW depending business rule
9. FAIL
10. PASS
11. not severe if rule is `> 100`
12. severe FAIL

### Section H

Answers should use clear names such as `has_rows`, `row_count_missing`, `schema_is_valid`, `is_source_fresh`, `has_no_errors`, `has_low_errors`, `status_allowed`, `status_blocked`, `amount_is_negative`, and should include a decision plus a plain reason.

### Section I

A safe answer checks missing values first, checks severe fail states before review states, uses named conditions, treats unsupported statuses as review or fail, tests thresholds such as `0`, `1`, `5`, `6`, `99.0`, and explains every outcome.
