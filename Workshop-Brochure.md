# Azure AI Foundry: Hands-On Workshop

## Build Production-Ready AI Agents in One Day

---

### Why This Workshop?

AI agents are moving from demos to production. The challenge isn't building a chatbot—it's building one that **reasons**, **uses tools**, **searches enterprise data**, and **integrates with your existing systems**.

This workshop gives you hands-on experience with the patterns and infrastructure that power enterprise AI deployments on Azure.

---

### What You'll Build

| Lab | Focus | Outcome |
|-----|-------|---------|
| **1. Infrastructure** | Azure AI Foundry setup | Resource group, AI project, GPT-4o deployment, RBAC |
| **2. AI Agents** | Progressive agent capabilities | 6 agents: basic → code interpreter → file search → web grounding → AI Search → multi-agent orchestration |
| **3. MCP + Logic Apps** | Enterprise integration | Expose agents as MCP tools via Logic Apps |
| **4. MCP Server/Client** | Custom tool development | Python MCP server with stdio transport, dynamic tool discovery |
| **5. M365 Copilot** | End-user deployment | Deploy your agent to Microsoft 365 Copilot |

---

### Architecture

```
                    Azure AI Foundry
    ┌────────────────────────────────────────────┐
    │  GPT-4o  │  AI Search  │  Bing Grounding   │
    └─────────────────┬──────────────────────────┘
                      │
              ┌───────┴───────┐
              │   AI Agents   │
              │  (Lab 2)      │
              └───────┬───────┘
                      │
       ┌──────────────┼──────────────┐
       │              │              │
       ▼              ▼              ▼
   Logic Apps     Python MCP    M365 Copilot
   (Lab 3)        (Lab 4)       (Lab 5)
```

---

### Key Patterns Covered

- **Tool-augmented agents** — Code execution, document search, web grounding
- **Multi-agent orchestration** — Specialist agents coordinated by an orchestrator
- **Model Context Protocol (MCP)** — Open standard for AI-tool integration
- **Dynamic tool discovery** — Agents discover capabilities at runtime
- **Enterprise deployment** — Logic Apps, M365 Copilot integration

---

### Who Should Attend

- **Developers** building AI-powered applications
- **Solution Architects** designing agent-based systems
- **Platform Engineers** operating AI infrastructure at scale

---

### Prerequisites

- Azure subscription (Contributor access)
- Azure AI Foundry access enabled
- VS Code installed
- Azure CLI authenticated

---

### What You Leave With

✅ Working AI agents with multiple tool integrations  
✅ Multi-agent orchestration pattern  
✅ MCP server you can extend  
✅ Agent deployed to M365 Copilot  
✅ Reusable code and templates  

---

**Ready to build?** → [github.com/maayanlux/AI-Hands-on-Day](https://github.com/maayanlux/AI-Hands-on-Day)
