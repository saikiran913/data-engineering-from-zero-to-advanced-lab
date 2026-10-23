# Logger Names and Module Use

`logging.getLogger(__name__)` returns the same named logger when called again for that module. Its name helps identify where an event arose. For example, `pipeline.validate` is a child of `pipeline` in the logger hierarchy.

```python
import logging

logger = logging.getLogger(__name__)

def validate(count: int) -> None:
    logger.info("stage=VALIDATE record_count=%s", count)
```

A child logger normally propagates records to ancestor handlers. If you attach a handler to both child and ancestor, the same event may print twice. Configure the application's console handler once at entry, and let helper modules use named loggers without installing their own handlers. A duplicate log is not evidence of duplicate data; inspect handler configuration before investigating ingestion.
