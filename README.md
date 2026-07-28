# My Skills

It's inspired by Mattpocock skills workflow, if you have any suggestions, welcome to open a pull request.

## npx / bunx

| Action | NPM command (npx) | Bun command (bunx) |
| :--- | :--- | :--- |
| List Skills | npx skills list | bunx skills list |
| Validate Format | npx skills validate | bunx skills validate |
| Add to Project | npx skills@latest add kokp520/skills/<name> | bunx skills add <name> |
| Help Menu | npx skills help | bunx skills help |

*Note: If the package is not yet published or installed globally, you can fallback to using the remote GitHub resolver:*
* `npx github:kokp520/skills <command>`

---

## Install

```bash
npx skills@latest add kokp520/skills/<skill-name>
```

---

## Skills

- **[git-split-commit](./skills/git-split-commit/SKILL.md)**: Analyzes uncommitted git diffs, logically groups changed files, and interactively creates split commits using Conventional Commits.
- **[open-br](./skills/open-br/SKILL.md)**: Analyzes git differences against `master`/`main` to generate a short kebab-case branch name (max 4 words) and automatically checks out the new branch.
- **[open-pr](./skills/open-pr/SKILL.md)**: Assesses current branch state, drafts concise titles and PR descriptions, and creates a GitHub pull request.
- **[pr-comment-resolver](./skills/pr-comment-resolver/SKILL.md)**: Automatically fetches PR review comments from GitHub, evaluates feedback, interacts with the user to confirm fixes, applies modifications, and posts replies back to GitHub.
- **[pr-critic](./skills/pr-critic/SKILL.md)**: Inspects GitHub PR diffs using `gh` CLI, evaluates reasoning/correctness, refines local files through user feedback, and suggests Conventional Commit messages.
- **[production-UX-design](./skills/frontend/production-UX-design/SKILL.md)**: Reusable portal-style UX/interaction design logic (Vercel-Geist style) for landing, pricing, and large filterable catalog pages — all visuals decoupled into CSS variables so you can re-skin freely.
- **[skill-craftsman](./skills/skill-craftsman/SKILL.md)**: Reference manual, architectural guidelines, and reviewer tool for crafting, refining, and auditing high-quality AI agent skills based on process predictability.
