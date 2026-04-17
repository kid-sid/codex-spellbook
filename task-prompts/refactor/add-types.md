---
name: add-types
description: Add strict TypeScript types or Python type hints to a file while preserving behavior.
category: refactor
---

Add types to `$FILE`.

Inspect the file, its call sites, and neighboring typed modules first. Match project conventions for Python or TypeScript rather than inventing a new style.

Rules:

- remove `any` where possible
- prefer precise return types over inference for public functions
- add runtime validation at boundaries if the file currently trusts untyped external input
- avoid broad casts that silence type errors without fixing them

Output:

- code changes
- any remaining ambiguous types that need domain clarification
