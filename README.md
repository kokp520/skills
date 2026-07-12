# 🪄 Wadiolk - Personal Skills Developer Kit

> **Wadiolk** is a custom skills developer and manager package built for the **Gemini Antigravity Agent**. With this tool, you can easily bootstrap, develop, symlink, and manage your custom Agent skills from scratch.
> 
> The architecture of this project is highly inspired by the popular open-source AI agent skill catalog [mattpocock/skills](https://github.com/mattpocock/skills). Beyond standard symlinking for local development, we've implemented project-level snapshot installation (`add` command) and static Frontmatter schema validation (`validate` command).

---

## 🚀 Key Features

* ⚡ **Ultra-Fast & Zero Dependencies**: Written 100% in Node.js native APIs, booting up in less than `10ms`. Fully supports instant executions via `bunx` and `npx`.
* 🛠 **Makefile Simplicity**: Wraps common development lifecycle commands into simple shortcuts.
* 🔗 **Smart Symlinking**: Effortlessly links all local skills to `~/.agent/skills` and `~/.gemini/skills`. Modifications in this repo apply to your Agent **instantly** without redeployment!
* 🔍 **Frontmatter Linter (Validation)**: Automatically scans your custom `SKILL.md` files to ensure mandatory fields like `name` are configured properly before loading.
* 📦 **Project-Level Snapshots (Add)**: Match the `skills add` mechanism to replicate a specific skill from your library directly into your project's local `.gemini/skills/` folder, allowing seamless commits into the project's Git repository.
* 🎨 **Elegant CLI Output**: Styled with precise ANSI colors and status indicators to offer a premium, modern developer experience.

---

## 📂 Project Structure

```text
wadiolk/
├── Makefile             # Development shortcuts (make new, make link, etc.)
├── package.json         # Package configuration and CLI bin mapping
├── README.md            # Comprehensive documentation
├── src/
│   └── cli.js           # Core zero-dependency ES Module CLI logic
└── skills/              # Directory for all your custom skills
    └── ...
```

---

## 🛠 Local Development Workflow (Makefile)

When developing skills inside this repository, using the `Makefile` is the most straightforward and intuitive way:

### 1. Bootstrap a New Skill
```bash
make new name=my-awesome-skill
```
> [!NOTE]
> This automatically generates a boilerplate directory structure containing a pre-formatted `SKILL.md` schema, a `scripts/` directory, and a `resources/` directory.

### 2. Edit Your Skill Logic
Open `skills/my-awesome-skill/SKILL.md` with your preferred editor and define when the skill should be triggered, what objective it has, and step-by-step operating guidelines.

### 3. Validate Formatting (Linter)
```bash
make validate
```
> [!IMPORTANT]
> Coding Agents rely strictly on the metadata declared inside the Frontmatter (top section enclosed by `---`). Run this command to lint your markdown files against standard guidelines!

### 4. Link to the Agent System (Local Development)
```bash
make link
```
> [!TIP]
> This command symlinks your skills to active system directories. 
> **Benefit**: Modifications to `SKILL.md` are **instantly synced** to the Agent, meaning zero downtime or manual redeploys.

### 5. Install Skill as a Project Snapshot (Project Distribution)
```bash
make add name=my-awesome-skill
```
> [!NOTE]
> This copies a static snapshot of the skill into the current project's `.gemini/skills/` folder. This is ideal when you want to commit your skill to a specific repository's codebase for team use.

### 6. Inspect Active Status
```bash
make list
```

### 7. Tear Down Symlinks
```bash
make unlink
```

---

## 📦 Distribution via npx / bunx

Once you push this repo to your GitHub (e.g., `github:username/wadiolk`) or publish it to a private registry, you can call these management commands directly from **any folder** without cloning the repo:

| Action | NPM command (`npx`) | Bun command (`bunx`) |
| :--- | :--- | :--- |
| **List Installed Skills** | `npx github:username/wadiolk list` | `bunx github:username/wadiolk list` |
| **Symlink to System** | `npx github:username/wadiolk link` | `bunx github:username/wadiolk link` |
| **Unlink from System** | `npx github:username/wadiolk unlink` | `bunx github:username/wadiolk unlink` |
| **Run Linter Checks** | `npx github:username/wadiolk validate` | `bunx github:username/wadiolk validate` |
| **Clone Skill into Project** | `npx github:username/wadiolk add <name>` | `bunx github:username/wadiolk add <name>` |
| **Show Helper Menu** | `npx github:username/wadiolk help` | `bunx github:username/wadiolk help` |

> [!WARNING]
> Remember to replace `username/wadiolk` with your actual GitHub username and repository name.

---

## 📑 Gold Standards for SKILL.md

A clean, reliable skill markdown file should align with these guidelines:
1. **Frontmatter**: Must define `name` and `description` in YAML format at the very top of the file (otherwise, Agents cannot parse it).
2. **When to use**: Define explicit scenarios so that the Agent knows exactly when to summon this skill.
3. **Step-by-Step Instructions**: Supply clear, declarative imperative instructions.
4. **Markdown Alerts**: Employ strategic GitHub alerts like `> [!IMPORTANT]` to emphasize core invariants.

---

Happy hacking! Feel free to ask if you have any questions or ideas.✨
