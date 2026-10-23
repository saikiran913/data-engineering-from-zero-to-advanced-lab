# Configuring Console Logs

`logging.basicConfig()` is the smallest useful setup for a standalone script. Call it once from `main`, where the application starts. It installs a console handler (normally `stderr`) on the root logger and sets a format and threshold.

```python
import logging

logger = logging.getLogger(__name__)

def main() -> None:
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s %(levelname)s %(name)s %(message)s",
    )
    logger.info("run_id=%s stage=START", "RUN-001")

if __name__ == "__main__":
    main()
```

`StreamHandler` is the console-output component behind this simple setup. A handler sends records somewhere; a formatter makes them readable. A helper module should request a named logger, not configure a new handler. If another environment has configured logging already, a later `basicConfig()` may have no effect. That is a reason to inspect the existing setup, not to keep adding handlers. In the standalone level demo, configuration happens once and only the root threshold is changed afterward.
