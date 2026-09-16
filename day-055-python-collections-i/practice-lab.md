# Work with Ordered Data Engineering Sequences

## Part 1 — Verify Python

```bash
python --version
```

Use the Python 3 command from your own environment.

## Part 2 — Run List Basics

```bash
python scripts/01_list_basics.py
```

## Part 3 — Run Tuple Basics

```bash
python scripts/02_tuple_basics.py
```

## Part 4 — Run Indexing and Slicing

```bash
python scripts/03_indexing_and_slicing.py
```

## Part 5 — Run Mutation Script

```bash
python scripts/04_list_mutation.py
```

## Part 6 — Run Record Sequences

```bash
python scripts/05_record_sequences.py
```

## Part 7 — Run Full Sequence Workflow

```bash
python scripts/06_data_engineering_sequence_workflow.py
```

## Part 8 — REPL List

```python
files = ["orders.csv", "customers.csv", "products.csv"]
```

Inspect:

- first item
- last item
- length

## Part 9 — Slice

Try:

```python
files[:2]
files[1:]
```

## Part 10 — Append

```python
files.append("payments.csv")
```

## Part 11 — Copy and Mutate Copy

```python
copy_of_files = files.copy()
copy_of_files.append("reviews.csv")
```

## Part 12 — Tuple Record

```python
record = ("ORD-1001", "PASS", 125.50)
```

## Part 13 — Unpack Tuple

```python
order_id, status, amount = record
```

## Part 14 — List of Tuples

Create a small list of order tuples.

## Part 15 — Loop Over Records

Loop through the tuples and print each field.

## Lab Checklist

- understands list/tuple difference
- can index
- can slice
- understands zero-based indexing
- understands mutation
- understands tuple immutability
- can unpack simple tuples
- can iterate record sequences
