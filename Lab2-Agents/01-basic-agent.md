# Lab 2.1: Basic AI Agent - Fun Fit Health Advisor

## Overview
In this lab, you will create your first AI Agent using Azure AI Foundry. This agent will act as a friendly health and fitness advisor, providing general wellness guidance while maintaining appropriate medical disclaimers.

---

## Prerequisites

Before starting this lab, ensure you have completed the following:

### 1. Azure AI Foundry Setup
- [ ] Azure subscription with access to Azure AI Foundry
- [ ] Azure AI Foundry hub created
- [ ] Azure AI Foundry project created within the hub
- [ ] GPT-4o model deployed in your project

### 2. Required Permissions
- [ ] Contributor or Owner role on the Azure AI Foundry resource
- [ ] Access to create and manage AI agents

### 3. Access Azure AI Foundry Portal
1. Navigate to [Azure AI Foundry](https://ai.azure.com)
2. Sign in with your Azure credentials
3. Select your project from the dashboard

---

## Lab Instructions

### Step 1: Navigate to Agents

1. In Azure AI Foundry portal, select your **Project**
2. In the left navigation pane, click on **Agents** under the "Build and customize" section
3. Click **+ New agent** to create a new agent

---

### Step 2: Create the Health Advisor Agent

Configure your agent with the following settings:

#### Agent Configuration

| Setting | Value |
|---------|-------|
| **Agent Name** | `Agent-fun-fit-health-advisor` |
| **Model** | `gpt-4o` |

#### Instructions

Copy and paste the following instructions into the agent's instruction field:

```
You are a friendly AI Health Advisor.
You provide general health, fitness, and nutrition information, but always:
1. Include medical disclaimers.
2. Encourage the user to consult healthcare professionals.
3. Provide general, non-diagnostic advice around wellness, diet, and fitness.
4. Clearly remind them you're not a doctor.
5. Encourage safe and balanced approaches to exercise and nutrition.
```

#### Steps to Create:
1. Enter the **Agent Name**: `Agent-fun-fit-health-advisor`
2. Select the **Model**: `gpt-4o` from the dropdown
3. Paste the **Instructions** in the instructions text box
4. Click **Create** to save your agent

---

### Step 3: Test Your Agent in the Playground

Once your agent is created, it's time to test it! Use the built-in Playground to interact with your agent.

1. After creating the agent, click **Try in Playground** or navigate to the **Playground** section
2. Ensure your `Agent-fun-fit-health-advisor` is selected
3. Test with the following example questions:

---

## Test Questions

### Test 1: Workout Advice 💪

**User Prompt:**
```
What's a good 30-minute workout routine for a beginner who wants to build strength?
```

**Expected Behavior:**
- Agent provides a beginner-friendly workout routine
- Includes warm-up and cool-down recommendations
- Reminds user to consult a healthcare professional
- Includes medical disclaimer

---

### Test 2: Nutrition Advice 🥗

**User Prompt:**
```
What should I eat before and after a workout for optimal performance?
```

**Expected Behavior:**
- Agent provides general nutrition guidance
- Suggests pre-workout and post-workout meal ideas
- Emphasizes balanced nutrition approach
- Includes disclaimer about individual dietary needs

---

### Test 3: Goal Setting 🎯

**User Prompt:**
```
How can I set realistic fitness goals for someone who wants to lose 20 pounds safely?
```

**Expected Behavior:**
- Agent provides guidance on realistic goal setting
- Mentions safe weight loss rates (1-2 lbs per week)
- Encourages consulting healthcare professionals
- Emphasizes sustainable approaches

---

### Test 4: Complex Health Question 🏥

**User Prompt:**
```
I'm a 35-year-old office worker who sits most of the day. I want to start exercising but I have limited time (only 20 minutes, 3 times per week). What would you recommend for someone with back pain from sitting too long?
```

**Expected Behavior:**
- Agent acknowledges the complexity of the situation
- Provides time-efficient exercise suggestions
- Addresses back pain concerns with general guidance
- **Strongly recommends** consulting a healthcare professional or physical therapist for the back pain
- Includes clear medical disclaimer
- Suggests ergonomic considerations for office work

---

## Validation Checklist

After testing, verify that your agent:

- [ ] Responds with helpful health and fitness information
- [ ] Includes medical disclaimers in responses
- [ ] Encourages users to consult healthcare professionals
- [ ] Reminds users it's not a doctor
- [ ] Provides balanced and safe advice
- [ ] Handles complex questions appropriately

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Agent not responding | Verify the model deployment is active |
| Model not available | Check that GPT-4o is deployed in your project |
| Unexpected responses | Review and update the agent instructions |
| Permission errors | Verify your role assignments in Azure |

---

## Summary

Congratulations! 🎉 You have successfully:

1. ✅ Set up the Azure AI Foundry prerequisites
2. ✅ Created your first AI Agent (`Agent-fun-fit-health-advisor`)
3. ✅ Configured the agent with appropriate health advisor instructions
4. ✅ Tested the agent with various health and fitness questions

---

## Next Steps

- Proceed to the next lab to learn about adding tools to your agent
- Explore additional agent configurations
- Learn how to integrate agents with external data sources

---

## Additional Resources

- [Azure AI Foundry Documentation](https://learn.microsoft.com/azure/ai-studio/)
- [AI Agents Overview](https://learn.microsoft.com/azure/ai-studio/concepts/agents)
- [Best Practices for AI Agents](https://learn.microsoft.com/azure/ai-studio/how-to/agents)
