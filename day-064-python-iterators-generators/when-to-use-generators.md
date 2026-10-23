# When to Use Generators

| Choose a generator when... | Choose a list when... |
|---|---|
| Records can be processed independently | The collection is small and a list is simpler |
| The source can be consumed incrementally | Several passes over the same output are required |
| Intermediate full lists are unnecessary | Random indexing is required |
| Stages compose into a one-pass flow | Sorting the full result is required |
| A consumer may stop early | The output must be reused repeatedly |

A generator cannot be indexed directly. `sorted(generator)` returns a list because sorting needs to examine all items. This consumes the generator and materialises the ordered result. Consider the entire path from source to consumer before claiming a memory benefit. Choose based on the work's semantics, not on which syntax is fashionable.
