# Day 062 Notes

```text
raw input → parser → transformer → validator → formatter → output
function(input) → deterministic logic → output
```

One stage should have one focused responsibility. Parameters expose dependencies, return values move data forward, and orchestration connects the stages. Hidden-state functions are harder to reuse and test.
