# Lab 2.4: Bing Grounding Agent - Real-Time Health Search

## What is Bing Grounding?

**Bing Grounding** enables AI agents to search the web in real-time using Bing Search. This capability allows your agent to provide up-to-date information, current news, and the latest research - going beyond static knowledge.

### Key Capabilities:
- 🌐 **Real-Time Search** - Access current information from the web
- 📰 **Latest News** - Get recent articles and updates
- 🔗 **Source Citations** - Provide links to original sources
- ✅ **Fact Verification** - Cross-reference information with live data

Unlike File Search (which uses your uploaded documents), Bing Grounding searches the entire web for current information.

---

## Prerequisites

Before starting this lab, ensure you have completed the following:

### 1. Azure AI Foundry Setup
- [ ] Azure subscription with access to Azure AI Foundry
- [ ] Azure AI Foundry project created
- [ ] GPT-4o model deployed in your project
- [ ] Required Permissionst

### 2. Bing Search Access
- [ ] Access to create Bing Search connections in AI Foundry

---

## Lab Instructions

### Step 1: Create a Bing Grounding Connection

Before creating the agent, you need to set up a Bing Search connection:

1. Navigate to [Azure AI Foundry](https://ai.azure.com)
2. Click on **Management Center**
3. Under your project, click on **Connected Resources**
4. Click **New Connection**
5. Choose **Grounding with Bing Search**
6. Click **Add Connection**

> 💡 This connection will be available when configuring your agent's knowledge sources.

---

### Step 2: Navigate to Agents

1. Go to [Azure AI Foundry](https://ai.azure.com)
2. Select your **Project**
3. In the left navigation pane, click on **Agents**
4. Click **+ New agent**

---

### Step 3: Create the Bing Grounding Agent

Configure your agent with the following settings:

#### Agent Configuration

| Setting | Value |
|---------|-------|
| **Agent Name** | `Agent-health-bing` |
| **Model** | `gpt-4o` |

#### Instructions

Copy and paste the following instructions:

```
You are a health and fitness assistant with Bing search capabilities.
Always:
1. Provide disclaimers that you are not a medical professional.
2. Encourage professional consultation.
3. Use Bing for real-time references when appropriate.
4. Provide brief, helpful answers.
5. Include relevant sources and citations from your searches.
```

---

### Step 4: Add Bing Grounding to the Agent

This is the key step that enables your agent to search the web!

1. In the agent configuration, find the **Knowledge** section
2. Click **+ Add**
3. Select **Grounding with Bing Search**
4. Click **Create connection**
5. Click **Add connection**
6. Click **Next**
7. Leave the optional parameters as **default**
8. It will automaticlly save your agent

> 💡 **What happens when you add Bing Grounding?**
> 
> Your agent can now:
> - Search the web for current information
> - Access recent news articles and publications
> - Provide citations with links to sources
> - Answer questions about recent events and trends

---

### Step 5: Test Your Agent in the Playground

1. After creating the agent, click **Try in Playground**
2. Ensure `Agent-health-bing` is selected
3. Test with the following prompts:

---

## Test Questions

### Test 1: Workout Trends 🏋️

**User Prompt:**
```
What are some new HIIT workout trends I should know about?
```

**Expected Behavior:**
- Agent searches Bing for current HIIT trends
- Provides recent workout trends and techniques
- Includes source citations/links
- Adds health disclaimer

---

### Test 2: WHO Recommendations 🏥

**User Prompt:**
```
What's the current WHO recommendation for sugar intake?
```

**Expected Behavior:**
- Agent searches for official WHO guidelines
- Provides current recommendations (typically <10% of daily energy intake)
- Cites WHO or reputable health sources
- Encourages consulting healthcare professionals

---

### Test 3: Intermittent Fasting News 📰

**User Prompt:**
```
Any news on intermittent fasting for weight management?
```

**Expected Behavior:**
- Agent searches for recent studies and news
- Provides current research findings
- Includes links to articles or studies
- Reminds user to consult professionals before starting any diet

---

## Validation Checklist

After testing, verify that your agent:

- [ ] Successfully searches the web using Bing
- [ ] Provides current, up-to-date information
- [ ] Includes source citations and links
- [ ] Adds health disclaimers in responses
- [ ] Encourages professional consultation

---

## Comparing Knowledge Sources

| Feature | File Search | Bing Grounding |
|---------|-------------|----------------|
| **Data Source** | Your uploaded documents | Live web search |
| **Information** | Static, controlled content | Real-time, current data |
| **Citations** | References your files | Links to web sources |
| **Best For** | Internal docs, policies | Current news, trends, research |

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Bing connection fails | Verify your subscription supports Bing Search |
| No search results | Try rephrasing the question |
| Outdated information | Ask specifically for "recent" or "latest" |
| Missing citations | Ask: "Please include your sources" |

---

## Summary

Congratulations! 🎉 You have successfully:

1. ✅ Created a Bing Grounding agent (`Agent-health-bing`)
2. ✅ Connected the agent to Bing Search
3. ✅ Tested real-time web search capabilities
4. ✅ Received current health information with citations

---

## Key Concepts Learned

| Concept | Description |
|---------|-------------|
| **Bing Grounding** | Enables real-time web search for agents |
| **Real-Time Data** | Access to current news, trends, and research |
| **Source Citations** | Links to original web sources for verification |

---

## Next Steps

- Continue to the next lab to learn how to connect your agent to **Azure AI Search** for enterprise search capabilities.
---

## Additional Resources

- [Bing Search](https://learn.microsoft.com/en-us/azure/ai-foundry/agents/how-to/tools-classic/bing-custom-search-samples?view=foundry-classic&pivots=portal)
