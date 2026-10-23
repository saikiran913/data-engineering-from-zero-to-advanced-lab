# Document and Refactor a Small Data Engineering Python Pipeline

Use Python 3.10+ and run everything from the Day 066 folder.

1. Verify the runtime with `python --version`.
2. Run `python -B scripts/01_basic_type_hints.py`.
3. Run `python -B scripts/02_typed_collections_and_records.py`.
4. Run `python -B scripts/03_docstrings_and_contracts.py`.
5. Run `python -B scripts/04_runtime_validation_vs_annotations.py`.
6. Run `python -B scripts/05_refactoring_for_maintainability.py`.
7. Run `python -B scripts/06_data_engineering_maintainable_workflow.py`.
8. Add `str | None` input and `str | None` return annotations to a simple untyped status helper.
9. Write a short docstring that says what `None` means and whether the helper prints or mutates data.
10. Test `None`, blank text, and an unsupported status through controlled validation; record results without a crash.
11. Choose one status/reason return shape and use it on every normal branch.
12. Move a repeated threshold check into a named helper or caller-supplied parameter.
13. Compare PASS/REVIEW/FAIL classifications before and after that refactor.
14. Explain why a correct annotation is not a runtime validator.

Final check: input records remain unchanged, all outputs match their hints and docstrings, and the classification counts add up to the number of records.
