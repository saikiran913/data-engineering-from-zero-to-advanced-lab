# Reusable Script Design

```text
imports → helper functions → main() → main guard
load → parse → validate → transform → summarize
```

Keep parsing, validation, transformation, and presentation separate. State input/output contracts, avoid hidden global state, use small functions, and make bundled examples deterministic. Day 060 file use is read-only.
