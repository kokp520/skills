# Comprehensive Skill Lexicon & Leading Words

When authoring or refining skills, eliminate ambiguous prose and adopt these **categorized leading words & domain concepts**.

## 1. Strategic Domain Concepts & Mental Models
| Generic / Vague Term | Matt Pocock Lexicon | Definition & Intended Function |
| :--- | :--- | :--- |
| *System prompt / Instructions* | **Behavioral Contract** | An explicit specification binding the agent's execution model and process. |
| *Randomness / Hallucination* | **Stochastic System** | The underlying non-deterministic engine that the skill aims to constrain. |
| *Same output every time* | **Process Predictability** | Guaranteeing identical *workflows and guardrails* across runs rather than static text. |
| *Prompt bloat / Token usage* | **Context Load** | The token load placed on the active context window per turn. |
| *User memory index* | **Cognitive Load** | The mental index the user must maintain to manually invoke skills. |
| *Step ordering* | **Information Hierarchy** | Ranking guidance by immediacy: In-skill Step ➔ In-skill Reference ➔ External Reference. |
| *Link to separate file* | **Context Pointer** | An explicit path directing the agent to load deep reference on demand (**Progressive Disclosure**). |
| *Grouping related content* | **Co-location** | Keeping a concept's definition, rules, and caveats under one heading rather than scattered. |
| *Skill division level* | **Granularity** | How finely you divide skills. Every division spends either Context Load or Cognitive Load. |
| *Splitting by triggers* | **Cut by Invocation** | Splitting off a model-invoked skill when you have a distinct leading word worth paying Context Load for. |
| *Splitting step sequences* | **Cut by Sequence** | Splitting a run of steps when the steps still ahead tempt the agent to rush (**Premature Completion**). |
| *Future steps* | **Post-completion Steps** | The steps still ahead in a sequence that might distract the agent. |
| *Single source of truth* | **Single Source of Truth (SSOT)** | One authoritative location for any rule; prevents duplication. |
| *Dispatched skill* | **Router Skill** | A meta-skill that dispatches requests to sub-skills to minimize cognitive & context load. |
| *Trigger condition* | **Trigger Branches** | Distinct operational paths that trigger skill execution. |

## 2. Execution & Execution Control Verbs
| Generic Action | Precise Imperative Verb | Contextual Usage |
| :--- | :--- | :--- |
| *Read/Parse input* | **Ingest / Dissect** | `Ingest user input and dissect the payload into structured metadata.` |
| *Create/Generate* | **Synthesize / Spawn / Instantiate** | `Synthesize a concise 4-word kebab-case slug and spawn the local branch.` |
| *Update code/branch* | **Synchronize Base / Rebase** | `Synchronize base branch with remote tracking before applying mutations.` |
| *Check/Verify* | **Audit / Validate / Inspect** | `Audit target codebase for missing unit test coverage.` |
| *Clean up text/code* | **Prune / Collapse / Distill** | `Prune redundant instructions and collapse synonymous triggers into one branch.` |
| *Change files* | **Apply Mutations** | `Do thorough legwork before applying mutations to source files.` |
| *Extract essential info* | **Extract / Isolate** | `Isolate core business logic from framework boilerplates.` |

## 3. States, Gates & Observable Conditions
| State / Concept | Precise Leading Word | Operational Meaning |
| :--- | :--- | :--- |
| *Step finish check* | **Completion Criterion** | A checkable, unambiguous boundary condition determining when a phase is complete. |
| *Failing test gate* | **Red Loop** | A binary observable state where a test fails specifically on the targeted bug. |
| *Fast & deterministic loop* | **Tight Loop** | Execution cycle optimized for minimal overhead, fast feedback, and high determinism. |
| *Deep research/investigation* | **Legwork** | Exhaustive search, reading, and analysis performed *before* changing code. |
| *First working prototype* | **Tracer Bullet** | An end-to-end thin slice implementation validating architecture early. |
| *Unknown environment/code* | **Fog of War** | High-uncertainty codebase state requiring discovery and mapping before action. |
| *Hard constraint/limit* | **Non-negotiable Guardrail** | An absolute boundary condition that the agent must never cross under any circumstance. |

## 4. Failure Modes & Anti-Patterns
| Failure Manifestation | Anti-Pattern Lexicon | Diagnostic & Remedy |
| :--- | :--- | :--- |
| *AI stopping early* | **Premature Completion** | Agent halts before satisfying acceptance criteria. *Fix: Exhaustive completion criteria.* |
| *Repeated instructions* | **Duplication** | Stating same rule in multiple places. *Fix: Single source of truth.* |
| *Stale legacy rules* | **Sediment** | Layers of dead instructions accumulated over time. *Fix: Aggressive pruning.* |
| *Bloated skill file* | **Sprawl** | Skill file too long. *Fix: Progressive disclosure via context pointers.* |
| *Useless default rule* | **No-op** | Instruction model follows anyway. *Fix: Delete or replace with stronger leading word.* |
| *Telling AI what NOT to do* | **Negation** | Steering by prohibition. *Fix: Frame positively (tell what TO do).* |
