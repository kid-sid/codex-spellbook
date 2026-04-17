## Purpose

`codex-spellbook` is a curated library of Codex skills, reusable task prompts, setup scripts, and stack-specific agent templates. The primary artifact is `skills/<name>/SKILL.md`: a modular instruction package that engineers can copy into `~/.codex/skills/` or a project-local skills directory.

## Repository Layout

Canonical directories:

- `skills/<skill-name>/SKILL.md` - installable Codex skills
- `task-prompts/**/*.md` - reusable one-shot prompts
- `agents/*.agents.md` - full project-level `AGENTS.md` templates
- `setup-scripts/*.sh` - environment bootstrap scripts for Codex VMs
- `templates/*/AGENTS.md` - starter copies pointing to the full agent templates

Legacy source material currently also exists under `instructions/`, but new work should target `skills/` first.

## Skill File Format

Every skill file must use this structure:

```markdown
---
name: kebab-case-name
description: Dense sentence that describes what the skill does and when to use it.
---

# Title

One-sentence summary.

## When to Activate
- 6-8 verb-led trigger conditions

## Content Sections
Tables, rules, code examples, BAD/GOOD pairs.

## Checklist
- [ ] 8-15 shipping checks
```

Skill rules:

- `SKILL.md` must use YAML frontmatter with only `name` and `description`.
- The folder name must match `name`.
- Put activation hints in `description`; the body is only read after the skill triggers.
- Include at least one comparison or decision table.
- Include at least one `BAD` / `GOOD` example pair.
- End with a `## Checklist` section containing unchecked checklist items.
- Keep writing terse, code-forward, and directly actionable.

Canonical examples:

- `skills/api-design/SKILL.md`
- `skills/coding-standards/SKILL.md`

Match their density and example quality.

## Task Prompt Format

Every prompt file must include:

```markdown
---
name: task-name
description: What the prompt accomplishes.
category: review | generate | refactor | audit | scaffold | document
---
```

Prompt rules:

- Speak directly to Codex.
- Use `$UPPERCASE` placeholders for user-supplied values.
- Name the files or directories Codex should inspect before acting.
- Define expected output shape and constraints explicitly.

## Agent Template Format

Each `agents/*.agents.md` file is a production-ready `AGENTS.md` template for a project type. Every template must include:

- stack-specific coding conventions
- testing expectations
- API and persistence guidance where relevant
- security baseline
- `## Environment Setup` with bash commands Codex should run before work starts

## Authoring Workflow

When adding a new skill:

1. Create `skills/<name>/SKILL.md`.
2. Update the skill inventory in `README.md`.
3. Validate the skill format locally or in CI before committing.

When adding a new task prompt or agent template:

1. Create the file in the correct directory.
2. Update README inventory tables if counts or listings change.
3. Keep examples consistent with existing canonical files.

## Validation

CI rejects skill files unless they contain:

- YAML frontmatter with `name` and `description`
- a `## When to Activate` section
- a `## Checklist` section
- at least one unchecked checklist item

CI also validates prompt frontmatter, agent template length, and markdown hygiene.
