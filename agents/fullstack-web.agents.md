# Fullstack Web Agent Template

## Purpose

Use this template for Next.js or SvelteKit applications that combine typed frontend code, server routes, form handling, and accessibility-sensitive UI work.

## Environment Setup

Run these commands before starting work:

```bash
set -euo pipefail
bash setup-scripts/node.sh
node --version
pnpm --version
pnpm exec playwright --version >/dev/null 2>&1 || true
```

## Working Style

- Preserve the existing design system and interaction patterns.
- Keep business logic out of components when it can live in typed utilities or services.
- Treat accessibility and form validation as first-class product requirements.
- Default to TypeScript strictness and explicit runtime parsing at boundaries.

## Frontend Conventions

- Components should have one dominant responsibility.
- Prefer explicit props types and discriminated unions over optional prop soup.
- Keep client-only state local; lift state only when coordination requires it.
- Avoid premature memoization unless the codebase already standardizes it.

## API and Form Design

- Validate forms on both client and server boundaries.
- Normalize server errors into user-safe field or form messages.
- Keep route handlers thin and shared logic reusable.
- Version breaking API changes instead of mutating contracts silently.

## Accessibility Baseline

- Every interactive control must be reachable by keyboard.
- Provide labels, roles, and error text that screen readers can consume.
- Preserve focus on dialog open and close.
- Respect reduced-motion preferences for non-essential animation.

## Testing

- Use Vitest for units and Playwright for end-to-end flows.
- Add unit tests for logic-heavy utilities and state transitions.
- Add Playwright coverage for primary user journeys, auth flows, and form submissions.
- Avoid brittle selector strategies; prefer role- and label-based selectors.

## Performance and Delivery

- Watch bundle growth and avoid client-shipping server-only dependencies.
- Defer or split heavy client code when possible.
- Keep image and font loading intentional.
- Use Docker multi-stage builds when containerized deployment exists.

## Git Workflow

- Use branch and commit conventions consistently.
- Keep PRs focused by feature or bug surface.
- Note accessibility, API, and migration risks in PR descriptions.

## Security Baseline

- Validate all route input and action payloads.
- Never expose secrets to client bundles.
- Enforce authorization on server-side data access.
- Review SSR, CSRF, and XSS surfaces on interactive features.

## Delivery Checklist

- [ ] Components and routes remain strictly typed.
- [ ] Forms validate at both client and server boundaries.
- [ ] Accessibility checks cover labels, focus, and keyboard use.
- [ ] Vitest and Playwright coverage match the changed behavior.
- [ ] Client bundle changes are justified.
- [ ] Secrets remain server-only.
