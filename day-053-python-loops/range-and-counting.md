# Range and Counting

## `range(stop)`

```python
for number in range(5):
    print(number)
```

This prints `0`, `1`, `2`, `3`, and `4`. `range(5)` starts at `0`.

## `range(start, stop)`

```python
for number in range(1, 6):
    print(number)
```

This prints `1` through `5`.

## Stop Is Excluded

The stop value is not included. `range(1, 6)` stops before `6`.

## Step Concept

```python
for number in range(0, 10, 2):
    print(number)
```

This counts by twos.

## Counting Iterations

```python
iteration_count = 0

for number in range(1, 4):
    iteration_count += 1

print(iteration_count)
```

## `enumerate()` Conceptually

```python
files = ["orders.csv", "customers.csv"]

for position, file_name in enumerate(files, start=1):
    print(position, file_name)
```

`enumerate()` gives a position and an item. This is optional for Day 053.

## Common Off-By-One Mistakes

If you want 1 through 5, use `range(1, 6)`, not `range(1, 5)`.

## Practice

```python
for number in range(3):
    print(number)

for number in range(1, 4):
    print(number)

for number in range(2, 7):
    print(number)

for number in range(0, 10, 2):
    print(number)

for batch_number in range(1, 6):
    print(batch_number)

for retry_number in range(1, 4):
    print(retry_number)

for check_number in range(1, 5):
    print(check_number)

for day_number in range(1, 8):
    print(day_number)

for file_number in range(1, 3):
    print(file_number)

for position, file_name in enumerate(["orders.csv", "customers.csv"], start=1):
    print(position, file_name)

for number in range(5, 8):
    print(number)

for number in range(10, 13):
    print(number)
```
