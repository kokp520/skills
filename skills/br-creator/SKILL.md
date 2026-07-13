---
name: br-creator
description: Interactive Jira Git Branch Creator. Fetch a Jira ticket summary via mcp-atlassian, generate a kebab-case branch name (max 4 words), prompt the user with an interactive agy UI modal, checkout and pull master, and create the new branch locally.
disable-model-invocation: true
---

# Interactive Jira Git Branch Creator

This interactive skill automates the creation of git branches aligned with Jira ticket summaries. It pulls context from Jira, generates a semantic kebab-case branch name, prompts the user via an interactive modal, and safely prepares/creates the branch locally.

## 🎯 Trigger Conditions (When to use)
* When the user mentions `/branch` or `/br` followed by a Jira ticket ID (e.g., `/branch APP-12345`).
* When the user asks to "create a git branch from a Jira ticket" or "checkout a branch for ticket APP-XXXXXX".

## 🛠️ Step-by-Step Interactive Workflow

### 1. Extract and Validate Ticket ID
- Parse the input for a Jira ticket pattern (typically `[A-Z]+-[0-9]+` such as `APP-12345`).
- If no ticket ID is provided, respond politely: `"What is the Jira Ticket ID (e.g., APP-12345) for the branch you would like to create?"` and wait for user input.

### 2. Fetch Jira Issue Details (MCP Tool)
- Run the `mcp_mcp-atlassian_jira_get_issue` tool (or `jira_get_issue` tool on `mcp-atlassian` server):
  - **ServerName**: `mcp-atlassian`
  - **ToolName**: `jira_get_issue`
  - **Arguments**:
    ```json
    {
      "issueIdOrKey": "APP-12345"
    }
    ```

### 3. Generate Semantic Branch Description (`ticket-desc`)
Extract `fields.summary` (the Jira Title) from the response. Translate it to English (if in Chinese or other languages) and synthesize it into a clean, semantic `ticket-desc` adhering to these rules:
1. **Length Limit**: Strictly a maximum of **4 words** (connected by hyphens).
2. **Character Set**: Lowercase alphanumeric characters (`a-z`, `0-9`) and hyphens (`-`) only. Remove all punctuation, brackets, parentheses, spaces, or special characters.
3. **Format**: Strictly `kebab-case` (all lowercase, words joined by single hyphens).
4. **Examples**:
   - `"Fix API login session timeout issue"` ➡️ `fix-login-timeout`
   - `"實作 17LIVE 聊天室送禮特效優化"` ➡️ `gift-effect-optimize`
   - `"User avatar upload error on iOS app"` ➡️ `ios-avatar-upload-error`
   - `"Refactor"` ➡️ `refactor-code`

### 4. Assemble the Branch Name
Construct the draft branch name using the pattern: `{TICKET-ID}-{ticket-desc}`
- *Example*: `APP-12345-fix-login-timeout`
- Ensure the Ticket ID prefix remains capitalized (e.g., `APP-12345`).

### 5. Interactive UI Confirmation (Crucial for agy)
Before running any shell commands, you **MUST** present an interactive modal dialog to the user utilizing the `ask_question` tool. This is optimized for the `agy` runtime.
- **Tool**: `ask_question`
- **Arguments**:
  - `question`: `"I have generated the git branch name \"{Branch-Name}\" from Jira. Does this look good to you?"`
  - `options`:
    1. `"(Recommended) Yes, use the generated branch name: {Branch-Name}"`
    2. `"No, I want to type a custom branch name"`
- **Processing the user's action**:
  - If the user selects **Option 1**: Use the generated `{Branch-Name}` as the final branch name.
  - If the user selects **Option 2** (or utilizes the write-in text box): Grab the custom string written by the user and use it as the final branch name.

### 6. Git Branch Preparation
Once the final branch name is confirmed, execute the following commands in sequence on the user's system:
1. **Check and Pull Latest Master/Main**:
   Determine whether the repository's default branch is `master` or `main` (usually `master`). Pull latest code to ensure branch divergence is clean:
   ```bash
   git checkout master   # (or main)
   git pull
   ```
2. **Create and Switch to the New Branch Locally**:
   ```bash
   git checkout -b <final-branch-name>
   ```

## 🔍 Validation Checklist (Self-Correction)
- [ ] Did I run `jira_get_issue` via the `mcp-atlassian` server?
- [ ] Is the generated `ticket-desc` translated into English, kebab-case, and strictly **under 4 words**?
- [ ] Did I use the `ask_question` tool to pop up an interactive UI modal?
- [ ] Did I verify and pull the base branch (`master` or `main`) before spawning the new branch locally?

