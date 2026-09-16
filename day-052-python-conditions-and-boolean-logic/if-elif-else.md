# If, Elif, and Else

## Basic `if`

```python
record_count = 10

if record_count > 0:
    print("Rows are available")
```

## `if` / `else`

```python
if record_count > 0:
    print("PASS")
else:
    print("FAIL")
```

## `if` / `elif` / `else`

```python
error_count = 3

if error_count == 0:
    status = "PASS"
elif error_count <= 5:
    status = "REVIEW"
else:
    status = "FAIL"

print(status)
```

Python checks from top to bottom. Only one branch runs in this chain.

## Indentation

Correct:

```python
if record_count > 0:
    print("Rows are available")
```

Incorrect:

```python
# if record_count > 0:
# print("Rows are available")
```

The body must be indented.

## Mutually Exclusive Outcomes

`PASS`, `REVIEW`, and `FAIL` are usually mutually exclusive. One final decision should be produced for one validation check.

## Multiple Independent `if`s

Multiple `if` statements are checked separately. An `if` / `elif` / `else` chain chooses one path.

```python
if error_count > 0:
    print("Has errors")

if error_count <= 5:
    print("Low error count")
```

Both could run. That is not the same as `elif`.

## Fallback Branch

`else` can make unexpected states visible instead of silently doing nothing.

## Data Engineering Examples

- completeness threshold becomes `PASS` or `REVIEW`
- freshness check becomes `PASS` or `FAIL`
- error thresholds become `PASS`, `REVIEW`, or `FAIL`
- unsupported status becomes `REVIEW` or `FAIL`
