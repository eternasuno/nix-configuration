---
name: task-model-routing
description: Required for every non-trivial engineering request and before every task call. Use for codebase exploration, multi-file implementation, debugging, review, architecture, research, and UI work to select the model, subagent type, and delegation workflow.
---

# Task model routing

## Delegation gate

For every non-trivial request, dispatch at least one meaningful subtask. Delegate codebase exploration, external research, multi-file implementation, debugging, review, architecture, and UI work. Direct handling is reserved for conversational answers and localized, obvious operations requiring no investigation.

Select the exact model and subagent type according to the task:

- **Research and code exploration**
  - Models, in order:`gpt-load/qwen3.8-flash` -> `gpt-load/deepseek-v4-flash`
  - Type: `research`
  - Use for documentation lookup, external research, codebase search, locating files or symbols, understanding existing code, and read-only investigation.
- **Code changes**
  - Models, in order: `gpt-load/qwen3.8-flash` -> `gpt-load/deepseek-v4-flash`
  - Type: `general`
  - Use for well-defined implementation, bug fixes, refactoring, tests, configuration changes, and other non-visual code modifications.
- **Review**
  - Models, in order: `gpt-load/gpt-5.6-sol` -> `gpt-load/kimi-k2.7-code`
  - Type: `research`
  - Use for code review, security analysis, architecture assessment, difficult debugging, regression detection, and maintainability review. Report concrete findings with severity and file/line references. Do not modify files.
- **UI design and implementation**
  - Model: `gpt-load/gemini-3.7-flash`
  - Type: `general`
  - Use for UI/UX, layout, styling, responsive behavior, accessibility, interactions, animations, visual polish, and user-facing frontend implementation.

## Rules

- Pass the selected model through the `task` tool's `model` parameter.
- For an ordered model chain, try one model at a time and advance only when the `task` call fails because the model or provider is unavailable, rate-limited, or times out. Retry with the same prompt and subagent type; never launch fallback attempts in parallel. If every model fails, report the failure.
- Include all necessary context, paths, constraints, and expected output because every task starts fresh.
- Use `batch` for independent tasks.
- Run dependent stages sequentially: research before implementation, and implementation before review.
- Never run parallel write tasks that may modify overlapping files.
- If several routes apply, split the work into meaningful stages and route each stage separately.
- If no route clearly matches, use the closest route rather than silently skipping delegation.
- Do not delegate token tasks merely to satisfy the gate; each subtask must produce useful research, implementation, or review output.
- Inspect, reconcile, and verify subagent results before responding to the user.