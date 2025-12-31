# AI Day Hands-On Labs

Welcome to the **AI Day Hands-On Labs** workshop! This repository contains a series of guided labs to help you build intelligent AI applications using **Azure AI Foundry**, **AI Agents**, and **Model Context Protocol (MCP)**.

## 📋 Overview

This workshop takes you from setting up Azure AI Foundry infrastructure to building sophisticated multi-agent systems and exposing them through MCP servers. You'll gain practical experience with:

- **Azure AI Foundry** - Microsoft's unified platform for AI development
- **AI Agents** - Intelligent assistants with various capabilities (code interpretation, file search, web grounding)
- **Model Context Protocol (MCP)** - Open standard for connecting AI assistants to external tools

---

## 🗂️ Repository Structure

```
├── Lab1-Foundry/
│   └── 01-foundry-infrastructure.md    # Azure AI Foundry setup
├── Lab2-Agents/
│   ├── 01-basic-agent.md               # Basic health advisor agent
│   ├── 02-code-interpreter-agent.md    # Agent with Python execution
│   ├── 03-file-search-agent.md         # Agent with document search
│   ├── 04-bing-grounding-agent.md      # Agent with web search
│   ├── 05-ai-search-agent.md           # Agent with Azure AI Search
│   ├── 06-multi-agent-solution.md      # Multi-agent orchestration
│   └── sample-data/                    # Sample files for labs
├── Lab3-MCP-LogicAPP/
│   ├── 01-mcp-logic-app.md             # MCP server with Logic Apps
│   ├── checkMCP-url.ps1                # Helper script for MCP URL
│   └── logic-app-flow.json             # Logic App workflow definition
├── Lab4-Advance/
│   ├── MCP-Client-Server-Code.md       # MCP architecture explanation
│   ├── server.py                       # MCP server with inventory tools
│   ├── client.py                       # AI Agent MCP client
│   ├── requirements.txt                # Python dependencies
│   └── .env.example                    # Environment template
└── Lab5-DeployTo365/
    └── 01-deploy-agent-to-copilot365.md  # Deploy agent to M365 Copilot
```

---

## 🚀 Labs Overview

### Lab 1: Azure AI Foundry Infrastructure

| Topic | Description |
|-------|-------------|
| **Resource Setup** | Create Resource Group, AI Foundry, and Project |
| **Model Deployment** | Deploy GPT-4o model |
| **Permissions** | Configure RBAC for AI development |

**Duration:** ~30 minutes

---

### Lab 2: AI Agents

Build progressively more capable AI agents:

| Lab | Agent Type | Key Capability |
|-----|------------|----------------|
| 2.1 | Basic Agent | Health advisor with instructions |
| 2.2 | Code Interpreter | Python execution, BMI calculations, charts |
| 2.3 | File Search | Document-grounded responses |
| 2.4 | Bing Grounding | Real-time web search |
| 2.5 | AI Search | Product catalog search |
| 2.6 | Multi-Agent | Orchestrated ticket triage system |

**Duration:** ~2-3 hours (all labs)

---

### Lab 3: MCP Logic App Integration

| Topic | Description |
|-------|-------------|
| **Logic App Setup** | Create Standard Logic App with MCP support |
| **Agent Integration** | Connect Logic App to AI Foundry Agent |
| **VS Code Client** | Use agent as MCP tool in VS Code |

**Duration:** ~45 minutes

---

### Lab 4: Advanced MCP (Client-Server Code)

| Topic | Description |
|-------|-------------|
| **MCP Server** | Build custom MCP server with Python (FastMCP) |
| **MCP Client** | Create AI Agent that discovers and calls MCP tools |
| **stdio Transport** | Local subprocess communication |
| **Dynamic Discovery** | Agent finds tools at runtime |

**Duration:** ~45 minutes

---

### Lab 5: Deploy Agent to Microsoft 365 Copilot

| Topic | Description |
|-------|-------------|
| **M365 Agents Toolkit** | Install VS Code extension |
| **Declarative Agent** | Create M365 Copilot agent project |
| **Foundry Integration** | Connect to Azure AI Foundry agent |
| **Teams Testing** | Test agent in Microsoft Teams |

**Duration:** ~30 minutes

---

## 📋 Prerequisites

Before starting the labs, ensure you have:

- [ ] **Azure Subscription** with Contributor or Owner access
- [ ] **Azure AI Foundry** access enabled on your subscription
- [ ] **Visual Studio Code** installed (for Lab 3)
- [ ] **PowerShell** available (for Lab 3)
- [ ] **Azure CLI** installed and authenticated

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        Azure AI Foundry                         │
├─────────────────────────────────────────────────────────────────┤
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐             │
│  │   GPT-4o    │  │  AI Search  │  │    Bing     │             │
│  │   Model     │  │   Index     │  │  Grounding  │             │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘             │
│         │                │                │                     │
│  ┌──────┴────────────────┴────────────────┴──────┐             │
│  │                  AI Agents                     │             │
│  │  • Health Advisor    • Code Interpreter        │             │
│  │  • File Search       • AI Search               │             │
│  │  • Multi-Agent Orchestrator                    │             │
│  └──────────────────────┬────────────────────────┘             │
└─────────────────────────┼───────────────────────────────────────┘
                          │
              ┌───────────┴───────────┐
              │     Logic App         │
              │    (MCP Server)       │
              └───────────┬───────────┘
                          │
              ┌───────────┴───────────┐
              │      VS Code          │
              │    (MCP Client)       │
              └───────────────────────┘
                          │
    ┌─────────────────────┼─────────────────────┐
    │                     │                     │
    ▼                     ▼                     ▼
┌─────────┐      ┌──────────────┐      ┌──────────────┐
│ Lab 4   │      │   Lab 5      │      │   Lab 3      │
│ Python  │      │   M365       │      │  Logic App   │
│ MCP     │      │   Copilot    │      │   MCP        │
└─────────┘      └──────────────┘      └──────────────┘
```

---

## 🎯 Learning Objectives

By completing these labs, you will:

1. **Understand Azure AI Foundry** - Navigate the platform and deploy models
2. **Build AI Agents** - Create agents with various tools and capabilities
3. **Implement Knowledge Sources** - Use File Search, Bing, and AI Search
4. **Design Multi-Agent Systems** - Orchestrate multiple agents for complex tasks
5. **Expose Agents via MCP** - Make agents available as tools in VS Code
6. **Build MCP Servers** - Create custom tool servers with Python
7. **Deploy to M365 Copilot** - Bring your agent to Microsoft 365

---

## 📚 Key Concepts

| Concept | Description |
|---------|-------------|
| **AI Agent** | Autonomous AI assistant with instructions and tools |
| **Code Interpreter** | Execute Python code in a sandboxed environment |
| **File Search** | Search through uploaded documents using vectors |
| **Bing Grounding** | Real-time web search for current information |
| **Azure AI Search** | Structured search with custom indexes |
| **Multi-Agent** | Multiple specialists coordinated by an orchestrator |
| **MCP** | Model Context Protocol for AI tool integration |
| **FastMCP** | Python library for building MCP servers |
| **M365 Copilot** | Microsoft 365 AI assistant that can use custom agents |

---

## 🛠️ Getting Started

1. **Clone this repository** or download the files
2. **Start with Lab 1** to set up your Azure AI Foundry infrastructure
3. **Progress through Lab 2** to build increasingly capable agents
4. **Complete Lab 3** to expose your agent via Logic Apps MCP
5. **Complete Lab 4** to build custom MCP server with Python
6. **Complete Lab 5** to deploy your agent to Microsoft 365 Copilot

---

## 📖 Additional Resources

- [Azure AI Foundry Documentation](https://learn.microsoft.com/azure/ai-studio/)
- [AI Agents Overview](https://learn.microsoft.com/azure/ai-studio/concepts/agents)
- [Azure AI Search Documentation](https://learn.microsoft.com/azure/search/)
- [Model Context Protocol](https://modelcontextprotocol.io/)
- [Azure Logic Apps](https://learn.microsoft.com/azure/logic-apps/)

---

## 🤝 Support

If you encounter issues during the labs:

1. Check the **Troubleshooting** section in each lab
2. Verify your Azure permissions and resource deployments
3. Ensure all prerequisites are completed before starting each lab

---

## 📝 License

This workshop content is provided for educational purposes.

---

**Happy Building! 🚀**
