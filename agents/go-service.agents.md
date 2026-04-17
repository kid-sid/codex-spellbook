# Go Service Agent Template

## Purpose

Use this template for Go services built around the standard library, explicit package boundaries, and operational simplicity.

## Environment Setup

Run these commands before starting work:

```bash
set -euo pipefail
bash setup-scripts/go.sh
go version
golangci-lint --version
govulncheck -version || true
```

## Working Style

- Prefer the standard library before adding frameworks.
- Keep handlers small and push logic into testable packages.
- Model dependencies through interfaces only where more than one implementation is plausible.
- Optimize for readability over cleverness.

## Go Conventions

- Keep package names short, lowercase, and domain-driven.
- Return explicit errors and wrap with context.
- Use contexts consistently for cancellation and deadlines.
- Avoid global mutable state.

## HTTP and Service Design

- Use `net/http` and explicit route wiring.
- Keep request parsing, validation, and response writing close to the transport layer.
- Define stable JSON contracts and error envelopes.
- Add health and readiness endpoints.

## Testing

- Use table-driven tests for input matrices.
- Add subtests where they improve failure isolation.
- Keep unit tests fast and deterministic.
- Add integration tests for persistence and HTTP seams when behavior matters.

## Build and Tooling

- Expose `make build`, `make test`, and `make lint` when a Makefile exists.
- Run `gofmt` and `golangci-lint` on touched code.
- Keep module dependencies minimal and review new additions critically.

## Docker

- Use multi-stage builds with a separate builder image.
- Produce a minimal runtime image when possible.
- Run the container as non-root.

## Git Workflow

- Use `feat/`, `fix/`, and `chore/` branch prefixes.
- Use conventional commits.
- Prefer squash merges for noisy branches and merge commits for meaningful multi-step history.

## Security Baseline

- Never embed credentials in code or config committed to the repo.
- Validate external input at HTTP and queue boundaries.
- Use parameterized SQL with `database/sql` or query builders.
- Run `govulncheck` for dependency and standard-library issues.

## Delivery Checklist

- [ ] Handlers stay thin and delegate to services.
- [ ] Errors are returned and wrapped with context.
- [ ] New behavior includes table-driven tests.
- [ ] Contexts are passed through I/O boundaries.
- [ ] Docker build is multi-stage and non-root.
- [ ] Dependency additions are justified.
- [ ] Security-sensitive flows were reviewed explicitly.
