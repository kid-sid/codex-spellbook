---
name: testing
description: Testing guidance covering AAA structure, naming, mocks versus real dependencies, coverage targets, TDD flow, parameterized tests, and flake-resistant suites.
category: testing
---

# Testing Instructions for Codex

Write tests that isolate behavior, document intent, and fail for one reason at a time.

## Scope
- Structure tests with Arrange, Act, Assert.
- Name tests by behavior and scenario.
- Decide what to mock and what to keep real.
- Set coverage targets by system type.
- Prevent flaky tests and support TDD.

## Standards and Conventions

### Test Structure

| Phase | Purpose | Rule |
| --- | --- | --- |
| Arrange | Build inputs and collaborators | Keep setup minimal and explicit |
| Act | Execute one behavior | One action per test |
| Assert | Verify outcome | Assert observable effects, not internals |

### Naming

| Style | Example |
| --- | --- |
| Python | `test_create_user_rejects_duplicate_email` |
| TypeScript | `it("rejects duplicate email on createUser")` |
| Go | `func TestCreateUser_RejectsDuplicateEmail(t *testing.T)` |

### Mock vs Real

| Dependency | Default | Reason |
| --- | --- | --- |
| Database adapter in unit tests | Mock or in-memory fake | Keep units fast |
| Pure domain services | Real | No need to mock deterministic logic |
| HTTP clients | Mock at network boundary | Avoid external flake |
| Serialization and validation | Real | Contract drift matters |

### Coverage Targets

| Codebase Type | Target |
| --- | --- |
| Shared library | `>= 90%` line coverage |
| Backend service | `>= 80%` line coverage with integration coverage on critical flows |
| Frontend app | `>= 70%` on logic-heavy modules, E2E coverage on core journeys |

### TDD Loop

| Step | Goal |
| --- | --- |
| Red | Prove the behavior is missing |
| Green | Implement the smallest passing change |
| Refactor | Improve structure without changing behavior |

### Parameterized Tests

Use tables when the assertion is stable and inputs vary.

Python

```python
@pytest.mark.parametrize(("input", "expected"), [("A", "a"), ("B", "b")])
def test_normalize_code(input: str, expected: str) -> None:
    assert normalize_code(input) == expected
```

TypeScript

```ts
it.each([
  ["A", "a"],
  ["B", "b"],
])("normalizes %s", (input, expected) => {
  expect(normalizeCode(input)).toBe(expected);
});
```

### Flakiness Prevention

| Risk | Prevention |
| --- | --- |
| Time dependence | Freeze time or inject clock |
| Randomness | Seed generators |
| Order dependence | Isolate global state and DB fixtures |
| Network | Stub external calls |

### BAD / GOOD Examples

BAD

```python
def test_user_flow():
    # creates user, sends email, checks DB, checks cache
    ...
```

GOOD

```python
def test_create_user_persists_record() -> None:
    ...

def test_create_user_enqueues_welcome_email() -> None:
    ...
```

## When to Apply These Patterns
- Add tests for new behavior.
- Refactor a flaky or slow test suite.
- Decide whether a collaborator should be mocked.
- Raise or enforce coverage expectations.
- Convert duplicated tests into parameterized cases.
- Review a PR for missing test coverage.
- Drive a change with TDD.

## Checklist
- [ ] Each test follows Arrange, Act, Assert.
- [ ] Test names describe behavior and scenario.
- [ ] Mocks are used only at unstable boundaries.
- [ ] Critical paths have integration coverage.
- [ ] Time, randomness, and network are controlled.
- [ ] Parameterized tests replace duplicated assertion logic where useful.
- [ ] Coverage targets match the codebase type.
