# Reading Text Files

```python
with file_path.open("r", encoding="utf-8") as file:
    content = file.read()
```

The context manager closes the file automatically. Line iteration is useful when full-file reading is not appropriate:

```python
with file_path.open("r", encoding="utf-8") as file:
    for line in file:
        print(line.rstrip("\n"))
```

`.readline()` and `.readlines()` are useful concepts. This lesson remains read-only and does not cover large-file optimisation deeply.
