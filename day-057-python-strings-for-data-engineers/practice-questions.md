# Practice Questions

## A. Concept Checks

1. What is a string? 2. Are strings mutable? 3. What does `strip()` remove? 4. What does `lstrip()` remove? 5. What does `rstrip()` remove? 6. What is an empty string? 7. What is whitespace-only text? 8. How does `None` differ? 9. Why save cleaning output? 10. Why preserve leading zeros? 11. What is canonical value? 12. What is raw value? 13. What is a delimiter? 14. What does `split()` return? 15. Why check field count? 16. What does `join()` do? 17. What does `replace()` do? 18. What does `startswith()` check? 19. What does `endswith()` check? 20. What does `in` check? 21. What does `find()` return if absent? 22. Why use f-strings? 23. Does display formatting change data? 24. What is idempotency? 25. Why standardise status? 26. Why not over-clean free text? 27. Why is simple split limited? 28. What is case normalisation? 29. Why validate before indexing? 30. Why keep raw and canonical values? 31. What is a controlled code? 32. Why document maps? 33. Why separate blank and missing? 34. Why use simple examples first?

## B. Predict the Cleaned Value

Apply suitable stated methods: 1. `" ready ".strip()`; 2. `" uk ".strip().upper()`; 3. `"A-B".replace("-", "_")`; 4. `"   ".strip()`; 5. `"Done".lower()`; 6. `"orders.csv".endswith(".csv")`; 7. `"ORD-1"[:3]`; 8. `"ORD-1"[0]`; 9. `"a|b|c".split("|")`; 10. `"|".join(["a", "b"])`; 11. `"ERROR" in "ERROR: retry"`; 12. `"x".find("z")`; 13. `"  file.csv".strip()`; 14. `"UK".lower()`; 15. `"completed".upper()`; 16. `"00125"`; 17. `"A  B".strip()`; 18. `"orders_1.csv".startswith("orders_")`; 19. `"x".replace("x", "y")`; 20. `"".strip()`.

## C. Choose the Method

Choose `strip`, `lower`, `upper`, `replace`, `split`, `join`, `startswith`, or `endswith`: 1. remove edge spaces; 2. canonical status; 3. compare lower-case code; 4. change known separator; 5. parse pipe parts; 6. rebuild pipe record; 7. validate `orders_` prefix; 8. validate `.csv`; 9. clean user-entered code; 10. normalise country code; 11. split fixed text; 12. join cleaned fields; 13. check archive prefix; 14. check extension; 15. replace technical dash; 16. trim input; 17. standardise code; 18. parse three fields; 19. rebuild diagnostic key; 20. check batch suffix.

## D. Predict Split Output

Predict `value.split("|")`: 1. `a|b`; 2. `a||b`; 3. `a|`; 4. `|a`; 5. ``; 6. `a`; 7. `a|b|c`; 8. ` a | b `; 9. `ORD-1|C-1|PASS`; 10. `ORD-1||PASS`; 11. `a|||b`; 12. `|`; 13. `x|y|`; 14. `x||`; 15. `one|two|three|four`; 16. `  a|b  `.

## E. Safe or Unsafe Cleaning?

Decide and explain: 1. strip status; 2. remove every name space; 3. upper country code; 4. convert `00125` to int; 5. replace known technical dash; 6. rewrite free-text punctuation; 7. strip filename edges; 8. lower case-sensitive ID; 9. split quoted complex record; 10. check count before indexing; 11. discard raw status; 12. retain raw and canonical; 13. default missing status silently; 14. map approved synonym; 15. invent synonym; 16. run cleaning twice.

## F. Raw Versus Canonical

For each, give raw and canonical policy: 1. `" done "`; 2. `"UK"`; 3. `"uk"`; 4. `"00125"`; 5. `"Name, Inc."`; 6. `None`; 7. `"   "`; 8. `"completed"`; 9. `"Complete"`; 10. `"daily-orders"`; 11. `"orders.csv"`; 12. `"archive.CSV"`; 13. `"ORD-1|C-1|PASS"`; 14. optional note text.

## G. Fix the Parsing Logic

Fix: 1. index before count; 2. wrong delimiter; 3. ignore empty ID; 4. discard raw record; 5. split complex quoted text; 6. strip only whole record; 7. no individual trim; 8. assume exactly three fields; 9. convert invalid amount immediately; 10. join with comma instead of pipe; 11. no `None` check; 12. treat blank as valid status; 13. map before case clean; 14. hide unknown status.

## H. Standardisation Design

For each scenario state input rule, canonical output, and validation: 1. statuses; 2. country codes; 3. filename extension; 4. approved status synonyms; 5. missing status; 6. blank status; 7. leading-zero customer ID; 8. free-text note; 9. pipe order record; 10. technical source name; 11. unknown code; 12. optional review note; 13. batch filename prefix; 14. internal-space location name.

## I. Mini Case Study

Use raw source name `" Orders_Source "`, raw status `" done "`, raw record `"ORD-001|CUST-001| completed "`, and optional review note `None`. Distinguish missing and blank, strip controlled values, canonicalise status, preserve ID formatting, split and count fields, detect an empty field, format a readable result, state which raw values to retain, and explain why split is not a general CSV parser.

## Answer Key

A: strings are immutable text; `strip` removes edge whitespace; empty, whitespace-only, and `None` differ; save method results; preserve identifier formatting; canonical means approved standard; split makes parts and join recombines them; validate count before indexing; `find` returns `-1` when absent; f-strings format readable output without changing underlying data; idempotent rules stabilise on repeat; controlled codes can be standardised but free text needs caution; simple split cannot safely handle all structured data.

B: 1 `ready`; 2 `UK`; 3 `A_B`; 4 empty text; 5 `done`; 6 true; 7 `ORD`; 8 `O`; 9 list `a,b,c`; 10 `a|b`; 11 true; 12 `-1`; 13 `file.csv`; 14 `uk`; 15 `COMPLETED`; 16 unchanged; 17 `A  B`; 18 true; 19 `y`; 20 empty text.

C: 1, 9, 16 strip; 2, 10, 17 upper; 3 lower; 4, 15 replace; 5, 11, 18 split; 6, 12, 19 join; 7, 13 startswith; 8, 14, 20 endswith.

D: split keeps empty fields: `a|b` gives two parts, `a||b` gives `a`, empty, `b`; edge delimiters create edge empty parts. An empty input gives one empty part; no delimiter gives one unchanged part. Whitespace remains until each part is stripped.

E: safe when rule preserves controlled meaning: 1, 3, 5, 7, 10, 12, 14, 16. Unsafe or risky: 2, 4, 6, 8, 9, 11, 13, 15.

F: retain raw where traceability matters; canonicalise controlled status/country/extension values with documented rules; keep `00125` unchanged; keep free text minimally changed; represent `None` and blank distinctly; validate records before any parsed canonical output.

G: validate `len(parts)` before index, use agreed delimiter, check blank required fields, retain raw text, keep complex quoting for a proper parser, strip parts individually, validate before numeric conversion, rejoin with the agreed delimiter, check `None`, and surface unknown values for review.

H and I: use the pipeline `None → strip → blank → normalise → validate`; preserve raw source values and identifier formatting; use approved maps only; for the case, `done` maps to `COMPLETED`, the record has three fields after split, and `ORD-001` remains text. Split is only for the controlled pipe contract, not quoted CSV-style text.
