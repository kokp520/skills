# Recommended Tools & Environment Setup for GAS LINE Bot

This reference file details recommended MCP tools, local development CLI setups, and testing tools for managing a Google Apps Script (GAS) LINE Bot.

---

## 1. Recommended MCP Tools & Integration

### A. `@google/clasp` / Google Apps Script MCP
- **Purpose**: Enables AI to push/pull code to Google Apps Script, manage deployments, and read execution logs directly.
- **Recommended Setup**:
  1. Install `@google/clasp` globally or locally: `npm install -g @google/clasp`
  2. Login via clasp: `clasp login`
  3. Enable Google Apps Script API in Google Cloud Console.
  4. Use a Clasp MCP server or command-line integration to allow AI to run `clasp push`, `clasp pull`, and `clasp logs`.

### B. LINE Messaging API OpenAPI / Schema MCP
- **Purpose**: Provides AI with up-to-date LINE Messaging API JSON definitions (Flex Messages, Rich Menus, Webhook Event Objects).
- **Usage**: When creating Flex Message layouts or handling complex postback actions, refer to official LINE Messaging API specs to avoid malformed JSON payloads.

### C. Webhook Inspector & Tunneling (ngrok / Hookdeck)
- **Purpose**: Forward real LINE Webhook events to local mock servers or inspect incoming request payloads.
- **Usage**: Use ngrok or Hookdeck CLI when debugging raw HTTP headers (`x-line-signature`) and request body verification.

---

## 2. Local Testing & Webhook Event Mocking

Since GAS `doPost(e)` receives event objects via HTTP POST, you can test functions locally using Node.js or directly in GAS by executing test functions.

### Example: GAS Test Function for `doPost`
```javascript
function testDoPostTextMessage() {
  var mockEvent = {
    postData: {
      contents: JSON.stringify({
        destination: "U1234567890abcdef1234567890abcdef",
        events: [
          {
            type: "message",
            replyToken: "nH2OHuBGvU26GH5A8tcCHQ",
            source: {
              userId: "U1234567890abcdef1234567890abcdef",
              type: "user"
            },
            timestamp: 1625000000000,
            message: {
              id: "325708",
              type: "text",
              text: "Hello Bot"
            }
          }
        ]
      })
    }
  };

  var result = doPost(mockEvent);
  Logger.log("doPost Result: " + JSON.stringify(result));
}
```

---

## 3. Deployment Checklist for GAS

1. **Script Properties Configuration**:
   - Ensure `CHANNEL_ACCESS_TOKEN` is set via `PropertiesService.getScriptProperties().setProperty('CHANNEL_ACCESS_TOKEN', '...')`.
2. **Deploy as Web App**:
   - Execute as: **Me (your account)**
   - Who has access: **Anyone** (Required for LINE platform to reach the Webhook).
3. **Webhook URL**:
   - Copy the deployed Web App URL (`https://script.google.com/macros/s/.../exec`) and paste it into LINE Developers Console > Webhook settings. Enable **Use webhook**.
