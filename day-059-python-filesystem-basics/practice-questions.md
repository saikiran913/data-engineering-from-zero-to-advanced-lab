# Practice Questions

## A. Concept Checks

1. What is a filesystem? 2. What is a Path? 3. What is cwd? 4. What is relative? 5. What is absolute? 6. Why compose with `/`? 7. What checks existence? 8. What checks file? 9. What checks directory? 10. What is suffix? 11. What is stem? 12. What is parent? 13. Why sort listing? 14. Why use `with`? 15. Why UTF-8? 16. What is CSV? 17. What is header? 18. Why not split comma? 19. What does DictReader return? 20. What type are CSV fields? 21. What is JSON? 22. JSON object becomes what? 23. JSON array becomes what? 24. JSON null becomes what? 25. Why validate root type? 26. Why validate keys? 27. Why derive from `__file__`? 28. Why read-only? 29. Why no recursion? 30. Why no personal absolute path? 31. Why does suffix not prove format? 32. What is a parser? 33. What is a file handle? 34. What is encoding? 35. What is a required file? 36. What is structured file?

## B. Path Reasoning

Answer for 18 cases: cwd-relative path, script-relative path, child composition, parent selection, missing file, directory target, personal path, changed terminal folder, and portable separator choice.

## C. Predict Path Property

For `Path("sample-data/orders_sample.csv")`, predict `.name`, `.stem`, `.suffix`, `.parent`, `.exists()`, `.is_file()`, and repeat for 16 related examples.

## D. Safe or Unsafe Actions

Classify 16 actions: inspect, sorted list, read UTF-8 text, DictReader, json.load, delete, rename, append, overwrite, recursive scan, production directory, and external parser packages.

## E. Choose Parser

Choose text, CSV, or JSON for 18 examples including notes, quoted-comma orders, config object, array text, malformed suffix, and plain log text.

## F. CSV Reasoning

Answer 16 questions about headers, quoted commas, blanks, text typing, DictReader keys, required columns, and why numeric conversion is explicit.

## G. JSON Reasoning

Answer 16 questions about objects, arrays, null, true/false, root validation, required keys, optional lookups, and nested shapes.

## H. Fix the Code

Fix 18 scenarios: string-concatenated paths, cwd dependence, no existence check, directory opened as file, missing encoding, naive CSV split, missing header validation, JSON unparsed, assumed dict root, and unsafe write action.

## I. Mini Case Study

Given a Day folder with `sample-data/`, text notes, one CSV, and JSON config: derive base from `__file__`, verify directory/files, list deterministically, read text safely, parse CSV with DictReader, explain string typing, load JSON, validate dict root and required keys, and explain why no write/delete step is needed.

## Answer Key

Use `Path` for portable composition, derive bundled data from `__file__`, and validate existence/type before reading. Text uses UTF-8 context-managed reading, CSV uses `csv.DictReader`, and JSON uses `json.load`. CSV fields begin as strings; JSON object/array/null map to dict/list/None. Sort listing output, validate required headers/keys, and keep the workflow read-only.
