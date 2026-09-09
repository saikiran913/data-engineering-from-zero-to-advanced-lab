# Practice Questions

## Section A - Concept Checks

1. What is a local repository?
2. What is a remote repository?
3. What is `origin`?
4. What is a remote URL?
5. What does `git clone` do?
6. What does `git fetch` do?
7. What does `git pull` do?
8. What does `git push` do?
9. Why is fetch safer for inspection?
10. Why can pull create conflicts?
11. What is an upstream branch?
12. What is a tracking branch?
13. What is a remote-tracking branch?
14. What is `origin/main`?
15. What is `origin/feature/order-validation`?
16. What does ahead mean?
17. What does behind mean?
18. What does diverged mean?
19. Why can push be rejected?
20. Why check status before pull?
21. Why check log before push?
22. Why should large raw data not be pushed by default?
23. Why should secrets never be pushed?
24. What is pull request thinking?
25. Is a pull request a core Git object?
26. What is a PR source branch?
27. What is a PR target branch?
28. Why should PRs be focused?
29. Why does validation still matter before PR review?
30. Why are force push and rebase out of scope?

## Section B - Choose the Command

1. Inspect remote names and URLs.
2. Clone a repository from a URL.
3. Fetch from the default remote.
4. Fetch specifically from `origin`.
5. Check current branch.
6. Check working tree state.
7. Inspect upstream tracking details.
8. Pull remote changes into current branch.
9. First push a feature branch and set upstream.
10. Push later after upstream exists.
11. Inspect all branch history.
12. Compare local HEAD with `origin/main` conceptually.
13. Find repository root.
14. List branches.
15. Check whether a branch is ahead or behind.
16. Inspect files before push.
17. Confirm no local changes before pull.
18. Review graph after fetch.
19. Publish `feature/order-validation`.
20. Check remote configuration after clone.

## Section C - Fetch, Pull, or Push?

Classify each as fetch, pull, or push.

1. Download remote references without changing current branch.
2. Publish local commits.
3. Integrate remote work into current branch.
4. Inspect remote changes first.
5. Send feature branch to remote.
6. Bring remote default branch changes into current branch.
7. Update `origin/main`.
8. Make code visible to collaborators.
9. Operation may create local conflicts.
10. Operation may be rejected because remote has new work.
11. Safe first look at remote state.
12. Often used before inspecting graph.
13. Should be done after validation when publishing.
14. Combines fetch plus integration.
15. Does not upload anything.
16. Does not automatically update working branch.
17. Can publish commits containing secrets if careless.
18. Should happen only after checking current branch.

## Section D - Branch Graph Exercises

1. Local and `origin/main` point to same commit. What state is this?
2. Local has one commit not on `origin/main`. What state is this?
3. `origin/main` has one commit not local. What state is this?
4. Both local and `origin/main` have different new commits. What state is this?
5. After `git fetch`, `origin/main` moves forward. Did local `main` automatically change?
6. A feature branch has two local commits and no upstream. What might first push need?
7. Graph shows `origin/feature/x`. What is it?
8. Graph shows local feature behind `origin/feature/x`. What should learner inspect?
9. Push is rejected after remote advanced. What is the safe next step?
10. Pull reports conflict. What earlier day workflow applies?
11. `git branch -vv` shows ahead 2. What does it mean?
12. `git branch -vv` shows behind 1. What does it mean?

## Section E - PR Review Scenarios

1. PR changes one SQL filter and includes validation.
2. PR changes SQL, docs, generated logs, and unrelated formatting.
3. PR title is `updates`.
4. PR includes `.env`.
5. PR changes a join and includes row-count validation.
6. PR changes schema docs only.
7. PR target branch is wrong.
8. PR source branch includes old unrelated commits.
9. Reviewer asks for edge-case validation.
10. Reviewer catches a grain mismatch.
11. PR description explains purpose and known limitation.
12. PR contains large raw dataset.

## Section F - Safe or Unsafe?

1. Fetch before pulling.
2. Pull with a dirty working tree.
3. Push after checking status, log, and secrets.
4. Force push after rejection.
5. Push `.env`.
6. Push a focused feature branch with `-u`.
7. Use rebase to fix sync as a beginner.
8. Open focused PR with validation notes.
9. Ignore push rejection.
10. Clone into a clearly named disposable folder.
11. Clone inside another repo by accident.
12. Treat remote as the only backup.
13. Push generated logs.
14. Follow team policy before integration.

## Section G - Mini Case

A learner clones a repository, creates `feature/order-validation`, commits SQL and docs, notices `debug.log` and `.env`, fetches and sees remote main has moved, then wants to publish a clean feature branch for review.

Answer:

1. What should they inspect before pushing?
2. Which files should not be pushed?
3. What command fetches remote state?
4. What command shows graph history?
5. What does it mean if local feature is ahead?
6. What does it mean if remote main moved?
7. What should happen before integrating remote work?
8. What command first-pushes the feature branch?
9. What should the PR source branch be?
10. What should the PR target branch be?
11. What validation evidence should be included?
12. Why should force push not be used?

## Answer Key

### Section A

1. Repository on your machine.
2. Shared repository elsewhere.
3. Common default remote name.
4. Location used to clone or connect to a repository.
5. Creates local copy from remote.
6. Downloads remote references.
7. Fetches and integrates into current branch.
8. Publishes local commits.
9. It does not integrate into current branch.
10. It integrates remote work into local work.
11. Remote branch tracked by local branch.
12. Local branch connected to upstream.
13. Local reference to remote state.
14. Local reference to remote `main`.
15. Local reference to remote feature branch.
16. Local has commits remote does not.
17. Remote has commits local does not.
18. Both sides have different new commits.
19. Remote may contain work local branch lacks.
20. Pull changes current branch.
21. Push publishes commits.
22. Git is not raw-data storage by default.
23. Secrets become exposed in shared history.
24. Review proposal thinking.
25. No.
26. Branch proposing changes.
27. Branch receiving changes.
28. Easier review and safer merge.
29. Reviewers need evidence and correctness.
30. They can rewrite history or add complexity.

### Section B

1. `git remote -v`
2. `git clone <repository-url>`
3. `git fetch`
4. `git fetch origin`
5. `git branch --show-current`
6. `git status`
7. `git branch -vv`
8. `git pull`
9. `git push -u origin feature/name`
10. `git push`
11. `git log --oneline --graph --decorate --all`
12. `git diff HEAD..origin/main`
13. `git rev-parse --show-toplevel`
14. `git branch`
15. `git branch -vv`
16. `git status` and `git diff`
17. `git status`
18. `git log --oneline --graph --decorate --all`
19. `git push -u origin feature/order-validation`
20. `git remote -v`

### Section C

1. Fetch.
2. Push.
3. Pull.
4. Fetch.
5. Push.
6. Pull.
7. Fetch.
8. Push.
9. Pull.
10. Push.
11. Fetch.
12. Fetch.
13. Push.
14. Pull.
15. Fetch.
16. Fetch.
17. Push.
18. Pull or push, depending on direction; always confirm branch first.

### Section D

1. In sync.
2. Local ahead.
3. Local behind.
4. Diverged.
5. No.
6. `git push -u origin feature/name`.
7. Remote-tracking branch.
8. Fetch, graph, status, and team policy.
9. Fetch and inspect.
10. Day 048 conflict workflow.
11. Two local commits not on upstream.
12. One upstream commit not local.

### Section E

1. Good.
2. Too broad.
3. Weak title.
4. Unsafe.
5. Good review evidence.
6. Good if focused.
7. Must be corrected before merge.
8. Needs cleanup or explanation.
9. Add validation if appropriate.
10. Fix before merge.
11. Good.
12. Unsafe by default.

### Section F

1. Safe.
2. Unsafe.
3. Safe.
4. Unsafe.
5. Unsafe.
6. Safe.
7. Unsafe for Day 049.
8. Safe.
9. Unsafe.
10. Safe.
11. Unsafe.
12. Unsafe assumption.
13. Unsafe by default.
14. Safe.

### Section G

1. Current branch, status, log, diff, staged diff if relevant, and sensitive files.
2. `debug.log` and `.env`.
3. `git fetch`.
4. `git log --oneline --graph --decorate --all`.
5. Local branch has commits not on upstream.
6. Remote default branch has newer work.
7. Inspect status, graph, differences, and team policy.
8. `git push -u origin feature/order-validation`.
9. `feature/order-validation`.
10. The intended default or integration branch.
11. SQL review, docs review, and any safe validation output.
12. It can overwrite shared history and is out of scope.
