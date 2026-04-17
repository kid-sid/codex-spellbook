# Contributing

## Branch Naming

- `feat/instruction-<name>` for new instruction sets
- `feat/prompt-<name>` for new prompt templates
- `fix/<issue>` for bug fixes

## Conventional Commits

Use:

- `feat:`
- `fix:`
- `docs:`
- `chore:`

Keep subjects specific and imperative. Add a body when the why is not obvious from the diff.

## Add A New Instruction Set

1. Create `instructions/<domain>/instructions.md` with required frontmatter and sections.
2. Add at least one decision table and one `BAD` / `GOOD` example pair, then end with a checklist.
3. Update the README inventory and counts so the repo index stays accurate.

## Add A New Task Prompt

1. Create a markdown file under the correct `task-prompts/<category>/` directory with frontmatter.
2. Use direct instructions to Codex and `$UPPERCASE` placeholders for user-supplied values.

## Quality Bar

- No meta-commentary or filler prose.
- Avoid phrases like "this instruction covers"; start with the real guidance.
- Keep writing terse and code-forward.
- Use tables for decisions and tradeoffs.
- Use `BAD` / `GOOD` pairs when an example can clarify a rule.
- Match the density and style of `api-design` before opening a PR.

## Pull Request Checklist

- [ ] CI passes.
- [ ] README inventory is updated.
- [ ] New content matches the `api-design` canonical density and structure.
- [ ] Frontmatter is present and valid.
- [ ] Tables and examples are concrete rather than generic filler.
