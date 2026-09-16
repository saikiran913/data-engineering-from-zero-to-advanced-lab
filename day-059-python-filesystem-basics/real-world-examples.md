# Real-World Examples

| Scenario | Path/parser choice | Validation | Risk | Safe design |
| --- | --- | --- | --- | --- |
| Locate landing directory | script-relative Path | is_dir | terminal differs | derive from `__file__` |
| Verify expected CSV | Path / filename | exists/is_file | missing file | check before read |
| Verify JSON config | Path / filename | suffix/type | wrong target | known contract |
| Read pipeline notes | text reader | UTF-8 | encoding mismatch | explicit encoding |
| List local samples | sorted iterdir | file check | unstable order | sort |
| Filter CSV | suffix check | is_file | directory named csv | both checks |
| Inspect suffix | Path property | expected format | suffix lies | validate content later |
| Relative path | Path text | cwd awareness | wrong terminal | explain basis |
| Absolute path concept | resolve | debug only | private paths | do not commit |
| Script-relative path | `__file__` | exists | parent wrong | test scripts |
| Wrong cwd | script base | sample exists | FileNotFound | derive base |
| Missing file | Path | exists false | parser error | stop safely |
| Directory not file | Path | is_file false | IsADirectoryError | inspect type |
| CSV rows | DictReader | fields | raw splitting | csv parser |
| Quoted comma | DictReader | row values | shifted columns | parser handles quote |
| Blank CSV field | DictReader | empty text | assume None | document state |
| Numeric CSV text | DictReader | type is str | accidental arithmetic | convert explicitly later |
| JSON object | json.load | dict root | unparsed text | check type |
| JSON array concept | json.load | list root | assume dict | branch by type |
| JSON null | json.load | None | string confusion | check None |
| Nested config | dict lookup | keys | missing nesting | validate level |
| Missing JSON key | get/check | required set | KeyError | contract check |
| Optional JSON key | get | default rule | false requirement | safe lookup |
| Empty text | text reader | content | false assumption | handle blank |
| Encoding mismatch | text reader | decode | error | follow source encoding |
| No recursion | iterdir | direct children | broad scan | keep scope |
| Plain notes | text reader | read lines | unnecessary parser | use text reader |
| Extension mismatch | known expected format | contract | suffix trust | inspect/validate |
| Full workflow | all parsers | summaries | source changes | read-only |
