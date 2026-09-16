# Troubleshooting Guide

## `SyntaxError` After `for`

Check the colon:

```python
for item in items:
    print(item)
```

## `IndentationError`

The loop body must be indented consistently.

## `NameError` for Loop Variable

Check spelling and make sure the variable is used inside the loop where it is defined.

## Counter Remains Zero

The counter may never be updated, or the condition may never be true.

## Counter Resets Unexpectedly

The counter may be initialized inside the loop. Initialize it before the loop.

## Range Has Wrong Count

`range()` excludes the stop value.

## While Loop Never Ends

Check that the condition changes.

```python
attempt += 1
```

## Loop Stops Too Early

Check for `break`.

## Some Items Skipped

Check for `continue`.

## Validation Summary Wrong

Check:

- initialization
- branch logic
- updates

## Nested Loop Produces Too Many Lines

Nested loops multiply work.

## Empty List Produces No Output

This is normal. A `for` loop over an empty list has no iterations.

## `TypeError` in Comparison

Check types from Day 051 before comparing.

## Wrong Validation Branch Inside Loop

Check Day 052 rule order.

## Script Appears Frozen

It may be an infinite loop. Interrupt safely in your environment and inspect the condition. Do not keep running an unbounded loop.

## Troubleshooting Flow

```text
1. inspect iterable
2. print current loop variable
3. check indentation
4. check condition
5. check counter initialization
6. check counter update
7. check break/continue
8. test with 2-3 items only
```
