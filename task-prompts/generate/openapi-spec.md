---
name: openapi-spec
description: Generate an OpenAPI 3.1 specification from existing route handlers and validation code.
category: generate
---

Generate an OpenAPI 3.1 spec from `$ROUTES_PATH`.

Read route handlers, schemas, validators, middleware, and shared error response code before drafting the spec.

The spec must include:

- paths and methods
- request parameters and bodies
- response schemas for success and failure cases
- authentication requirements
- pagination and rate limit headers where implemented

Output:

- a complete OpenAPI 3.1 document
- a short list of ambiguities that need human confirmation
