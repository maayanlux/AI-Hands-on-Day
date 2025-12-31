# Lab 4: MCP Inventory Agent

## What You'll Build
An AI-powered inventory assistant that automatically calls external tools to analyze stock levels and provide restock/clearance recommendations.

```
┌──────────────────┐     stdio      ┌──────────────────┐
│   client.py      │ ◄────────────► │   server.py      │
│   (AI Agent)     │                │   (MCP Tools)    │
└──────────────────┘                └──────────────────┘
        │                                   │
        │ Uses Azure AI Agents              │ Provides:
        │ to reason & decide                │ • get_inventory_levels
        └───────────────────────────────────│ • get_weekly_sales
```

---

### 1. Setup Environment
```bash
cd Lab4-Advance
python -m venv .venv

# Windows
.venv\Scripts\activate

# macOS/Linux
source .venv/bin/activate

pip install -r requirements.txt
pip install azure-ai-agents
```

### 2. Configure Credentials
```bash
# Copy example file
copy .env.example .env    # Windows
cp .env.example .env      # macOS/Linux
```

Edit `.env` with your Azure AI Foundry values:
```dotenv
PROJECT_ENDPOINT=https://YOUR-RESOURCE.services.ai.azure.com/api/projects/YOUR-PROJECT
MODEL_DEPLOYMENT_NAME=gpt-4o
```

> 📍 Find these at [ai.azure.com](https://ai.azure.com) → Your Project → Overview

### 3. Login & Run
```bash
az login
python client.py
```

### 4. Try These Prompts
```
What items need restocking?
Which products should go on clearance?
Analyze our inventory health
```

Type `quit` to exit.

---

## How It Works

### The MCP Server (`server.py`)
Exposes two tools that the AI can call:

```python
from mcp.server.fastmcp import FastMCP
mcp = FastMCP("Inventory")

@mcp.tool()
def get_inventory_levels() -> dict:
    """Returns current stock for all products."""
    return {"Moisturizer": 6, "Shampoo": 8, "Body Spray": 28, ...}

@mcp.tool()
def get_weekly_sales() -> dict:
    """Returns units sold last week."""
    return {"Moisturizer": 22, "Shampoo": 18, "Body Spray": 3, ...}

mcp.run()
```

**Key points:**
- `@mcp.tool()` registers a function as an MCP tool
- The docstring becomes the tool description (AI sees this)
- `mcp.run()` starts the server (uses stdio by default)

### The Client (`client.py`)
1. **Starts the MCP server** as a subprocess
2. **Discovers tools** automatically from the server
3. **Creates an Azure AI Agent** with those tools
4. **Handles the conversation loop** - when the agent needs data, it calls the MCP tools

**Key code:**
```python
# Start MCP server as subprocess
server_params = StdioServerParameters(command="python", args=["server.py"])

# Discover tools dynamically (no hardcoding!)
response = await session.list_tools()

# Create agent with MCP tools
agent = agents_client.create_agent(
    model=model_deployment,
    instructions="Recommend restock if inventory < 10 and sales > 15...",
    tools=mcp_function_tool.definitions
)
```

---

## What is MCP?

**Model Context Protocol (MCP)** = A standard way for AI to connect to tools.

Think of it as **"USB-C for AI"** – any AI can talk to any tool using the same protocol.

### Why use MCP?
- ✅ **Dynamic discovery** – Agent finds tools at runtime
- ✅ **Loose coupling** – Add/remove tools without changing agent code
- ✅ **Standardized** – Works with any MCP-compatible client

### MCP Deployment Options

| Type | Transport | When to Use |
|------|-----------|-------------|
| **Local (this lab)** | stdio | Development, testing |
| **Remote Server** | HTTP/SSE | Production, shared tools |
| **Managed MCP Servers** | HTTPS | Pre-built integrations (Azure, GitHub, Slack, etc.) |
| **Logic Apps** | HTTPS | Enterprise workflows (see Lab 3) |

> 💡 Many 3rd-party MCP servers exist: GitHub, Slack, Notion, databases, and more. Check [MCP Server Registry](https://github.com/modelcontextprotocol/servers) for options.

**This lab uses stdio** = Server runs as subprocess, talks via stdin/stdout pipes.

| Stream | Direction | Description |
|--------|-----------|-------------|
| **stdin** (standard input) | Parent → Child | The client writes messages to the server's input |
| **stdout** (standard output) | Child → Parent | The server writes responses back through its output |

---

## Troubleshooting

| Error | Fix |
|-------|-----|
| `No module named 'dotenv'` | `pip install python-dotenv` |
| `No module named 'azure.ai.agents'` | `pip install azure-ai-agents` |
| `No project endpoint found` | Check `.env` has correct values |
| `Authentication failed` | Run `az login` |

---

## Extend It

Add a new tool in `server.py`:
```python
@mcp.tool()
def get_supplier_lead_times() -> dict:
    """Returns delivery time in days per product."""
    return {"Moisturizer": 7, "Shampoo": 5, ...}
```

Client discovers it automatically on next run! 🎉

---

## Resources
- [Model Context Protocol](https://modelcontextprotocol.io/)
- [MCP Python SDK](https://github.com/modelcontextprotocol/python-sdk)

