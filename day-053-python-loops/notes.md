# Notes — Python Loops

## What Is Iteration?

Iteration means repeating logic for one item, then the next item, then the next item.

```text
same logic
→ next item
→ next item
→ next item
```

## What Is a Loop?

A loop is code that repeats. Instead of writing the same statement many times, a loop applies one block of logic repeatedly.

## For Loop Mental Model

```python
for item in items:
    print(item)
```

Python takes one item from `items`, gives it the name `item`, runs the indented body, and then moves to the next item.

## While Loop Mental Model

```python
while condition:
    print("repeat while true")
```

A `while` loop repeats while its condition remains true.

## Loop Variable

The loop variable represents the current item.

## Loop Body

The loop body is the indented code that runs on each iteration.

## Indentation

Python uses indentation to decide what belongs inside the loop. Four spaces is common style.

## Known Collection Versus Condition-Driven Repetition

| Situation | Better beginner choice |
|---|---|
| Process 3 known files | `for` |
| Count from 1 to 5 | `for` + `range()` |
| Repeat until condition changes | `while` |
| Process validation results | `for` |

## Counters

```python
pass_count = 0
```

A counter tracks how many times something happens.

## Accumulators

An accumulator stores a running value, such as total rows.

## Conditions Inside Loops

Day 052 validation logic fits naturally inside loops.

```python
for result in validation_results:
    if result == "PASS":
        pass_count += 1
```

## Break

`break` stops a loop early.

## Continue

`continue` skips the rest of the current iteration and moves to the next item.

## Nested Loops

A nested loop is a loop inside another loop. Nested loops multiply work.

## Data Engineering Mental Model

```text
collection
→ one item
→ validate
→ classify
→ update summary
→ next item
```
