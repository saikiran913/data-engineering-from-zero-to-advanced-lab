# Inspecting Files and Directories

```python
for path in sorted(data_dir.iterdir()):
    print(path.name)
```

Do not assume filesystem listing order. Check whether each path is a file or directory and inspect `.suffix` before applying a known parser. Count expected `.txt`, `.csv`, and `.json` files in a landing folder. Day 059 deliberately avoids recursion and all destructive operations.
