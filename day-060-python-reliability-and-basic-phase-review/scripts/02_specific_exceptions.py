"""Day 060: handle expected exceptions clearly."""

try:
    print(int("bad"))
except ValueError:
    print("Invalid integer")
try:
    print({"id": "A"}["status"])
except KeyError:
    print("Missing status key")
try:
    print(["A"][1])
except IndexError:
    print("Missing list position")
