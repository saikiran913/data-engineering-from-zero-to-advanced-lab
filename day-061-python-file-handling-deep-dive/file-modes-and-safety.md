# File Modes and Safety

| Goal | Mode |
| --- | --- |
| Read source | `r` |
| Replace generated output | `w` |
| Intentionally append | `a` |
| Create only if absent | `x` |

`w` truncates before writing. `a` can duplicate output on reruns. Never use either mode on `sample-data`.

Text mode is the normal choice for `.txt`, `.csv`, and `.json`; binary mode is for non-text formats and is outside this lesson. Prefer `x` when a generated file must never be replaced accidentally, and always review the resolved destination path before using `w`.
