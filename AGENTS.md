# AGENTS.md

## Applicability

This file defines mandatory operational rules for AI coding agents (LLM-based tools such as Claude Code, Copilot, Cursor, and similar).

Human contributors must treat these rules as enforced constraints, not optional style guidance.

## Boundaries

### Always

- Read the target file before editing it.
- Do only what was explicitly asked.
- When confidence is below 95%, ask instead of proceeding.
- Read the relevant rule file before the activity it covers.
- Check environment state (branch, working directory, runtime) before acting on assumptions about it.

### Ask First

- Multi-step or multi-file changes: confirm the plan before executing.
- Changes to headings, titles, or structure the user wrote.
- Any action that deletes or overwrites content the user did not name.
- README updates triggered by other changes.

### Never

- Use a larger edit than the task requires. The smallest diff that satisfies the request is the correct one.
- Rename, remove, or rewrite content outside the stated scope.
- Run destructive or irreversible commands without the user naming the exact target and confirming.
- Present guesses as facts. Say "I am not sure" when uncertain.
- Expand scope beyond what was asked. If something else needs attention, mention it and wait.
- Interpret questions, complaints, or frustration as implicit requests to take action. A question is a request for an answer. Frustration is not a change request.

## Conduct

### Preserve User Decisions

If the user chose a specific approach, library, pattern, or naming convention, do not replace it with an alternative unless asked. User decisions are intentional.

Violation: the user names a variable `cfg` and the agent renames it to `config` because it considers the abbreviation unclear.

### Repository Awareness

Read the repository's README.md at the start of any task if one exists. When a change affects something documented in the README, flag it and propose the update as a separate commit. Do not mix README updates with unrelated changes.

Violation: a structural change adds a new directory, but the agent does not flag that the README's structure section is now out of date.

## Rule Files

Each rule file below is mandatory for the activity it covers. The summaries are not sufficient. Read the full file before performing the associated activity.

- `rules/git.md`: Branching, commit messages, history, and destructive Git operations. Read before any Git activity.
- `rules/code.md`: How agents write and modify code, covering error handling, naming, complexity, validation, comments, and structure. Read before changing or adding source files.
- `rules/writing.md`: How agents produce prose. Read before writing or revising substantial written content.

## Extension Rules

Adding new rule files must not weaken or override existing rules unless explicitly stated.

Future rule files must:

- define their own scope explicitly
- not implicitly override existing rules
- state precedence if overlap exists

If a new rule file needs to modify the behavior defined in an existing file, it must:

- reference the existing file explicitly
- define the exact rule being replaced or extended

Implicit modification is not allowed.
