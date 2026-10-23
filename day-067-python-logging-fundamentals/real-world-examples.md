# Real-World Logging Examples

These are generic pipeline situations. Each context field is a safe summary rather than a raw row. An event's level describes operational meaning, not a business record's PASS/REVIEW/FAIL status.

| # | Situation | Event and level | Safe context | Why useful | Pitfall |
|---|---|---|---|---|---|
| 1 | Batch starts | START, INFO | run ID, source | Locate run | No run ID |
| 2 | In-memory batch received | READ, INFO | count | Know expected input | Log records |
| 3 | Normalisation begins | NORMALISE start, DEBUG | stage | Trace slow stage | Too many DEBUG lines |
| 4 | Normalisation ends | NORMALISE complete, INFO | count | Compare input/output | Ignore lost rows |
| 5 | Validation begins | VALIDATE start, INFO | input count | Locate boundary | Per-row START |
| 6 | Validation PASS | Summary, INFO | pass count | Reconcile | Claim all data is good from logs alone |
| 7 | Validation REVIEW | Summary, WARNING | review count | Flag action | ERROR per row |
| 8 | Validation FAIL | Summary, INFO | fail count | Keep outcome visible | Confuse FAIL with crash |
| 9 | An amount is malformed | Invalid category, WARNING | invalid count | Diagnose quality | Print bad amount |
| 10 | Zero rows arrive | Empty batch, WARNING | source, count=0 | Investigate absence | Declare a crash unconditionally |
| 11 | Counts disagree | Reconciliation failure, ERROR | stage, totals | Detect logic issue | Continue as success |
| 12 | A stage raises | Failure, ERROR via exception | run ID, stage | Get traceback | Log it twice |
| 13 | A retry is scheduled | Retry, WARNING | attempt number | Show recovery path | Log credentials |
| 14 | Retry succeeds | Recovery, INFO | attempt number | Close incident | Leave stale failure status |
| 15 | Run completes | COMPLETE, INFO | accepted count | Identify finish | Emit after failure |
| 16 | Debugging a filter | Filter counts, DEBUG | before/after counts | Locate loss | Log row contents |
| 17 | Component name matters | Component event, INFO | logger name | Find module | Configure every module |
| 18 | Several runs overlap | Stage event, INFO | run ID | Correlate events | Use changing field names |
| 19 | Source category changes | Source event, INFO | safe source label | Explain mix | Include source path with secrets |
| 20 | Output is deliberately printed | Result, print | accepted count | User-readable value | Mistake print for diagnostic log |
| 21 | Threshold is raised | DEBUG filtered | configured level | Reduce volume | Assume message was never called |
| 22 | Pipeline cannot proceed | CRITICAL | stage, safe reason | Escalate major outage | Use for routine bad row |
| 23 | Duplicate lines appear | Handler audit, DEBUG | logger name | Find setup error | Assume duplicate ingestion |
| 24 | An exception is handled | Recovery, WARNING | stage, safe reason | Show decision | Swallow it silently |
| 25 | Optional field is absent | Quality summary, INFO | missing count | Quantify completeness | Log the row |
| 26 | Unsupported status appears | Validation summary, WARNING | unsupported count | Guide review | Claim Python crashed |
| 27 | Required field is absent | Validation summary, INFO | failed count | Measure rejection | Log personal identifiers |
| 28 | Data appears stale | Freshness warning, WARNING | safe age or period | Prompt investigation | Claim a file was read in this lesson |
| 29 | A run is repeated | START, INFO | new run ID, source | Separate attempts | Reuse an ambiguous run ID |
| 30 | A threshold is approached | Threshold warning, WARNING | count, threshold | Trigger review | Emit one warning per row |
| 31 | A stage aborts | Abort, ERROR | run ID, stage | Clarify no completion | Log COMPLETE anyway |
| 32 | Secret-bearing config exists | Safe config event, INFO | config category | Confirm mode | Print or log the config object |

For a concrete pattern, see [the workflow](scripts/06_data_engineering_logging_workflow.py). It logs one summary per stage, not one event per order. For actual alerting or historical metrics, build dedicated systems later; console logs alone do not supply them.
