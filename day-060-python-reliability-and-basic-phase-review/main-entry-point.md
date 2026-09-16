# Main Entry Point

```python
def main():
    print("Running validation workflow")


if __name__ == "__main__":
    main()
```

The main guard lets a file run directly while preventing its main workflow from running automatically when imported. Put reusable functions above `main()`. Main orchestrates helpers and prints a summary instead of containing every business rule.
