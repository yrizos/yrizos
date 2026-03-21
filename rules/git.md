# Git

## Authority

This file defines strict rules for all Git operations: branching, commit messages, and history management.

These rules apply to all Git activity unless another rule file explicitly overrides them with equal or higher specificity.

## Destructive Operations

Agents must never perform destructive Git operations without explicit user confirmation. Destructive operations fall into two categories.

Operations that destroy shared history: force pushing, deleting branches that are not the agent's own, resetting commits on shared branches, and any operation that rewrites history already pushed to a remote.

Operations that destroy uncommitted work: `git restore`, `git checkout -- <path>`, `git reset --hard`, and `git clean`. These discard local changes that cannot be recovered from Git.

Before performing any destructive operation, the agent must stop and ask the user for confirmation. The agent must describe exactly what the operation will do and what data could be lost.

### Ask First

Some Git operations are not destructive but carry risk. These require user confirmation before execution:

- amending the most recent commit
- squashing commits on an unshared branch
- force-pushing to a personal branch
- interactive rebase on a local branch

The agent must describe what it intends to do and wait for approval. "This will rewrite the last 3 commits on your local branch" is the expected level of specificity.

## Branching

### Branch Naming

Each branch name must follow this structure:

```
<type>/<short-description>
```

The short description uses lowercase words separated by hyphens. It must be concise and specific enough to identify the work without reading the associated issue or pull request.

### Allowed Branch Types

- `feature`: new functionality
- `fix`: bug fix
- `hotfix`: urgent production fix, branched from the release or main branch
- `refactor`: restructuring without behavior change
- `chore`: maintenance work, including dependencies, tooling, and configuration
- `docs`: documentation changes
- `test`: test additions or corrections
- `release`: release preparation

No additional types are allowed unless explicitly introduced in this file.

### Branch Naming Examples

```
feature/user-export-csv
fix/null-pointer-on-login
hotfix/payment-timeout
refactor/extract-auth-middleware
chore/upgrade-node-20
docs/api-rate-limits
release/2.4.0
```

### Prohibited Branch Patterns

Do not use:

- bare names without a type prefix, such as `my-branch`
- issue numbers as the sole description, such as `fix/1234`
- uppercase letters, underscores, or dots in the short description
- nested paths beyond type and description, such as `feature/api/users/export`

Issue numbers may appear alongside a description, such as `fix/1234-null-pointer-on-login`.

### Branch Lifecycle

Branches must be short-lived. A branch exists to deliver a single pull request and should be deleted after merge.

Long-lived branches are limited to `main`, `develop` (if used), and `release/*` branches awaiting deployment.

Do not reuse merged branch names.

## Commit Messages

### Objective

Commit messages must:

- communicate intent unambiguously
- allow independent reasoning about changes
- support reliable history navigation and debugging
- avoid interpretation or guesswork

### Format

Each commit message must follow this structure:

```
<type>: <subject>

<body>
```

### Scope Field

Scope is not allowed.

Do not use the `<type>(scope):` form. Do not introduce parentheses after the type.

All classification must be expressed through:

- the type
- the subject line

### Allowed Commit Types

- feat
- fix
- refactor
- perf
- test
- docs
- build
- ci
- chore

No additional types are allowed unless explicitly introduced in this file.

### Subject Line

Rules:

- maximum 72 characters
- imperative mood
- no trailing period
- no vague or generic wording

The subject must describe what the change does.

The subject should be understandable to any contributor familiar with the repository. Avoid abbreviations or terminology that only make sense within a single team or feature branch.

### Body

Required when the subject line alone does not fully describe what changed and why. Commits that change fewer than 5 lines and have a fully descriptive subject are likely trivial enough to omit the body. The deciding factor is semantic completeness, not line count.

Must include:

- what changed
- why the change was necessary
- any relevant constraints or side effects

Must not include:

- implementation process
- development steps
- tool usage

### Body Structure

Use plain paragraphs by default.

Use bullet points only when the content is a set of independent, parallel items.

Do not convert explanatory or causal text into bullet lists.

### Atomicity

Each commit must represent a single logical change.

Do not:

- combine unrelated changes
- mix refactor with behavior change
- batch independent fixes

Violation: a single commit that updates a dependency, fixes a bug exposed by the update, and reformats an unrelated file. These are 3 separate commits.

When a behavior change requires a preparatory refactor, split them into separate commits. The preparatory commit's subject and body must state the upcoming change it enables, so it is independently understandable.

### Prohibited Commit Content

Do not include:

- vague phrases such as "update", "cleanup", "fix stuff"
- effort descriptions such as "quick fix"
- unverified tool-generated summaries
- conversational or emotional language

### Agent Commit Workflow

Before writing a commit message, the agent must inspect the actual staged changes using `git diff --cached`. The commit message must be derived entirely from the staged diff. The agent must not rely on chat history, task descriptions, or its own prior memory of edits. The user may have staged changes the agent is unaware of.

### Attribution

When an agent generates a commit, the human operator is the author. The commit must not attribute authorship to the agent.

If the repository uses `Co-authored-by` trailers, the agent may be listed as a co-author. This is optional, not required.

### Issue References

If used, append at the end of the body:

```
Refs: #<issue>, #<issue>
```

Multiple issues are comma-separated on a single line.

Issue references must not replace the subject.

## History Hygiene

Before integration into a shared branch:

- rewrite unclear messages
- squash commits that do not stand alone
- ensure each commit is independently valid

Agents must not execute history rewrites autonomously. Rebasing, squashing, and amending are destructive to local history. The agent must propose the cleanup and wait for the user to confirm before running any rebase or fixup operation.

Squash merges at the pull request level are acceptable as an alternative and do not require additional confirmation.

Intermediate or incomplete commits must not enter shared history.

## Enforcement

### Branch Enforcement

A branch name is invalid if:

- it lacks a type prefix
- the type is not in the allowed list
- the description is vague or generic, such as `feature/stuff`
- it violates the naming format

Invalid branch names must be corrected before opening a pull request.

### Commit Enforcement

A commit is invalid if:

- intent is not clear from the message
- understanding requires reading the diff
- multiple concerns are combined
- the message describes activity instead of outcome

Invalid commits must be rewritten.
