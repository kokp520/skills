---
name: edd-skill-creator
description: Create and refine AI agent skills using Evaluation-Driven Development (EDD).
disable-model-invocation: true
---

# EDD Skill Creator

Use this skill when you want to build or refine AI agent skills using **Evaluation-Driven Development (EDD)**. EDD enforces process predictability by ensuring skills are scientifically designed, benchmarked, and validated against explicit evaluation cases before instructions are finalized.

---

## Behavioral Contract: Evaluation-First Development Loop

In EDD, **evaluations precede implementation**. Before authoring rules or instructions in `SKILL.md`, you MUST first establish measurable assertions and evaluation cases.

```
+-------------------+      +-------------------+      +-------------------+
| 1. Define Evals   | ---> | 2. Run Baseline   | ---> | 3. Draft Skill    |
| (Input/Expected)  |      | (Measure initial) |      | (SKILL.md rules)  |
+-------------------+      +-------------------+      +-------------------+
                                                                |
+-------------------+      +-------------------+                |
| 5. Refactor Skill | <--- | 4. Run Evaluation | <----------------+
| (Iterate on fail) |      | (Check Pass/Fail) |
+-------------------+      +-------------------+
```

---

## Ordered Execution Workflow

### Step 1: Define Eval Cases (`evals/`)
Ingest target skill requirements and synthesize test scenarios under the target skill's `evals/` directory (e.g., `evals/eval_cases.json` or `evals/test_scenarios.md`).
Each eval case MUST isolate:
- **Input / Trigger Branch**: The exact prompt, command, or context payload provided.
- **Expected Outcome / Assertions**: Explicit observable state, tool call sequence, or output structure required.
- **Edge Cases**: Malformed inputs, boundary constraints, or potential failure modes.

- *Completion Criterion*: At least 3 distinct evaluation scenarios (including 1 edge case) are written in the `<skill-name>/evals/` directory.

### Step 2: Run Baseline Assessment
Execute or simulate the workflow *without* the new skill rules (or using the current version) to establish an initial benchmark.
- Isolate gaps, hallucination risks, or default failure modes.
- Document baseline weaknesses as targeted behaviors to eliminate.

- *Completion Criterion*: Baseline performance and failure modes are explicitly logged.

### Step 3: Write or Refine `SKILL.md`
Synthesize or update skill guidelines following high-quality skill principles:
- **Leading Words**: Recruit pretrained model priors using strong domain vocabulary (*legwork*, *tight loop*, *non-negotiable guardrail*).
- **Progressive Disclosure**: Minimize **Context Load** by placing deep references or heavy documentation behind **Context Pointers** (`references/`).
- **Checkable Completion Criteria**: Ensure every step terminates on an unambiguous, observable boundary condition.
- **Positive Guidance**: Direct agent behavior through positive assertions; prune **Negation** and prohibitions.
- **Pruning**: Eliminate **No-ops**, **Sediment**, **Duplication**, and unnecessary **Sprawl**.

- *Completion Criterion*: `SKILL.md` is updated with targeted instructions explicitly addressing baseline failure modes.

### Step 4: Run Evaluation & Audit Verification
Execute evaluation cases with the updated skill active.
- Inspect tool invocations, behavioral adherence, and structural compliance against assertions.

- *Completion Criterion*: All evaluation cases pass or demonstrate verified, measurable improvement against the baseline.

### Step 5: Refactor & Prune
If an evaluation case fails:
- Avoid adding redundant instructions (**Sediment** / **Sprawl**).
- Refactor existing rules, replace generic verbs with stronger **Leading Words**, or sharpen **Completion Criteria**.
- Re-run Step 4 until the evaluation suite passes consistently.

- *Completion Criterion*: The updated skill passes all eval cases cleanly without instruction bloat or redundant rules.

---

## Non-negotiable Guardrails & Best Practices

> [!TIP]
> **Co-location of Evals**: Always store evaluation files within the skill directory (e.g., `<skill-name>/evals/`) to maintain single-source portability.

> [!NOTE]
> **Evaluation-First Enforcement**: Always prompt or guide the user to establish evaluation cases before writing complex skill rules. Establishing evals first drastically minimizes prompt friction and **Premature Completion**.

