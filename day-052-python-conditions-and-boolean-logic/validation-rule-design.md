# Validation Rule Design

Validation logic translates business rules into clear Python conditions.

## Rule Components

1. input
2. expected condition
3. Boolean expression
4. outcome
5. message

Example:

```text
Input: record_count
Rule: must be greater than zero
Expression: record_count > 0
Outcome: PASS / FAIL
Message: "Source contains records"
```

## Named Conditions

```python
record_count = 120
error_rate = 0.5
schema_valid = True

has_rows = record_count > 0
error_rate_ok = error_rate <= 1.0
schema_is_valid = schema_valid
```

## Combined Rule

```python
all_checks_pass = has_rows and error_rate_ok and schema_is_valid
```

## PASS / REVIEW / FAIL Thinking

- `PASS` = no issue found
- `REVIEW` = small issue or unclear state needs attention
- `FAIL` = severe issue or required rule failed

Exact statuses depend on the business process.

## Validation Messages

Every outcome should explain why.

```python
if all_checks_pass:
    print("PASS: source passed required checks")
else:
    print("REVIEW: one or more checks need attention")
```

## Avoid Silent Default

Do not let unexpected states disappear. Use a fallback branch where appropriate.

## Validate Boundaries

Test below, exactly at, and above each threshold.

## Keep Business Rules Centralised Conceptually

As code grows, keep rules easy to find and review. Functions and configuration files are future topics.
