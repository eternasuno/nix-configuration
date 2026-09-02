---
name: writing-lean-code
description: Lean, direct code design with minimal unnecessary complexity. Use for every code change, including implementation, refactoring, bug fixes, tests, configuration, and review; prefer built-ins, clear boundaries, and minimal custom infrastructure.
---

# Writing Lean Code

Write the smallest clear implementation that preserves required behavior. Prefer direct code, pure business logic, and explicit boundaries for external effects.

## Capability preference

Choose capabilities in this order:

1. Language built-ins and the standard library.
2. A suitable, trusted third-party dependency.
3. A custom implementation only when the first two cannot safely satisfy the requirement.

See `design-and-dependencies.md` for the decision rules.

## Core boundaries

Prefer two layers:

- **Inner layer:** domain data, validation, decisions, and business transformations. Keep these functions pure and independent of external systems.
- **Outer layer:** entry points, persistence, network, files, processes, frameworks, serialization, configuration, and concrete effect implementations.

Keep effects in the outer layer. Use an interface only when an explicit design requires a stable boundary, dependency inversion, multiple implementations, or a deliberate test seam. Do not create interfaces merely for mocking or possible future substitution.

See `architecture.md` for the boundary rules.

## Readability conventions

- Separate every top-level declaration with a blank line, regardless of declaration kind. Treat related members inside one declaration as a unit.
- Write every block-capable construct with an explicit braced body, including single-statement bodies.
- Separate a completed block from the next statement with a blank line. Keep directly connected branches, handlers, and continuations together as one construct.
- Put a blank line before a terminating statement such as `return` or `throw` unless it is the block's only statement.
- Apply these layout principles by syntax and role rather than by a closed list of keywords. Use blank lines to expose declaration boundaries and control-flow stages without adding visual noise.

## Focused references

- Structural complexity and capability choice: `design-and-dependencies.md`
- Contracts, data flow, ownership, and effects: `contracts-and-data.md`
- Control flow, naming, and comments: `readability.md`
- Test layout and test boundaries: `testing.md`
- TypeScript, TSX, and TypeScript-governed JavaScript: `typescript.md`

## Workflow

Before modifying code, load and apply this skill. Apply these conventions to production code, tests, and configuration changes. Before finishing, inspect the diff and run the project's formatter, linter, type checker, and tests when available.

## Guardrails

Do not simplify away required validation, error handling, security, accessibility, compatibility, data protection, side-effect ordering, performance requirements, or meaningful test seams. Follow the repository's formatter, linter, compiler or interpreter, runtime, and complexity budgets.
