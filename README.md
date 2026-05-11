<div align="center">

<img src="assets/codex-logo.png" alt="codex-spellbook logo" width="180" />

# codex-spellbook

**Ship faster. Review smarter. Build with intent.**

A curated library of skills, task prompts, and agent templates that transform OpenAI Codex<br>
into a precision engineering assistant — one spell at a time.

[![CI](https://github.com/kid-sid/codex-spellbook/actions/workflows/ci.yml/badge.svg)](https://github.com/kid-sid/codex-spellbook/actions/workflows/ci.yml)
![Skills](https://img.shields.io/badge/skills-62-blueviolet)
![Task Prompts](https://img.shields.io/badge/task%20prompts-15-blue)
![License](https://img.shields.io/badge/license-MIT-green)

*Each skill is a spell. Cast wisely.*

</div>

---

## Star History

<a href="https://star-history.com/#kid-sid/codex-spellbook&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=kid-sid/codex-spellbook&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=kid-sid/codex-spellbook&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=kid-sid/codex-spellbook&type=Date" />
 </picture>
</a>

## What's In The Box

| Layer | What | Count |
| --- | --- | --- |
| Skills | Installable Codex `SKILL.md` packages | 62 |
| Task prompts | Reusable one-shot prompts for common engineering workflows | 15 |
| Agent templates | Full project-level `AGENTS.md` files for common stacks | 5 |
| Setup scripts | VM bootstrap scripts for Python, Node, Go, and Rust | 4 |
| Hooks | Reusable hook scripts for formatting, safety guards, and validation | 6 |

## Quick Start

### macOS / Linux (bash)

```bash
# Clone and install all skills globally (works across every repo)
git clone https://github.com/kid-sid/codex-spellbook.git
mkdir -p "$HOME/.agents/skills"
cp -r codex-spellbook/skills/* "$HOME/.agents/skills/"
```

### Windows (PowerShell)

```powershell
git clone https://github.com/kid-sid/codex-spellbook.git
cd codex-spellbook

# Skills + hooks (does not overwrite existing files)
powershell -NoProfile -ExecutionPolicy Bypass -File tools\\install.ps1 -Global -AllSkills -Hooks

# Enable hooks (one-time per machine)
Add-Content (Join-Path $HOME \".codex\\config.toml\") \"`n[features]`ncodex_hooks = true`n\"
```

Then open any repo in Codex and ask naturally — skills activate on their own:

```
Design a REST API for user billing with cursor pagination.
Review this PR for security issues and missing tests.
Write a safe migration for adding org_id to invoices.
```

**Full setup guide** (project installs, hooks, task prompts, agent templates): [SETUP.md](SETUP.md)

## Verify Your Install

From the `codex-spellbook` repo:

- macOS/Linux: `python scripts/validate_skills.py && python scripts/validate_task_prompts.py && python scripts/validate_agent_templates.py`
- Windows: `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\\validate.ps1`

Markdown lint:

- macOS/Linux: `python scripts/lint_markdown.py`
- Windows: `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\\lint.ps1`

Hook wiring and limitations: see [hooks/README.md](hooks/README.md).

## Skills

Skills are the primary artifact in this repo. Each skill lives at `skills/<name>/SKILL.md` and is designed to trigger contextually when Codex sees a matching task.

### Skill Inventory

| Skill | Activates when... |
| --- | --- |
| `api-design` | REST API design patterns for resource naming, HTTP methods, status codes, pagination strategy, error envelopes, versioning, and rate limiting. Use when designing, reviewing, or refactoring HTTP APIs and endpoint contracts. |
| `aws` | Use when writing boto3 or AWS SDK v3 code — configuring IAM auth, reading/writing S3, designing DynamoDB access patterns, writing Lambda handlers, processing SQS batches, or troubleshooting credential and throttling errors. |
| `azure` | Use when writing Python code that integrates with Azure Blob Storage, AI Search, Document Intelligence, or Key Vault — or when configuring Managed Identity auth, designing a hybrid search index, or troubleshooting Azure SDK retry behavior. |
| `azure-service-bus` | Use when implementing reliable message processing with Azure Service Bus — choosing between queues and topics, configuring peek-lock settlement, handling dead-lettered messages, or enforcing ordered processing with sessions. |
| `caching` | Use when adding or debugging caching in a service — choosing a cache strategy, designing TTLs, preventing stampedes, reasoning about invalidation, or configuring HTTP Cache-Control headers. |
| `ci-cd` | Use when setting up or debugging GitHub Actions pipelines — adding quality gates, configuring OIDC cloud auth, building matrix test runs, publishing artifacts to GHCR/PyPI/npm, or promoting builds from staging to production. |
| `claude-api` | Use when building or debugging apps that call the Claude API — implementing tool use, streaming, vision, prompt caching, batch processing, extended thinking, or an agentic loop with the Anthropic SDK. |
| `claude-code` | Use when configuring Claude Code — installing skills or agents, writing hook configurations, setting up tool permissions, registering MCP servers, or authoring CLAUDE.md project instructions. |
| `code-review` | Pull request review guidance for correctness, security, tests, performance, API contract drift, migrations, and error handling. Use when reviewing diffs, pull requests, or risky refactors. |
| `codex-orchestration` | Authoritative reference for OpenAI Codex CLI's orchestration surface - skills discovery paths, agents/openai.yaml schema, hooks.json events and stdin JSON payload, notify config, and AGENTS.md precedence. Use when installing skills, wiring hooks, debugging why a skill or hook isn't firing, or explaining Codex-vs-Claude-Code differences. Do NOT use for general Codex usage tips, prompt engineering, or non-orchestration configuration like models/approvals. |
| `codex-skill-generator` | Create or update Codex skills that follow the repository skill format, trigger cleanly, and stay concise. Use when adding a new skill, refining an existing SKILL.md, or converting domain guidance into an installable Codex skill package. |
| `coding-standards` | Cross-language coding standards for Python, TypeScript, and Go covering naming, SOLID design, code smell removal, and comment philosophy. Use when writing, reviewing, or refactoring production code for maintainability. |
| `complex-doc-rag` | Use when building a RAG pipeline that ingests PDFs, Excel, CSV, or images — especially when debugging silent data loss, choosing between OCR tools, or handling edge cases like scanned pages, merged cells, or embedded charts. |
| `containerization` | Use when writing Dockerfiles, setting up docker-compose for local dev, configuring Kubernetes resources (Deployment, Service, Ingress, HPA), sizing pod resource limits, or packaging a service with Helm. |
| `database` | Database guidance for schema naming, safe migrations, indexing, N+1 detection, transaction scope, and soft-delete versus hard-delete tradeoffs. Use when designing schemas, writing migrations, or tuning persistence behavior. |
| `database-design` | Use when designing a schema, adding indexes to fix slow queries, writing a zero-downtime migration, diagnosing N+1 issues with EXPLAIN ANALYZE, or configuring connection pooling for a PostgreSQL-backed service. |
| `data-pipelines` | Use when building or debugging data pipelines with Airflow or Prefect, writing dbt models or tests, designing incremental loads, implementing idempotent ETL/ELT jobs, validating data quality, or orchestrating multi-step data workflows. |
| `deployment-strategies` | Use when choosing a deployment strategy for a release, setting up canary or blue/green rollouts, adding feature flags to decouple deployment from release, coordinating a zero-downtime database migration, or defining rollback criteria and procedures. |
| `development-workflow` | Use when choosing a branching strategy, writing a commit message, opening or reviewing a pull request, setting up commit linting, or tagging a versioned release. |
| `docker` | Containerization guidance for multi-stage builds, non-root execution, dockerignore hygiene, layer caching, healthchecks, and secret handling. Use when writing or reviewing Dockerfiles and container images. |
| `end-to-end-testing` | End-to-end (E2E) testing patterns for user journeys, browser automation, UI state, and production-like environment validation. Use when testing the system as a black box from the user's perspective. |
| `event-driven` | Use when designing or debugging an event-driven system — choosing Kafka partitioning strategies, implementing the outbox pattern, handling dead-letter queues, ensuring idempotent consumers, or making event sourcing decisions. |
| `fastapi` | Use when structuring a FastAPI application, designing dependency injection chains, defining Pydantic v2 schemas, adding JWT authentication, or writing async route tests with httpx. |
| `feature-flags` | Use when adding feature flag support to a service, designing a percentage-based rollout, setting up A/B experiments or multivariate tests, choosing between LaunchDarkly, Unleash, and OpenFeature, writing tests for flag-gated code, or managing flag lifecycle and cleanup. |
| `frontend` | Use when designing React component structure, deciding where state should live, implementing data fetching with TanStack Query, building validated forms, or optimizing rendering performance. |
| `general-temporal` | Use when building or debugging Temporal workflows in Python — structuring workflows and activities, enforcing determinism, handling retries and timeouts, managing state across replays, or diagnosing workflow failures. |
| `github-issues` | Use when creating, triaging, or filing GitHub issues — writing bug reports, feature requests, or task tickets; classifying severity; using the gh CLI; or handling edge cases like regressions, flaky failures, security vulnerabilities, or cross-repo dependencies. |
| `git-workflow` | Git workflow guidance for branch naming, conventional commits, PR title format, merge strategy, and safe history rewriting. Use when creating branches, preparing commits, or reviewing repository hygiene. |
| `go` | Use when writing or debugging non-trivial Go — error handling patterns, goroutine/channel design, interface composition, generics, context propagation, or Go-specific idioms like table-driven tests and functional options. |
| `incident-response` | Use when triaging a production alert, writing a postmortem, creating or updating a runbook, classifying incident severity, or setting up on-call escalation paths. |
| `infrastructure-as-code` | Use when writing Terraform for cloud resources, setting up remote state, structuring modules for reuse, managing multiple environments, reviewing a plan before apply, or importing and resolving state drift. |
| `integration-testing` | Integration testing patterns for database state, API contracts, service boundaries, and component wiring. Use when testing how multiple parts of a system work together without mocks. |
| `langgraph` | Use when building or debugging LangGraph workflows — designing state graphs, adding conditional routing, wiring checkpointers, streaming tokens, implementing human-in-the-loop interrupts, or coordinating multi-agent subgraphs. |
| `memory-map` | Use when installing or configuring memory_map, writing CLAUDE.md session-setup instructions, choosing what to save in memory vs history, managing cross-project memory, tuning compression, or troubleshooting why Claude isn't loading context at session start. |
| `microservices` | Use when decomposing a monolith, designing inter-service communication, implementing circuit breakers or sagas, reasoning about data ownership across services, or setting up an API gateway for a distributed system. |
| `mongodb` | Use when writing async MongoDB queries with Motor, designing aggregation pipelines, creating indexes, running multi-document transactions, or working with adk.state in Agentex agents. |
| `observability` | Use when adding structured logging, instrumenting Prometheus metrics, wiring up distributed tracing with OpenTelemetry, writing alerting rules, defining SLOs and error budgets, or building a Grafana golden-signals dashboard. |
| `openai-agents` | Use when building or debugging OpenAI Agents SDK workflows — defining agents with tools and handoffs, wiring typed context, streaming responses, adding guardrails, or integrating with the Agentex ADK. |
| `openai-api` | Build against the OpenAI API with current model selection, Responses API patterns, Codex model guidance, streaming, structured outputs, retries, and key management. Use when integrating OpenAI or Codex models into an app, service, CLI, or agent workflow. |
| `performance` | Use when diagnosing a slow endpoint, fixing N+1 queries, adding a caching layer, offloading CPU-bound work to threads, or defining a latency budget for a service. |
| `performance-testing` | Use when load testing a service before launch or after a significant traffic change — writing k6 or Locust scripts, setting SLO-based pass/fail thresholds, diagnosing bottlenecks under load, or integrating performance tests into CI. |
| `postgresql` | Use when writing complex PostgreSQL queries, diagnosing slow queries with EXPLAIN ANALYZE, designing indexes, handling concurrent writes, or planning safe schema migrations on large tables. |
| `promptbase` | Use when writing, reviewing, or adapting a Claude Code skill for sale on PromptBase — checking scope, audience breadth, rejection risk, description quality, examples, and setup instructions. |
| `pydantic` | Use when defining request/response schemas, writing custom validators, controlling serialization for PATCH endpoints, validating non-model data with TypeAdapter, or configuring app settings from environment variables with pydantic-settings. |
| `python` | Python engineering guidance for type hints, pydantic validation, httpx usage, pytest conventions, pyproject structure, async patterns, and lightweight dependency injection. Use when building or reviewing Python services and libraries. |
| `react` | Use when building advanced React features — designing custom hooks, using Suspense or error boundaries, working in Next.js App Router with Server Components or Server Actions, applying TypeScript generics, or building animated UI with Framer Motion, View Transitions, or scroll-driven animations. |
| `redis` | Use when choosing a Redis data structure for a use case, implementing caching or rate limiting, building pub/sub or Streams-based real-time messaging, or writing atomic operations like distributed locks. |
| `requirements-planning` | Use when writing a PRD, drafting user stories with acceptance criteria, breaking an epic into sprint-sized vertical slices, story pointing in planning poker, or defining a team's Definition of Done. |
| `security` | Application security guidance covering OWASP Top 10 mitigations, secrets handling, boundary validation, SQL injection prevention, JWT usage, dependency scanning, and STRIDE threat modeling. Use for audits, auth changes, or any security-sensitive code. |
| `solution-testing` | Use when writing Playwright E2E tests for critical user journeys, setting up post-deployment smoke tests, debugging flaky browser automation, or implementing BDD feature files with Gherkin. |
| `spellbook-setup` | Use when installing claude-spellbook for the first time, setting up skills/agents/commands globally or into a specific project, registering the memory_map MCP server, enabling lifecycle hooks, or migrating an existing install to a new machine. |
| `sqlalchemy` | Use when using async SQLAlchemy 2.0 — defining models, writing queries, managing async sessions, loading relationships without N+1, or setting up and debugging Alembic migrations. |
| `system-design` | Use when designing a new service from scratch, writing a tech spec or RFC, selecting a database or communication pattern, estimating capacity, or reviewing a design for scalability and reliability gaps. |
| `tailwind` | Use when composing Tailwind utilities, building responsive or dark-mode layouts, defining component variants with cva, resolving conflicting classes with tailwind-merge, or configuring a custom theme. |
| `technical-documentation` | Use when writing a README, documenting an API with OpenAPI, drafting a runbook for on-call engineers, authoring a technical spec or ADR, or setting up docs-as-code with auto-deploy to GitHub Pages. |
| `temporal` | Use when building or debugging Temporal-based Agentex agents — structuring workflows and activities, handling signal routing, managing state across replays, or diagnosing workflow failures and retry exhaustion. |
| `testing` | Testing patterns for AAA structure, naming, mocks versus real dependencies, coverage targets, TDD flow, parameterized tests, and flake prevention. Use when writing, reviewing, or repairing automated test suites. |
| `test-strategy` | Use when choosing a testing model for a new project, auditing a test suite that is slow or provides low confidence, setting coverage targets, or writing a QA test plan for a release. |
| `typescript` | TypeScript guidance for strict mode, Zod runtime validation, eliminating any, discriminated unions, explicit error modeling, module format choices, path aliases, and Vitest. Use when building or reviewing TypeScript services and applications. |
| `unit-testing` | Use when writing unit tests for a function or module, mocking external dependencies, practising TDD on new business logic, or enforcing a coverage target across a codebase in Python, TypeScript, or Go. |
| `websockets-sse` | Use when building real-time features with WebSockets or SSE — choosing between the two, implementing connection management and heartbeats, scaling broadcasts across workers with Redis, handling backpressure, writing tests for streaming endpoints, or debugging connection drops and missed events. |
| `writing-plans` | Use when creating an implementation plan for a non-trivial task — any change spanning multiple files, involving a database migration, requiring specific sequencing, or being handed off to a subagent for execution. |
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
By participating, you agree to follow the [Code of Conduct](CODE_OF_CONDUCT.md).
