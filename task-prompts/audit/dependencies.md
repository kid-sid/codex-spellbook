---
name: dependencies
description: Audit dependency manifests and lockfiles for outdated or vulnerable packages.
category: audit
---

Audit dependency manifests under `$MANIFEST_PATHS`.

Inspect package manifests, lockfiles, Dockerfiles, and CI setup. Identify runtime-critical dependencies first, then developer tooling.

Output:

- `Vulnerable Dependencies`
- `Outdated High-Risk Dependencies`
- `Low-Risk Maintenance Updates`
- `Recommended Upgrade Order`

Constraints:

- prioritize reachable production dependencies
- note likely breaking changes for major-version upgrades
- include affected files and package names
