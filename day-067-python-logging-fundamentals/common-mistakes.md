# Common Logging Mistakes

Most logging problems come from unclear operational meaning, misplaced configuration, or messages with too much or too little context.

| # | Problem | Why it hurts | Better choice |
|---|---|---|---|
| 1 | Only using `print` for diagnostics | No severity or filtering | Use a named logger for events |
| 2 | Logging every normal stage at ERROR | Hides real failures in noise | Use INFO for milestones |
| 3 | Treating every validation FAIL as ERROR | Business status is not operational severity | Summarise outcomes separately |
| 4 | Calling a routine warning CRITICAL | Escalates ordinary work | Reserve CRITICAL for system-wide inability to proceed |
| 5 | Logging a password | Exposes a secret | Omit it entirely |
| 6 | Logging a token | Exposes a credential | Report a safe category only |
| 7 | Logging personal data | Creates privacy risk | Log counts and non-sensitive source labels |
| 8 | Logging a raw row | Can leak unexpected fields | Log a stage summary |
| 9 | Logging every row | Expensive and unreadable | Aggregate counts |
| 10 | Logging the same exception at every layer | Duplicated alarms | Let one owning layer log it |
| 11 | Calling `logger.exception` outside `except` | No useful active traceback | Call inside a specific handler |
| 12 | Catching every exception broadly | Masks programming errors | Catch a known exception type |
| 13 | Logging ERROR and continuing silently | Suggests failure was handled | Explicitly handle or propagate |
| 14 | Configuring in each helper | Repeated or inconsistent output | Configure once in `main` |
| 15 | Adding a handler to child and root | Propagation duplicates lines | Reuse the root handler |
| 16 | Assuming logs use stdout | Console logs usually use stderr | Inspect both streams |
| 17 | Expecting DEBUG at INFO threshold | It is filtered out | Adjust the threshold deliberately |
| 18 | Mismatching `%s` and arguments | Causes formatting errors | Count placeholders and values |
| 19 | Eagerly building an expensive f-string for DEBUG | Work happens even if filtered | Pass `%s` arguments |
| 20 | Omitting `run_id` | Hard to connect stages | Use a stable run ID |
| 21 | Omitting `stage` | Hard to locate failure | Name the stage |
| 22 | Using inconsistent context keys | Hard to scan or search | Standardise key names |
| 23 | Logging only START | No proof of later progress | Add stage and completion summaries |
| 24 | Logging COMPLETE after failure | Misleads readers | Only complete after success |
| 25 | Replacing validation with log text | Logs are not data results | Keep structured validation outcomes |
| 26 | Claiming key=value text is JSON | Misrepresents its structure | Call it readable key=value context |
| 27 | Logging unbounded exception text | It may include source values | Keep known exception messages safe |
| 28 | Missing source counts | Cannot reconcile stages | Record bounded input/output totals |
| 29 | Logging an important stage failure only at DEBUG | It disappears at INFO threshold | Use ERROR for actual failed operations |
| 30 | Configuring logging during helper import | Import changes global behavior | Configure from the entry point |
| 31 | Asserting exact `asctime` text in tests | Wall-clock time varies | Assert meaningful event fields instead |
| 32 | Suppressing the useful failure cause | `failed` alone is hard to diagnose | Add safe stage context and a traceback when appropriate |
| 33 | Logging sensitive configuration | Config may contain credentials | Log only safe configuration categories |
| 34 | Using logs as the only monitoring system | They do not guarantee alerts or metrics | Keep results, metrics, tests, and alerts separate |

The same log statement may be correct in one application and too noisy in another. Choose messages for questions an operator will actually ask.
