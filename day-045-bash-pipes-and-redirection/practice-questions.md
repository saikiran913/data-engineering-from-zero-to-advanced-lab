# Practice Questions

## Section A - Concept Checks

1. What is stdin?
2. What is stdout?
3. What is stderr?
4. Why are stdout and stderr separate?
5. What does file descriptor `0` represent?
6. What does file descriptor `1` represent?
7. What does file descriptor `2` represent?
8. What does `|` do?
9. What does `>` do?
10. What does `>>` do?
11. What does `<` do conceptually?
12. What does `2>` do?
13. What does `2>>` do?
14. What does `2>&1` mean conceptually?
15. Why can `>` be risky?
16. Why should targets stay inside `practice-output/`?
17. What does `grep` do?
18. What does `wc -l` do?
19. Why is `sort | uniq` common?
20. What does `cut -d',' -f4` do?
21. Why is `cut` not a full CSV parser?
22. What does `tee` do?
23. Why should captured errors be inspected?
24. Why does pipeline command order matter?
25. Why test without redirection first?
26. Why should source files remain unchanged?

## Section B - Choose the Operator

Choose among `|`, `>`, `>>`, `<`, `2>`, and `2>>`.

1. Send output from `grep` into `wc`.
2. Save stdout to a new practice file.
3. Add stdout to the end of an existing notes file.
4. Send a file into stdin.
5. Save error output to a practice error file.
6. Append error output to an existing error file.
7. Connect `sort` to `uniq`.
8. Save warning lines to `practice-output/warnings.txt`.
9. Append a review note.
10. Count filtered lines.
11. Capture missing-file errors.
12. Append another missing-file error.
13. Send status values into `sort`.
14. Save a line count to a file.
15. Keep adding review messages to one notes file.
16. Separate stderr from stdout.
17. Read input through stdin.
18. Build a two-stage command chain.

## Section C - Build the Pipeline

1. Count `ERROR` lines.
2. Count `WARN` lines.
3. List unique statuses.
4. Count unique statuses.
5. Capture warnings to `practice-output/warnings.txt`.
6. Append a review note.
7. Save stderr from a missing file.
8. Inspect last log lines and filter `INFO`.
9. Filter before counting errors.
10. Extract order status column.
11. Sort extracted statuses.
12. List unique extracted statuses.
13. Show and save INFO lines with `tee`.
14. Save line count for orders.
15. Append another note to review notes.
16. Inspect saved errors.

## Section D - Predict the Result

1. `grep "ERROR" sample-data/pipeline_log.txt | wc -l`
2. `grep "CRITICAL" sample-data/pipeline_log.txt`
3. `sort sample-data/status_values.txt | uniq`
4. `uniq sample-data/status_values.txt | sort`
5. `cut -d',' -f4 sample-data/orders_sample.csv`
6. `wc -l sample-data/orders_sample.csv`
7. `echo "Reviewed" > practice-output/review.txt`
8. `echo "Again" >> practice-output/review.txt`
9. `cat sample-data/does-not-exist.txt 2> practice-output/errors.txt`
10. `grep "WARN" sample-data/pipeline_log.txt > practice-output/warnings.txt`
11. `grep "INFO" sample-data/pipeline_log.txt | tee practice-output/info.txt`
12. `command > practice-output/all.txt 2>&1`

## Section E - Fix the Mistake

1. A learner redirects into the same source file.
2. A learner uses `>` but wanted to keep old notes.
3. A learner uses `>>` forever without review.
4. A learner assumes empty stdout means success.
5. A learner ignores captured errors.
6. A learner combines stdout and stderr too early.
7. A learner uses `uniq` before sorting.
8. A learner uses unnecessary `cat`.
9. A learner treats `cut` as a full CSV parser.
10. A learner forgets the header row.
11. A learner searches for `error` but the log contains `ERROR`.
12. A learner forgets quotes around a path with spaces.
13. A learner targets the wrong directory.
14. A learner copies Bash redirection into PowerShell unchanged.
15. A learner uses one long pipeline without testing stages.
16. A learner does not inspect generated output.

## Section F - Safety Review

Classify each as safe, review first, or unsafe for Day 045.

1. Write warning lines to `practice-output/warnings.txt`.
2. Write sorted source content back into the same source file.
3. Append a note to `practice-output/review_notes.txt`.
4. Capture missing-file stderr into `practice-output/errors.txt`.
5. Use `tee` to write into a source CSV.
6. Run `grep` without redirection first.
7. Count lines in a sample CSV.
8. Use `cut` on a simple sample CSV and document limitations.
9. Combine stdout and stderr before inspecting either stream.
10. Keep all generated files inside `practice-output/`.

## Answer Key

### Section A

1. Standard input.
2. Standard output, or normal output.
3. Standard error, or error output.
4. So normal results and errors can be handled separately.
5. stdin.
6. stdout.
7. stderr.
8. Sends stdout from one command to stdin of another.
9. Redirects stdout and can overwrite.
10. Appends stdout.
11. Sends file content into stdin.
12. Redirects stderr and can overwrite.
13. Appends stderr.
14. Sends stderr to the same place as stdout.
15. It can replace existing content.
16. To protect source and project files.
17. Filters matching lines.
18. Counts lines.
19. `uniq` normally collapses adjacent duplicates.
20. Selects the fourth comma-delimited field.
21. Complex CSV quoting can break simple delimiter logic.
22. Displays output and writes it to a file.
23. Captured errors may show failure details.
24. Each stage receives output from the previous stage.
25. To confirm output before writing files.
26. Source data should remain reliable.

### Section B

1. `|`
2. `>`
3. `>>`
4. `<`
5. `2>`
6. `2>>`
7. `|`
8. `>`
9. `>>`
10. `|`
11. `2>`
12. `2>>`
13. `<` or direct file argument depending on command
14. `>`
15. `>>`
16. `2>`
17. `<`
18. `|`

### Section C Sample Answers

```bash
grep "ERROR" sample-data/pipeline_log.txt | wc -l
grep "WARN" sample-data/pipeline_log.txt | wc -l
sort sample-data/status_values.txt | uniq
sort sample-data/status_values.txt | uniq | wc -l
grep "WARN" sample-data/pipeline_log.txt > practice-output/warnings.txt
echo "Warnings reviewed" >> practice-output/review_notes.txt
cat sample-data/does-not-exist.txt 2> practice-output/errors.txt
tail sample-data/pipeline_log.txt | grep "INFO"
cut -d',' -f4 sample-data/orders_sample.csv | sort | uniq
grep "INFO" sample-data/pipeline_log.txt | tee practice-output/info_lines.txt
wc -l sample-data/orders_sample.csv > practice-output/order_line_count.txt
cat practice-output/errors.txt
```

### Section D

1. Counts matching error lines.
2. Produces no normal output if there are no matches.
3. Sorts statuses and collapses adjacent duplicates.
4. May leave non-adjacent duplicates before sorting.
5. Prints the fourth field, including the header.
6. Counts file lines, including the header.
7. Writes and can overwrite the review file.
8. Appends a line.
9. Captures stderr.
10. Saves warning lines and can overwrite target.
11. Displays and writes info lines.
12. Combines stdout and stderr.

### Section E

Use `practice-output/`, inspect first, avoid overwriting source files, use append intentionally, keep stdout and stderr separate when reviewing, sort before `uniq`, avoid unnecessary stages, remember `cut` limitations, quote paths, test each stage, and inspect generated output.

### Section F

1. Safe.
2. Unsafe.
3. Safe if reviewed.
4. Safe.
5. Unsafe.
6. Safe.
7. Safe.
8. Safe with caveat.
9. Review first.
10. Safe.

