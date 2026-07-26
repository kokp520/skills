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
├── package.json         # Package definitions and binary mapping
├── README.md            # Brief documentation
├── src/
│   └── cli.js           # Core zero-dependency CLI executable
├── skills/              # Your custom developer skills
│   ├── frontend/             # Frontend / UX design skills
│   │   └── production-UX-design/ # Portal-style UX pattern kit (themeable)
│   ├── git-split-commit/     # Interactive conventional split commit generator
│   ├── open-br/              # Fast diff-based short git branch generator
│   ├── open-pr/              # GitHub pull request creator
│   ├── pr-comment-resolver/  # Automated PR review comment resolver & reply poster
│   ├── pr-critic/            # GitHub PR reviewer and critic via gh CLI
│   └── skill-craftsman/      # Reference & reviewer for auditing AI agent skills
```

## Cross-Project Distribution via npx / bunx

Once published to NPM or configured with local registry, you can execute these commands in any repository:

| Action | NPM command (npx) | Bun command (bunx) |
| :--- | :--- | :--- |
| List Skills | npx skills list | bunx skills list |
| Validate Format | npx skills validate | bunx skills validate |
| Add to Project | npx skills@latest add kokp520/skills/<name> | bunx skills add <name> |
| Help Menu | npx skills help | bunx skills help |

*Note: If the package is not yet published or installed globally, you can fallback to using the remote GitHub resolver:*
* `npx github:kokp520/skills <command>`

---

## Available Skills

Here are the custom skills currently available in this developer kit:

- **[git-split-commit](./skills/git-split-commit/SKILL.md)**: Analyzes uncommitted git diffs, logically groups changed files, and interactively creates split commits using Conventional Commits.
- **[open-br](./skills/open-br/SKILL.md)**: Analyzes git differences against `master`/`main` to generate a short kebab-case branch name (max 4 words) and automatically checks out the new branch.
- **[open-pr](./skills/open-pr/SKILL.md)**: Assesses current branch state, drafts concise titles and PR descriptions, and creates a GitHub pull request.
- **[pr-comment-resolver](./skills/pr-comment-resolver/SKILL.md)**: Automatically fetches PR review comments from GitHub, evaluates feedback, interacts with the user to confirm fixes, applies modifications, and posts replies back to GitHub.
- **[pr-critic](./skills/pr-critic/SKILL.md)**: Inspects GitHub PR diffs using `gh` CLI, evaluates reasoning/correctness, refines local files through user feedback, and suggests Conventional Commit messages.
- **[production-UX-design](./skills/frontend/production-UX-design/SKILL.md)**: Reusable portal-style UX/interaction design logic (Vercel-Geist style) for landing, pricing, and large filterable catalog pages — all visuals decoupled into CSS variables so you can re-skin freely.
- **[skill-craftsman](./skills/skill-craftsman/SKILL.md)**: Reference manual, architectural guidelines, and reviewer tool for crafting, refining, and auditing high-quality AI agent skills based on process predictability.

---

## How to Install Skills (For Other Team Members)

If other team members or collaborators want to use these skills inside their project repositories, they can perform a Project-level installation.

This copies a static snapshot of the specified skill directly into the active project repository's `.gemini/skills/` folder, allowing it to be committed and shared with the team via Git.

In the root directory of the target project, run:
```bash
npx skills@latest add kokp520/skills/<skill-name>
```

For example, to install the **br-creator** skill:
```bash
npx skills@latest add kokp520/skills/br-creator
```
