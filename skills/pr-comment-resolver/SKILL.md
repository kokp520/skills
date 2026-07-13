---
name: pr-comment-resolver
description: Automatically fetch PR review comments from co-workers, evaluate their feedback, interact with the user to confirm fixes, apply modifications, and reply to comments on GitHub.
---

# PR Comment Resolver

Automatically retrieve review comments from a GitHub Pull Request (PR), analyze co-worker feedback, locate local file contexts, seek user confirmation via interactive questions, apply fixes, draft replies, and post confirmed responses directly back to GitHub.

## Trigger Conditions
* When the user mentions `/pr-comment-resolver`, `/resolve-comments`, `/fix-comments`, or asks to "fix comments on my PR".
* When the user wants to automatically address reviews/comments on a specific PR.

## Steps

### 1. Identify the PR Context
* Parse the user's prompt for a GitHub Pull Request URL (matching pattern `github.com/owner/repo/pull/num`) or PR number (e.g., `#num`).
* If not explicitly provided, attempt to auto-detect the PR associated with the current checked-out git branch in the repository:
  ```bash
  gh pr view --json url,number
  ```
* If no PR can be auto-detected, ask the user to provide the PR URL or number.
* Completion Criterion: A valid PR number and owner/repository name are identified.

### 2. Verify gh CLI Environment
* Confirm that the GitHub CLI (`gh`) is installed and authenticated:
  ```bash
  gh auth status
  ```
* If the command is unauthenticated, stop and ask the user to configure or authenticate before proceeding.
* Completion Criterion: The `gh` command is fully responsive and authenticated.

### 3. Fetch PR Review Comments
* Fetch the repository info (owner and name) dynamically:
  ```bash
  gh repo view --json owner,name
  ```
* Retrieve the file-specific review comments on the PR using the GitHub API:
  ```bash
  gh api repos/{owner}/{repo}/pulls/{number}/comments
  ```
* Parse and compile a list of active review comments, grouping them by file path (`path`), comment ID (`id`), and line number (`line` or `original_line`).
* Completion Criterion: All active review comments and their metadata are loaded into context.

### 4. Evaluate Feedback & Confirm with User
* For each active review comment:
  * Read the target file path (`path`) and surrounding lines using `view_file` to build a complete view of the context.
  * Evaluate the co-worker's feedback and draft a proposed local code modification.
  * **Ask for Confirmation**: Stop and present the proposed fix to the user. Use the `ask_question` tool or an interactive prompt to let the user review and approve each fix.
* Completion Criterion: The user has reviewed and approved the planned fixes.

### 5. Apply Corrective Fixes Locally
* Modify the local files directly using `replace_file_content` or `multi_replace_file_content` according to the user-approved plans.
* Ensure that the modifications strictly follow the project's style guide and leave unrelated comments/logic completely untouched.
* Run any available local compilation, linting, or test commands to validate the changes.
* **Do NOT** run `git add`, `git commit`, or push changes. All modifications must remain unstaged for the user to review.
* Completion Criterion: Approved fixes are applied and verified in the local workspace.

### 6. Draft & Confirm Review Comment Replies
* For each successfully resolved comment:
  * Draft a professional and clear reply message for the reviewer (e.g., "Thanks for the feedback! I have applied the fix as suggested.").
  * Present the drafted replies to the user for confirmation.
  * Once the user approves the replies, post them directly to the PR comment thread on GitHub:
    ```bash
    gh api -X POST repos/{owner}/{repo}/pulls/comments/{comment_id}/replies -f body="Your approved reply"
    ```
* Completion Criterion: Replies to the resolved comments are approved and posted to GitHub.

### 7. Synthesize Resolution Report
* Present a structured markdown table summarizing the work completed:
  | File | Line | Co-worker Feedback | Resolution Action | Reply Posted | Status |
  | --- | --- | --- | --- | --- | --- |
  | `path/to/file` | `L12` | *Feedback text...* | *Description of fix* | *Reply text...* | **Resolved & Replied** |
* If a comment is skipped, outdated, or not applied, provide a clear, professional, and logical justification in the table.
* Prompt the user to review the unstaged changes and commit them when ready.
* Completion Criterion: A clear, detailed resolution report is printed.

## Reference

### Failure Modes and Safe Paths
* **API Limits / Private Repo**: If `gh api` fails due to permissions, prompt the user to re-authenticate with the appropriate scope: `gh auth refresh -s repo`.
* **Outdated Comments**: Comments on lines of code that no longer exist or have been heavily refactored should be marked as "Outdated" in the final report, with no changes applied or replies posted.
* **Conflicting Feedback**: If two reviewers have given conflicting feedback on the same lines, stop and ask the user to clarify which approach to follow before making edits.
