# Design and Dependencies

## Capability preference

For a needed capability, prefer:

1. language built-ins and the standard library;
2. a suitable, trusted third-party dependency;
3. a custom implementation only when neither safely satisfies the requirement.

Reuse existing project helpers and installed dependencies before adding new code or packages. A trusted dependency has appropriate provenance, maintenance, security history, license, runtime support, and operational cost.

Do not reimplement established parsing, encoding, validation, concurrency, cryptography, protocol, collection, or serialization behavior without a concrete reason. Do not add a dependency merely to replace a few clear lines of domain logic.

## Complexity

- Keep the public surface minimal and implementation details local.
- Keep each function focused on one coherent responsibility.
- Extract a helper when it is reused, isolates meaningful complexity, or names a real boundary.
- Inline one-use helpers that only rename an expression.
- Prefer direct control flow and visible data flow over speculative abstractions, wrappers, indirection, and unused configurability.
- Keep sequential work sequential; name meaningful stages instead of compressing operations into dense expressions.
- Trace the real call path before adding a layer or representation.
- Avoid representation round-trips such as callback → Promise → effect when the external operation can implement the consumer's abstraction directly.
- Before writing preprocessing or normalization, verify whether the platform or dependency already guarantees it.
- Apply the interface rules in `architecture.md`.
