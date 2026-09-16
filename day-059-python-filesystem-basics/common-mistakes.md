# Common Mistakes

| Mistake | Why it matters | Safer approach |
| --- | --- | --- |
| Hard-coded separators | Not portable | Use Path composition |
| Assume working directory is script directory | Script fails elsewhere | Derive from `__file__` |
| String path concatenation | Separator mistakes | Use `/` with Path |
| Commit personal absolute path | Not portable/private | Use relative sample path |
| Skip existence check | Missing path surprises | Use `.exists()` |
| Treat directory as file | Read fails | Use `.is_file()` |
| Assume listing order | Order varies | Use `sorted()` |
| Add recursive traversal | Scope expands | Inspect one directory |
| Delete practice files | Destructive | Read only |
| Overwrite sample | Changes lesson | No writes |
| No context manager | Handle may stay open | Use `with` |
| Omit encoding | Decode rule unclear | Specify UTF-8 |
| Assume wrong encoding | Decode can fail | Follow source contract |
| Read huge file blindly | Memory concern | Use line iteration later |
| Misread newlines | Text output looks odd | Strip only newline when needed |
| Use `split(",")` for CSV | Quotes break it | Use csv module |
| Ignore quoted comma | Columns shift | Use DictReader |
| Assume CSV values numeric | Reader returns strings | Convert explicitly later |
| Treat header as row | Output wrong | Use DictReader/header rule |
| Misspell DictReader key | KeyError | Validate headers |
| Skip required CSV columns | Contract breaks | Compare headers |
| Blank equals None | Different states | Handle intentionally |
| Treat JSON text as dict | Not parsed | Use json.load/loads |
| Treat Python literal as JSON | Syntax differs | Use valid JSON |
| Use True in JSON | JSON requires true | Follow JSON syntax |
| Treat null as string | Meaning differs | Map to None |
| Assume JSON root | Could be list | Check type |
| Skip required JSON key | Later lookup fails | Validate keys |
| Assume nested key | Shape may differ | Check level by level |
| Trust suffix as proof | Content may disagree | Validate contract |
| Parse empty file blindly | No useful structure | Check result |
| Terminal-relative sample path | Fails from another folder | Use script-relative base |
| Resolve path considered portable | Output is environment-specific | Use for debugging only |
| Misunderstand `__file__` | Wrong base directory | Explain script path |
| Open binary as text | Decode can fail | Keep text scope |
| Add external package | Not required | Use standard library |
| Introduce pandas | Scope expands | Use csv/json |
| Use production directory | Risky | Use bundled synthetic data |
| Add write mode | Alters state | Read mode only |
| Traverse beyond practice folder | Scope broadens | Restrict to sample-data |
