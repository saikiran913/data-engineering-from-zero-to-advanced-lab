# Beginner Summary

## What Learners Should Remember

Functions package reusable logic. `def` defines a function. Parameters receive inputs, and arguments are values passed by the caller.

`return` sends a value back to the caller. `print()` displays information, but it is not a substitute for returning reusable results. A function that prints a calculation may look useful, but the caller cannot easily use the calculated value later.

Local variables exist inside function scope. A variable created inside a function is not automatically available outside it. Hidden global dependencies make functions harder to reason about because required inputs are not visible in the function call.

Functions should have clear interfaces. A good function name explains the job. Good parameter names explain required inputs. A clear return value explains what the caller receives. Focused functions are easier to test, reuse, and review.

Pure transformations are predictable. The same input gives the same output, without hidden external changes. Side effects such as printing, writing files, database updates, or network calls should be deliberate.

Validation functions should return clear outcomes such as `PASS`, `REVIEW`, or `FAIL`. Transformation functions should return transformed values. Main or orchestration code can connect small functions into a larger workflow.

Repeated business logic should usually live in one reusable place. Copying the same rule into many places makes future changes risky.

## Mental Model

```text
Define input
→ call focused function
→ receive output
→ pass output to next step
```

## Required Warnings

> A function should have a clear contract: what inputs it expects, what it returns, and what side effects it performs.

> Avoid hidden dependencies on global variables. Functions are easier to understand, reuse, and test when required values are passed explicitly as parameters.

> `print()` displays information, while `return` sends a value back to the caller. Printing is not a substitute for returning reusable results.

> Keep functions focused. Very large functions that validate, transform, log, write files, and control workflow at the same time are difficult to review and debug.

## Preview

**Day 055 — Python Collections for Data Engineers: Lists, Tuples, Sets, and Dictionaries**

Day 055 will deepen the data structures passed into and returned from functions.
