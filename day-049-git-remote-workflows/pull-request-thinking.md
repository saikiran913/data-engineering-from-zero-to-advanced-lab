# Pull Request Thinking

A pull request is not a core Git object. It is a review surface used by hosting platforms.

## Main Ideas

| Concept | Meaning |
|---|---|
| Source branch | Branch proposing changes |
| Target branch | Branch receiving changes if approved |
| Review surface | Place where reviewers inspect changes |
| Merge proposal | Request to combine work |
| Validation evidence | Proof that checks were run |

## Good Pull Request

A good pull request is:

- focused
- clearly titled
- concise
- purpose-driven
- validated
- honest about known limitations
- free of secrets

## Reviewer Checks

Reviewers may check:

- correctness
- data grain
- joins
- edge cases
- tests or validation
- documentation
- naming
- scope
- unexpected files

## Data Engineering Reminder

Review is not only style. It protects pipeline behaviour, business rules, and reproducibility.
