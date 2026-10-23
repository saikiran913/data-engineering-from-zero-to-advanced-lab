# Pipeline Diagnostics

A useful run reads like a short sequence of stage summaries:

```text
START → READ → NORMALISE → VALIDATE → SUMMARISE → COMPLETE
```

Here READ means accepting an **in-memory** synthetic batch. These examples perform no file or network I/O. Every event includes a fixed `run_id`, safe source name, and stage. Log record counts at transitions, and reconcile `input_count = accepted_count + review_count + rejected_count` when each input belongs to exactly one outcome.

| Event | Useful context | Level |
|---|---|---|
| Run started | run ID, source | INFO |
| Batch accepted | stage, input count | INFO |
| Normalisation finished | stage, output count | INFO |
| Validation finished | PASS/REVIEW/FAIL counts | INFO or WARNING if review action needed |
| Unexpected stage failure | stage, run ID, exception traceback | ERROR via `logger.exception` |
| Run complete | total and accepted counts | INFO |

Do not log completion after an unhandled failure. Logs help reconstruct what happened, but a missing stage message is only a clue; inspect program control flow, result data, and tests too. The full [workflow script](scripts/06_data_engineering_logging_workflow.py) demonstrates the sequence without dumping records.
