# Practice Questions

## Concept Questions (1-40)

1. Define a function contract. 2. What is a parameter? 3. What is an argument? 4. Why expose dependencies? 5. Define deterministic. 6. Define pure. 7. Define side effect. 8. Define orchestration. 9. Define composition. 10. Define single responsibility. 11. What is parsing? 12. What is transformation? 13. What is validation? 14. Why preserve raw records? 15. What is a helper module? 16. What is a return value? 17. What is a return contract? 18. What is an optional parameter? 19. What is a required parameter? 20. Why use defaults? 21. Why avoid mutable defaults? 22. Why use keyword arguments? 23. What is hidden state? 24. Why avoid it? 25. Why separate I/O? 26. Why use new dictionaries? 27. What is idempotence? 28. Why direct-call test? 29. What makes a result consistent? 30. Why include a reason? 31. Why use PASS/REVIEW/FAIL? 32. Why keep modules focused? 33. Why avoid circular imports? 34. Why avoid wildcard imports? 35. Why use a main guard? 36. What is an input contract? 37. What is an output contract? 38. Why use specific exceptions? 39. Why stage debugging? 40. Why configuration-driven rules?

## Parameter Design (1-18)

1. Identify required input for `parse_amount`. 2. Add a `minimum_amount` default. 3. Call it with keywords. 4. Explain positional order. 5. Choose a safe default. 6. Fix `items=[]`. 7. Pass allowed statuses. 8. Pass a country mapping. 9. Identify a hidden threshold. 10. Remove a hidden threshold. 11. Spot too many unrelated parameters. 12. Group configuration logically. 13. Document optional `None`. 14. Select a useful default. 15. Explain keyword clarity. 16. Explain a required field list. 17. Explain why caller owns configuration. 18. Design a parser signature.

## Return Values (1-18)

1. Choose scalar for parsed amount. 2. Choose Boolean for simple presence. 3. Choose tuple for status/reason. 4. Choose dictionary for labeled result. 5. Unpack a tuple. 6. Read a dictionary status. 7. Document `None`. 8. Fix mixed string/dictionary return. 9. Explain caller safety. 10. Return invalid amount marker. 11. Return valid amount marker. 12. Return missing-field result. 13. Compare tuple/dictionary. 14. Explain one contract. 15. Identify implicit `None`. 16. Choose result keys. 17. Explain a reason field. 18. Design `validate_record` output.

## Pure or Impure? (1-18)

1. Uppercase text. 2. Print text. 3. Write CSV. 4. Read a global. 5. Return new dict. 6. Change input dict. 7. Parse float. 8. Send request. 9. Count a passed list. 10. Append to global list. 11. Format message. 12. Change random state. 13. Normalize twice. 14. Use current time. 15. Validate a passed record. 16. Open a file. 17. Return status dictionary. 18. Change module variable.

## Fix the Function (1-18)

1. Replace `errors=[]`. 2. Replace global minimum. 3. Return instead of print. 4. Add missing return branch. 5. Stop mutating raw record. 6. Split giant function. 7. Catch only conversion errors. 8. Remove file read from validator. 9. Move display from validator. 10. Move validation from formatter. 11. Add explicit status keys. 12. Remove wildcard import. 13. Remove path hack. 14. Add main guard. 15. Rename vague `process`. 16. Parameterize statuses. 17. Parameterize threshold. 18. Preserve invalid input reason.

## Return Contract Choices (1-16)

1. Amount parse. 2. Date parse. 3. Required field check. 4. Status check. 5. Full record validation. 6. Formatter. 7. Summary count. 8. Optional country. 9. Missing record ID. 10. Negative amount. 11. Unknown status. 12. Invalid date. 13. Normalizer. 14. Boolean predicate. 15. Tuple caller. 16. Dictionary caller.

## Responsibility Separation (1-16)

1. Who reads input? 2. Who parses? 3. Who normalizes? 4. Who validates? 5. Who formats? 6. Who prints? 7. Who counts? 8. Who owns config? 9. Who catches parse errors? 10. Who preserves raw data? 11. Who writes output conceptually? 12. Who builds messages? 13. Who coordinates stages? 14. Who imports helpers? 15. Who owns business rules? 16. Who tests pure helpers?

## Composition (1-14)

1. Order parser/transformer. 2. Order validator/formatter. 3. Inspect after parse. 4. Inspect after normalize. 5. Handle parse None. 6. Propagate record ID. 7. Pass allowed statuses. 8. Pass minimum amount. 9. Format validation result. 10. Count results. 11. Debug one stage. 12. Compose two functions. 13. Compose record workflow. 14. Explain isolated failure.

## Module Design (1-14)

1. Place `parse_amount`. 2. Place `normalize_status`. 3. Place `validate_amount`. 4. Place `format_summary`. 5. Place `main`. 6. Avoid circular import. 7. Avoid wildcard import. 8. Avoid top-level app run. 9. Explain package init. 10. Explain explicit import. 11. Explain module boundary. 12. Explain parser dependency. 13. Explain formatter boundary. 14. Explain reuse.

## Mini Case

Design a reusable chain for a raw record containing ID, amount, date, and status. State required fields, allowed statuses, minimum amount, each function's parameters and return contract, the PASS/REVIEW/FAIL policy, and how raw input remains unchanged.

## Answer Key

**Concept:** A contract documents inputs, outputs, failure behaviour, and side effects. Parameters make dependencies visible; arguments supply them. Pure deterministic functions return results without external changes. Parsing converts, transformation standardizes, validation applies rules, formatting presents results, and orchestration connects stages. Preserve raw data, use focused modules, specific exceptions, configuration, a main guard, and direct-call tests.

**Parameters:** Make raw input required; use defaults such as `minimum_amount=0`; call configurable rules by keyword; use `None` rather than mutable defaults; pass statuses, mappings, and thresholds rather than reading globals.

**Returns:** Parsers may return a scalar or documented `None`; simple predicates return Boolean; detailed validation can consistently return `{"status": ..., "reason": ...}`; never mix normal return shapes.

**Purity:** 1, 5, 7, 9, 11, 13, 15, and 17 are pure when they use only passed values. The others are impure because they print, perform I/O, read/change outside state, or mutate input.

**Fixes:** Apply the named fix in each prompt: use `None`, parameters, returns, complete branches, copied dictionaries, focused helpers, specific exceptions, module boundaries, explicit imports, and a main guard.

**Contracts and separation:** Parsers own conversion; transforms own normalization; validators own rules; formatters own display; `app.py` owns orchestration and printing. Use a documented scalar/Boolean/tuple/dictionary appropriate to each prompt, with dictionary status/reason for full validation.

**Composition and modules:** Use `parse → normalize → validate → format`, inspect between stages, propagate IDs/configuration explicitly, and place functions in parsers, transforms, validators, formatters, and app respectively. Test helpers directly.

**Mini case:** Parse amount/date to value or `None`, normalize status, validate required fields/amount/status with the common status/reason dictionary, format only after validation, and create clean records with copies.
