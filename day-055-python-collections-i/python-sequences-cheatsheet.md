# Python Sequences Cheatsheet

## List

```python
items = ["a", "b", "c"]
```

## Tuple

```python
record = ("ORD-1", "PASS")
```

## Index

```python
items[0]
items[-1]
```

## Slice

```python
items[0:2]
items[:2]
items[1:]
```

## Length

```python
len(items)
```

## Membership

```python
"PASS" in items
```

## Append

```python
items.append("d")
```

## Loop

```python
for item in items:
    print(item)
```

## Tuple Unpack

```python
order_id, status = record
```

## Data Engineering Reminder

```text
ordered values
→ clear positions
→ safe iteration
→ documented meaning
```
