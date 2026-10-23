# Error Propagation and Ownership

Each layer should make only the decision it owns:

| Layer | Responsibility |
|---|---|
| Parse helper | Convert one value or raise a clear `ValueError` |
| Row processor | Turn a known invalid value into REVIEW/FAIL with reason |
| Stage controller | Continue, abort, or retry a specifically transient operation |
| Top-level app | Record final SUCCESS/PARTIAL/FAILED outcome |

`raise ValueError("amount must be numeric")` signals a failure to the caller. A returned validation dictionary means the row processor **has** handled a known business condition. Bare `raise` from inside `except` preserves the original exception when a layer cannot resolve it. Use `raise ... from exc` when translating a known lower-level failure and retaining cause.

Keep `try` blocks narrow. Do not use a blanket catch that turns unexpected errors into PASS. Avoid logging and re-raising the same error at every layer; one responsible boundary can log safe context, while another decides whether to stop. A top-level failure must not be followed by a misleading COMPLETE message.

> Catch exceptions at the level where you can make a meaningful decision. Do not silently swallow failures or log an error and then claim the pipeline succeeded.
