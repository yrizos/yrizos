# Git

Strict rules for all Git activity: branching, commit messages, history.

## Destructive Operations

Never run these without explicit user confirmation. Before running one, stop, state exactly what it does and what data could be lost, and ask.

- Destroys shared history: force push, deleting branches that are not yours, resetting commits on shared branches, any rewrite of pushed history.
- Destroys uncommitted work: `git restore`, `git checkout -- <path>`, `git reset --hard`, `git clean`.

### Ask First

Not destructive but risky. Describe the intent and wait for approval, for example "This will rewrite the last 3 commits on your local branch".

- amend the most recent commit
- squash commits on an unshared branch
- force-push to a personal branch
- interactive rebase on a local branch

## Branching

### Branch Naming

Format: `<type>/<short-description>`

The description uses lowercase words separated by hyphens. It must identify the work without reading the issue or pull request.

Allowed types, and no others:

- `feature`: new functionality
- `fix`: bug fix
- `hotfix`: urgent production fix, branched from the release or main branch
- `refactor`: restructuring without behavior change
- `chore`: dependencies, tooling, configuration
- `docs`: documentation changes
- `test`: test additions or corrections
- `release`: release preparation

Examples:

```text
feature/user-export-csv
fix/null-pointer-on-login
hotfix/payment-timeout
refactor/extract-auth-middleware
chore/upgrade-node-20
docs/api-rate-limits
release/2.4.0
```

### Prohibited Branch Patterns

- no type prefix, such as `my-branch`
- an issue number as the sole description, such as `fix/1234` (`fix/1234-null-pointer-on-login` is fine)
- uppercase letters, underscores, or dots in the description
- nesting beyond type and description, such as `feature/api/users/export`
- vague descriptions, such as `feature/stuff`

Invalid branch names must be corrected before opening a pull request.

### Branch Lifecycle

A branch delivers a single pull request and is deleted after merge. Do not reuse merged branch names.

Long-lived branches are limited to `main`, `develop` (if used), and `release/*` branches awaiting deployment.

## Commit Messages

Messages must state intent unambiguously, so changes can be reasoned about independently and history stays navigable.

### Format

```text
<type>: <subject>

<body>
```

Scope is not allowed. Do not use `<type>(scope):` or any parentheses after the type.

Allowed types, and no others: feat, fix, refactor, perf, test, docs, build, ci, chore.

### Subject Line

- maximum 72 characters
- imperative mood
- no trailing period
- no vague or generic wording
- describes what the change does
- understandable to any contributor, with no abbreviations or terms specific to one team or branch

### Body

Required when the subject alone does not fully describe what changed and why. The test is semantic completeness, not line count. A commit under 5 changed lines with a fully descriptive subject can omit it.

Must include what changed, why, and any constraints or side effects.

Must not include implementation process, development steps, or tool usage.

Use plain paragraphs. Use bullets only for independent, parallel items, never for explanatory or causal text.

### Atomicity

Each commit is a single logical change. Do not combine unrelated changes, mix refactor with behavior change, or batch independent fixes.

Example: a commit that updates a dependency, fixes a bug exposed by the update, and reformats an unrelated file must be 3 commits.

When a behavior change needs a preparatory refactor, use separate commits. The preparatory commit's subject and body must state the change it enables.

### Prohibited Commit Content

- vague phrases such as "update", "cleanup", "fix stuff"
- effort descriptions such as "quick fix"
- unverified tool-generated summaries
- conversational or emotional language

### Agent Commit Workflow

Inspect `git diff --cached` before writing the message. Derive the message entirely from the staged diff. Never rely on chat history, task descriptions, or memory of your own edits, because the user may have staged changes you do not know about.

### Attribution

The human operator is the author. Never attribute authorship to the agent. A `Co-authored-by` trailer naming the agent is optional.

### Issue References

If used, end the body with a single line, comma-separated, and never in place of the subject:

```text
Refs: #<issue>, #<issue>
```

## History Hygiene

Before integration into a shared branch:

- rewrite unclear messages
- squash commits that do not stand alone
- make each commit independently valid

Never rewrite history autonomously. Rebase, squash, and amend are destructive to local history. Propose the cleanup and wait for confirmation before any rebase or fixup.

Squash merges at the pull request level are acceptable and need no extra confirmation.

Intermediate or incomplete commits must not enter shared history.

## Commit Enforcement

A commit is invalid, and must be rewritten, if:

- intent is unclear from the message
- understanding requires reading the diff
- multiple concerns are combined
- the message describes activity instead of outcome
