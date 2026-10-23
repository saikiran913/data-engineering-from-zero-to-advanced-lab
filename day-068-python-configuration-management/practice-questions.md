# Practice Questions

Use this lesson's teaching contract: **code defaults < config file < approved environment overrides**. Unless stated otherwise, environment inputs below are simulated in memory. Try each section before reading its matching answer key.

## Section 1: Concepts (25)

1. What is configuration?
2. How is configuration different from a source record?
3. Why avoid scattering a batch-size constant across functions?
4. Name four configuration sources taught today.
5. What is a safe default?
6. Which kind of setting should not receive an insecure hard-coded fallback?
7. What does `os.getenv("DAY068_X")` return when X is absent?
8. How does `os.environ["DAY068_X"]` differ when absent?
9. What type are environment-variable values?
10. Why is `bool("false")` wrong for configuration parsing?
11. What is a config file?
12. What does `json.load()` return for a JSON object root?
13. Is valid JSON syntax enough to trust the settings?
14. What does `ConfigParser.read()` return when nothing is read?
15. What do INI `getint()` and `getboolean()` do?
16. Why validate after merging?
17. What is precedence?
18. Does an absent override erase a file value?
19. Is a present empty string the same as an absent value?
20. Why use an allowlist for environment names?
21. What is a required setting?
22. Is every required setting a secret?
23. What is a pure configuration merge function?
24. Why pass validated config into a processing function?
25. Does Python automatically load `.env` files?

## Section 2: Identify the Source (10)

For each, identify the source and whether it is automatically typed as described.

1. `batch_size = 100` in a Python defaults mapping.
2. `DAY068_BATCH_SIZE="25"` supplied to a process.
3. `"enabled": true` in bundled JSON.
4. `enabled = yes` under `[pipeline]` in INI.
5. `mode="validation"` in a Python defaults mapping.
6. `"allowed_statuses": ["READY"]` in JSON.
7. `max_retries = 2` in INI.
8. A simulated dictionary entry `{"DAY068_ENABLED": "false"}`.
9. A source row `{"status": "READY"}`.
10. A fallback passed as `os.getenv("DAY068_MODE", "development")`.

## Section 3: Environment Types and Boolean Conversion (12)

Use the lesson parser: true/1/yes → True; false/0/no → False, case-insensitive after trimming; anything else is rejected.

1. What is the raw type of env `"25"`?
2. What does `int("25")` produce?
3. What does `bool("false")` produce in Python?
4. Parse `"false"` correctly.
5. Parse `"0"` correctly.
6. Parse `" YES "` correctly.
7. Parse `"No"` correctly.
8. Parse `"perhaps"` correctly.
9. What does missing `os.getenv("DAY068_UNKNOWN")` yield?
10. Is env `""` missing or present?
11. How should required source name `"   "` be handled?
12. Why reject Python `True` as a batch size even though `int(True) == 1`?

## Section 4: Safe Default or Required? (10)

Choose a documented optional default or require an explicit value; give a brief reason.

1. Synthetic demo batch size.
2. Synthetic optional debug flag.
3. Source name needed to identify a batch.
4. Real service token, if an integration actually needs one.
5. Synthetic demo mode.
6. Optional max retries.
7. Explicit batch override `"0"`.
8. Explicit enabled override `"perhaps"`.
9. Blank required source name.
10. Unknown status format choice when only known formats are supported.

## Section 5: Precedence (12)

Defaults: size=100, mode=development, enabled=False. File: size=50, mode=validation, enabled=True. Later approved environment values win. Give the final value and type or explain the error.

1. No environment values: size?
2. No environment values: mode?
3. No environment values: enabled?
4. Env size `"25"`: size?
5. Env enabled `"false"`: enabled?
6. Env mode `"production"`: mode?
7. Env size absent: does file size remain?
8. Env size `""`: use file size or reject?
9. Env size `"0"`: use default or reject?
10. Env enabled `"maybe"`: use file value or reject?
11. Env includes unknown `DAY068_OTHER`: does it override a known key under an allowlist?
12. File omits mode and env omits mode: mode?

## Section 6: Parsing and Validation Fixes (10)

State the issue and a fix.

1. `bool(os.getenv("DAY068_ENABLED", "false"))`
2. `batch_size = os.getenv("DAY068_BATCH_SIZE")` then numeric comparison.
3. `batch_size = int(raw)` with no positive bound.
4. `isinstance(True, int)` accepted as a size.
5. JSON loaded, then `config["source_name"]` without root-shape check.
6. INI `parser.read(path)` result ignored.
7. INI `parser.get("pipeline", "enabled")` used directly in `if`.
8. `source_name="   "` accepted.
9. Mode accepts any non-empty string.
10. `except Exception: return defaults` after a bad explicit override.

## Section 7: Safe or Unsafe? (10)

Classify and explain briefly.

1. Put a real token in a public JSON lesson file.
2. Print `dict(os.environ)` while debugging.
3. Report `batch_size must be positive` without its raw value.
4. Use a fake, non-secret `source_name=demo_orders`.
5. Log a full future config dictionary.
6. Keep real `.env` out of Git if a separate project uses one.
7. Assume a local `.env` automatically populates `os.getenv`.
8. Pass a simulated mapping into a pure merge function.
9. Hard-code an insecure token fallback for a real integration.
10. Name a missing sensitive setting in an error without showing its value.

## Section 8: Integrated Case

Defaults: `batch_size=100`, `mode=development`, `enabled=False`. A synthetic JSON object contains `source_name=demo_orders`, `batch_size=50`, `mode=validation`, `enabled=True`, and `allowed_statuses=[READY, COMPLETED, REVIEW]`. Simulated environment input contains `DAY068_BATCH_SIZE="25"` and `DAY068_ENABLED="false"`.

1. Name the three sources.
2. State the priority order.
3. What is the final batch size and type?
4. What is the final enabled value and type?
5. Which file-only setting remains unchanged?
6. What source-name check is required?
7. What numeric bound should the size satisfy?
8. Should a secret or whole settings dictionary be printed?
9. How should a reusable processing function receive these values?
10. What should happen if the explicit size override is `"not-a-number"`?
11. Why is the case deterministic without relying on the real process environment?

## Answer Key

### Section 1

1. Named values controlling behavior. 2. A record is business input, not a setting. 3. One contract avoids inconsistent changes. 4. Code defaults, environment, JSON, INI. 5. Documented non-sensitive fallback for optional behavior. 6. Secrets or security-critical settings. 7. `None`. 8. It raises `KeyError`. 9. Strings. 10. Any non-empty string is truthy. 11. A document containing settings. 12. A Python dictionary. 13. No; check shape and rules. 14. An empty list. 15. Convert INI text to int and bool. 16. Later sources may introduce invalid values. 17. Priority between sources. 18. No. 19. No; it is present and needs a policy. 20. To restrict which settings can change. 21. A value needed to proceed. 22. No, e.g. `source_name`. 23. One with explicit inputs and no hidden reads/writes. 24. It makes behavior testable and type expectations clear. 25. No.

### Section 2

1. Code default; integer already. 2. Environment; string, conversion needed. 3. JSON; becomes Python bool. 4. INI; text, use `getboolean`. 5. Code default; string already. 6. JSON; becomes Python list. 7. INI; text, use `getint`. 8. Simulated environment mapping; string, conversion needed. 9. Business record, not configuration. 10. The fallback is code; returned value is text here, though an actual environment value can replace it.

### Section 3

1. String. 2. Integer 25. 3. True. 4. False. 5. False. 6. True. 7. False. 8. Reject with `ValueError`. 9. `None`. 10. Present blank string. 11. Strip and reject as blank. 12. Bool is not an intended numeric size; reject it explicitly.

### Section 4

1. Optional positive default such as 100. 2. Optional False. 3. Required non-empty. 4. Required only if the real integration needs it; no fallback. 5. Optional development for this demo. 6. Optional documented non-negative default. 7. Reject; do not use default. 8. Reject; not an accepted Boolean spelling. 9. Reject; required value is blank. 10. Reject unknown choice rather than silently accepting it.

### Section 5

1. Integer 50. 2. String `validation`. 3. Boolean True. 4. Integer 25. 5. Boolean False. 6. String `production`. 7. Yes, 50 remains. 8. Reject invalid explicit override. 9. Reject non-positive explicit override. 10. Reject invalid explicit override. 11. No; the allowlist ignores it under this documented policy. 12. String `development` from defaults.

### Section 6

1. `bool("false")` is True; explicitly parse accepted spellings. 2. Raw text/None cannot safely be compared; convert and validate. 3. Reject zero and negative values. 4. Reject bool before integer acceptance. 5. Check dictionary root first. 6. Check that a path was read. 7. Use `getboolean()` and validate. 8. Strip and reject blank. 9. Check an allowed set. 10. Catch expected errors and reject the override; do not silently fall back.

### Section 7

1. Unsafe: credential exposure. 2. Unsafe: may dump secrets. 3. Safe: names a non-sensitive rule. 4. Safe: synthetic source label. 5. Unsafe: future fields may be sensitive. 6. Safe and necessary in a real project. 7. Unsafe assumption: standard Python does not load it. 8. Safe and deterministic. 9. Unsafe: masks missing credentials. 10. Safe if only the setting name is shown.

### Section 8

1. Code defaults, JSON file, simulated environment. 2. Defaults < file < env. 3. Integer 25. 4. Boolean False. 5. `allowed_statuses` stays from JSON; `source_name` also does. 6. Require a non-empty string after trimming. 7. Positive integer greater than zero; reject bool. 8. No. 9. As a validated settings object or typed dictionary parameter. 10. Raise a clear `ValueError` naming `batch_size`, without echoing the value or using a fallback. 11. Every override is supplied by a fixed in-memory mapping, so host variables cannot change expected results.
