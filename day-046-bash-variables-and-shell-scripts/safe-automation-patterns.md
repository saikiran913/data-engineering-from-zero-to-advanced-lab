# Safe Automation Patterns

## Pattern 1 - Validate Then Read

```text
argument
→ file exists?
→ process
→ summary
```

## Pattern 2 - Safe Output Directory

All generated output should go to:

```text
practice-output/
```

## Pattern 3 - Preview Before Write

Run a command without redirection first. Redirect only after the output looks correct.

## Pattern 4 - Explicit Input

Prefer arguments or clear configuration variables over unknown hardcoded paths.

## Pattern 5 - Safe Defaults

If required input is missing:

- print usage
- exit non-zero
- do nothing else

## Pattern 6 - Idempotency Concept

> Running the same read-only validation script twice should ideally not create different side effects.

## Pattern 7 - Dry-Run Concept

A dry run shows what would happen without performing a changing action. Day 046 introduces the idea only conceptually.

## Pattern 8 - Logging Concept

Normal summaries can go to stdout. Error messages should go to stderr. Optional logs should be written only to practice output files.

## Pattern 9 - Keep Scripts Small

Small scripts are easier to inspect, test, and trust.

## Pattern 10 - Manual Testing Before Scheduling

Do not schedule beginner scripts. Run them manually with sample data and inspect the output.
