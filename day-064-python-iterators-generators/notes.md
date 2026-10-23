# Day 064 Notes

```text
iterable → iterator → next value → next value → exhausted
```

An **iterable** can provide an iterator. An **iterator** remembers its position and produces one value when asked. A **generator** is a convenient way to create an iterator. A `for` loop requests successive values automatically until the iterator is exhausted.

```text
source records → lazy transform → lazy filter → consumer
```

Lazy stages produce values only when the consumer requests them. Lists are eager, materialised collections: they already hold their items. A generator expression or function delays its output; it does not necessarily make the original source lazy. Keep stages focused and decide when a full list is actually needed.
