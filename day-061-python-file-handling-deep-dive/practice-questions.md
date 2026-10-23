# Practice Questions

## 1. Foundations

1. What does a file path identify?
2. Why use `Path` instead of a hard-coded absolute path?
3. What does `with` do for a file?
4. Why specify UTF-8?
5. Which mode reads a file?
6. Which mode can replace a file?
7. What is an input file?
8. What is generated output?
9. Why keep them separate?
10. What is a file handle?

## 2. Text Files

1. When is `.read()` convenient?
2. When is line iteration preferable?
3. What does `.strip()` remove?
4. What does `.rstrip("\n")` preserve?
5. How can you identify a blank line?
6. Why use `enumerate`?
7. Why is a final newline useful?
8. What can append mode duplicate?
9. Where should clean notes be written?
10. What should be checked after writing?

## 3. CSV

1. Why not use `split(",")` for CSV?
2. What does `DictReader` use as keys?
3. Why use `newline=""`?
4. Are CSV amounts numeric automatically?
5. What does `DictWriter` need?
6. Why make fields explicit?
7. What is a required column?
8. How should a blank order ID be handled?
9. What status could identify an unknown value?
10. Why keep a validation reason?

## 4. JSON

1. What Python module parses JSON?
2. What does `json.load` accept?
3. What does `json.dump` do?
4. What exception reports malformed JSON?
5. Does valid JSON guarantee valid configuration?
6. Why use `indent=2`?
7. What is a JSON object in Python?
8. What should you validate after parsing?
9. Why not build JSON with string concatenation?
10. Where should a generated summary be stored?

## 5. Errors and Safety

1. How should a missing source be reported?
2. What is quarantine?
3. Why avoid broad `except Exception`?
4. What is row-count reconciliation?
5. Why retain source filename?
6. What should happen to a malformed config?
7. Why should bad rows not disappear silently?
8. What is the risk of `w` mode?
9. What is the risk of `a` mode?
10. What proves an input stayed unchanged?

## Answer Key

**Foundations:** 1 location; 2 portable paths; 3 closes safely; 4 consistent text decoding; 5 `r`; 6 `w`; 7 read-only source; 8 pipeline-created result; 9 prevents accidental overwrite; 10 opened-file object.

**Text:** 1 small files; 2 large/line processing; 3 outer whitespace; 4 content spaces except newline; 5 `not line.strip()`; 6 row numbers; 7 readable line format; 8 rerun records; 9 `output/`; 10 content and count.

**CSV:** 1 quoted commas exist; 2 header names; 3 correct CSV line handling; 4 no; 5 fieldnames; 6 stable schema; 7 expected header; 8 FAIL; 9 REVIEW; 10 explain the decision.

**JSON:** 1 `json`; 2 an open file; 3 writes JSON; 4 `JSONDecodeError`; 5 no; 6 readability; 7 dictionary; 8 keys/types; 9 escaping is hard; 10 `output/`.

**Safety:** 1 path and clear error; 2 isolate bad input; 3 it hides causes; 4 compare counts; 5 lineage; 6 report and stop safely; 7 investigation needs evidence; 8 replacement; 9 duplicates; 10 a matching hash.
