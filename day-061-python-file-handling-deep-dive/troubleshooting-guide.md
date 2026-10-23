# Troubleshooting Guide

| Symptom | Likely cause | What to do |
|---|---|---|
| `FileNotFoundError` | Incorrect or missing path | Print the resolved path and verify delivery |
| `PermissionError` | File is protected or in use | Check access and close competing tools |
| `UnicodeDecodeError` | Wrong source encoding | Confirm the producer's encoding |
| `JSONDecodeError` | Invalid JSON punctuation or structure | Inspect the reported line and request a corrected source |
| CSV values shift columns | Manual splitting or malformed quoting | Use `csv` module and inspect source quoting |
| Missing dictionary key | Header changed | Validate fieldnames before row processing |
| Output has fewer rows | Rows were skipped | Keep every row with a validation result |
| Output has duplicate rows | Append mode was rerun | Use controlled write mode or clear run identifiers |
| Amount conversion fails | Non-numeric text | Catch `ValueError` and mark the row |
| Status is unexpected | Source value changed or needs normalisation | Normalise and mark REVIEW |
| JSON summary cannot be read | Invalid write or wrong path | Reopen it with `json.load` after writing |
| Source was altered | Incorrect destination variable or mode | Restore source and separate input/output paths |

When diagnosing, start with the resolved path, file format, header, row count, and exact exception. Keep the original source unchanged so the issue is reproducible.
