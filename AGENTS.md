## Purpose

`codex-spellbook` is a curated library of reusable `AGENTS.md` instruction blocks, task prompts, setup scripts, and full agent templates for OpenAI Codex. Treat the repository as source material for precision engineering workflows, not as a prose-heavy documentation site.

## Content Formats

### `instructions/<domain>/instructions.md`

Every instruction file must use this shape:

```markdown
---
name: kebab-case-name
description: Dense keyword-rich sentence describing the domain expertise added.
category: design | development | testing | security | infra | operations
---

# <Domain> Instructions for Codex

Single-sentence summary.

## Scope
- 4-6 bullets

## Standards and Conventions
Code-forward guidance, decision tables, BAD/GOOD examples, terse rationale.

## When to Apply These Patterns
- 6-8 verb-led triggers

## Checklist
- [ ] Shipping checks
```

Required quality rules:

- Start with concrete guidance, not meta-commentary.
- Include at least one decision or comparison table.
- Include at least one `BAD` / `GOOD` example pair.
- End with a `## Checklist` section.
- Keep content language-agnostic where possible; show Python and TypeScript differences when that matters.

### `task-prompts/**/*.md`

Every prompt file must include YAML frontmatter:

```markdown
---
name: task-name
description: What the prompt accomplishes.
category: review | generate | refactor | audit | scaffold | document
---
```

Prompt body rules:

- Speak directly to Codex.
- Use `$UPPERCASE` placeholders for user-supplied values.
- Name files or directories Codex should inspect before acting.
- Define expected output shape and constraints explicitly.

### `agents/*.agents.md`

Each agent template is a production-ready `AGENTS.md` for a project type. Every template must include:

- stack-specific coding conventions
- test expectations
- API and persistence guidance where relevant
- security baseline
- `## Environment Setup` with bash commands Codex should run before work starts

## Authoring Workflow

When adding a new instruction set:

1. Create `instructions/<domain>/instructions.md` with the required frontmatter and sections.
2. Update the README inventory tables and repository structure if counts or categories change.
3. Validate locally before committing.

Canonical examples:

- `instructions/api-design/instructions.md`
- `instructions/coding-standards/instructions.md`

Match their density, table usage, checklist style, and BAD/GOOD example quality.

## Validation

CI rejects instruction files unless they contain:

- YAML frontmatter with `name`, `description`, and `category`
- a `## When to Apply These Patterns` section
- a `## Checklist` section
- at least one unchecked checklist item

CI also validates prompt frontmatter, agent template length, and markdown linting.

## Editing Guidance

- Preserve consistent frontmatter across all markdown artifacts.
- Prefer compact tables over long explanatory prose.
- Use examples that can be pasted into real codebases.
- Keep examples in ASCII.
