---
name: linebot-gas-architect
description: Comprehensive architecture guide, environment setup, debugging, and testing workflows for Google Apps Script (GAS) powered LINE Bots. Use when analyzing, writing, refactoring, or testing GAS-based LINE Bot code.
---

# LINE Bot on Google Apps Script (GAS) Architect

This skill governs how agents analyze, develop, refactor, and test LINE Bots hosted on Google Apps Script (GAS).

---

## 1. Core Architecture & Non-negotiable Guardrails

- **Mandatory Single Source of Truth**: Before executing any task, development, or deployment, ALWAYS read and strictly adhere to `CONTEXT.md` in the project root if present.
- **Webhook Deployment Rules**: When deploying updates via `@google/clasp`, ALWAYS check `CONTEXT.md` for the target Production Deployment ID. Use `npx @google/clasp deploy -i <deploymentId> --description "<desc>"` to update the existing deployment. NEVER create a new deployment ID without explicit user instruction.
- **Webhook Entry Point**: All incoming LINE Webhook events arrive at `doPost(e)`.
- **Event Parsing & Dispatch Loop**: Ingest `e.postData.contents`, parse JSON `events`, and iterate to dispatch handlers based on `event.type` (`message`, `follow`, `unfollow`, `postback`, `join`, `leave`).
- **HTTP Transport**: Enforce native `UrlFetchApp.fetch(url, options)`. Do NOT import or use browser/Node `fetch` or `axios`.
- **Secret & Config Isolation**: Access sensitive tokens (`CHANNEL_ACCESS_TOKEN`, `CHANNEL_SECRET`) exclusively via `PropertiesService.getScriptProperties()`. Never hardcode secrets in source code files.
- **Git Secret Prevention**: Ensure `.clasp.json` and local source files contain no plain-text access tokens or API keys before committing to version control.
- **Modular Architecture Breakdown**: Divide monolithic GAS scripts into dedicated, single-responsibility files (e.g., `main.js`, `lineApi.js`, `sheetService.js`, and domain-specific handlers like `orderHandler.js`, `memoHandler.js`, `listHandler.js`).
- **Flex Message Presentation**: Prefer sending structured, visual LINE Flex Messages over plain text for menus, help commands, and status dashboards.
- **TDD Workflow & Test Harness**: Always maintain a dedicated `testRunner.js` test file containing mock Webhook payloads (`mockWebhookEvent`) and assertions (`assert`) to run tests locally in GAS before deploying to production.
- **Robust API Response Logging**: Log explicit error responses and HTTP status codes for `UrlFetchApp.fetch` to ensure instant diagnosis when LINE Messaging API returns non-200 responses.
- **Generic Open-Source Compliance**: Ensure all skill references, templates, and code examples remain completely agnostic and free of user-specific identities or hardcoded values.

---

## 2. Progressive Disclosure & Context Pointers

To minimize **Context Load**, refer to sub-guides for operational setups:

- **Single Source of Truth**: Always read `CONTEXT.md` first for project-specific rules, file structures, and deployment IDs.
- **Environment & Deployment Tooling**: Read [reference/environment.md](reference/environment.md) for `@google/clasp` workflows, MCP tools, and webhook payload simulation templates.

---

## 3. Ordered Execution Workflow

Follow this sequence when developing or refactoring GAS LINE Bot code:

### Step 1: Read Project Context & Environment Audit
Read `CONTEXT.md` to confirm repo rules and inspect local workspace configuration for `@google/clasp` and `.clasp.json` to enable local synchronization.
- *Completion Criterion*: `CONTEXT.md` is read, `.clasp.json` is verified, and deployment rules are confirmed.

### Step 2: Codebase Legwork & Dispatch Architecture Setup
Dissect `doPost(e)` entry point, extract event payload parsing logic, and isolate event handlers into distinct modular functions.
- *Completion Criterion*: `doPost(e)` cleanly routes events to dedicated handler functions without monolithic block logic.

### Step 3: Webhook Simulation & Test Harness Verification
Construct or execute a local/GAS mock event harness (e.g., `node localTestRunner.js` or `testDoPostTextMessage()`) to test handlers under a controlled feedback loop.
- *Completion Criterion*: Mock event executes through `doPost(e)` and returns HTTP 200 / valid text log payload without uncaught exceptions.

### Step 4: Apply Mutations & Prune Legacy Sediment
Apply code modifications to GAS source files, ensure non-negotiable guardrails are respected, and prune unused legacy logic.
- *Completion Criterion*: Target changes are written, syntax is verified, and code adheres strictly to GAS-native API patterns (`UrlFetchApp`, `PropertiesService`).

### Step 5: Interactive Clasp Push & Deployment Confirmation
Local code modifications and Git commits DO NOT automatically update the remote Google Apps Script environment.
- **Explicit Confirmation Prompt**: Always ask the user before executing `clasp push` or `clasp deploy`.
- **Synchronization Flow**:
  1. Prompt the user for explicit confirmation: *"Would you like to sync (clasp push) these updated files to Google Apps Script now?"*
  2. If approved, execute `npx @google/clasp push`.
  3. Check `CONTEXT.md` for the Production Deployment ID. Ask the user: *"Would you like to update the existing production deployment (using -i <deploymentId>) so the Webhook URL remains unchanged?"*
  4. If approved, execute `npx @google/clasp deploy -i <deploymentId> --description "..."` instead of generating new deployment IDs.

