---
name: open-br
description: Read diff against master or main, then create and checkout a short branch name.
disable-model-invocation: true
---

# `open-br`

## Steps

1. **Analyze**. Check current git differences against `master` (or `main` if `master` is absent) to identify the core intent of the changes.
   - *Completion Criterion*: Core intent and affected file scopes are identified.

2. **Generate**. Produce a short, kebab-case branch name (maximum 4 words) capturing that intent.
   - *Completion Criterion*: A 4-word kebab-case branch name is synthesized.

3. **Branch**. Spawn and check out the new local branch using the generated name.
   - *Completion Criterion*: Workspace is successfully switched to the new branch.

