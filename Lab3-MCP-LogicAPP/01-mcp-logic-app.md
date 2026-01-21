# Lab 3: Custom MCP Logic App

## Overview

This lab guides you through creating a custom **Model Context Protocol (MCP)** server using Azure Logic Apps. You will create a workflow that triggers an AI Agent and expose it as an MCP tool usable directly within VS Code or other MCP clients.

### What is MCP?

**Model Context Protocol (MCP)** is an open standard that allows AI assistants to connect with external tools and data sources. By exposing your Logic App as an MCP server, you can:

- 🔧 Call your AI agents directly from VS Code
- 🔗 Integrate Azure workflows with AI assistants
- 🚀 Create custom tools for GitHub Copilot and other MCP clients

---

## Prerequisites

Before starting this lab, ensure you have completed the following:

### 1. Azure AI Foundry Setup (from Lab 1 & 2)
- [ ] Azure subscription with access to Azure AI Foundry
- [ ] Azure AI Foundry project created
- [ ] `Agent-fitness-search` agent created (from Lab 2.5)

### 2. Development Environment
- [ ] Visual Studio Code installed
- [ ] PowerShell available
- [ ] Azure account configured in VS Code

### 3. Required Information
- [ ] Your AI Foundry Project Endpoint
- [ ] Your Agent ID (from `Agent-fitness-search`)

---

## Lab Instructions

### Step 1: Create Azure Logic App (Standard)

1. Log in to the [Azure Portal](https://portal.azure.com)
2. Search for and select **Logic Apps**
3. Click **Create** and configure the following:

| Setting | Value |
|---------|-------|
| **Subscription** | Select your active subscription |
| **Resource Group** | Select the same resource group (e.g., `rg-ai-foundry-lab`) |
| **Logic App Name** | Enter a unique name (e.g., `logic-mcp-server-lab3`) |
| **Region** | Select the same region as your Foundry services (e.g., `East US 2`) |
| **Plan Type** | Select **Standard (Workflow Service Plan)** |
| **Windows Plan** | Select a new or existing App Service Plan (e.g., `WS1`) |

4. Click **Review + create**, then **Create**
5. Wait for the deployment to complete and navigate to the resource

---

### Step 2: Enable Managed Identity

The Logic App needs a managed identity to authenticate with Azure AI Foundry.

1. In the Logic App menu, go to **Identity** on the left menu
2. Under **System assigned** tab, turn the **Status** to **On**
3. Click **Save**
4. Click **Yes** to confirm

#### Assign Role to Managed Identity:

> ⚠️ **Important:** You must grant the Logic App access to your AI Foundry Project.

1. Go to your **AI Foundry Project** in the Azure Portal
2. Select **Access Control (IAM)**
3. Click **+ Add** → **Add role assignment**
4. Search for and select: `Azure AI Developer`, `Azure AI Project Manager`, `Cognitive Services User`, `Cognitive Services OpenAI User`
5. Click **Next**
6. Select **Managed identity**
7. Click **+ Select members**
8. Select **Logic app** as the managed identity type
9. Find and select your Logic App (`logic-mcp-server-lab3`)
10. Click **Select**, then **Review + assign**

---

### Step 3: Enable MCP Server

To expose your Logic App workflows as MCP tools, you must enable the feature in the host configuration.

1. In the Logic App menu, go to **Development Tools** → **Advanced Tools**
2. Click **Go** (this opens the Kudu management interface in a new tab)
3. In the top menu, click **Debug Console** → **CMD**
4. Navigate through the folders: `site` → `wwwroot`
5. Find the `host.json` file and click the **pencil icon** (Edit) next to it
6. Add the following `"extensions"` block to the JSON object:

```json
{
  "version": "2.0",
  "extensionBundle": {
    "id": "Microsoft.Azure.Functions.ExtensionBundle.Workflows",
    "version": "[1.*, 2.0.0)"
  },
  "extensions": {
    "workflow": {
      "McpServerEndpoints": {
        "enable": true
      }
    }
  }
}
```

> 💡 **Note:** Ensure you add a comma `,` after the previous property if necessary to maintain valid JSON syntax.

7. Click **Save**

---

### Step 4: Prepare the Foundry Agent

Ensure your agent is ready in Azure AI Foundry and gather the required information.

#### Get Agent ID:

1. Go to [Azure AI Foundry](https://ai.azure.com)
2. Open your Project
3. Navigate to **Agents**
4. Click on `Agent-fitness-search`
5. Copy the **Agent ID** (also called Assistant ID) from the overview page

#### Get Project Endpoint:

1. In your AI Foundry Project, go to **Overview**
2. Copy the **Project Endpoint** URL

> 📝 **Save these values** - you'll need them in the next step:
> - Agent ID: `asst_xxxxxxxxxxxxxxxx`
> - Project Endpoint: `https://xxxxxxxx.services.ai.azure.com/xxxxx`
---

### Step 5: Create the Workflow

Now create the Logic App workflow that will call your AI agent.

1. In your Logic App, go to **Workflows** in the left menu
2. Click **+ Add**
3. Enter workflow name: `fitness-agent-trigger`
4. Select **Stateful**
5. Click **Create**
6. Create first action:  **When an HTTP request is received**
7. Create second action: **Create Thread**
> 💡 This will create the Foundry Connection:
> - Connection name: **azureagentservice**
> - Authentication type: **Logic Apps Managed Identity**
> - Azure AI Project Endpoint: **paste your Project Endpoint URL**

8. Open the workflow and click **Code View**
9. Replace the content with the workflow JSON from `logic-app-flow.json`
10. **Modify the connection** with your own project endpoint at line **107** 
> 💡Replace ONLY the connection name "**Your-Project-Connection**/threads/@{variables('thread_id')}/runs/@{body('Create_Run')?['id']}?api-version=2025-05-01"
11. **Update the Agent ID** in the workflow at line **16**
12. Click **Save**

#### Key Configuration Points:

| Parameter | Value |
|-----------|-------|
| **Project Endpoint** | Your AI Foundry Project Endpoint |
| **Agent ID** | Your `Agent-fitness-search` Agent ID |
| **GET-Status action** | Update with your project endpoint |

---
### Step 6: Create an app registration

To create an app registration for your logic app to use in your Easy Auth setup, follow these steps:
https://learn.microsoft.com/en-us/azure/logic-apps/set-up-model-context-protocol-server-standard#create-an-app-registration 
then : https://learn.microsoft.com/en-us/azure/logic-apps/set-up-model-context-protocol-server-standard#set-up-easy-auth-for-your-mcp-server


### Step 7: Get the MCP Endpoint URL

Now retrieve the MCP endpoint URL to connect it to VS Code.

1. Open the file `checkMCP-url.ps1` in VS Code
2. Update the `$uri` variable with your specific details:
   - Replace the **Subscription ID**
   - Replace the **Resource Group name**
   - Replace the **Logic App name**

3. Run the script in a PowerShell terminal:

```powershell
.\checkMCP-url.ps1
```

4. **Copy the URL** returned in the output

> 💡 The URL will look something like:
> `https://logic-mcp-server-lab3.azurewebsites.net/runtime/webhooks/mcp/sse`

---

### Step 8: Configure VS Code MCP Client

Connect your Logic App MCP server to Visual Studio Code.

1. In Visual Studio Code, open the **Command Palette** (`Ctrl+Shift+P` or `Cmd+Shift+P`)
2. Search for and select **MCP: Add Server**
3. Select **HTTP (HTTP or Server-Sent Events)**
4. **Enter Server URL:** Paste the URL you copied from the PowerShell script output
5. **Enter Server ID:** Provide a meaningful name (e.g., `logic-app-mcp`)
6. Select **Global** or **Workspace** to store the configuration

VS Code will open the `mcp.json` file.

7. Click the **Start** or **Restart** link next to your server status to establish connectivity
8. If prompted, **sign in to your Azure account** to authenticate

---

## Test Your MCP Server

### Test in VS Code Chat

1. Open the **Chat panel** in VS Code (GitHub Copilot Chat)
2. Your Logic App tool should now be available
3. Test by asking:

```
What fitness equipment is available?
```

or

```
Search for strength training products under $100
```

### Expected Behavior:

- VS Code detects the `fitness-agent-trigger` tool from your Logic App
- The request is sent to the Logic App
- Logic App triggers the `Agent-fitness-search` agent
- Results are returned to VS Code chat

---

## Validation Checklist

- [ ] Logic App (Standard) created
- [ ] Managed Identity enabled
- [ ] Azure AI Developer role assigned to Logic App
- [ ] MCP Server enabled in host.json
- [ ] Workflow created with correct Agent ID and Endpoint
- [ ] MCP URL retrieved using PowerShell script
- [ ] VS Code MCP server configured
- [ ] Successfully tested tool in VS Code chat

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| MCP URL not returned | Verify Logic App name and subscription in script |
| Authentication failed | Sign in to Azure in VS Code |
| Tool not appearing | Restart the MCP server in VS Code |
| Agent not responding | Verify Agent ID and Endpoint are correct |
| Permission denied | Check managed identity role assignment |
| host.json syntax error | Validate JSON syntax (use a JSON validator) |

---

## Summary

Congratulations! 🎉 You have successfully:

1. ✅ Created an Azure Logic App (Standard)
2. ✅ Enabled Managed Identity and assigned permissions
3. ✅ Enabled MCP Server in the Logic App
4. ✅ Created a workflow to trigger your AI Agent
5. ✅ Retrieved the MCP endpoint URL
6. ✅ Connected VS Code to your MCP server
7. ✅ Tested the AI agent tool from VS Code

---

## Key Concepts Learned

| Concept | Description |
|---------|-------------|
| **MCP (Model Context Protocol)** | Open standard for connecting AI assistants to external tools |
| **MCP Server** | Endpoint that exposes tools for AI assistants to use |
| **Logic App Standard** | Serverless workflow platform with MCP support |
| **Managed Identity** | Azure's secure identity for service-to-service auth |
| **MCP Client** | Application (like VS Code) that connects to MCP servers |

---

## Architecture Diagram

```
┌─────────────────┐         ┌─────────────────┐         ┌─────────────────┐
│    VS Code      │  MCP    │   Logic App     │  API    │  AI Foundry     │
│   (MCP Client)  │ ──────► │  (MCP Server)   │ ──────► │     Agent       │
└─────────────────┘         └─────────────────┘         └─────────────────┘
        │                           │                           │
        │  User asks question       │  Triggers workflow        │  Processes query
        │                           │                           │
        ◄───────────────────────────┼───────────────────────────┤
                    Response returned through the chain
```

---

## Next Steps

- Add more workflows to expose additional agents as MCP tools
- Create conditional workflows based on user input
- Explore other MCP clients beyond VS Code
- Build complex multi-step agent workflows

---

## Additional Resources

- [Model Context Protocol Documentation](https://modelcontextprotocol.io/)
- [Azure Logic Apps Documentation](https://learn.microsoft.com/azure/logic-apps/)
- [VS Code MCP Integration](https://code.visualstudio.com/docs)
- [Azure AI Foundry Agents](https://learn.microsoft.com/azure/ai-studio/how-to/agents)
- [Set up Standard logic apps as remote MCP servers ](https://learn.microsoft.com/en-us/azure/logic-apps/set-up-model-context-protocol-server-standard)
