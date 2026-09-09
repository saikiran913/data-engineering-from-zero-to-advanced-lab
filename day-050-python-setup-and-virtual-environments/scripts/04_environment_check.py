"""Purpose: print simple environment information using the standard library."""

import os
import sys

environment_hint = ".venv" in sys.executable

print(f"Python executable: {sys.executable}")
print(f"Python version: {sys.version}")
print(f"Current working directory: {os.getcwd()}")
print(f"environment_hint: executable path contains .venv = {environment_hint}")
print("This hint is not universal proof of a virtual environment.")
