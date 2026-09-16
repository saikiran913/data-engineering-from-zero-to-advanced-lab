# Build Key-Based Data Engineering Records and Lookup Checks

1. Verify Python with `python --version`.
2. Run `scripts/01_dictionary_basics.py`.
3. Run `scripts/02_safe_lookups.py`.
4. Run `scripts/03_dictionary_iteration.py`.
5. Run `scripts/04_set_basics.py`.
6. Run `scripts/05_nested_records.py`.
7. Run `scripts/06_data_engineering_lookup_workflow.py`.
8. In the REPL, create an order dictionary.
9. Read its required `order_id` directly.
10. Read an optional note with `.get()`.
11. Add and update a field.
12. Iterate through `.items()`.
13. Create a set of statuses.
14. Deduplicate a short identifier list, then explain what was lost.
15. Compare required keys with observed keys using set difference.
16. Inspect a nested customer record one level at a time.
17. Confirm: no files, databases, network calls, or external packages were used.

## Final Checklist

- I can explain dictionary key and value.
- I can choose direct lookup versus `.get()`.
- I can distinguish a missing key from `None`.
- I can use a set without assuming order.
- I can validate required keys.
- I can explain the shape of a shallow nested record.
