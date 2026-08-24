---
name: task-model-routing
description: Route delegated tasks to the required model and subagent type. Use whenever dispatching work with the task tool.
---

# Task model routing

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
- If no route clearly matches or the task is trivial, handle it directly with the main agent.
- Inspect and reconcile subagent results before responding to the user.
