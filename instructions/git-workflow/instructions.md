---
name: git-workflow
description: Git workflow guidance for branch naming, conventional commits, PR titles, merge strategy, and safe history rewriting across collaborative repositories.
category: operations
---

# Git Workflow Instructions for Codex

Keep history readable, reviewable, and safe for collaborators by using consistent branch names, conventional commits, and disciplined merge behavior.

## Scope
- Name branches and PRs predictably.
- Write conventional commit messages with useful bodies.
- Choose squash, merge, or rebase intentionally.
- Rewrite history safely when collaboration requires it.
- Keep release history understandable.

## Standards and Conventions

### Branch Naming

| Change Type | Pattern | Example |
| --- | --- | --- |
| Feature | `feat/<topic>` | `feat/api-pagination` |
| Fix | `fix/<topic>` | `fix/jwt-expiry-check` |
| Chore | `chore/<topic>` | `chore/update-ci` |

### Conventional Commits

| Type | Use When |
| --- | --- |
| `feat:` | User-visible capability added |
| `fix:` | Bug fixed |
| `docs:` | Documentation only |
| `chore:` | Maintenance with no product behavior change |
| `refactor:` | Structure changed without behavior change |
| `test:` | Tests added or updated |
| `perf:` | Measurable performance improvement |

Commit shape:

```text
feat(api): add cursor pagination to list users

Why:
- offset scans were timing out on large tenants

What:
- added cursor token parsing
- exposed page.has_more
```

### PR Titles and Bodies

| Field | Format |
| --- | --- |
| PR title | `<type>(<scope>): <summary>` |
| Description | problem, approach, risks, validation |
| Linked work | issue or ticket reference when available |

### Merge Strategy

| Situation | Preferred | Avoid |
| --- | --- | --- |
| Small feature branch | Squash merge | Preserving noisy fixup history |
| Multi-commit change with meaningful milestones | Merge commit | Squashing away useful audit trail |
| Local cleanup before review | Interactive rebase locally | Rewriting shared branch unexpectedly |

### Safe Force Pushes

| Operation | Rule |
| --- | --- |
| Rewrite your own reviewed branch | Use `--force-with-lease` |
| Rewrite shared branch used by others | Do not do it without explicit coordination |
| Recover from mistaken push | Prefer revert when branch is public |

### BAD / GOOD Examples

BAD

```text
commit message: stuff
branch: new-branch
```

GOOD

```text
commit message: fix(auth): reject expired refresh tokens
branch: fix/refresh-token-expiry
```

## When to Apply These Patterns
- Start a new feature or fix branch.
- Prepare commits before opening a PR.
- Rename a noisy branch before review.
- Decide whether to squash or merge.
- Rewrite branch history after review feedback.
- Audit commit hygiene before release.
- Recover from a mistaken push safely.

## Checklist
- [ ] Branch name matches `feat/`, `fix/`, or `chore/` intent.
- [ ] Commit subject uses a conventional commit type.
- [ ] Commit body explains why the change exists when context is non-trivial.
- [ ] PR title matches commit style.
- [ ] Merge strategy fits the branch history.
- [ ] Shared history is never force-pushed without `--force-with-lease`.
- [ ] Review fixups are squashed or left intentionally.
