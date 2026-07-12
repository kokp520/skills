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

Once published or pushed to GitHub, you can execute these commands in any repository:

| Action | NPM command (npx) | Bun command (bunx) |
| :--- | :--- | :--- |
| List Skills | npx github:kokp520/skills list | bunx github:kokp520/skills list |
| Validate Format | npx github:kokp520/skills validate | bunx github:kokp520/skills validate |
| Add to Project | npx github:kokp520/skills add <name> | bunx github:kokp520/skills add <name> |
| Help Menu | npx github:kokp520/skills help | bunx github:kokp520/skills help |

---

## How to Install the "br-creator" Skill (For Other Team Members)

If other team members or collaborators want to install and use the `br-creator` (Jira Branch Manager) skill inside the project repository, they can perform a Project-level installation.

This copies a static snapshot of the `br-creator` skill directly into the active project repository, allowing it to be committed and shared with the team in Git.

In the root directory of the target project, they should run:
```bash
npx github:kokp520/skills add br-creator
```
*Note: Thanks to our built-in remote resolver, if "br-creator" is not found on their local machine, our CLI automatically downlinks the latest version from your GitHub repository (kokp520/skills) and copies it to `.gemini/skills/br-creator`. Once copied, commit the newly added files to the project repository's Git.*

They can also explicitly download a skill from any other public GitHub repository by using:
```bash
npx github:kokp520/skills add github-username/repo-name/skills/skill-name
```
