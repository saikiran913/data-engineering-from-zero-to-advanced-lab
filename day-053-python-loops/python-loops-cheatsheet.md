# Python Loops Cheatsheet

## For

```python
for item in items:
    print(item)
```

## While

```python
count = 1

while count <= 3:
    print(count)
    count += 1
```

## Range

```python
for number in range(1, 6):
    print(number)
```

## Counter

```python
pass_count = 0

for result in results:
    if result == "PASS":
        pass_count += 1
```

## Break

```python
break
```

Stops the loop.

## Continue

```python
continue
```

Skips to the next iteration.

## Data Engineering Loop Pattern

```text
iterate
→ validate
→ classify
→ count
→ summarize
```

## Safety Reminders

- initialize counters before loops
- update `while` conditions
- test small examples first
- avoid unnecessary nesting
- print summaries after the loop
