# Code

## Authority

This file defines strict rules for how agents write and modify code.

These rules apply to all code changes unless another rule file explicitly overrides them with equal or higher specificity.

## Error Handling

Fail loudly. Do not swallow exceptions or silently return default values. Every error must either be handled with an explicit recovery strategy or propagated to the caller.

Do not wrap code in generic try/catch blocks without distinguishing between expected and unexpected failures. Catch specific error types and handle each one deliberately.

Log errors at the point where they are handled, not where they are thrown. Include enough context in the log message to diagnose the issue without reading the code.

## Naming

Function names must describe what the function returns or what side effect it produces. A reader should be able to predict the function's behavior from its name without reading the implementation.

Boolean variables and functions must read as yes/no questions: `isValid`, `hasPermission`, `canRetry`. Do not use names like `flag`, `status`, or `check` for booleans.

Avoid abbreviations unless they are standard in the project's domain. When in doubt, spell it out.

Do not encode type information in names. Let the type system do that work.

Use the same terms the domain uses. If the domain calls it a "policy", the code calls it a "policy", not a "rule" or "config". When a name in the code does not match what the user or domain expert would say, the name is wrong. The agent should flag or correct naming mismatches rather than silently adopting inconsistent terminology.

## Complexity

Functions must do one thing. If a function requires a comment to explain what "the next section" does, that section should be a separate function.

Maximum nesting depth is 3 levels. Use early returns, guard clauses, or extracted functions to flatten deep nesting.

## Input Validation

Validate inputs at system boundaries: API endpoints, CLI entry points, message consumers, and any function that accepts data from an external source. Internal functions may trust their callers when the call chain is short and well-typed.

Do not scatter validation logic throughout the codebase. Centralize it at the boundary and let validated data flow inward.

Reject invalid input early and with a clear error message. Do not silently coerce or truncate values.

## Comments

Comments must explain why, not what. If a comment restates what the code does, remove it.

Required comments:

- non-obvious design decisions
- intentional trade-offs or known limitations
- workarounds for external bugs or constraints
- regulatory or compliance reasoning

Prohibited comments:

- commented-out code (remove it; version control preserves history)
- TODO without an associated issue reference
- section dividers or decorative formatting

## File Organization

Each file should have a single, clear responsibility. If a file grows beyond what a reader can hold in working memory, split it.

Group imports by origin: standard library, external dependencies, internal modules. Separate each group with a blank line.

Constants that are used across multiple files belong in a dedicated module. Constants used in a single file stay in that file.

Do not place utility functions in a generic "utils" or "helpers" module. Place them in a module named after the concern they address.

## Meaningful Values

Do not pass bare primitives when the value represents a domain concept. A threshold, a file path, a timeout, or an amount belongs in a named constant or a small function. The name must communicate what the value means. The goal is not elaborate type wrappers, but ensuring a reader never has to guess why a particular number or string appears in the code.

## Agent Behavior

Before modifying existing code, read the surrounding file and any closely related files to understand the conventions already in use. Match the existing patterns rather than introducing new ones.

Do not refactor code that is unrelated to the current task. If the agent identifies a problem outside the task scope, note it in a comment or communicate it to the user, but do not fix it in the same change.

When generating new code, prefer the simplest solution that satisfies the requirement. Do not introduce abstractions, patterns, or indirection unless the current requirement demands it.

### Edit Granularity

Use the smallest edit that satisfies the request. When the task requires changing part of a file, use a targeted replacement. Do not overwrite or regenerate the entire file.

The correct diff for "fix this function" changes that function. It does not reformat surrounding code, adjust imports that still work, or rewrite adjacent functions.

### Conflicts with Existing Code

When the user's existing code contradicts a rule in this file, match the existing pattern and flag the conflict. Do not silently "fix" the code to comply with the rule. The user may have reasons for the deviation that are not documented.

Violation: the codebase uses generic `catch (e)` blocks everywhere, and the agent rewrites them to catch specific error types during an unrelated change because this file says to catch specific types.

### Ambiguity

When a code decision is ambiguous, ask. This includes naming choices that could go either way, structural decisions with trade-offs, and any situation where two reasonable developers would disagree. "I went with X because it seemed right" is not an acceptable justification when the alternative was equally plausible.
