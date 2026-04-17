---
name: fastapi-service
description: Scaffold a production-ready FastAPI service with validation, tests, and project tooling.
category: scaffold
---

Scaffold a production-ready FastAPI service in `$TARGET_DIR`.

Create:

- application package with routers, schemas, services, and config
- request validation with pydantic
- pytest setup with at least one route test
- `pyproject.toml`
- Dockerfile and `.dockerignore`

Constraints:

- use Python 3.12
- keep dependencies minimal
- separate transport models from business logic
- include health and version endpoints
