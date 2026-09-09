# tee and Observation

## Why `tee` Exists

`tee` lets you see output and write it to a file.

```bash
grep "WARN" sample-data/pipeline_log.txt | tee practice-output/warnings.txt
```

## Append With `tee -a`

```bash
echo "review complete" | tee -a practice-output/review.txt
```

## Why `tee` Is Useful

- observe output while capturing it
- debug simple pipelines
- collect log output conceptually

## Safety Warning

`tee` can overwrite files just like `>` unless append mode is used. Never target source files.

## When Not to Use `tee`

- important source or configuration files
- secrets
- huge uncontrolled outputs
- binary data

