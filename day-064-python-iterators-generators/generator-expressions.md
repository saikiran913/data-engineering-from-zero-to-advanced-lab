# Generator Expressions

The bracket choice changes when results are produced:

```python
values = [1, 2, 3]
squares_list = [value * value for value in values]
squares_generator = (value * value for value in values)
```

`squares_list` is a materialised list. `squares_generator` is a lazy generator expression: it calculates each square on request. The parentheses here do not create a tuple of squares.

```python
for square in squares_generator:
    print(square)
```

That loop consumes the generator. A second loop produces nothing because it is exhausted. To repeat, create a new generator expression from `values`. `list(squares_generator)` deliberately collects all *remaining* values; use it when a full list is needed, and remember it changes the generator's state.
