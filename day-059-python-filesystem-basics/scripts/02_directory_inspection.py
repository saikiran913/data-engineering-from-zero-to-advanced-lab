"""Day 059: list direct sample-data children deterministically."""

from pathlib import Path

data_dir = Path(__file__).resolve().parent.parent / "sample-data"
counts = {".txt": 0, ".csv": 0, ".json": 0}
for path in sorted(data_dir.iterdir()):
    print(path.name, "file=" + str(path.is_file()), "suffix=" + path.suffix)
    if path.is_file() and path.suffix in counts:
        counts[path.suffix] += 1
print("Counts:", counts)
