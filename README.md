[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

# codex-spellbook

`codex-spellbook` is a curated library of `AGENTS.md` instruction sets, reusable task prompts, setup scripts, and stack-specific agent templates for OpenAI Codex. It gives teams a consistent way to install domain knowledge once, then reuse it across design, development, testing, security, infrastructure, and operations tasks.

## What's In The Box

| Artifact | Count | Notes |
| --- | --- | --- |
| Instruction sets | 10 | Domain-specific guidance for dropping into project `AGENTS.md` files |
| Task prompts | 15 | Reusable prompts for review, generate, refactor, audit, document, and scaffold workflows |
| Agent templates | 5 | Full project-level `AGENTS.md` files for common stacks |

## Quick Start

### Copy instruction blocks into an existing `AGENTS.md`

1. Open the instruction file you need under `instructions/<domain>/instructions.md`.
2. Paste the content into your project `AGENTS.md` or `~/.codex/AGENTS.md`.
3. Keep the original section structure so Codex gets the intended triggers and checklist.

### Use a full agent template

1. Pick the closest file in `agents/*.agents.md`.
2. Copy it into your target repository as `AGENTS.md`.
3. Adjust `## Environment Setup` for project-specific tools or package managers.

### Run a task prompt

1. Open a prompt from `task-prompts/**`.
2. Replace every `$UPPERCASE` placeholder with project-specific values.
3. Submit the prompt directly to Codex in the target repository.

## Instructions Inventory

### Design

| Instruction | Description |
| --- | --- |
| `api-design` | REST resource naming, status codes, pagination, error envelopes, versioning, and rate limiting contracts |

### Development

| Instruction | Description |
| --- | --- |
| `coding-standards` | Cross-language naming, SOLID usage, comment policy, and code smell removal |
| `code-review` | PR review checks for correctness, security, tests, performance, and migration safety |
| `python` | Python typing, pydantic validation, `httpx`, async patterns, and dependency injection guidance |
| `typescript` | Strict TS, Zod validation, discriminated unions, module format choices, and Vitest guidance |
| `database` | Schema naming, safe migrations, indexing, N+1 detection, transaction scope, and delete strategies |

### Testing

| Instruction | Description |
| --- | --- |
| `testing` | AAA structure, naming conventions, coverage targets, TDD flow, mocks, and flake prevention |

### Security

| Instruction | Description |
| --- | --- |
| `security` | OWASP Top 10 mitigations, boundary validation, JWT handling, dependency scanning, and STRIDE quick reference |

### Infra

| Instruction | Description |
| --- | --- |
| `docker` | Multi-stage builds, non-root containers, layer caching, healthchecks, and secret handling |

### Operations

| Instruction | Description |
| --- | --- |
| `git-workflow` | Conventional commits, branch names, PR title format, merge strategy, and safe force pushes |

## Task Prompts Inventory

### Review

| Prompt | Description |
| --- | --- |
| `review/pr-review` | Blocking-minded review for logic, security, tests, and performance |
| `review/security-audit` | OWASP-focused codebase or file-set audit |

### Generate

| Prompt | Description |
| --- | --- |
| `generate/unit-tests` | Generate unit tests for a file using local conventions |
| `generate/integration-tests` | Generate realistic integration tests for a service |
| `generate/openapi-spec` | Draft an OpenAPI 3.1 spec from route handlers and validators |
| `generate/migration` | Generate a safe migration plan and migration code for a schema change |

### Refactor

| Prompt | Description |
| --- | --- |
| `refactor/extract-function` | Extract large-function logic into cohesive helpers |
| `refactor/add-types` | Add Python type hints or TypeScript strict types to a file |

### Audit

| Prompt | Description |
| --- | --- |
| `audit/dependencies` | Audit manifests and lockfiles for risky dependencies |
| `audit/find-secrets` | Scan a repository for hardcoded secrets and tokens |

### Document

| Prompt | Description |
| --- | --- |
| `document/readme` | Generate a concrete README from repository structure |
| `document/adr` | Write an ADR with context, alternatives, and consequences |

### Scaffold

| Prompt | Description |
| --- | --- |
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

Starter copies for common stacks also live under `templates/`.

## How To Write A New Instruction Set

Match the density and structure of `instructions/api-design/instructions.md` and `instructions/coding-standards/instructions.md`. New instruction files must include:

- YAML frontmatter with `name`, `description`, and `category`
- `## Scope`
- `## Standards and Conventions`
- `## When to Apply These Patterns`
- `## Checklist`
- at least one decision table
- at least one `BAD` / `GOOD` example pair

After adding the file, update the README inventory so counts and listings stay accurate.

## Repository Structure

```text
codex-spellbook/
├── AGENTS.md
├── README.md
├── CONTRIBUTING.md
├── Makefile
├── instructions/
│   ├── api-design/
│   ├── code-review/
│   ├── coding-standards/
│   ├── database/
│   ├── docker/
│   ├── git-workflow/
│   ├── python/
│   ├── security/
│   ├── testing/
│   └── typescript/
├── task-prompts/
│   ├── audit/
│   ├── document/
│   ├── generate/
│   ├── refactor/
│   ├── review/
│   └── scaffold/
├── agents/
├── templates/
├── setup-scripts/
├── scripts/
└── .github/
    ├── workflows/
    └── PULL_REQUEST_TEMPLATE.md
```

## Contributing

Contribution rules, branch naming, and review expectations live in [CONTRIBUTING.md](/C:/Users/Sidhartha/Desktop/codex-spellbook/CONTRIBUTING.md).
