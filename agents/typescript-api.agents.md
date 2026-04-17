# TypeScript API Agent Template

## Purpose

Use this template for Express, Fastify, or tRPC services that run on Node, expose APIs, and require strict typing end to end.

## Environment Setup

Run these commands before starting work:

```bash
set -euo pipefail
bash setup-scripts/node.sh
node --version
pnpm --version
pnpm test --help >/dev/null 2>&1 || true
```

## Working Style

- Treat TypeScript strictness as a design tool, not a compiler tax.
- Keep routers thin and move orchestration into typed services.
- Parse untrusted input with Zod at the boundary.
- Prefer explicit error types or `Result`-style returns for recoverable failures.

## TypeScript Conventions

- Enable `strict` mode and avoid `any`.
- Use discriminated unions for variant states.
- Prefer ESM for new Node 20 services unless the repo is intentionally CJS.
- Keep path aliases aligned across `tsconfig`, tests, and runtime tooling.

## API Design

- Use plural nouns for collections and identifiers in the path.
- Standardize error payloads and include request identifiers.
- Prefer cursor pagination for high-volume list endpoints.
- Document auth requirements and rate-limit headers when present.

## Validation and Persistence

- Use Zod for request parsing and environment validation.
- Keep Prisma or Drizzle schema changes additive before destructive cleanup.
- Avoid leaking ORM models across service boundaries when DTOs are clearer.
- Check generated queries for N+1 behavior on list endpoints.

## Testing

- Use Vitest or Jest based on project standard; default to Vitest for new work.
- Add unit tests for domain logic and integration tests for route contracts.
- Mock network and third-party SDK boundaries, not internal validation code.
- Use fake timers explicitly for time-dependent flows.

## Docker

- Use multi-stage Dockerfiles.
- Install dependencies before copying application code.
- Run the runtime image as non-root.
- Keep production images free of build toolchains.

## Git Workflow

- Use conventional commits and consistent branch prefixes.
- Keep PR titles in commit style.
- Rewrite your branch only with `--force-with-lease`.

## Security Baseline

- No secrets in source, examples, or tests.
- Parse untrusted JSON from `unknown`, not direct casts.
- Enforce authorization on every sensitive route.
- Validate JWT claims and rotate refresh tokens on reuse detection.
- Scan dependencies and lockfiles for advisories.

## Delivery Checklist

- [ ] `strict` typing is preserved or improved.
- [ ] Zod validates external input.
- [ ] API changes include tests for success and failure cases.
- [ ] Database migrations are rollout-safe.
- [ ] Docker changes keep a minimal non-root runtime.
- [ ] Security-sensitive changes were reviewed for auth and secret handling.
