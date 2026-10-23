# Troubleshooting Configuration

When a run behaves unexpectedly, diagnose one setting at a time. Name the setting and source, never a secret value.

| Symptom | Likely check | Safe next step |
|---|---|---|
| Environment key missing | Was the exact `DAY068_` name supplied? | Apply documented optional default or report required absence |
| Required value empty/whitespace | `None` versus stripped text | Reject blank explicitly |
| `"false"` behaves True | `bool(text)` was used | Use explicit Boolean parser |
| Integer conversion fails | Value is not supported numeric text | Report setting name and expected type |
| Size parses as zero/negative | Range not checked | Require positive bound |
| JSON file missing | Path or working directory wrong | Derive bundled path from `__file__` |
| Malformed JSON | Syntax error | Identify file, not its contents |
| JSON root is a list | Wrong shape | Require dictionary root |
| INI not read | `read()` returned empty | Check derived path |
| INI section/key missing | Contract does not match file | Name required section/key |
| INI bool/int invalid | Typed getter rejects text | Correct synthetic fixture or source rule |
| Unexpected effective setting | Merge order reversed | Review defaults < file < env |
| Relative path fails elsewhere | Current directory changed | Use script-relative path |
| Config printed accidentally | Broad debug dump | Remove it; print safe fields only |
| Secret fallback appears | Insecure default | Require explicit real setting at integration boundary |
| Tests differ by machine | Real env leaked into expected result | Use fixed simulated mapping |
| Unknown override not applied | Name absent from allowlist | Document or deliberately add approved mapping |
| Wrong business behavior | Raw config passed to processor | Validate and pass typed settings |

This lesson's policy is to **ignore unknown environment names** by reading only an approved mapping. A real project may choose to reject unknown names, but it must document and test that choice. Invalid values for an approved name are **rejected**, never silently ignored.

## Diagnostic Sequence

1. Identify the setting name; do not print a secret value.
2. Identify its intended source and declared precedence.
3. Verify the file path, section, and key where relevant.
4. Distinguish missing, empty, and whitespace-only values.
5. Parse the documented target type.
6. Validate allowed choices and numeric range.
7. Inspect only non-sensitive effective settings.
8. Pass the validated settings into pipeline functions and compare the actual result.

Configuration errors should be corrected before data processing. An invalid input record is a separate business-data issue.
