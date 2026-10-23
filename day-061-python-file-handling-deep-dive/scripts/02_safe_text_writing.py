from pathlib import Path

day_dir = Path(__file__).resolve().parent.parent
source = day_dir / "sample-data" / "pipeline_notes.txt"
output = day_dir / "output" / "clean_pipeline_notes.txt"
with source.open("r", encoding="utf-8") as file:
    lines = [line.rstrip() for line in file if line.strip()]
with output.open("w", encoding="utf-8") as file:
    file.write("\n".join(lines) + "\n")
with output.open("r", encoding="utf-8") as file:
    print("Generated lines:", len(file.readlines()))
