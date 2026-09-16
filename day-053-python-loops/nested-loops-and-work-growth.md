# Nested Loops and Work Growth

## Basic Nested Loop

```python
files = ["orders", "customers"]
checks = ["row_count", "null_check"]

for file_name in files:
    for check_name in checks:
        print(file_name, check_name)
```

This runs the inner loop once for each outer-loop item.

## Work Growth

2 files x 2 checks = 4 inner iterations.

| Outer items | Inner items | Maximum inner iterations |
|---|---:|---:|
| 10 | 10 | 100 |
| 100 | 100 | 10,000 |
| 1000 | 1000 | 1,000,000 |

## Why Nested Loops Matter

Nested loops are sometimes useful, but they can multiply work quickly.

## Avoid Unnecessary Cross-Products

A cross-product means every item from one group is paired with every item from another group. This can create far more work than expected.

## Data Engineering Caution

Be careful when checking every file against every rule, joining every item to every other item, or repeating expensive checks.

## Keep Day 053 Simple

This day does not introduce algorithmic complexity notation deeply. The beginner lesson is: nested loops multiply work, so use them deliberately.
