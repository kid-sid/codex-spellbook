---
name: typescript
description: TypeScript guidance covering strict mode, Zod runtime validation, eliminating any, discriminated unions, Result-style error handling, module format choices, path aliases, and Vitest testing.
category: development
---

# TypeScript Instructions for Codex

Use the type system aggressively at compile time and Zod at runtime so invalid states are hard to represent and easy to reject.

## Scope
- Enforce strict TypeScript configuration.
- Validate untrusted input with Zod.
- Replace `any` with precise types.
- Model variants with discriminated unions.
- Standardize module format and testing choices.

## Standards and Conventions

### Compiler Settings

| Setting | Expectation |
| --- | --- |
| `strict` | `true` |
| `noUncheckedIndexedAccess` | enabled |
| `exactOptionalPropertyTypes` | enabled when practical |
| `moduleResolution` | aligned to runtime and bundler |

### Runtime Validation

BAD

```ts
const body = req.body as CreateUserInput;
```

GOOD

```ts
const CreateUserSchema = z.object({
  email: z.string().email(),
  name: z.string().min(1),
});

const body = CreateUserSchema.parse(req.body);
```

### Type Modeling

| Problem | Preferred | Avoid |
| --- | --- | --- |
| Heterogeneous state | Discriminated union | Optional field soup |
| External JSON | `unknown` then parse | `any` |
| Recoverable failure | `Result<T, E>` style return | Throwing for normal control flow |

### ESM vs CJS

| Situation | Choice |
| --- | --- |
| New Node 20+ service | ESM |
| Legacy toolchain locked to CJS | CJS until migration is funded |
| Mixed environment | Hide format behind build output boundary |

### Path Aliases

| Preferred | Avoid |
| --- | --- |
| Stable aliases like `@/domain/user` | Deep relative imports like `../../../../user` |
| Match runtime and TS config | Compile-only aliases that break at runtime |

### Testing With Vitest

| Rule | Why |
| --- | --- |
| Co-locate or mirror test files consistently | Easier navigation |
| Use `vi.mock` only at unstable boundaries | Preserve real type interactions |
| Keep fake timers explicit | Avoid hidden temporal coupling |

### BAD / GOOD Examples

BAD

```ts
type Payment = {
  status?: "pending" | "paid";
  error?: string;
  receiptUrl?: string;
};
```

GOOD

```ts
type Payment =
  | { status: "pending" }
  | { status: "paid"; receiptUrl: string }
  | { status: "failed"; error: string };
```

## When to Apply These Patterns
- Configure a new TypeScript service.
- Add request parsing or input validation.
- Replace `any` in an existing module.
- Model variant-heavy state or workflow results.
- Choose ESM or CJS for a package.
- Introduce path aliases in a growing codebase.
- Write or review Vitest suites.

## Checklist
- [ ] `strict` mode is enabled.
- [ ] Untrusted input is parsed from `unknown` with Zod.
- [ ] `any` is eliminated or tightly isolated.
- [ ] Variant data uses discriminated unions.
- [ ] Error paths are modeled explicitly.
- [ ] Module format matches runtime expectations.
- [ ] Path aliases are configured consistently across tools.
