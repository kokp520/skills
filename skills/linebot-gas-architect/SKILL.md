---
name: linebot-gas-architect
description: Comprehensive architecture guide, environment setup, debugging, and testing workflows for Google Apps Script (GAS) powered LINE Bots. Use when analyzing, writing, refactoring, or testing GAS-based LINE Bot code.
---

# LINE Bot on Google Apps Script (GAS) Architect

This skill governs how agents analyze, develop, refactor, and test LINE Bots hosted on Google Apps Script (GAS).

---

## 1. Core Architecture & Non-negotiable Guardrails

- **Webhook Entry Point**: All incoming LINE Webhook events arrive at `doPost(e)`.
- **Event Parsing & Dispatch Loop**: Ingest `e.postData.contents`, parse JSON `events`, and iterate to dispatch handlers based on `event.type` (`message`, `follow`, `unfollow`, `postback`, `join`, `leave`).
- **HTTP Transport**: Enforce native `UrlFetchApp.fetch(url, options)`. Do NOT import or use browser/Node `fetch` or `axios`.
- **Secret & Config Isolation**: Access sensitive tokens (`CHANNEL_ACCESS_TOKEN`, `CHANNEL_SECRET`) exclusively via `PropertiesService.getScriptProperties()`. Never hardcode secrets.
- **State & Caching Layer**: Utilize `CacheService.getScriptCache()` for ephemeral session state (up to 6 hours) and `PropertiesService` or external storage (Google Sheets/Firestore) for persistent records.

---

## 2. Progressive Disclosure & Context Pointers

To minimize **Context Load**, refer to sub-guides for operational setups:

- **Environment & Deployment Tooling**: Read [reference/environment.md](reference/environment.md) for `@google/clasp` workflows, MCP tools, and webhook payload simulation templates.

---

## 3. Ordered Execution Workflow

Follow this sequence when developing or refactoring GAS LINE Bot code:

### Step 1: Environment & Tooling Audit
Inspect local workspace configuration for `@google/clasp` and `.clasp.json` to enable local synchronization.
- *Completion Criterion*: `.clasp.json` is verified or `clasp` CLI environment is confirmed ready.

### Step 2: Codebase Legwork & Dispatch Architecture Setup
Dissect `doPost(e)` entry point, extract event payload parsing logic, and isolate event handlers into distinct modular functions.
- *Completion Criterion*: `doPost(e)` cleanly routes events to dedicated handler functions without monolithic block logic.

### Step 3: Webhook Simulation & Test Harness Verification
Construct or execute a local/GAS mock event harness (e.g., `testDoPostTextMessage()`) to test handlers under a controlled feedback loop.
- *Completion Criterion*: Mock event executes through `doPost(e)` and returns HTTP 200 / valid text log payload without uncaught exceptions.

### Step 4: Apply Mutations & Prune Legacy Sediment
Apply code modifications to GAS source files, ensure non-negotiable guardrails are respected, and prune unused legacy logic.
- *Completion Criterion*: Target changes are written, syntax is verified, and code adheres strictly to GAS-native API patterns (`UrlFetchApp`, `PropertiesService`).

