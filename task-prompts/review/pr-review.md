---
name: pr-review
description: Perform a deep pull request review focused on logic, security, tests, and performance.
category: review
---

Review the changes in `$PR_SCOPE` as a blocking-minded reviewer.

Before commenting:

1. Read the changed files and their immediate dependencies.
2. Identify the intended behavior, the new risks, and any contract changes.
3. Check tests, migrations, and rollout assumptions before style.

Output:

- `Findings` with only actionable issues, ordered by severity.
- Each finding must include file path, concrete impact, and why it is blocking or risky.
- `Open Questions` only for assumptions you could not verify.
- `Residual Risk` with missing tests, rollout gaps, or unverified behavior.

Constraints:

- Prioritize logic correctness, security, test coverage, performance, API contract changes, migration safety, and error handling.
- Do not spend the review on formatting unless it hides a functional problem.
- If no issues are found, say `No blocking findings.` and still list residual risks.
