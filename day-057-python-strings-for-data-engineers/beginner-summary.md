# Beginner Summary

Strings are text values used throughout Data Engineering: IDs, statuses, codes, filenames, and notes. They often look simple but can carry business meaning in their case, spaces, punctuation, and leading zeros. Treat a source string as raw data first, then apply only rules that have a clear purpose.

Strings are immutable. Methods such as `strip()`, `upper()`, and `replace()` return a new string rather than changing the old one. Clear names such as `raw_status`, `clean_status`, and `canonical_status` make this visible and preserve traceability.

Whitespace cleaning usually starts with `strip()`, which removes edge whitespace. `lstrip()` and `rstrip()` remove one edge. Internal whitespace is different: it may be meaningful in a name, description, or code. Empty text, whitespace-only text, and `None` are separate states. Check `None` before calling string methods, then strip if the business rule permits it, then test for blank text.

Case standardisation works well for controlled values such as statuses and country codes. For example, a documented rule may turn `" completed "` into `"COMPLETED"`. Do not automatically change display text or IDs. An identifier such as `"00125"` must remain a string when leading zeros are meaningful.

`replace()` can standardise a known separator, while membership, `startswith()`, and `endswith()` can validate controlled filenames or codes. Use `find()` only when the position is useful; use `in` for a simple existence check. Every replacement needs a narrow, documented reason.

`split()` separates simple controlled text into a list of parts, and `join()` rebuilds parts with a chosen delimiter. For a pipe-delimited record, first strip the whole record, split on `|`, check the exact field count, clean each part, then assign field names. Empty fields need validation too. Simple splitting is not a substitute for a proper parser when quoting, embedded delimiters, escaping, or nested data exist.

F-strings create readable summaries such as `f"status={status}, row_count={row_count}"`. Formatting is for people; it does not transform the underlying values or replace a structured record.

Standardisation maps can turn approved input variants such as `done` and `complete` into one canonical status, `COMPLETED`. Keep the raw value when traceability matters, and use a separate canonical value. A sound cleaning rule is deterministic and idempotent: running it again yields the same canonical result.

Before Day 058, remember the practical order: raw value, missing check, edge cleaning, blank check, standardisation, validation, then controlled parsing when needed. Avoid over-cleaning and preserve business meaning at every stage.
