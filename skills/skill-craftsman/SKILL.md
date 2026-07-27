---
name: skill-craftsman
description: Reference and reviewer for crafting, refining, and auditing high-quality AI agent skills. Integrates Matt Pocock's skill design principles, leading words, anti-pattern diagnostics, and precise domain vocabulary.
---

# Skill Craftsman (Great Skill Guidelines & Reviewer)

This skill provides the architectural principles, precise vocabulary, and auditing workflow for designing, writing, and reviewing AI agent skills. 

The root virtue of a skill is **process predictability** — wrangling determinism out of a stochastic system by enforcing a consistent behavioral contract, robust completion criteria, and precise domain language.

---

## Trigger Conditions
* When asked to "create a new skill", "write a skill", "review a skill", "audit a skill", or "refine skill language".
* When reviewing existing `.md` files in `~/.agent/skills/` or `~/.gemini/skills/`.

---

## Lexicon & Leading Words (Context Pointer)

When authoring or refining skills, you **MUST** eliminate ambiguous prose and adopt the precise domain concepts, verbs, and anti-pattern definitions defined in the glossary.

**[View the Comprehensive Skill Lexicon](GLOSSARY.md)**

Always refer to `GLOSSARY.md` for the exact definitions of terms like *Behavioral Contract*, *Context Load*, *Legwork*, *Premature Completion*, and *Router Skill*.

## Core Design Mechanics

### 1. Invocation Mechanics & Trade-offs
- **Model-Invoked Skill**: Omit `disable-model-invocation`. Front-load description with distinct **Trigger Branches**. Incurs **Context Load** every turn.
- **User-Invoked Skill**: Set `disable-model-invocation: true`. Strips description from agent index. Pays **Zero Context Load**, but incurs **Cognitive Load** on the user.
- **Router Skill**: A single user-invoked skill that routes to other user-invoked skills when cognitive load gets too high.

### 2. Information Hierarchy & Progressive Disclosure
1. **In-skill Steps**: Ordered execution sequence in `SKILL.md`. Each step MUST terminate on a checkable **Completion Criterion**.
2. **In-skill Reference**: Rules and definitions listed under clear, co-located headings.
3. **External Reference**: Pushed behind a **Context Pointer** (e.g., `references/` or `GLOSSARY.md`) to keep `SKILL.md` lean.

### 3. Leading Words (Token Compression)
Anchor complex behavior using pretrained conceptual shortcuts (e.g., *tight*, *red*, *legwork*). A single strong **leading word** can collapse multi-sentence instructions into a single high-signal token.

---

## Anti-Pattern Diagnostics (Failure Modes)

When auditing skills, actively identify and eliminate failure modes such as **Premature Completion**, **Duplication**, **Sediment**, **Sprawl**, **No-ops**, and **Negation**. 

*(See `GLOSSARY.md` for exact definitions and remedies for each anti-pattern.)*

---

## Skill Audit Workflow

When auditing or refining a skill:

1. **Ingest & Dissect**: Read the target skill using `view_file`.
2. **Diagnose Failure Modes**: Check for Sediment, Sprawl, No-ops, and Negation.
3. **Refine Lexicon**: Replace generic terms with **Matt Pocock Lexicon** and **Leading Words**.
4. **Enforce Hierarchy**: Ensure every step ends with an explicit **Completion Criterion**.
5. **Synthesize Changes**: Apply edits via `replace_file_content` and report structural improvements.

---

## Validation Checklist
- [ ] Frontmatter explicitly tuned for Context vs. Cognitive load?
- [ ] Every step terminates on a checkable **Completion Criterion**?
- [ ] Free of Sediment, Sprawl, No-ops, and Negation?
- [ ] Replaced generic verbs with precise domain terms?
