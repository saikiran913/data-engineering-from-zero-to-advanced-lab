# Modules and Imports

A module is a `.py` file with reusable code. Standard-library modules include `csv`, `json`, `datetime`, and `pathlib`. A local module can hold shared validation helpers.

```python
import validation_utils
from validation_utils import validate_record_count
```

Imports run a module’s top-level code, so reusable modules should avoid unintended side effects. Avoid wildcard imports; focused import names make source clearer.
