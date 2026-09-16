# Beginner Summary

## What Learners Should Remember

Loops repeat logic. A `for` loop is ideal when you already have a known collection, such as a list of file names or validation outcomes. A `while` loop repeats while a condition is true, so it needs a clear termination condition.

Loop bodies use indentation. The loop variable represents the current item. In this example, `file_name` changes on each iteration:

```python
files = ["orders.csv", "customers.csv"]

for file_name in files:
    print(file_name)
```

`range()` supports simple counting. `range(1, 6)` produces `1` through `5` because the stop value is excluded.

Counters start before loops and are updated inside loops. Accumulators collect running values, such as total rows. Conditions from Day 052 fit naturally inside loops, so a script can classify many results and produce a final summary.

`break` stops a loop. `continue` skips the rest of one iteration. Both should be used deliberately because they change which items are processed.

`while` loops need clear termination. If the condition never becomes false, the loop can run forever. Day 053 uses bounded examples only.

Nested loops multiply work. Two files and two checks produce four inner iterations. One hundred files and one hundred checks can produce ten thousand inner iterations.

Validation loops can classify and summarize outcomes, but clear loops are better than clever loops. Python loops are useful for learning and utility scripts, but they are not always the right tool for massive data processing.

## Mental Model

```text
Choose items
→ process one item
→ validate
→ update summary
→ repeat
→ report final result
```

## Required Warnings

> A loop repeats logic, including mistakes. Always understand what each iteration changes before running a loop over many items.

> `while` loops can run forever if the condition never becomes false. Make the termination condition explicit and test it with small examples.

> Nested loops can multiply work quickly. A loop over 100 items inside another loop over 100 items performs up to 10,000 inner iterations.

> Python loops are excellent for learning and many utility tasks, but large-scale Data Engineering workloads may require vectorised, distributed, SQL-based, or framework-specific processing instead of row-by-row Python loops.

## Preview

**Day 054 — Python Collections for Data Engineers: Lists, Tuples, Sets, and Dictionaries**

Day 054 will deepen the containers that loops iterate over.
