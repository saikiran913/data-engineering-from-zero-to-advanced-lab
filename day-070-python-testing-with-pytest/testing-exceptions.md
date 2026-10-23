# Testing Exceptions

When a function contract says invalid input **raises**, make that the expected outcome in a test:

```python
import pytest
from pipeline_utils.parsing import parse_amount

def test_invalid_amount_raises_value_error():
    with pytest.raises(ValueError):
        parse_amount("bad")
```

The test passes because the specified exception occurred. If `parse_amount("bad")` unexpectedly returned a value, pytest would fail the test. If it raised a different error, that is also a mismatch. The application function itself does **not** import or use `pytest.raises`; it simply raises according to its contract. `parse_iso_date("2023-02-29")` is another invalid-input case. A deliberately unhandled exception should not be left in the committed passing test suite. Checking exact message text is possible but can be brittle; start with the meaningful exception type and stable behavior.
