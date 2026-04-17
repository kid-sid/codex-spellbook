---
name: migration
description: Generate a safe database migration plan and migration code for a schema change.
category: generate
---

Generate a safe database migration for `$SCHEMA_CHANGE`.

Inspect current schema definitions, migration history, application read and write paths, and rollout constraints before proposing changes.

Produce:

- migration steps in execution order
- migration code or SQL
- backfill plan if needed
- rollback or fallback notes

Constraints:

- never perform destructive schema changes in one step on active tables
- call out dual-read or dual-write requirements when relevant
