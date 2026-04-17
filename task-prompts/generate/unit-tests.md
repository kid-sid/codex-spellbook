---
name: unit-tests
description: Generate unit tests for a file while following existing project conventions.
category: generate
---

Generate unit tests for `$FILE`.

First inspect:

- the target file
- adjacent test files
- test configuration files
- existing helpers or fixtures used by the project

Then add or update tests that:

- follow the local naming and framework conventions
- use Arrange, Act, Assert structure
- cover success, failure, and edge cases
- mock only unstable boundaries

Output:

- the test file changes
- a short note describing uncovered cases you could not test safely
