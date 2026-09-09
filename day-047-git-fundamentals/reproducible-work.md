# Reproducible Work

## Why Reproducibility Matters

Data Engineering work should be explainable later. Git helps answer which version of a query, script, configuration, or note produced a result.

## SQL Versioning

SQL changes can affect row counts, joins, filters, and reports. Git history shows how the query changed.

## Bash and Python Script Versioning

Scripts can affect validation, file checks, and pipeline steps. Versioning scripts makes investigations easier.

## Data-Quality Rule Versioning

Rules change over time. Git helps record when a required field, threshold, or validation note changed.

## Config Versioning

Configuration describes how work runs. Keep safe, non-secret configuration under version control when appropriate.

## Documentation Versioning

Documentation explains why technical choices were made. Docs and code should move together when related.

## What Not to Version by Default

Avoid committing secrets, raw private data, generated logs, temporary files, and large raw datasets by default.

## Reproducible Local Workflow

```text
1. inspect status
2. make one logical change
3. run or validate
4. inspect diff
5. stage exact files
6. inspect staged diff
7. commit clearly
8. inspect history
```
