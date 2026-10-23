from pathlib import Path

path = Path(__file__).resolve().parent.parent / "sample-data" / "blank_lines.txt"
with path.open("r", encoding="utf-8") as file:
    print("Full length:", len(file.read()))
with path.open("r", encoding="utf-8") as file:
    print("First line:", file.readline().rstrip("\n"))
with path.open("r", encoding="utf-8") as file:
    for number, line in enumerate(file, start=1):
        print(number, repr(line.rstrip("\n")))
