---
name: integration-tests
description: Generate integration tests for a service or workflow with realistic boundaries.
category: generate
---

Generate integration tests for `$SERVICE`.

Inspect the service entrypoint, routing or job wiring, persistence layer, and any existing integration test harness before writing code.

Test requirements:

- cover the main happy path
- cover one realistic validation or permission failure
- use real serialization and validation code
- stub only external services that would make the test flaky or expensive

Output:

- test file edits
- required fixtures or setup changes
- assumptions about the environment or test database
