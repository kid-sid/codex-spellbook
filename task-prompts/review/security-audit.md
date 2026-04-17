---
name: security-audit
description: Audit a codebase or file set against OWASP Top 10 risks and common secret-handling failures.
category: review
---

Audit `$TARGET_PATHS` for security issues.

Read the authentication, authorization, input validation, database access, secret loading, and outbound network code first. Then inspect dependency manifests and CI or deployment configuration if present.

Output:

- `Critical Findings`
- `High Findings`
- `Medium Findings`
- `Needs Verification`
- `Recommended Fixes`

Constraints:

- Map findings to OWASP Top 10 categories where applicable.
- Call out SQL injection, SSRF, unsafe deserialization, hardcoded secrets, weak JWT handling, and missing authorization checks explicitly.
- Include file paths and exploit paths, not generic advice.
