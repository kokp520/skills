---
name: edd-skill-creator
description: Create, audit, and refine AI agent skills using Evaluation-Driven Development (EDD) to enforce process predictability.
disable-model-invocation: true
---

# EDD Skill Creator

Use this skill when authoring, auditing, or refining AI agent skills using **Evaluation-Driven Development (EDD)**. EDD enforces **process predictability** by ensuring skills are benchmarked and validated against explicit evaluation cases before instructions are finalized.

---

## Trigger Branches

- **New Skill Creation**: Instantiate a new skill from scratch using EDD workflow.
- **Skill Optimization**: Audit, prune, and benchmark an existing skill (`SKILL.md`) against evaluation scenarios.
- **Eval Suite Synthesis**: Generate or refine test assertions under `<target-skill>/evals/`.

---

## Behavioral Contract: Evaluation-First Loop

In EDD, **evaluations precede implementation**. Before authoring or updating rules in `SKILL.md`, you **MUST** establish measurable assertions and evaluation cases.

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

## High-Signal / Zero-Noise Output Contract

Output **ONLY** actionable execution summaries and structured diffs. Eliminate preambles, greetings, and conversational chatter.
- **If Skill / Eval Suite is already optimal**: Output `Clean. No action needed.`
- **Action Completed**: Output concise summary of mutations applied and test evaluation status.

---

## Ordered Execution Workflow

### Step 1: Ingest & Define Eval Cases (`evals/`)
Ingest target skill requirements and synthesize test scenarios under the target skill's `evals/` directory (e.g., `evals/eval_cases.json` or `evals/test_scenarios.md`).
Each eval case MUST isolate:
- **Trigger Branch / Input Payload**: The exact prompt, command, or context payload provided.
- **Expected Outcome / Assertions**: Explicit observable state, tool call sequence, or output structure required.
- **Edge Cases**: Malformed inputs, boundary constraints, or failure modes.

- *Completion Criterion*: At least 3 distinct evaluation scenarios (including 1 edge case) are written to `<skill-name>/evals/`.

### Step 2: Run Baseline Assessment
Execute or simulate the workflow *without* the new skill rules (or using the active version) to establish an initial benchmark.
- Do thorough **legwork** to isolate gaps, hallucination risks, or default failure modes.
- Document baseline weaknesses as targeted behaviors to eliminate.

- *Completion Criterion*: Baseline performance and failure modes are explicitly logged.

### Step 3: Synthesize or Refine `SKILL.md`
Synthesize or update skill guidelines applying **Matt Pocock Lexicon** and **Skill Craftsman** principles:
- **Leading Words**: Recruit pretrained model priors using strong domain terms (*legwork*, *tight loop*, *non-negotiable guardrail*, *behavioral contract*).
- **Progressive Disclosure**: Minimize **Context Load** by placing deep references behind **Context Pointers** (`references/` or `GLOSSARY.md`).
- **Checkable Completion Criteria**: Ensure every step terminates on an unambiguous, observable boundary condition.
- **Positive Guidance**: Direct agent behavior through positive assertions; prune **Negation** and prohibitions.
- **Pruning**: Eliminate **No-ops**, **Sediment**, **Duplication**, **Sprawl**, and **Output Noise**.

- *Completion Criterion*: `SKILL.md` is updated with targeted instructions explicitly addressing baseline failure modes.

### Step 4: Audit Verification & Run Evaluation
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

## Non-negotiable Guardrails

> [!TIP]
> **Co-location of Evals**: Always store evaluation files within the target skill directory (e.g., `<skill-name>/evals/`) to maintain single-source portability.

> [!IMPORTANT]
> **Evaluation-First Enforcement**: Always establish evaluation cases before authoring complex skill rules to prevent **Premature Completion**.


