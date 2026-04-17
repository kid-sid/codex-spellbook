---
name: api-design
description: REST API design guidance covering resource naming, HTTP semantics, pagination strategy, versioning, error envelopes, and rate limiting contracts for durable service interfaces.
category: design
---

# API Design Instructions for Codex

Design resource-oriented HTTP APIs with stable contracts, predictable errors, and explicit tradeoffs around pagination and versioning.

## Scope
- Define URI structure, verbs, and resource naming.
- Choose status codes and response envelopes.
- Standardize pagination, filtering, and sorting.
- Version APIs without breaking active clients.
- Expose rate limiting and idempotency guarantees.

## Standards and Conventions

### Resource Naming

| Concern | Preferred | Avoid |
| --- | --- | --- |
| Collections | `/users` | `/getUsers` |
| Single resource | `/users/{user_id}` | `/user?id=123` |
| Nested resource | `/users/{user_id}/tokens` | `/userTokens/{user_id}` |
| Actions | `/jobs/{job_id}:cancel` when no resource exists | `/cancelJob/{job_id}` |

Rules:

- Use plural nouns for collections.
- Use kebab-case for multi-word path segments.
- Put identifiers in the path, filters in the query string.
- Model actions as resources first; use action suffixes only when state transitions do not map cleanly to CRUD.

### Method Semantics

| Method | Use When | Idempotent | Response |
| --- | --- | --- | --- |
| `GET` | Read resources | Yes | `200`, `206`, `304` |
| `POST` | Create resource or submit command | No | `201`, `202` |
| `PUT` | Replace full resource | Yes | `200`, `204` |
| `PATCH` | Partial update | Usually | `200`, `204` |
| `DELETE` | Remove resource | Yes | `204` |

### Status Codes

| Situation | Code | Notes |
| --- | --- | --- |
| Created synchronously | `201 Created` | Return `Location` header |
| Accepted async work | `202 Accepted` | Return job resource |
| Validation failure | `400 Bad Request` | Schema or format issue |
| Authentication missing | `401 Unauthorized` | Include auth challenge when applicable |
| Permission denied | `403 Forbidden` | Caller is authenticated |
| Missing resource | `404 Not Found` | Do not leak existence across tenants |
| Version conflict | `409 Conflict` | ETag or business conflict |
| Rate limited | `429 Too Many Requests` | Include reset headers |

### Pagination Strategy

| Strategy | Use When | Strengths | Tradeoffs |
| --- | --- | --- | --- |
| Offset pagination | Small admin lists, stable datasets | Simple for humans | Slow on large offsets, duplicate/skipped rows under writes |
| Cursor pagination | User-facing feeds, large tables, append-heavy data | Stable under writes, faster scans | Harder to debug manually |

Default:

- Use cursor pagination for externally consumed list endpoints.
- Use offset pagination only for bounded internal tooling.

Cursor response shape:

```json
{
  "data": [{ "id": "usr_123", "email": "a@example.com" }],
  "page": {
    "next_cursor": "eyJpZCI6InVzcl8xMjMifQ==",
    "has_more": true
  }
}
```

### Error Envelope

Return one shape across the API:

```json
{
  "error": {
    "code": "validation_error",
    "message": "email must be a valid address",
    "details": [
      { "field": "email", "reason": "invalid_format" }
    ],
    "request_id": "req_01HV..."
  }
}
```

Rules:

- `code` is stable and machine-readable.
- `message` is human-readable and safe to log.
- `details` is optional and field-scoped.
- Always include `request_id` for support correlation.

### Versioning

| Approach | Preferred | Avoid |
| --- | --- | --- |
| Public API version | `/v1/...` at the router boundary | Version per endpoint ad hoc |
| Breaking change rollout | Ship `/v2`, deprecate `/v1`, publish sunset date | Mutate `/v1` response shape silently |
| Additive changes | New optional fields | Reusing field names with changed meaning |

### Rate Limiting

Expose explicit headers:

| Header | Meaning |
| --- | --- |
| `X-RateLimit-Limit` | Total quota in current window |
| `X-RateLimit-Remaining` | Requests left in window |
| `X-RateLimit-Reset` | Unix timestamp when quota resets |
| `Retry-After` | Seconds until retry after `429` |

### BAD / GOOD Examples

BAD

```http
GET /getUserOrders?userId=42&limit=5000
```

GOOD

```http
GET /users/42/orders?limit=100&cursor=eyJpZCI6Im9yZF8xIn0=
```

BAD

```json
{ "message": "Something went wrong" }
```

GOOD

```json
{
  "error": {
    "code": "rate_limited",
    "message": "Too many requests",
    "request_id": "req_123"
  }
}
```

## When to Apply These Patterns
- Design a new HTTP or REST endpoint.
- Refactor route naming or handler contracts.
- Choose between offset and cursor pagination.
- Introduce a breaking API change.
- Define error payloads and status codes.
- Add rate limiting or idempotency behavior.
- Review an OpenAPI spec for consistency.

## Checklist
- [ ] Paths use plural nouns and stable identifiers.
- [ ] HTTP method matches the state transition.
- [ ] Success and failure codes are explicit for each endpoint.
- [ ] List endpoints declare pagination strategy and bounds.
- [ ] Error responses use the shared error envelope.
- [ ] Breaking changes are isolated behind a version boundary.
- [ ] Rate-limited endpoints return quota headers.
- [ ] Examples show realistic URLs and payloads.
