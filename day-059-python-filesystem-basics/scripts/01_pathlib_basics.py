"""Day 059: inspect bundled paths without changing files."""

from pathlib import Path

script_path = Path(__file__).resolve()
script_dir = script_path.parent
day_dir = script_dir.parent
data_dir = day_dir / "sample-data"
file_path = data_dir / "pipeline_notes.txt"

print("Script:", script_path.name)
print("Script directory:", script_dir.name)
print("Day directory:", day_dir.name)
print("Sample directory exists:", data_dir.exists(), data_dir.is_dir())
print("File:", file_path.name, file_path.stem, file_path.suffix)
print("File parent:", file_path.parent.name)
print("File exists:", file_path.exists(), file_path.is_file())
