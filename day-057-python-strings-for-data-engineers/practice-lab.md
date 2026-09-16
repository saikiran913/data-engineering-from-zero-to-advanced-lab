# Clean and Standardise Data Engineering Strings

1. Verify Python: `python --version`.
2. Run `python scripts/01_string_basics.py`.
3. Run `python scripts/02_whitespace_and_case.py`.
4. Run `python scripts/03_replace_search_and_checks.py`.
5. Run `python scripts/04_split_join_and_parse.py`.
6. Run `python scripts/05_standardisation_rules.py`.
7. Run `python scripts/06_data_engineering_string_workflow.py`.
8. In the REPL, run `raw_status = " completed "` and `clean_status = raw_status.strip().upper()`.
9. Test blank detection with `"   ".strip() == ""`.
10. Test controlled prefix and suffix checks.
11. Split `"ORD-1001|CUST-001|COMPLETED"` on `|`.
12. Validate `len(parts)` before indexing.
13. Join cleaned parts with `"|".join(parts)`.
14. Create a small approved status map.
15. Run the same standardisation twice and confirm the output is unchanged.

## Lab Checklist

- I understand string immutability.
- I can clean edge whitespace.
- I can standardise controlled casing.
- I can use `replace()` safely.
- I can check prefixes and suffixes.
- I can split and join controlled text.
- I validate field count.
- I distinguish blank text from `None`.
- I understand canonical standardisation.
