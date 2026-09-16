"""Day 060: modules organise reusable code."""
import json
from pathlib import Path

print("Imported module:", json.__name__)
print("Script folder:", Path(__file__).resolve().parent.name)
print("Local package imports are shown in mini_project/app.py.")
