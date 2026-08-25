---
name: task-model-routing
description: Delegate and route non-trivial software-engineering work. Load before exploration, research, multi-file changes, debugging, review, architecture, or UI work.
---

# Task model routing

## Delegation gate

For every non-trivial request, dispatch at least one meaningful subtask. Delegate codebase exploration, external research, multi-file implementation, debugging, review, architecture, and UI work. Direct handling is reserved for conversational answers and localized, obvious operations requiring no investigation.

Select the exact model and subagent type according to the task:

- **Research and code exploration**
  - Model: `openai/gpt-5.6-luna`
  - Type: `research`
  - Use for documentation lookup, external research, codebase search, locating files or symbols, understanding existing code, and read-only investigation.
- **Code changes**
  - Model: `openai/gpt-5.6-luna`
  - Type: `general`
  - Use for well-defined implementation, bug fixes, refactoring, tests, configuration changes, and other non-visual code modifications.
- **Review**
  - Model: `openai/gpt-5.6-sol`
  - Type: `research`
  - Use for code review, security analysis, architecture assessment, difficult debugging, regression detection, and maintainability review. Report concrete findings with severity and file/line references. Do not modify files.
- **UI design and implementation**
  - Model: `google/gemini-3.7-flash`
  - Type: `general`
  - Use for UI/UX, layout, styling, responsive behavior, accessibility, interactions, animations, visual polish, and user-facing frontend implementation.

## Rules

- Pass the selected model through the `task` tool's `model` parameter.
- Include all necessary context, paths, constraints, and expected output because every task starts fresh.
- Use `batch` for independent tasks.
- Run dependent stages sequentially: research before implementation, and implementation before review.
- Never run parallel write tasks that may modify overlapping files.
- If several routes apply, split the work into meaningful stages and route each stage separately.
- If no route clearly matches, use the closest route rather than silently skipping delegation.
- Do not delegate token tasks merely to satisfy the gate; each subtask must produce useful research, implementation, or review output.
- Inspect, reconcile, and verify subagent results before responding to the user.
