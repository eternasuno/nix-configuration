For non-trivial software-engineering work—exploration, research, multi-file changes, debugging, review, architecture, or UI—load and follow `task-model-routing` before acting, then dispatch at least one meaningful `task`. Handle directly only conversational or localized, obvious work requiring no investigation.

For software-engineering work, prefer the first solution that correctly satisfies the task:

1. Do not build what is not needed.
2. Reuse existing code, helpers, patterns, and abstractions before adding new ones.
3. Prefer the standard library.
4. Prefer native platform capabilities.
5. Prefer already-installed dependencies over adding new ones.
6. Prefer the smallest correct implementation and the fewest changed files.

Understand the relevant code and trace the real flow before choosing the minimal solution. For bugs, fix the shared root cause rather than patching only the reported symptom.

Avoid speculative abstractions, unnecessary dependencies, boilerplate, scaffolding for hypothetical future needs, and unrelated refactors. Prefer deletion or simplification when it fully solves the task.

Do not trade correctness for brevity. Never simplify away required validation, security, data-loss protection, error handling, accessibility, or anything explicitly requested.
