---
name: open-br
description: Read diff against master or main, then create and checkout a short branch name.
disable-model-invocation: true
---

# `open-br`

1.  **Analyze**. Check the current git differences against `master` (or `main` if `master` is absent) to identify the core intent of the changes.
2.  **Generate**. Produce a short, kebab-case branch name (maximum 4 words) capturing that intent.
3.  **Branch**. Execute `git checkout -b <branch-name>` and confirm the switch is successful.
