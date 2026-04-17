---
name: docker
description: Containerization guidance covering multi-stage builds, non-root execution, dockerignore hygiene, layer caching, healthchecks, secret handling, and minimal base image selection.
category: infra
---

# Docker Instructions for Codex

Build minimal, reproducible images that start fast, run as non-root, and separate build-time concerns from runtime behavior.

## Scope
- Structure multi-stage Dockerfiles.
- Order layers for cache efficiency.
- Enforce non-root runtime users.
- Choose base images intentionally.
- Handle secrets and healthchecks safely.

## Standards and Conventions

### Base Image Choice

| Use Case | Preferred | Avoid |
| --- | --- | --- |
| Production service | distroless or slim runtime | Full distro with build toolchain |
| Build stage | language-specific SDK image | Installing compilers in runtime image |
| Tiny static binary | `scratch` when feasible | Heavy general-purpose images |

### Layer Order

| Order | Reason |
| --- | --- |
| Copy lockfiles first | Maximizes dependency cache hits |
| Install dependencies | Expensive step stays cached |
| Copy source later | Code changes do not bust dependency layer |

### Runtime User

BAD

```dockerfile
FROM python:3.12-slim
WORKDIR /app
COPY . .
CMD ["python", "main.py"]
```

GOOD

```dockerfile
FROM python:3.12-slim AS runtime
WORKDIR /app
RUN useradd --create-home appuser
COPY --chown=appuser:appuser . .
USER appuser
CMD ["python", "main.py"]
```

### Secrets

| Scenario | Rule |
| --- | --- |
| Build-time private dependency access | Use ephemeral build secrets if available |
| Runtime credentials | Inject via environment or secret store |
| Static secret in Dockerfile | Never do it |

### Healthchecks

| Preferred | Avoid |
| --- | --- |
| Application-level readiness endpoint | Checking only whether PID exists |
| Fast, dependency-light command | Heavy scripts that change container state |

### `.dockerignore`

Exclude:

| Always Ignore |
| --- |
| `.git` |
| `node_modules` |
| `.venv` |
| test artifacts |
| local secrets and `.env` files |

### BAD / GOOD Examples

BAD

```dockerfile
COPY . .
RUN npm install
```

GOOD

```dockerfile
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY . .
```

## When to Apply These Patterns
- Write or refactor a Dockerfile.
- Split build and runtime concerns.
- Harden a container for production.
- Improve Docker build cache performance.
- Add container healthchecks.
- Review secret handling in image builds.
- Shrink image size and attack surface.

## Checklist
- [ ] Dockerfile uses multi-stage builds when build tooling is required.
- [ ] Dependency layers are copied before application source.
- [ ] Runtime image uses a non-root user.
- [ ] `.dockerignore` excludes local junk and secrets.
- [ ] Secrets are injected at runtime or via build secret facilities.
- [ ] Healthcheck verifies real service readiness.
- [ ] Base image is minimal for the workload.
