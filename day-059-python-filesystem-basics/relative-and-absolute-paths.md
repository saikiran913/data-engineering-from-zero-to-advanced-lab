# Relative and Absolute Paths

`sample-data/orders_sample.csv` is relative to the current working directory. An absolute path is complete for one environment, such as conceptual `/project/day-059/sample-data/orders_sample.csv` or `C:\project\day-059\sample-data\orders_sample.csv`.

Script location and terminal working directory can differ. Build bundled sample paths from the script location:

```python
from pathlib import Path

day_dir = Path(__file__).resolve().parent.parent
data_dir = day_dir / "sample-data"
```

`__file__` refers to the script file path. Do not commit personal absolute paths or join path text with hard-coded separators.
