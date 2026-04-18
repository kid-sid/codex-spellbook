[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

# codex-spellbook

`codex-spellbook` is a curated library of Codex skills, reusable task prompts, setup scripts, and stack-specific agent templates. It is the Codex equivalent of a spellbook repo such as `claude-spellbook`: install the skills once, then reuse them across API design, development, testing, security, infrastructure, and review work.

## What's In The Box

| Layer | What | Count |
| --- | --- | --- |
| Skills | Installable Codex `SKILL.md` packages | 12 |
| Task prompts | Reusable one-shot prompts for common engineering workflows | 15 |
| Agent templates | Full project-level `AGENTS.md` files for common stacks | 5 |
| Setup scripts | VM bootstrap scripts for Python, Node, Go, and Rust | 4 |
| Hooks | Reusable hook scripts for formatting, safety guards, and validation | 6 |

## Quick Start

### 1. Install skills into Codex

Copy the skill folders you want into your Codex skills directory:

```bash
# Install one skill
cp -r skills/security "${CODEX_HOME:-$HOME/.codex}/skills/"

# Install all skills
cp -r skills/* "${CODEX_HOME:-$HOME/.codex}/skills/"
```

Codex discovers them automatically in later sessions.

### 2. Start using the skills

You do not call most skills manually. Just ask Codex to do the task naturally:

```text
Design a REST API for user billing with cursor pagination.
Review this PR for security issues and missing tests.
Add strict types to src/payments/service.ts.
Write a safe migration for adding org_id to invoices.
```

Codex will load the relevant skills based on the task.

### 3. Add project-level instructions with an agent template

1. Pick the closest file in `agents/*.agents.md`.
2. Copy it into your target repository as `AGENTS.md`.
3. Adjust `## Environment Setup` for project-specific tools.

Example:

```bash
cp agents/typescript-api.agents.md /path/to/your-project/AGENTS.md
```

Use this when you want Codex to follow project-wide rules every session.

### 4. Run a reusable task prompt

1. Open a prompt from `task-prompts/**`.
2. Replace every `$UPPERCASE` placeholder with project-specific values.
3. Submit the prompt directly to Codex in the target repository.

Example:

```text
Use task-prompts/review/pr-review.md against the current branch diff.
```

### 5. Use environment setup scripts when a project needs bootstrapping

The scripts in `setup-scripts/` are meant to be called from a project `AGENTS.md` under `## Environment Setup`.

Example:

```bash
bash setup-scripts/python.sh
```

### 6. Hooks

This repo now ships reusable hook scripts under `hooks/`.

Use them to wire up:

- format-on-edit behavior
- validation after docs changes
- blocking `git push --force`
- warnings for destructive shell commands

Start here:

```bash
cp -r hooks /path/to/your-project/
```

Then point your Codex hook events at the scripts in `hooks/scripts/`.

See [hooks/README.md](/C:/Users/Sidhartha/Desktop/codex-spellbook/hooks/README.md) for the full list and setup examples.

## Using This In Codex

### Global install

Install skills once into your Codex home directory:

```bash
cp -r skills/* "${CODEX_HOME:-$HOME/.codex}/skills/"
```

Best for:

- personal default toolkit
- repeated use across many repos
- keeping domain guidance available everywhere

### Project install

Copy only the skills and template you want into a specific project:

```bash
mkdir -p /path/to/project/.codex/skills
cp -r skills/security /path/to/project/.codex/skills/
cp agents/python-api.agents.md /path/to/project/AGENTS.md
```

Best for:

- team-specific repos
- tighter project scope
- avoiding unused skills in a single codebase

### Typical workflow

1. Install the skills you want.
2. Add an `AGENTS.md` file to the project if you want persistent project rules.
3. Start Codex in the target repo.
4. Ask for the task directly in normal language.
5. Use a task prompt only when you want a repeatable, highly structured request.

## Skills

Skills are the primary artifact in this repo. Each skill lives at `skills/<name>/SKILL.md` and is designed to trigger contextually when Codex sees a matching task.

### Skill Inventory

| Skill | Activates when... |
| --- | --- |
| `api-design` | Designing or reviewing REST endpoints, status codes, pagination, error envelopes, or versioning |
| `coding-standards` | Writing, reviewing, or refactoring code for naming, abstractions, and maintainability |
| `git-workflow` | Creating branches, preparing commits, or deciding merge and PR hygiene |
| `testing` | Writing tests, choosing mocks, fixing flake, or driving changes with TDD |
| `security` | Auditing auth, secrets, input validation, JWTs, or dependency risk |
| `code-review` | Performing a deep PR review for correctness, security, tests, and migrations |
| `python` | Building or reviewing Python services, typing, validation, async, and project setup |
| `typescript` | Building or reviewing strict TypeScript services and applications with runtime validation |
| `docker` | Writing or reviewing Dockerfiles, build layers, runtime hardening, and healthchecks |
| `database` | Designing schemas, migrations, indexes, transaction scope, or delete strategy |
| `codex-skill-generator` | Creating or refining Codex skills that follow this repo's format and trigger cleanly |
| `openai-api` | Integrating OpenAI or Codex models with current model selection and Responses API patterns |

## Task Prompts

| Prompt | Description |
| --- | --- |
| `review/pr-review` | Blocking-minded review for logic, security, tests, and performance |
| `review/security-audit` | OWASP-focused codebase or file-set audit |
| `generate/unit-tests` | Generate unit tests for a file using local conventions |
| `generate/integration-tests` | Generate realistic integration tests for a service |
| `generate/openapi-spec` | Draft an OpenAPI 3.1 spec from route handlers and validators |
| `generate/migration` | Generate a safe migration plan and migration code for a schema change |
| `refactor/extract-function` | Extract large-function logic into cohesive helpers |
| `refactor/add-types` | Add Python type hints or TypeScript strict types to a file |
| `audit/dependencies` | Audit manifests and lockfiles for risky dependencies |
| `audit/find-secrets` | Scan a repository for hardcoded secrets and tokens |
| `document/readme` | Generate a concrete README from repository structure |
| `document/adr` | Write an ADR with context, alternatives, and consequences |
| `scaffold/fastapi-service` | Scaffold a production-ready FastAPI service |
| `scaffold/express-api` | Scaffold a strict TypeScript Express API with validation |
| `scaffold/go-http-service` | Scaffold a Go HTTP service using the standard library |

## Agent Templates

| Template | Use Case |
| --- | --- |
| `agents/python-api.agents.md` | FastAPI or Django APIs with pytest, SQLAlchemy or Alembic, Docker, and REST conventions |
| `agents/typescript-api.agents.md` | Express, Fastify, or tRPC backends with strict TS, Zod, Vitest or Jest, and database guidance |
| `agents/go-service.agents.md` | Go services using `net/http`, table-driven tests, Makefile workflows, and multi-stage Docker |
| `agents/fullstack-web.agents.md` | Next.js or SvelteKit apps with strict TS, accessibility baseline, Vitest, and Playwright |
| `agents/data-pipeline.agents.md` | Python pipelines with pandas or polars, structlog, pytest, and idempotent data movement |

## Writing A New Skill

Read [AGENTS.md](/C:/Users/Sidhartha/Desktop/codex-spellbook/AGENTS.md) first. New skills must follow the canonical format used by [skills/api-design/SKILL.md](/C:/Users/Sidhartha/Desktop/codex-spellbook/skills/api-design/SKILL.md) and [skills/coding-standards/SKILL.md](/C:/Users/Sidhartha/Desktop/codex-spellbook/skills/coding-standards/SKILL.md):

- YAML frontmatter with `name` and `description`
- `## When to Activate`
- at least one decision or comparison table
- at least one `BAD` / `GOOD` example pair
- `## Checklist`

After adding the skill, update the README inventory so counts and listings stay accurate.

## Repository Structure

```text
codex-spellbook/
├── AGENTS.md
├── README.md
├── CONTRIBUTING.md
├── Makefile
├── hooks/
├── skills/
│   └── <skill-name>/
│       └── SKILL.md
├── task-prompts/
├── agents/
├── setup-scripts/
├── templates/
├── scripts/
└── .github/
    └── workflows/
```

## Contributing

Contribution rules, branch naming, and review expectations live in [CONTRIBUTING.md](/C:/Users/Sidhartha/Desktop/codex-spellbook/CONTRIBUTING.md).
