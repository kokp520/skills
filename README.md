# Wadiolk - Personal Skills Developer Kit

Wadiolk is a zero-dependency CLI package built to bootstrap, validate, and manage custom skills for the Gemini Antigravity Agent. It is heavily inspired by the open-source mattpocock/skills workflow, adapted for structured local development and project distribution.

## Key Features

- **Zero-Dependency**: Written entirely in Node.js native APIs. Boots up in under 10ms.
- **Smart Symlinking**: Links local skills to ~/.agent/skills and ~/.gemini/skills instantly.
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

### 3. Symlink to Agent System
```bash
make link
```
Symlinks all local skills to active Agent system paths. Changes made here apply instantly to the Agent.

### 4. Remove Symlinks
```bash
make unlink
```
Safely untethers your local skills from the Agent system.

### 5. Install Skill Snapshot to Current Project
```bash
make add name=my-skill
```
Copies the specified skill into your current working directory's .gemini/skills/ folder.

### 6. List Active Status
```bash
make list
```

## Cross-Project Distribution via npx / bunx

Once published or pushed to GitHub, you can execute these commands in any repository:

| Action | NPM command (npx) | Bun command (bunx) |
| :--- | :--- | :--- |
| List Skills | npx github:username/wadiolk list | bunx github:username/wadiolk list |
| Link to System | npx github:username/wadiolk link | bunx github:username/wadiolk link |
| Unlink Symlinks | npx github:username/wadiolk unlink | bunx github:username/wadiolk unlink |
| Validate Format | npx github:username/wadiolk validate | bunx github:username/wadiolk validate |
| Add to Project | npx github:username/wadiolk add <name> | bunx github:username/wadiolk add <name> |
| Help Menu | npx github:username/wadiolk help | bunx github:username/wadiolk help |

Replace `username/wadiolk` with your actual GitHub username and repository name.
