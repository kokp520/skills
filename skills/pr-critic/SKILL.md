---
name: pr-critic
description: Inspect and review a GitHub PR URL using the gh CLI. Evaluate code changes for correctness, feasibility, and potential improvements, modify local files as requested, and suggest commit messages.
disable-model-invocation: true
---

# PR Critic

Analyze a GitHub Pull Request (PR) by downloading its diff using the GitHub CLI (gh), scrutinize the logic for potential improvements, interactive with the user for any questions, refine local files based on findings, and suggest high-quality conventional commit messages.

## Trigger Conditions
* When the user mentions `/pr-critic` or asks to "review a pull request" or "check this PR".
* When the user provides a GitHub PR link and wants an inspection or feasibility review.

## Steps

### 1. Extract or Request PR URL
* Parse the user's prompt for a GitHub Pull Request URL (matching pattern `github.com/owner/repo/pull/num`).
* If no URL is found, ask the user to provide it. You can use the `ask_question` tool or a direct text prompt to retrieve the link.
* Completion Criterion: A valid GitHub PR URL is identified.

### 2. Verify and Bootstrap gh CLI Environment
* Check if the GitHub CLI (`gh`) is installed and authenticated. Run:
  ```bash
  gh auth status
  ```
* If `gh` is missing or the authentication check fails, stop and ask the user if they want to install it or help them establish credentials. Do not proceed with PR downloading until the environment is healthy.
* Completion Criterion: The `gh` command is fully responsive and authenticated.

### 3. Fetch PR Details and Diff (inspect-phase)
* Retrieve the PR basic details (title, body):
  ```bash
  gh pr view <PR-URL>
  ```
* Retrieve the actual unified diff of the PR:
  ```bash
  gh pr diff <PR-URL>
  ```
* Completion Criterion: The PR title, body, and full diff content are successfully loaded into your context.

### 4. Evaluate and Scrutinize Code Changes (critic-loop)
* Critically evaluate the changes in the diff along three dimensions:
  1. **Reasonableness**: Does the architectural approach make sense for the problem being solved?
  2. **Feasibility**: Are there edge cases, race conditions, null pointer issues, or syntax errors?
  3. **Optimization**: Are there cleaner, more performant, or more idiomatic ways to implement the solution?
* If you identify any potential bugs, security concerns, or have doubts about the implementation details, stop and compile a list of questions or issues. Present them to the user clearly to seek alignment before moving forward.
* Completion Criterion: A thorough review report is presented, and any critical questions have been answered by the user.

### 5. Interactive Refinement
* Collaborate with the user to iterate on the solutions.
* If the user agrees on making local code adjustments based on your PR review:
  * Locate the corresponding files in your local workspace.
  * Apply modifications to the local files directly using file-editing tools (such as `replace_file_content` or `multi_replace_file_content`).
  * Always run validations (like tests or compilation checks) if available after making edits.
* Do NOT run `git add` or `git commit`. Keep the modifications unstaged for the user to review.
* Completion Criterion: The agreed-upon code changes are written locally and validated.

### 6. Synthesize Git Commit Messages
* Once all code refinements are completed and approved by the user, draft a set of suggested Git commit messages following the Conventional Commits specification.
* Format the suggestions based on the specific changes made:
  ```
  <type>[optional scope]: <description>
  ```
  Where `type` is `feat`, `fix`, `docs`, `refactor`, `perf`, `test`, `style`, `chore`, etc.
* Present these suggested messages to the user for their easy copy-pasting.
* Completion Criterion: Clear, compliant Conventional Commit messages are displayed to the user.

## Reference

### Failure Modes and Safe Paths
* **CLI Authorization Failure**: If the remote fetch fails due to private repository constraints, ask the user to configure `gh` with appropriate scopes (e.g., `repo`) or prompt them to paste the PR diff directly in the chat.
* **No-Op Refactoring**: Avoid modifying code that does not actively improve readability, security, or performance. Only recommend changes that yield clear benefits.
* **Premature Commit**: Ensure you never automatically commit code. Leave git staging and committing entirely to the user.
