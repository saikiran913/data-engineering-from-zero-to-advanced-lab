# Test Structure and Organisation

```text
day-070-python-testing-with-pytest/
├── pipeline_utils/
│   ├── cleaning.py
│   ├── parsing.py
│   ├── validation.py
│   └── transformations.py
└── tests/
    ├── test_cleaning.py
    ├── test_parsing.py
    └── ...
```

`pipeline_utils/` contains reusable application functions. `tests/` contains expectations about them. Keeping concerns separate prevents pytest from becoming a runtime dependency. A file per concern helps learners locate a failure quickly.

Use **Arrange → Act → Assert**: create a synthetic input, call the helper, then compare the result with the contract. For example:

```python
def test_clean_record_does_not_mutate_source():
    source = {"status": " ready "}  # Arrange
    cleaned = build_clean_record(source)  # Act
    assert cleaned == {"status": "READY"}  # Assert
    assert source == {"status": " ready "}
```

Each test creates its own input and should pass regardless of execution order. Avoid a shared mutable dictionary changed by another test. A test name should state the behavior, not merely `test_function`. Fixtures and parametrization can reduce repetition later; they are not required for today's six small modules.
