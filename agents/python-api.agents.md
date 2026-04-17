# Python API Agent Template

## Purpose

Use this template for FastAPI or Django backends that expose HTTP APIs, persist relational data, and ship inside Docker.

## Environment Setup

Run these commands before starting work:

```bash
set -euo pipefail
bash setup-scripts/python.sh
python --version
uv --version || poetry --version
pytest --version
```

## Working Style

- Prefer small typed modules over large service files.
- Keep handlers thin; move business rules into services.
- Validate request and settings data with pydantic.
- Use `httpx` for outbound HTTP.
- Write pytest coverage for new logic and route behavior.

## Python Conventions

- Add type hints to public functions, methods, and module constants when ambiguity exists.
- Use `BaseModel` for request and response validation.
- Use `dataclass(frozen=True)` for small internal value objects.
- Avoid framework globals; inject repositories, clocks, and clients explicitly.

## API Design

- Use plural resource names and stable identifiers in paths.
- Prefer cursor pagination for externally consumed list endpoints.
- Keep one shared error envelope with machine-readable error codes.
- Version breaking API changes behind `/v1`, `/v2`, not silent field mutation.

## Database

- Use SQLAlchemy for data access and Alembic for migrations.
- Never ship destructive schema changes in one step on active tables.
- Keep transactions short and exclude network calls.
- Inspect list endpoints for N+1 query patterns.

## Testing

- Use pytest with Arrange, Act, Assert.
- Add unit tests for domain logic and integration tests for HTTP and persistence seams.
- Mock external HTTP services, not pydantic validation or serialization.
- Freeze time or inject clocks for time-sensitive logic.

## Docker

- Use multi-stage builds when build tooling is required.
- Run containers as non-root.
- Copy dependency metadata before application code for cache efficiency.
- Keep `.dockerignore` current.

## Git Workflow

- Branch names: `feat/<topic>`, `fix/<topic>`, `chore/<topic>`.
- Commits use conventional commit prefixes.
- Use `--force-with-lease` instead of `--force`.

## Security Baseline

- Never hardcode secrets; load from runtime environment or a secret manager.
- Validate untrusted input at the HTTP boundary.
- Use parameterized queries or ORM parameter binding.
- Validate JWT issuer, audience, and expiry claims.
- Review auth and migration changes with blocking rigor.

## Delivery Checklist

- [ ] Types are added for new Python code.
- [ ] Request and config validation use pydantic.
- [ ] API changes preserve contract or version explicitly.
- [ ] Alembic migrations are additive before destructive cleanup.
- [ ] New logic includes pytest coverage.
- [ ] Docker changes preserve non-root execution.
- [ ] Security-sensitive changes were reviewed explicitly.
