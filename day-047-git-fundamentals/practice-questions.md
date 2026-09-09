# Practice Questions

## Section A - Concept Checks

1. What is version control?
2. What is Git?
3. What is GitHub?
4. Why is Git not the same as GitHub?
5. What is a repository?
6. What is the repository root?
7. What does `.git` store conceptually?
8. What is the working tree?
9. What is a tracked file?
10. What is an untracked file?
11. What is a modified file?
12. What is a staged file?
13. What is a commit?
14. What is a commit hash?
15. What does HEAD mean conceptually?
16. What is the staging area?
17. Why does Git have a staging area?
18. What does `git status` show?
19. What does `git diff` show?
20. What does `git diff --staged` show?
21. What does `git add` do?
22. What does `git commit` do?
23. What does `git log` show?
24. What does `git show` inspect?
25. What is `.gitignore` for?
26. Why should secrets never be committed?
27. Why are small commits useful?
28. Why does Git history support reproducibility?
29. What is a local commit?
30. Why are remote workflows out of scope for Day 047?

## Section B - Identify the Git State

Classify each as untracked, modified, staged, committed, ignored, or clean.

1. A new `notes.md` file appears in `git status`.
2. `sql/daily_orders.sql` was changed after the last commit.
3. `docs/validation-notes.md` was added with `git add`.
4. A change appears in `git log`.
5. `git status` says nothing to commit.
6. `practice-output/result.log` matches `.gitignore`.
7. A new `.env` appears as untracked.
8. A tracked README was edited.
9. A staged SQL file is ready for the next commit.
10. A generated cache file is not shown because it is ignored.
11. A commit was created with a clear message.
12. A file is new but not staged.
13. A file was staged, then edited again.
14. A documentation folder was staged.
15. A tracked script changed locally.
16. The working tree is clean after commit.

## Section C - Choose the Command

Use only Day 047 commands.

1. Check whether Git is available.
2. Find the repository root.
3. Check repository state.
4. Review unstaged changes.
5. Stage one SQL file.
6. Stage the docs directory.
7. Review staged changes.
8. Create a local commit with a message.
9. View compact history.
10. View the latest five commits.
11. Inspect one commit by hash.
12. Inspect commit file-change stats.
13. Check whether you are inside a working tree.
14. Start a new isolated practice repository.
15. Confirm staged files before commit.
16. Review current state after commit.
17. Show full commit history.
18. Check whether a new file is untracked.

## Section D - Order the Workflow

Put each workflow in a safer order.

1. `git add`, `git status`, `git diff`, `git commit`
2. edit file, `git commit`, `git diff`, `git status`
3. `git diff --staged`, `git add`, `git status`, `git commit`
4. `git commit`, `git status`, `git log --oneline`
5. `git add .`, inspect files, `git status`
6. make change, `git status`, `git diff`, validate change
7. stage file, inspect staged diff, write commit message
8. inspect repo root, initialise isolated practice repo, check status
9. create new file, inspect file, stage file, commit
10. modify SQL, modify unrelated notes, create one logical commit
11. find secret in diff, commit, rotate later
12. stage docs, review staged diff, commit documentation change

## Section E - Commit Message Review

Classify each as good or weak.

1. `Add daily order validation query`
2. `changes`
3. `Document staging checks`
4. `stuff`
5. `Fix completed order status filter`
6. `update`
7. `Add sample validation notes`
8. `final`
9. `Refine count rows script usage message`
10. `misc`
11. `Add order sample CSV for Git practice`
12. `work`

## Section F - Safe or Unsafe?

1. Stage one reviewed SQL file.
2. Use broad staging without checking status.
3. Commit an `.env` file.
4. Commit a small generic sample CSV.
5. Commit a large raw private dataset.
6. Initialise Git inside a disposable copied practice folder.
7. Initialise Git blindly inside an unknown folder.
8. Commit generated logs accidentally.
9. Review `git diff --staged` before commit.
10. Use a local commit message that explains purpose.
11. Use a remote command during Day 047 practice.
12. Copy destructive recovery commands without understanding them.

## Section G - Mini Case Study

A learner modifies `sql/daily_orders.sql`, updates `docs/validation-notes.md`, accidentally creates `debug.log`, and has an untracked `.env`.

Answer:

1. What command should they run first?
2. Which files likely belong in the commit?
3. Which files should not be committed?
4. Which command reviews unstaged SQL/doc changes?
5. Which command stages the intended SQL file?
6. Which command stages the intended docs file?
7. Which command reviews staged changes?
8. Suggest a clear commit message.
9. Which command inspects history after commit?
10. What must they do if a secret appears in a diff?

## Answer Key

### Section A

1. A system for recording change history.
2. A distributed version control tool.
3. A hosted collaboration platform built around Git repositories.
4. Git tracks history; GitHub hosts repositories and collaboration features.
5. A project managed by Git.
6. The top-level folder of the repository.
7. Git metadata and history.
8. The current checked-out project files.
9. A file Git already knows about.
10. A new file Git does not track yet.
11. A tracked file changed since last commit.
12. A change selected for the next commit.
13. A recorded logical change.
14. A unique identifier for a commit.
15. The current checked-out commit conceptually.
16. The place selected changes wait before commit.
17. To choose exact changes for the next commit.
18. Repository state.
19. Unstaged line-level changes.
20. Staged line-level changes.
21. Stages selected files or directories.
22. Records staged changes locally.
23. Commit history.
24. Details of a commit.
25. To keep matching untracked files out of normal staging.
26. Git history can expose sensitive data.
27. They are easier to review and understand.
28. It links results to exact file versions.
29. A commit recorded on your machine.
30. Local fundamentals should be understood first.

### Section B

1. Untracked.
2. Modified.
3. Staged.
4. Committed.
5. Clean.
6. Ignored.
7. Untracked and should not be committed.
8. Modified.
9. Staged.
10. Ignored.
11. Committed.
12. Untracked.
13. Both staged and modified conceptually.
14. Staged.
15. Modified.
16. Clean.

### Section C

1. `git --version`
2. `git rev-parse --show-toplevel`
3. `git status`
4. `git diff`
5. `git add sql/daily_orders.sql`
6. `git add docs/`
7. `git diff --staged`
8. `git commit -m "Clear commit message"`
9. `git log --oneline`
10. `git log --oneline -5`
11. `git show <commit-hash>`
12. `git show --stat <commit-hash>`
13. `git rev-parse --is-inside-work-tree`
14. `git init` only inside an isolated practice folder
15. `git status` and `git diff --staged`
16. `git status`
17. `git log`
18. `git status`

### Section D

1. `git status`, `git diff`, `git add`, `git status`, `git diff --staged`, `git commit`.
2. edit file, `git status`, `git diff`, `git add`, `git diff --staged`, `git commit`.
3. `git status`, `git add`, `git diff --staged`, `git commit`.
4. `git status`, `git commit`, `git log --oneline`.
5. inspect files, `git status`, then stage exact files.
6. make change, validate change, `git status`, `git diff`.
7. stage file, inspect staged diff, commit with a message.
8. inspect repo root, enter isolated folder, initialise practice repo, check status.
9. create new file, inspect file, check status, stage file, review staged diff, commit.
10. Separate unrelated changes into separate commits.
11. Do not commit; remove the secret safely and seek help if exposed.
12. stage docs, review staged diff, commit documentation change.

### Section E

1. Good.
2. Weak.
3. Good.
4. Weak.
5. Good.
6. Weak.
7. Good.
8. Weak.
9. Good.
10. Weak.
11. Good.
12. Weak.

### Section F

1. Safe.
2. Unsafe.
3. Unsafe.
4. Safe if generic and intentional.
5. Unsafe.
6. Safe for Day 047.
7. Unsafe.
8. Unsafe.
9. Safe.
10. Safe.
11. Unsafe for Day 047 scope.
12. Unsafe.

### Section G

1. `git status`.
2. `sql/daily_orders.sql` and `docs/validation-notes.md`, if related.
3. `debug.log` and `.env`.
4. `git diff`.
5. `git add sql/daily_orders.sql`.
6. `git add docs/validation-notes.md`.
7. `git diff --staged`.
8. `Update daily order validation notes`.
9. `git log --oneline`.
10. Do not commit it; remove it safely and rotate the credential if it was exposed externally.
