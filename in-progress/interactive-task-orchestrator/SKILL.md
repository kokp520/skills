---
name: interactive-task-orchestrator
description: Interactive task planning and execution with step-by-step grilling, guardrails, human-in-the-loop review, and verification gates.
---

# Interactive Task Orchestrator Protocol

Use this skill when the user wants to execute a multi-step task with interactive confirmations, strict guardrails, and explicit verification.

## Phase 1: Interactive Task Definition (Grill & Plan)
Iteratively interview the user to construct the task specification using the 3 core criteria:

1. **Step Breakdown & HITL Assignment**:
   - Split task into clear sequential steps.
   - For each step, mark whether Human-in-the-Loop (HITL) manual confirmation is required.
   - Classify task type (e.g., Refactoring, Feature Development, Bug Fix, Documentation).

2. **Guardrails Configuration**:
   - Define file path boundaries (allowed vs restricted directories/files).
   - Define negative constraints (e.g., "Do not delete tests", "Do not modify public API signatures").
   - Set execution permission limits for shell commands.

3. **Definition of Done (DoD) & Verification**:
   - Define mandatory verification commands for each step (e.g., `go test ./...`, `npm run lint`).
   - Define exact expected output criteria (e.g., exit code 0, 100% coverage).

Save the approved plan to `.gemini/tasks/<task-id>.md`.

---

## Phase 2: Controlled Execution Loop

For each step defined in `.gemini/tasks/<task-id>.md`:

1. **Pre-Step Check**:
   - Check if step requires HITL confirmation. If yes, prompt user via interactive modal (`ask_question`) or direct text.
   - Display active Guardrails for this step.

2. **Step Execution**:
   - Execute actions while strictly obeying configured Guardrails.
   - If a Guardrail is about to be violated, trigger a Hard Stop and alert the user immediately.

3. **Implementation Summary & User Confirmation (Mandatory)**:
   - **MUST list all implemented changes, file edits, and generated artifacts in detail.**
   - Request explicit user confirmation on the implementation summary before proceeding to verification or marking complete.

4. **Verification Gate**:
   - Run defined verification commands.
   - If verification passes: Mark step as complete in `.gemini/tasks/<task-id>.md` and proceed.
   - If verification fails: Present failure logs and options (A: Retry fix, B: Adjust DoD, C: Manual intervention).
