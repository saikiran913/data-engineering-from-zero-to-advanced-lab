# Practice Questions

## Section A — Concept Checks

1. What is iteration?
2. What is a loop?
3. What is an iterable?
4. What is a loop variable?
5. What is a loop body?
6. Why does indentation matter?
7. When is a `for` loop useful?
8. When is a `while` loop useful?
9. What does `range(5)` produce conceptually?
10. Why is the stop value excluded in `range()` important?
11. What is a counter?
12. What is an accumulator?
13. Why initialize counters before loops?
14. What does `+= 1` do?
15. What does `break` do?
16. What does `continue` do?
17. What is a termination condition?
18. What is an infinite loop?
19. Why can nested loops multiply work?
20. What is fail-fast validation?
21. What is full-scan validation?
22. Why should loop variables be descriptive?
23. Why can loops repeat mistakes?
24. Why should `while` loops be bounded for beginners?
25. How can Day 052 conditions be used inside loops?
26. What does `enumerate()` provide conceptually?
27. What is an off-by-one error?
28. What happens when a `for` loop receives an empty list?
29. Why should summaries usually print after a loop?
30. Why might Python loops be unsuitable for huge datasets?
31. Why should source values be preserved inside data-processing loops?
32. Why should nested loops be reviewed carefully?

## Section B — Predict the Output

1. `for n in range(3): print(n)`
2. `for n in range(1, 4): print(n)`
3. `for n in range(0, 6, 2): print(n)`
4. loop over `["A", "B"]`
5. loop over `"CSV"`
6. `pass_count` over `["PASS", "FAIL", "PASS"]`
7. total rows over `[10, 20, 30]`
8. while attempt from 1 to 3
9. break on first `FAIL`
10. continue on `"SKIP"`
11. nested 2 files x 2 checks
12. empty list loop
13. one-item list loop
14. `range(1, 1)`
15. `range(5, 6)`
16. review count in `["REVIEW", "PASS", "REVIEW"]`
17. fail count in `["PASS", "PASS"]`
18. total error count `[0, 2, 3]`
19. first item printed before break
20. summary printed after loop

## Section C — Complete the Loop

1. Print each file name.
2. Print each validation result.
3. Count `PASS`.
4. Count `REVIEW`.
5. Count `FAIL`.
6. Add row counts.
7. Print numbers 1 to 5.
8. Print three attempts with `while`.
9. Stop on `FAIL`.
10. Skip `"SKIP"`.
11. Print file positions with `enumerate()`.
12. Print each source label.
13. Count zero row counts.
14. Count non-zero row counts.
15. Print each character in `"CSV"`.
16. Nested loop over files and checks.
17. Summarize pass/review/fail counts.
18. Print a reason for each row-count decision.

## Section D — Fix the Mistake

1. `for file_name in files print(file_name)`
2. `while attempt <= 3 print(attempt)`
3. missing indentation after `for`
4. `for x in files:` with unclear name
5. counter initialized inside loop
6. counter never updated
7. accumulator reset each iteration
8. `while attempt <= 3:` without `attempt += 1`
9. `range(1, 5)` when 1 through 5 is needed
10. `break` before summary count completes
11. `continue` before required counter update
12. nested loop used by accident
13. `row_count > 0` when `row_count` may be `None`
14. string row count compared to integer
15. summary printed inside loop
16. source label overwritten
17. real filesystem traversal attempted in Day 053
18. external package added for simple loop

## Section E — Choose For or While

1. Process three known file names.
2. Print numbers 1 to 5.
3. Repeat until attempt reaches 3.
4. Count validation results.
5. Process known status labels.
6. Model a bounded retry check.
7. Iterate two partition labels.
8. Repeat while row count is missing conceptually.
9. Review every file in a hard-coded list.
10. Stop after maximum checks.
11. Print each character in a string.
12. Count batches with `range()`.
13. Continue while a flag remains true conceptually.
14. Summarize known outcomes.

## Section F — Count the Iterations

1. `range(3)`
2. `range(1, 4)`
3. `range(1, 6)`
4. `range(0, 10, 2)`
5. list with 3 files
6. tuple with 2 statuses
7. empty list
8. one-item list
9. while from 1 to 3 inclusive
10. while from 0 while `< 3`
11. nested 2 x 2
12. nested 3 x 4
13. nested 10 x 10
14. nested 100 x 100

## Section G — Validation Loops

1. Count `PASS` outcomes.
2. Count `REVIEW` outcomes.
3. Count `FAIL` outcomes.
4. Count sources with zero rows.
5. Sum all row counts.
6. Print file and decision.
7. Handle `None` row count conceptually.
8. Stop on first critical failure.
9. Full scan all validations.
10. Skip intentionally excluded source.
11. Count low-error sources.
12. Count high-error sources.
13. Print final summary.
14. Explain each outcome.

## Section H — Break or Continue?

1. Stop on first `FAIL`.
2. Skip `"SKIP"` rows.
3. Count every `FAIL`.
4. Ignore sample source.
5. Stop after critical schema failure.
6. Print every status.
7. Skip blank labels.
8. Summarize all outcomes.
9. Fail-fast validation.
10. Full-scan validation.
11. Skip optional checks.
12. Stop bounded retry loop.

## Section I — Mini Case Study

Use file names, row counts, and validation statuses.

Tasks:

1. iterate files
2. classify row counts
3. count pass/review/fail
4. handle zero rows
5. handle missing value conceptually
6. decide whether to break on critical failure
7. produce final summary
8. explain why full-scan and fail-fast differ

## Answer Key

### Section A

1. Repeating logic item by item.
2. Repeated code.
3. A value Python can visit item by item.
4. Name for current item.
5. Indented repeated code.
6. It defines what repeats.
7. Known collections.
8. Condition-driven repetition.
9. 0 through 4.
10. It affects boundaries.
11. Counts events.
12. Collects running totals.
13. So they do not reset.
14. Adds one.
15. Stops loop.
16. Skips to next iteration.
17. Rule that allows loop to end.
18. Loop that never stops.
19. Inner loop runs for each outer item.
20. Stop on critical issue.
21. Process every item.
22. Improves readability.
23. The same wrong logic repeats.
24. To avoid accidental infinite loops.
25. Classify each item.
26. Position and item.
27. Boundary counting mistake.
28. Body does not run.
29. It prevents repeated noisy summaries.
30. Large-scale tools may be better.
31. To keep lineage and meaning.
32. Work can grow quickly.

### Section B

1. `0`, `1`, `2`
2. `1`, `2`, `3`
3. `0`, `2`, `4`
4. `A`, then `B`
5. `C`, `S`, `V`
6. `2`
7. `60`
8. `1`, `2`, `3`
9. items before and including first `FAIL` condition handling
10. all except `"SKIP"`
11. `4`
12. no output
13. one output
14. zero iterations
15. one iteration
16. `2`
17. `0`
18. `5`
19. first item only if break follows it
20. one final summary

### Section C

Answers should use `for` loops for known iterables, initialize counters before loops, update counters inside the correct branch, and print summaries after the loop.

### Section D

Fix with colons, indentation, descriptive loop variables, initialization before loops, condition updates in `while`, correct `range()` stop values, careful `break`/`continue`, explicit `None` checks, type checks, and standard-library-only examples.

### Section E

Use `for` for 1, 2, 4, 5, 7, 9, 11, 12, and 14. Use `while` for 3, 6, 8, 10, and 13 when the condition-driven repetition is explicit and bounded.

### Section F

1. 3
2. 3
3. 5
4. 5
5. 3
6. 2
7. 0
8. 1
9. 3
10. 3
11. 4
12. 12
13. 100
14. 10,000

### Section G

Good answers should preserve each source value, apply Day 052 conditions inside the loop, count outcomes, print reasons, and choose full-scan or fail-fast deliberately.

### Section H

Use `break` for 1, 5, 9, and sometimes 12 through a condition. Use `continue` for 2, 4, 7, and 11. Use neither for 3, 6, 8, and 10 when every item must be processed.

### Section I

A strong answer uses a `for` loop over hard-coded labels, checks `None` before numeric comparison, treats zero rows as failure or review by rule, counts outcomes, prints a final summary, and explains that fail-fast stops early while full-scan gives complete results.
