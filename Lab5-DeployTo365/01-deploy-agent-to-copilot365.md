# Lab 5: Deploy Agent to Microsoft 365 Copilot

## What You'll Build
Deploy your **Ticket Triage Orchestrator Agent** (from Lab 2.6) as a custom agent in Microsoft 365 Copilot, making it accessible directly from Teams or Copilot.

```
┌──────────────────┐                    ┌──────────────────┐
│   Microsoft 365  │                    │   Azure AI       │
│   Copilot        │ ◄────────────────► │   Foundry Agent  │
│   (Teams/Web)    │                    │   (Orchestrator) │
└──────────────────┘                    └──────────────────┘
```

---

## Prerequisites

- ✅ Completed **Lab 2.6** (Multi-Agent Ticket Triage System)
- ✅ VS Code installed
- ✅ Microsoft 365 account with Copilot access
- ✅ Node.js 18+ installed

---

## Step 1: Install Microsoft 365 Agents Toolkit

1. Open **VS Code**
2. Go to Extensions view (`Ctrl+Shift+X`)
3. Search for **Microsoft 365 Agents Toolkit**
4. Click **Install**

![Extensions](https://img.shields.io/badge/Extension-Microsoft%20365%20Agents%20Toolkit-blue)

---

## Step 2: Create New Agent Project

1. Click the **Microsoft 365 Agents Toolkit** icon in the VS Code sidebar
2. Select **Create a new agent/app**
3. Choose **Custom Engine Agent** and **Basic template** for building custom engine agents with **Azure OpenAI** and **JavaScript**
4. Configure:

| Setting | Value |
|---------|-------|
| **Folder** | Select a local folder for your project |
| **Agent Name** | `Ticket-Triage-Agent` |

5. Wait for the toolkit to scaffold the project

---

## Step 3: Get Agent Code from Azure AI Foundry

1. Go to [Azure AI Foundry](https://ai.azure.com)
2. Navigate to your project → **Agents**
3. Open the **Agent-Orchestrator** (from Lab 2.6)
4. Click **Try in playground** and **View Code** to get the agent code
5. Copy the code snippet

---

## Step 4: Integrate Agent Logic

1. Open your new project in VS Code
2. Navigate to `src/agent.js` and `src/config.js`
3. Open **GitHub Copilot Chat** (`Ctrl+Shift+I`)
4. Use this prompt:

```
Update the agent in this project to integrate with my Azure AI Foundry agent. 
Here's the agent code from Foundry:

[PASTE YOUR AGENT CODE HERE]

The agent is a ticket triage orchestrator that:
- Assesses priority (High/Medium/Low)
- Assigns team (Frontend/Backend/Infrastructure/Marketing)
- Estimates effort (Small/Medium/Large)
```

5. Review and apply the suggested changes

---

## Step 5: Update Configuration

Create a `.env` file in the folder:
```dotenv
AZURE_OPENAI_ENDPOINT=https://YOUR-RESOURCE.openai.azure.com/
AZURE_OPENAI_API_KEY=your-api-key
MODEL_DEPLOYMENT_NAME=gpt-4o
```

---

## Step 6: Test in Playground

1. In the **Microsoft 365 Agents Toolkit** sidebar, find **Deployment**
2. Click **Preview your app** → **Debug in Microsoft 365 agents playground**
3. A browser window will open with the playground

### Test Queries

Try these prompts (from Lab 2.6):

```
Users can't reset their password from the mobile app
```

**Expected Response:**
| Analysis | Result |
|----------|--------|
| Priority | High - User-facing blocking issue |
| Team | Frontend or Backend |
| Effort | Medium |

---

```
User can't access to his DB
```

**Expected Response:**
| Analysis | Result |
|----------|--------|
| Priority | High - Blocking user from data |
| Team | Infrastructure or Backend |
| Effort | Medium to Large |

---

```
The login button color doesn't match our brand guidelines
```

**Expected Response:**
| Analysis | Result |
|----------|--------|
| Priority | Low - Cosmetic issue |
| Team | Frontend |
| Effort | Small |

---

## Step 7: Deploy to Microsoft 365

Once testing is complete:

1. In the toolkit sidebar, click **Provision**
2. Sign in with your Microsoft 365 account
3. Click **Deploy** to publish your agent
4. Your agent will be available in:
   - Microsoft Teams
   - Microsoft 365 Copilot
   - Outlook (if configured)

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Toolkit not showing | Restart VS Code after installing extension |
| Playground won't open | Check you're signed into M365 account |
| Agent not responding | Verify Azure OpenAI credentials in `.env` |
| Permission denied | Ensure your M365 account has Copilot access |

---

## Summary

You have successfully:
- ✅ Installed Microsoft 365 Agents Toolkit
- ✅ Created a new agent project
- ✅ Integrated your Azure AI Foundry agent logic
- ✅ Tested in the M365 playground
- ✅ Deployed to Microsoft 365 Copilot

Your Ticket Triage Agent is now accessible directly from Teams and Copilot! 🎉

---

## Resources
- [Microsoft 365 Agents Toolkit](https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/build-custom-engine-agent)
- [Azure AI Foundry Agents](https://learn.microsoft.com/en-us/azure/ai-services/agents/)
- [Copilot Extensibility](https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/)
