# Readability

- Keep control flow and data flow visible.
- Keep sequential operations sequential.
- Name meaningful stages instead of compressing unrelated operations into dense expressions.
- Use semantic names; reserve short names for tiny conventional scopes.
- Name operation-specific contracts after the operation instead of using ambiguous generic labels.
- Keep functions focused on one coherent responsibility.
- Extract helpers for reuse, meaningful complexity, or real boundaries; inline helpers that only rename a single expression.
- Write comments for non-obvious reasons, constraints, and trade-offs. Let code express visible behavior.
- Follow the repository's established formatting and naming conventions; leave mechanical formatting rules to tooling.
