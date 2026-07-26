---
name: open-pr
description: Create a GitHub pull request. Use when the user wants to open a PR, create a pull request, or mentions "open pr".
---
# Open PR

## Steps

1. **Assess branch state**. Check the current git branch, unpushed commits, and recent commit messages to understand the scope of changes.
   *Completion criterion*: You have gathered all necessary context to describe the changes.

2. **Draft the pitch**. Generate a concise PR title and a descriptive body. 
   - Title: Use conventional commits format if the branch follows it.
   - Body: Explain the *why* and the *what*. Keep it **tight**.
   *Completion criterion*: The drafted title and body are presented to the user for approval.

3. **Execute creation**. Once the user approves or modifies the draft, create the pull request using the GitHub CLI (`gh pr create`).
   *Completion criterion*: The PR is successfully created and the URL is provided to the user.

## Rules

- **Push first**: Ensure all local commits are pushed to the remote branch before attempting to create the PR.
- **Stay positive**: Guide the user through resolving any merge conflicts or missing upstream branches constructively.
