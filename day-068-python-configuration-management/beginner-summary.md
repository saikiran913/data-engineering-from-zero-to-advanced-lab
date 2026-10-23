# Beginner Summary

Configuration answers “how should this run?” rather than “what records are being processed?” An order row is data; a batch size, mode, or allowed-status list is configuration. Keeping settings separate from processing functions means the same code can work under several documented conditions without editing its logic each time. Day 068 uses only synthetic, local examples, not real deployment configuration.

The working model is:

```text
read known sources
→ apply documented precedence
→ parse types
→ validate required values and bounds
→ pass safe config to pipeline functions
```

In-code defaults are useful for optional, non-sensitive choices. A JSON file can hold structured values; an INI file groups textual keys into sections. An environment variable can override a known setting for a process. This lesson's priority is **defaults < file < environment**. A later source wins only when it supplies an approved key. Other projects may use another rule, but the rule must be explicit and tested.

Source and type are separate. `os.getenv()` returns a string or `None` when missing, unless a default is supplied. `"false"` is not Python `False`, and `"25"` is not integer 25. JSON does parse JSON `true` to Python `True` and a number to a Python number. INI values start as text, though `ConfigParser.getint()` and `.getboolean()` provide conversion. None of these conversions replaces business-rule validation: 0 may be an integer but still be an invalid batch size.

First merge approved inputs, then parse and validate the effective settings. Distinguish missing (`None`), present empty (`""`), whitespace-only (`"  "`), wrong type, invalid choice, and out-of-range values. Do not silently ignore an explicit bad override. A required `source_name` should fail if absent or blank. An optional `batch_size` can use a documented safe default. A credential needed by a real service would be required, not given a fabricated fallback.

Day 059's paths and Day 061's file handling help read the bundled JSON and INI fixtures. Script-relative paths based on `Path(__file__)` avoid confusion when the current working directory differs. Day 062's functions and Day 065's dataclass pattern make it practical to pass trusted configuration into record-processing code. Day 067's logging advice still applies: a diagnostic may name the invalid setting, but it must not reveal a sensitive value.

> Environment variables are strings. Values such as `"false"` and `"0"` are non-empty strings, so `bool("false")` is `True`; parse Boolean and numeric settings explicitly.

> Safe defaults are appropriate for non-sensitive, optional settings. Required secrets, credentials, and security-critical settings should not silently fall back to hard-coded or insecure values.

> Configuration precedence must be predictable and documented. Changing a setting in the environment should not silently conflict with a config-file value without a known override rule.

> Never commit a real `.env` file or put secrets in examples, console output, error messages, or logs. A file named `.env` is not automatically loaded by Python's standard library.

The six scripts demonstrate fixed simulated overrides, read-only fixture access, type checks, and a small in-memory pipeline. No real secrets, machine environment changes, external packages, or service calls are needed. The preview for the next lesson is **Day 069 — Python Testing Fundamentals: Assertions, unittest, and Pipeline Validation Checks**; that title is provisional and may change when Day 069 is planned.
