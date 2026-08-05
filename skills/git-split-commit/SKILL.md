---
name: git-split-commit
description: 'Use when the user asks to split changes, create multiple commits, or mentions "/git-split-commit". Analyzes diff to group files logically and interactively commits them using Conventional Commits.'
license: MIT
---

## Steps

1. **Analyze changes**: Run `git status --porcelain` and `git diff` (include `--staged` if files are staged).
   - _Completion criterion_: Every modified, added, or deleted file is accounted for.

2. **Formulate plan**: Group the files into logical features, fixes, or refactors. Group by **file-level** only.
   - _Completion criterion_: A commit plan is ready, detailing the Conventional Commit message (`<type>[optional scope]: <description>`) and the specific files for each commit.

3. **Confirm plan**: Present the plan using a markdown list and wait for user approval.
   - _Completion criterion_: The user explicitly approves the plan.

4. **Execute commits**: Iterate through the approved plan. For each commit, stage its files (`git add <file>`) and commit (`git commit -m "<message>"`).
   - _Completion criterion_: All planned commits are executed and reported to the user.

## Reference

**File-level grouping**: Place entire files into a single commit. Avoid patch-level splits within the same file.

**Conventional Commits**: Use `feat:`, `fix:`, `refactor:`, `style:`, `docs:`, `chore:`.

**Language**: Respond in English.

**Example Confirmation**:
```markdown
I have analyzed the changes and suggest splitting them into the following commits:

1. **feat: add user login API**
   - `src/api/login.go`
   - `src/models/user.go`
2. **fix: correct typo in database config**
   - `config/db.yaml`

Do you approve this plan?
```

## Output format

```
Done.

<- commits>
```
