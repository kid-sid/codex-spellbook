---
name: extract-function
description: Extract logic from a large function into well-named helpers without changing behavior.
category: refactor
---

Refactor `$FUNCTION` by extracting cohesive helper functions.

Read the full file, call sites, and existing tests before editing. Preserve behavior exactly unless you find a bug, in which case call it out separately.

Constraints:

- extract by intent, not by arbitrary line count
- improve naming and testability
- do not introduce speculative abstractions
- keep public API changes minimal

Output:

- code changes
- a brief note on the new helper boundaries
