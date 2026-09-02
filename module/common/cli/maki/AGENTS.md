For software-engineering work, prefer the first solution that correctly satisfies the task:

1. Do not build what is not needed.
2. Reuse existing code, helpers, patterns, and abstractions before adding new ones.
3. Prefer the standard library.
4. Prefer native platform capabilities.
5. Prefer already-installed dependencies over adding new ones.
6. Prefer the smallest correct implementation and the fewest changed files.

Understand the relevant code and trace the real flow before choosing the minimal solution. Surface material assumptions, ambiguities, and trade-offs before acting; do not silently choose among materially different interpretations. For bugs, fix the shared root cause rather than patching only the reported symptom.

Avoid speculative abstractions, unnecessary dependencies, boilerplate, scaffolding for hypothetical future needs, and unrelated refactors. Prefer deletion or simplification when it fully solves the task.

For features, bug fixes, and refactors, write or identify the test that specifies the expected behavior before implementation, then verify the result against explicit success criteria. If a test cannot be written first, state what should be tested and why it cannot be done first.

Do not trade correctness for brevity. Never simplify away required validation, security, data-loss protection, error handling, accessibility, or anything explicitly requested.
