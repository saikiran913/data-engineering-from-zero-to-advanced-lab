# Practice Questions

## Concept Checks

1. What is a syntax error? 2. Runtime error? 3. Logical error? 4. Exception? 5. Validation? 6. Why specific exception? 7. Why no bare except? 8. What does else do? 9. Finally concept? 10. Module? 11. Package? 12. Import? 13. Main guard? 14. Orchestration? 15. Fail-fast? 16. Fallback? 17. Why separate helpers? 18. Why retain raw value? 19. Why synthetic data? 20. Why read-only workflow?

## Choose the Handling

For invalid integer, absent key, short list, missing file, malformed JSON, blank amount, negative amount, and optional note: choose validation, specific exception, fallback, or fail-fast and explain why.

## Mini Case

Design a read-only CSV/JSON utility: validate required paths and keys, parse expected data, classify PASS/REVIEW/FAIL, keep reusable parser/validator/formatter modules, and use `main()` to print a summary.

## Answer Key

Validate known rules before risk, catch only known specific exceptions, use clear outcomes, place reusable code in focused modules, group related modules in a package, and protect orchestration with a main guard.
