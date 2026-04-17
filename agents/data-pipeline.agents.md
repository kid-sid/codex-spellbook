# Data Pipeline Agent Template

## Purpose

Use this template for Python data pipelines that extract, transform, and load data while preserving schema clarity, idempotency, and observable failure modes.

## Environment Setup

Run these commands before starting work:

```bash
set -euo pipefail
bash setup-scripts/python.sh
python --version
pytest --version
python -c "import pandas" >/dev/null 2>&1 || true
python -c "import polars" >/dev/null 2>&1 || true
```

## Working Style

- Prefer explicit pipeline stages over giant notebooks or monolithic scripts.
- Make transformations deterministic and idempotent.
- Fail loudly on schema drift, nullability surprises, and row drops.
- Keep side effects isolated to extract and load boundaries.

## Python and Data Conventions

- Add type hints to stage functions and helpers.
- Use pandas or polars intentionally; do not mix both in one module without cause.
- Validate external records and config at boundaries.
- Use immutable or append-only intermediate data where practical.

## Pipeline Design

- Split work into extract, validate, transform, and load phases.
- Make load steps idempotent through merge keys, partition replacement, or checkpoints.
- Track row counts and critical aggregates between stages.
- Reject silent coercions that hide data loss.

## Logging and Observability

- Use `structlog` or the project logger for structured events.
- Log dataset identifiers, batch windows, input counts, output counts, and error reasons.
- Emit warnings for dropped or quarantined records with enough context to debug safely.

## Testing

- Use pytest for stage-level unit tests.
- Build fixtures from small realistic datasets, not giant snapshots.
- Assert row counts, schema expectations, and transformation invariants.
- Add regression tests for previously corrupted or malformed inputs.

## Storage and Performance

- Avoid row-by-row loops when vectorized or batch operations exist.
- Keep memory growth visible when processing large datasets.
- Push filters and projections down to extract queries when possible.

## Security Baseline

- Never hardcode warehouse, API, or cloud credentials.
- Treat inbound files and messages as untrusted.
- Parameterize SQL and sanitize destination object names through allowlists.

## Delivery Checklist

- [ ] Pipeline stages are separated cleanly.
- [ ] Every stage function is type-annotated.
- [ ] Idempotency strategy is explicit.
- [ ] Schema drift and record drops are observable.
- [ ] Logging captures counts and batch identifiers.
- [ ] Tests cover malformed input and regression cases.
- [ ] Secrets remain external to source control.
