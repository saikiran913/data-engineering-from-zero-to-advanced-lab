# Retry Safety and Idempotency

An operation is **idempotent** when repeating it does not create unintended additional effects. Recomputing `sum([2, 3])` gives the same answer. Appending `"synthetic_output"` to a list twice creates two entries. Both examples are in memory, but they show why a repeated write or output operation might duplicate records. A duplicate charge or remote write is a conceptual risk only; this lesson performs neither.

In a real system, a timeout can leave the first attempt's outcome unknown. A retry might repeat an effect that actually succeeded. A local counter or check in a toy script does **not** prove exactly-once remote behavior. The retry policy must know which operation is repeatable or how duplicate effects would be prevented.

| Safety question | Why ask it? |
|---|---|
| Is the failure a known transient type? | Do not retry invalid data or bugs |
| Is there a positive attempt bound? | Prevent unending loops |
| Are repeated side effects safe? | Avoid duplicate output |
| Is recovery or exhaustion reported? | Keep run status honest |
| Are diagnostics concise? | Avoid log spam and leaks |

> A retry can repeat side effects. Before retrying writes or external operations, verify that the operation is idempotent or protected against duplicate effects.
