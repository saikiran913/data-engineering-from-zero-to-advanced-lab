# Practice Questions

## Section A - Concept Checks

1. What is a Git branch?
2. Why do branches exist?
3. What is a default branch?
4. Why do many repositories use `main`?
5. Why might another repository use a different default branch name?
6. What is a feature branch?
7. What is the current branch?
8. What does HEAD mean conceptually?
9. What is a branch pointer?
10. What does `git branch` show?
11. What does `git branch --show-current` show?
12. What does `git switch -c feature/name` do?
13. What does `git switch main` do?
14. Why does Day 048 prefer `git switch`?
15. Why is a branch not a folder?
16. Why should feature branches stay focused?
17. What does branch comparison help detect?
18. What does merging mean?
19. Why does merge direction matter?
20. What is a fast-forward merge?
21. What is a merge commit?
22. Why can Git merge automatically?
23. What is a merge conflict?
24. Why are conflicts normal?
25. What do conflict markers show?
26. Why must conflict markers be removed?
27. Why should `git status` be used during conflict resolution?
28. Why must resolved files be staged?
29. Why is validation required after merge?
30. Why are rebase and destructive history rewriting outside Day 048?

## Section B - Choose the Command

1. Show current branch.
2. List local branches.
3. Create and switch to `feature/order-validation`.
4. Switch to the default branch named `main`.
5. Check repository state.
6. Review unstaged changes.
7. Stage `docs/validation-notes.md`.
8. Commit staged changes with a clear message.
9. Compare `main` and `feature/order-validation`.
10. Show a graph of all branch history.
11. Merge `feature/order-validation` into the current branch.
12. Check status during a conflict.
13. Stage a resolved file.
14. Show compact history.
15. Find repository root.
16. Show current branch using a rev-parse form conceptually.
17. Compare branch file-change summary.
18. Inspect a commit.

## Section C - Predict the Branch State

1. You run `git switch -c feature/log-review`. What branch are you on?
2. You commit on a feature branch. Has main changed automatically?
3. You switch to main and merge the feature. Which branch receives changes?
4. Git says fast-forward. Is that automatically bad?
5. Two branches edit different files. What may happen during merge?
6. Two branches edit the same line. What may happen?
7. A file contains `<<<<<<<`. What does that mean?
8. You resolve a conflict but forget `git add`. Is Git finished?
9. You merge from the wrong current branch. What is the risk?
10. A branch is named `stuff`. What is the issue?
11. A branch contains unrelated SQL and docs changes. What is the issue?
12. `git diff main..feature/name` shows unexpected files. What should you do?
13. Automatic merge completes. Can business logic still be wrong?
14. Final status is clean after merge. What does that usually mean?

## Section D - Read the History Graph

1. `A---B main` means what?
2. `A---B main` and `A---B---C feature` means what?
3. A branch label points to commit `D`. What does that mean?
4. `main` and `feature` point to the same commit. What does that mean?
5. Feature has commits not on main. What should happen before merge?
6. Main and feature both moved after a shared point. What might merge create?
7. A graph shows a merge commit `M`. What does `M` represent?
8. A graph has several branch labels. What should you check before editing?
9. A graph shows old feature branch far behind main. What risk increases?
10. A clean graph does not prove business logic is correct. Why?

## Section E - Resolve the Conflict Conceptually

For each, explain sensible final content.

1.
```text
<<<<<<< HEAD
Allowed statuses: COMPLETED, PENDING
=======
Allowed statuses: COMPLETED, PENDING, CANCELLED
>>>>>>> feature/statuses
```

2.
```text
<<<<<<< HEAD
Review rule: Investigate failed payments.
=======
Review rule: Investigate refunded orders.
>>>>>>> feature/refunds
```

3.
```text
<<<<<<< HEAD
Daily query checks completed orders.
=======
Daily query checks completed and pending orders.
>>>>>>> feature/pending
```

4.
```text
<<<<<<< HEAD
Owner: data-quality-review
=======
Owner: pipeline-validation-review
>>>>>>> feature/docs
```

5.
```text
<<<<<<< HEAD
WHERE order_status = 'COMPLETED'
=======
WHERE order_status IN ('COMPLETED', 'PENDING')
>>>>>>> feature/sql-filter
```

6.
```text
<<<<<<< HEAD
Threshold: 100 rows
=======
Threshold: 120 rows
>>>>>>> feature/threshold
```

7.
```text
<<<<<<< HEAD
Use sample data only.
=======
Use generic sample data only.
>>>>>>> feature/wording
```

8.
```text
<<<<<<< HEAD
Validation runs daily.
=======
Validation runs after each sample load.
>>>>>>> feature/timing
```

9.
```text
<<<<<<< HEAD
Check order_id.
=======
Check order_id and customer_id.
>>>>>>> feature/keys
```

10.
```text
<<<<<<< HEAD
Warnings require review.
=======
Errors and warnings require review.
>>>>>>> feature/errors
```

11.
```text
<<<<<<< HEAD
Status check is optional.
=======
Status check is required.
>>>>>>> feature/required-check
```

12.
```text
<<<<<<< HEAD
Document row count only.
=======
Document row count and status checks.
>>>>>>> feature/notes
```

## Section F - Safe or Unsafe?

1. Confirm current branch before editing.
2. Create a focused feature branch.
3. Merge feature while currently on the intended target branch.
4. Commit conflict markers.
5. Use rebase as a beginner shortcut.
6. Use destructive history commands to escape a conflict.
7. Compare branch before merge.
8. Validate after automatic merge.
9. Put secret information in a branch name.
10. Use remote commands in Day 048 practice.
11. Stage a resolved file after manually removing markers.
12. Assume Git validates SQL business logic.

## Section G - Mini Case Study

Main has a stable SQL query. A feature branch adds a status filter. Main independently updates a validation list. The learner must merge safely.

Answer:

1. What is the target branch?
2. What command inspects current status?
3. What command compares branches?
4. What command starts the merge?
5. What command inspects conflict state?
6. How should final logic be chosen?
7. What must happen to conflict markers?
8. How should SQL be validated?
9. What command stages the resolved file?
10. What command completes the merge?
11. What command inspects the graph?
12. Why are rebase and destructive recovery commands unnecessary here?

## Answer Key

### Section A

1. A named line of Git history.
2. To isolate work.
3. The repository's main line of work.
4. It is a common modern default.
5. Defaults vary by repository and history.
6. A focused branch for one change.
7. The branch currently checked out.
8. Git's current position conceptually.
9. A branch name pointing to a commit.
10. Local branches.
11. The current branch name.
12. Creates and switches to a branch.
13. Switches to `main`.
14. It is clearer for branch switching.
15. It is history, not a directory.
16. To keep review and merge simple.
17. Unexpected or unrelated changes.
18. Bringing one branch's work into another.
19. The current branch receives changes.
20. A merge that moves the target pointer forward.
21. A commit recording combined histories.
22. Non-overlapping text changes can often be combined.
23. A situation where Git needs a human decision.
24. Overlapping work happens in real projects.
25. Competing versions of the same area.
26. They are not valid final source content.
27. It shows files needing resolution.
28. `git add` marks conflict resolution.
29. Git combines text, not business correctness.
30. They can rewrite or discard history and are advanced.

### Section B

1. `git branch --show-current`
2. `git branch`
3. `git switch -c feature/order-validation`
4. `git switch main`
5. `git status`
6. `git diff`
7. `git add docs/validation-notes.md`
8. `git commit -m "Add validation notes"`
9. `git diff main..feature/order-validation`
10. `git log --oneline --graph --decorate --all`
11. `git merge feature/order-validation`
12. `git status`
13. `git add docs/validation-notes.md`
14. `git log --oneline`
15. `git rev-parse --show-toplevel`
16. `git rev-parse --abbrev-ref HEAD`
17. `git diff --stat main..feature/order-validation`
18. `git show`

### Section C

1. `feature/log-review`.
2. No.
3. The current target branch.
4. No, it is normal.
5. Git may merge automatically.
6. A conflict may happen.
7. A conflict marker remains.
8. No, the resolved file must be staged.
9. Changes may merge into the wrong branch.
10. The purpose is unclear.
11. Review and merge become harder.
12. Stop and inspect before merging.
13. Yes.
14. Git sees no unresolved or uncommitted merge work.

### Section D

1. Main points to commit `B`.
2. Feature has commit `C` beyond main.
3. The branch currently ends at `D`.
4. They currently share the same latest commit.
5. Compare and review before merging.
6. A merge commit may be created.
7. Histories were combined.
8. Current branch.
9. Conflict and review complexity can increase.
10. Git history does not prove business rules are correct.

### Section E

Answers vary. A good answer removes all markers and keeps the intended business meaning. For example:

1. `Allowed statuses: COMPLETED, PENDING, CANCELLED`
2. `Review rule: Investigate failed payments and refunded orders.`
3. Choose based on reporting need; do not keep markers.
4. Choose the correct owner label for the process.
5. Choose the filter that matches business logic.
6. Confirm the correct threshold with the rule owner.
7. `Use generic sample data only.`
8. Choose the correct validation timing.
9. `Check order_id and customer_id.` if both keys matter.
10. `Errors and warnings require review.`
11. Choose required/optional based on the actual rule.
12. `Document row count and status checks.`

### Section F

1. Safe.
2. Safe.
3. Safe.
4. Unsafe.
5. Unsafe for Day 048.
6. Unsafe.
7. Safe.
8. Safe.
9. Unsafe.
10. Unsafe for Day 048.
11. Safe.
12. Unsafe assumption.

### Section G

1. The default branch receiving the feature.
2. `git status`.
3. `git diff main..feature-name`.
4. `git merge feature-name`.
5. `git status`.
6. By reviewing both versions and the intended business rule.
7. Remove all markers.
8. Read or run the query safely and check filters/grain.
9. `git add path/to/resolved-file`.
10. `git commit -m "Resolve merge conflict"`.
11. `git log --oneline --graph --decorate --all`.
12. Manual conflict resolution and validation are enough for this beginner local workflow.
