<div align="center">

<img src="assets/codex-logo.png" alt="codex-spellbook logo" width="180" />

# codex-spellbook

**Ship faster. Review smarter. Build with intent.**

A curated library of skills, task prompts, and agent templates that transform OpenAI Codex<br>
into a precision engineering assistant — one spell at a time.

[![CI](https://github.com/kid-sid/codex-spellbook/actions/workflows/ci.yml/badge.svg)](https://github.com/kid-sid/codex-spellbook/actions/workflows/ci.yml)
![Skills](https://img.shields.io/badge/skills-15-blueviolet)
![Task Prompts](https://img.shields.io/badge/task%20prompts-15-blue)
![License](https://img.shields.io/badge/license-MIT-green)

*Each skill is a spell. Cast wisely.*

</div>

---

## What's In The Box

| Layer | What | Count |
| --- | --- | --- |
| Skills | Installable Codex `SKILL.md` packages | 15 |
| Task prompts | Reusable one-shot prompts for common engineering workflows | 15 |
| Agent templates | Full project-level `AGENTS.md` files for common stacks | 5 |
| Setup scripts | VM bootstrap scripts for Python, Node, Go, and Rust | 4 |
| Hooks | Reusable hook scripts for formatting, safety guards, and validation | 6 |

## Quick Start

```bash
# Clone and install all skills globally (works across every repo)
git clone https://github.com/kid-sid/codex-spellbook.git
mkdir -p "$HOME/.agents/skills"
cp -r codex-spellbook/skills/* "$HOME/.agents/skills/"
```

Then open any repo in Codex and ask naturally — skills activate on their own:

```
Design a REST API for user billing with cursor pagination.
Review this PR for security issues and missing tests.
Write a safe migration for adding org_id to invoices.
```

**Full setup guide** (project installs, hooks, task prompts, agent templates): [SETUP.md](SETUP.md)

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
| `codex-orchestration` | Explaining Codex's skills discovery paths, hooks.json events, notify config, and AGENTS.md precedence; use before installing skills or wiring hooks |
| `openai-api` | Integrating OpenAI or Codex models with current model selection and Responses API patterns |
| `integration-testing` | Testing how multiple parts of a system work together without mocks, including DB and API clients |
| `end-to-end-testing` | Testing complete user journeys as a black box using browser automation or mobile testing |

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
