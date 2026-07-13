# Wadiolk - Personal Skills Developer Kit

Wadiolk is a zero-dependency CLI package built to bootstrap, validate, and manage custom skills for the Gemini Antigravity Agent. It is heavily inspired by the open-source mattpocock/skills workflow, adapted for structured local development and project distribution.

## Key Features

- **Zero-Dependency**: Written entirely in Node.js native APIs. Boots up in under 10ms.
- **Linter Validation**: Scans SKILL.md Frontmatter schemas to guarantee compatibility before loading.
- **Project Distribution**: Installs specific skill snapshots straight into a project's .gemini/skills/ folder for seamless Git collaboration.

## Directory Structure

```text
wadiolk/
├── CONTEXT.md           # Project rules (including the strict No-Emoji policy)
├── Makefile             # CLI shortcut command wrappers
├── package.json         # Package definitions and binary mapping
├── README.md            # Brief documentation
├── src/
│   └── cli.js           # Core zero-dependency CLI executable
└── skills/              # Your custom developer skills
    └── br-creator/      # Interactive Jira git branch manager (local only)
```

## Quick Start (Makefile)

Use the following Makefile commands within this repository to manage your skills:

### 1. Create a New Skill
```bash
make new name=my-skill
```
Generates a new skill folder with an interactive SKILL.md template.

### 2. Validate Frontmatter Schemas
```bash
make validate
```
Ensures all your local skills have valid YAML Frontmatter blocks (e.g., name and description).

### 3. Install Skill Snapshot to Current Project
```bash
make add name=my-skill
```
Copies the specified skill into your current working directory's .gemini/skills/ folder.

### 4. List Active Status
```bash
make list
```

## Cross-Project Distribution via npx / bunx

Once published to NPM or configured with local registry, you can execute these commands in any repository:

| Action | NPM command (npx) | Bun command (bunx) |
| :--- | :--- | :--- |
| List Skills | npx skills list | bunx skills list |
| Validate Format | npx skills validate | bunx skills validate |
| Add to Project | npx skills add <name> | bunx skills add <name> |
| Help Menu | npx skills help | bunx skills help |

*Note: If the package is not yet published or installed globally, you can fallback to using the remote GitHub resolver:*
* `npx github:kokp520/skills <command>`

---

## Available Skills

Here are the custom skills currently available in this developer kit:

- **[br-creator](./skills/br-creator/SKILL.md)**: Interactive Jira Git Branch Creator. Fetches a Jira ticket summary via `mcp-atlassian`, generates a semantic kebab-case branch name (max 4 words), prompts the user via an interactive `agy` UI modal, and safely prepares/creates the branch locally.
- **[pr-comment-resolver](./skills/pr-comment-resolver/SKILL.md)**: Automatically fetch PR review comments from co-workers, evaluate their feedback, and apply correct fixes to local files in the workspace.
- **[pr-critic](./skills/pr-critic/SKILL.md)**: Pull Request code critic and reviewer. Inspects GitHub PR diffs using the `gh` CLI, evaluates reasoning/feasibility, refines code locally through user feedback, and generates Conventional Commit messages.

---

## How to Install Skills (For Other Team Members)

If other team members or collaborators want to use these skills inside their project repositories, they can perform a Project-level installation.

This copies a static snapshot of the specified skill directly into the active project repository's `.gemini/skills/` folder, allowing it to be committed and shared with the team via Git.

In the root directory of the target project, run:
```bash
npx skills add <skill-name>
```

For example, to install the **br-creator** skill:
```bash
npx skills add br-creator
```

*Note: If the `skills` package is not yet published or installed globally on their system, team members can alternatively use the remote GitHub repository directly:*
```bash
npx github:kokp520/skills add br-creator
```
