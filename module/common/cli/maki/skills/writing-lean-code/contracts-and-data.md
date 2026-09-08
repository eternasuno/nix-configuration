# Contracts and Data

- Make stable contracts explicit. A contract may be a function, concrete type, schema, protocol message, or tested behavior; it does not automatically require an interface.
- Use a named representation when it adds domain meaning, clarifies a complex contract, or is reused.
- Keep durable domain entities separate from transient interaction, progress, and presentation state; colocate transient state with its owner.
- Store source facts once. Derive summaries, counts, display projections, and other cheap views instead of maintaining synchronized copies.
- Centralize each invariant, normalization, encoding, default, or translation at one authoritative boundary.
- Use structured parameters for cohesive operations with several fields; use direct parameters for small, stable calls where structure adds no clarity.
- Apply defaults at boundaries while preserving explicit values such as `0`, `false`, and empty strings.
- Group parameters by lifetime and responsibility. Pass stable inputs separately when only one part of a state object changes.
- Keep data flow visible. Prefer pure transformations with explicit inputs and outputs.
- Keep mutation local and ownership visible. Return existing data when sharing is safe; copy only for isolation, modification, or required transformation.
- Move invariant computation out of hot paths.
- Keep value comparison separate from ordering direction and follow the target platform's comparison contract.

Inner code returns domain data or failures. It does not produce outer-layer actions unless that is an explicit design. Outer code translates domain results into transport responses, UI behavior, CLI output, persistence, or other effects.
