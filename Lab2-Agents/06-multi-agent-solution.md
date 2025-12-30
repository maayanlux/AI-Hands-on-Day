# Lab 2.6: Multi-Agent Solution - Ticket Triage System

## Overview

In this lab, you will build a **multi-agent system** where multiple specialist agents work together, coordinated by an orchestrator agent. This pattern is powerful for complex tasks that require different expertise areas.

### What You'll Build

A ticket triage system that automatically analyzes support tickets and provides:
- **Priority Assessment** - How urgent is this ticket?
- **Team Assignment** - Which team should handle it?
- **Effort Estimation** - How much work will it take?

---

## Architecture Overview

The system consists of:

```
                    ┌─────────────────────┐
                    │   Orchestrator      │
                    │   Agent             │
                    └─────────┬───────────┘
                              │
            ┌─────────────────┼─────────────────┐
            │                 │                 │
            ▼                 ▼                 ▼
    ┌───────────────┐ ┌───────────────┐ ┌───────────────┐
    │   Priority    │ │     Team      │ │    Effort     │
    │    Agent      │ │    Agent      │ │    Agent      │
    └───────────────┘ └───────────────┘ └───────────────┘
```

1. **Three Specialist Agents**: Each focused on one aspect of ticket analysis
2. **One Orchestrator Agent**: Uses the specialist agents as tools to provide comprehensive triage
3. **Connected Agent Tools**: Enable the orchestrator to call specialist agents as needed

---

## Prerequisites

Before starting this lab, ensure you have completed the following:

### 1. Azure AI Foundry Setup (from Lab 1)
- [ ] Azure subscription with access to Azure AI Foundry
- [ ] Azure AI Foundry hub created
- [ ] Azure AI Foundry project created within the hub
- [ ] GPT-4o model deployed in your project

---

## Lab Instructions

### Step 1: Create the Priority Assessment Agent

This agent analyzes tickets to determine their urgency level. It categorizes tickets as High, Medium, or Low priority based on their impact on users and business operations.

1. Go to [Azure AI Foundry](https://ai.azure.com)
2. Select your **Project**
3. Navigate to **Agents** in the left menu
4. Click **+ New agent**
5. Configure the agent:

| Setting | Value |
|---------|-------|
| **Agent Name** | `Agent-Priority` |
| **Model** | `gpt-4o` |

#### Instructions

```
Assess how urgent a ticket is based on its description.

Respond with one of the following levels:
- High: User-facing or blocking issues
- Medium: Time-sensitive but not breaking anything
- Low: Cosmetic or non-urgent tasks

Only output the urgency level and a very brief explanation.
```

6. Click **Create**

---

### Step 2: Create the Team Assignment Agent

This agent determines which team should handle each ticket based on the technical domain and expertise required. It assigns tickets to Frontend, Backend, Infrastructure, or Marketing teams.

1. Click **+ New agent**
2. Configure the agent:

| Setting | Value |
|---------|-------|
| **Agent Name** | `Agent-Team` |
| **Model** | `gpt-4o` |

#### Instructions

```
Decide which team should own each ticket.

Choose from the following teams:
- Frontend
- Backend
- Infrastructure
- Marketing

Base your answer on the content of the ticket. Respond with the team name and a very brief explanation.
```

3. Click **Create**

---

### Step 3: Create the Effort Estimation Agent

This agent estimates the amount of work required to resolve each ticket. It categorizes the effort as Small (1 day), Medium (2-3 days), or Large (multi-day/cross-team effort).

1. Click **+ New agent**
2. Configure the agent:

| Setting | Value |
|---------|-------|
| **Agent Name** | `Agent-Effort` |
| **Model** | `gpt-4o` |

#### Instructions

```
Estimate how much work each ticket will require.

Use the following scale:
- Small: Can be completed in a day
- Medium: 2-3 days of work
- Large: Multi-day or cross-team effort

Base your estimate on the complexity implied by the ticket. Respond with the effort level and a brief justification.
```

3. Click **Create**

---

### Step 4: Create the Orchestrator Agent

The main orchestrator agent coordinates all three specialist agents. It receives the ticket and uses the specialist agents as tools to provide a comprehensive triage analysis.

1. Click **+ New agent**
2. Configure the agent:

| Setting | Value |
|---------|-------|
| **Agent Name** | `Agent-Orchestrator` |
| **Model** | `gpt-4o` |

#### Instructions

```
Triage the given ticket. Use the connected tools to determine the ticket's priority, which team it should be assigned to, and how much effort it may take.
```

3. **Do not click Create yet** - proceed to Step 5 to add connected agents

---

### Step 5: Connect Specialist Agents to Orchestrator

This is the key step that enables the multi-agent collaboration!

1. In the Orchestrator agent configuration, find the **Actions** section
2. Click on **Connected agents**
3. Click **+ Add** to add each specialist agent:

#### Add Priority Agent:
| Setting | Value |
|---------|-------|
| **Agent** | `Agent-Priority` |
| **Description** | `Assess the priority of a ticket` |

#### Add Team Agent:
| Setting | Value |
|---------|-------|
| **Agent** | `Agent-Team` |
| **Description** | `Determines which team should take the ticket` |

#### Add Effort Agent:
| Setting | Value |
|---------|-------|
| **Agent** | `Agent-Effort` |
| **Description** | `Determines the effort required to complete the ticket` |

4. Click **Create** to save the Orchestrator agent

---

## Test Your Multi-Agent System

### Test in the Playground

1. Open the **Playground** for the `Agent-Orchestrator`
2. Test with the following tickets:

---

### Test 1: Mobile Password Reset Issue 📱

**User Prompt:**
```
Users can't reset their password from the mobile app
```

**Expected Response:**

The orchestrator should call all three specialist agents and provide a combined analysis:

| Analysis | Expected Result |
|----------|-----------------|
| **Priority** | High - User-facing blocking issue |
| **Team** | Frontend or Backend (authentication related) |
| **Effort** | Medium - Requires investigation and fix |

---

### Test 2: Database Access Issue 🗄️

**User Prompt:**
```
user can't access to his DB
```

**Expected Response:**

| Analysis | Expected Result |
|----------|-----------------|
| **Priority** | High - Blocking user from accessing data |
| **Team** | Infrastructure or Backend |
| **Effort** | Medium to Large - Database issues can be complex |

---

### Additional Test Cases

Try these additional tickets to see how the system responds:

```
The login button color doesn't match our brand guidelines
```

```
Homepage loads slowly for users in Europe
```

```
Need to update the privacy policy footer link
```

---

## How Multi-Agent Collaboration Works

When you send a ticket to the Orchestrator:

1. **Orchestrator receives the ticket** and determines it needs all three analyses
2. **Orchestrator calls Agent-Priority** → Gets urgency assessment
3. **Orchestrator calls Agent-Team** → Gets team assignment
4. **Orchestrator calls Agent-Effort** → Gets effort estimation
5. **Orchestrator combines the results** into a comprehensive triage response

> 💡 **Key Insight:** Each specialist agent focuses on one specific task, making them more accurate and easier to maintain. The orchestrator coordinates them without needing to know the details of each analysis.

---

## Validation Checklist

- [ ] Agent-Priority created with correct instructions
- [ ] Agent-Team created with correct instructions
- [ ] Agent-Effort created with correct instructions
- [ ] Agent-Orchestrator created
- [ ] All three specialist agents connected to Orchestrator
- [ ] Descriptions added for each connected agent
- [ ] Orchestrator successfully calls all three agents
- [ ] Combined triage response is provided

---

## Summary

Congratulations! 🎉 You have successfully:

1. ✅ Created three specialist agents (Priority, Team, Effort)
2. ✅ Created an orchestrator agent
3. ✅ Connected specialist agents as tools to the orchestrator
4. ✅ Built a multi-agent ticket triage system
5. ✅ Tested the collaborative agent workflow

---

## Key Concepts Learned

| Concept | Description |
|---------|-------------|
| **Multi-Agent System** | Multiple agents working together on complex tasks |
| **Specialist Agents** | Agents focused on specific, narrow tasks |
| **Orchestrator Agent** | Coordinates other agents to produce combined results |
| **Connected Agents** | Agents exposed as tools to other agents |
| **Agent Collaboration** | Breaking complex tasks into specialized sub-tasks |

---

## Benefits of Multi-Agent Architecture

| Benefit | Description |
|---------|-------------|
| **Modularity** | Each agent can be updated independently |
| **Specialization** | Agents can be optimized for specific tasks |
| **Reusability** | Specialist agents can be used in multiple orchestrators |
| **Scalability** | Easy to add new specialist agents |
| **Maintainability** | Simpler instructions per agent |

---

## Next Steps

- Add more specialist agents (e.g., Sentiment Analysis, SLA Checker)
- Create different orchestrators for different workflows
- Explore conditional agent calling based on ticket content

---

## Additional Resources

- [Azure AI Foundry Documentation](https://learn.microsoft.com/azure/ai-studio/)
- [Multi-Agent Patterns](https://learn.microsoft.com/azure/ai-studio/how-to/agents)
- [Agent Tools and Connections](https://learn.microsoft.com/azure/ai-studio/how-to/agents)
