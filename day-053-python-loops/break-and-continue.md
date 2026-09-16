# Break and Continue

## `break`

`break` stops the loop.

```python
results = ["PASS", "REVIEW", "FAIL", "PASS"]

for result in results:
    if result == "FAIL":
        print("Stopping review")
        break
```

Use this carefully. It stops before later items are processed.

## `continue`

`continue` skips the rest of the current iteration.

```python
statuses = ["PASS", "SKIP", "REVIEW"]

for status in statuses:
    if status == "SKIP":
        continue
    print(status)
```

## Break Risk

`break` can stop before all records are checked.

## Continue Risk

`continue` can silently skip important logic if the skip condition is unclear.

## Prefer Clear Conditions

Always explain why a loop stops or skips an item.

## Data Engineering Examples

- stop on critical configuration failure
- skip intentionally excluded sample
- avoid `break` when a full validation summary is required

## Practice Scenarios

| Scenario | Better tool | Reason |
|---|---|---|
| stop on first `FAIL` | `break` | fail-fast review |
| skip `"SKIP"` status | `continue` | intentional exclusion |
| count all failures | neither | full scan needed |
| ignore sample source | `continue` | source deliberately excluded |
| stop after critical missing schema | `break` | further checks may be meaningless |
| print every status | neither | no skip/stop needed |
| skip blank labels | `continue` | avoid invalid item |
| stop at maximum attempts | `while` condition | bounded loop clearer |
| summarize all outcomes | neither | process all items |
| stop after first severe issue | `break` | fail-fast strategy |
