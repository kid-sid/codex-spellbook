---
name: go-http-service
description: Scaffold a Go HTTP service using the standard library and table-driven tests.
category: scaffold
---

Scaffold a Go HTTP service in `$TARGET_DIR`.

Create:

- `cmd/` entrypoint
- internal packages for handlers, services, and config
- standard library HTTP routing
- table-driven tests
- multi-stage Dockerfile
- Makefile targets for build, test, and lint

Constraints:

- prefer the standard library over frameworks
- keep handlers thin and business logic testable
- include health endpoint and graceful shutdown
