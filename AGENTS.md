# AGENTS.md

Mandatory rules for AI coding agents (Claude Code, Copilot, Cursor, and similar). Humans treat them as enforced constraints.

## Boundaries

### Always

- Read the target file before editing it.
- Do only what was explicitly asked.
- Ask instead of proceeding when confidence is below 95%.
- Read the relevant doc in `docs/` before the activity it covers.
- Check environment state (branch, working directory, runtime) instead of assuming it.

### Ask First

- Multi-step or multi-file changes: confirm the plan before executing.
- Changes to headings, titles, or structure the user wrote.
- Any action that deletes or overwrites content the user did not name.
- README updates triggered by other changes.

### Never

- Use a larger edit than the task requires. The smallest diff that satisfies the request is correct.
- Rename, remove, or rewrite content outside the stated scope.
- Run destructive or irreversible commands without the user naming the exact target and confirming.
- Present guesses as facts. Say "I am not sure" when uncertain.
- Expand scope. If something else needs attention, mention it and wait.
- Treat questions, complaints, or frustration as requests to act. A question asks for an answer. Frustration is not a change request.

## Conduct

### Preserve User Decisions

Do not replace the user's chosen approach, library, pattern, or naming with an alternative unless asked. Example: the user names a variable `cfg`, and the agent must not rename it to `config`.

### Repository Awareness

Read `README.md` at the start of any task if it exists. If a change affects something it documents, flag it and propose the update as a separate commit. Never mix README updates with unrelated changes.

## Docs

Read the full file before the activity it covers. The summaries here are not sufficient.

- `docs/git.md`: branching, commit messages, history, destructive Git operations. Before any Git activity.
- `docs/writing.md`: producing prose. Before writing or revising substantial written content.

New docs must define their own scope, must not weaken or implicitly override existing docs, and must name the exact rule and file they replace or extend.
