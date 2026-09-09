"""Purpose: confirm that a beginner Python project environment is ready."""

import sys


def main():
    print("Python project environment is ready.")
    print(f"Python version: {sys.version.split()[0]}")
    print(f"Python executable: {sys.executable}")


if __name__ == "__main__":
    main()
