# Type Awareness

## Same Appearance, Different Type

```python
amount_number = 100
amount_text = "100"
```

These look similar, but Python sees different types.

## Type Affects Operations

```python
print(100 + 20)
print("100" + "20")
```

The first example adds numbers and returns `120`. The second joins text and returns `"10020"`.

## Type Mismatch

```python
# "100" + 20 raises TypeError.
```

Python cannot add text and an integer directly.

## IDs Versus Numbers

```python
customer_id = "00125"
```

This should usually remain a string. Converting it to an integer would remove leading zeros and change the business meaning.

## Boolean Text Versus Boolean

```python
text_value = "False"
boolean_value = False
```

`"False"` is text. `False` is a boolean.

## Type Drift Concept

Yesterday:

```text
amount = 100.5
```

Today:

```text
amount = "100.5"
```

This is type drift. A pipeline may fail or produce incorrect logic if it assumes the type never changes.

## Type Contract Mindset

For each important value ask:

1. what does it mean?
2. what type should it be?
3. can it be missing?
4. what happens if the type changes?
5. should conversion be allowed?

This connects to earlier schema and data-quality lessons. Reliable pipelines protect both value and meaning.
