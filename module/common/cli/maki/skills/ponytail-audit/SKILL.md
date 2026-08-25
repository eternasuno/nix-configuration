---
name: ponytail-audit
description: >
  Whole-repo audit for over-engineering. Scans the entire codebase for deletion,
  simplification, and stdlib/native replacements. Use when the user says "audit this
  codebase", "audit for over-engineering", "what can I delete from this repo",
  "find bloat", "ponytail-audit", or invokes /ponytail-audit. One-shot report;
  does not apply fixes.
---

Audit the whole repository for over-engineering. Rank findings biggest cut first and cite paths.

## Tags

- `delete:` dead code, unused flexibility, speculative feature. Replacement: nothing.
- `stdlib:` hand-rolled thing the standard library ships. Name the function.
- `native:` dependency or code doing what the platform already does. Name the feature.
- `yagni:` abstraction with one implementation, config nobody sets, layer with one caller.
- `shrink:` same logic, fewer lines. Show the shorter form.

## Hunt

Dependencies the standard library or platform already ships, single-implementation interfaces, factories with one product, wrappers that only delegate, files exporting one thing, dead flags and configuration, and hand-rolled standard-library functionality.

## Output

One line per finding, ranked: `<tag> <what to cut>. <replacement>. [path]`.
End with `net: -<N> lines, -<M> deps possible.` If nothing can be cut, say `Lean already. Ship.`

## Boundaries

Scope: over-engineering and complexity only. Correctness bugs, security holes, and performance are out of scope; route them to a normal review. List findings only; apply nothing. "stop ponytail-audit" or "normal mode" means use normal behavior for the current response.