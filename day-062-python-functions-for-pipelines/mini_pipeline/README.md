# Day 062 Mini Pipeline

This package demonstrates an entirely in-memory pipeline:

```text
raw records → parse → normalize → validate → format → summarize
```

Run it from the Day 062 folder:

```bash
python mini_pipeline/app.py
```

`app.py` orchestrates. `pipeline_utils.parsers` converts values, `transforms` normalizes without mutation, `validators` applies rules with one dictionary return contract, and `formatters` presents results. There is no file, network, or database I/O, and no path manipulation or import hacks.
