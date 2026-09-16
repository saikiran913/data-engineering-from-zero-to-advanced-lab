"""Day 059: read a synthetic text file using a context manager."""

from pathlib import Path

notes_path = Path(__file__).resolve().parent.parent / "sample-data" / "pipeline_notes.txt"
with notes_path.open("r", encoding="utf-8") as file:
    lines = list(file)

print("Line count:", len(lines))
for line in lines:
    print(line.rstrip("\n"))
