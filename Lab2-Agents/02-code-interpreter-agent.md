# Lab 2.2: Code Interpreter Agent - Health Calculator

## What is Code Interpreter?

**Code Interpreter** is a powerful tool that enables AI agents to write and execute Python code in a secure, sandboxed environment. This capability transforms your agent from a text-only assistant into a computational powerhouse.

### Key Capabilities:
- 📊 **Data Analysis** - Process and analyze CSV, Excel, and other data files
- 📈 **Visualization** - Create charts, graphs, and plots using Python libraries
- 🔢 **Calculations** - Perform complex mathematical computations
- 📁 **File Processing** - Read, transform, and generate files

When you enable Code Interpreter, your agent can receive files, run Python code to process them, and return results including generated visualizations—all within a secure execution environment.

---

## Prerequisites

Before starting this lab, ensure you have completed the following:

### 1. Azure AI Foundry Setup
- [ ] Azure subscription with access to Azure AI Foundry
- [ ] Azure AI Foundry project created
- [ ] GPT-4o model deployed in your project
- [ ] Required Permissions

### 2. Required Files
- [ ] Download the `nutrition_data.csv` sample file (or create one with the format below)

### Sample nutrition_data.csv Format:
```csv
Date,Calories,Protein_g,Carbs_g,Fat_g,Fiber_g
2025-01-01,2100,85,250,70,28
2025-01-02,1850,78,220,65,25
2025-01-03,2200,90,260,75,30
2025-01-04,1950,82,230,68,27
2025-01-05,2050,88,245,72,29
```

## Lab Instructions

### Step 1: Navigate to Agents

1. In Azure AI Foundry portal, select your **Project**
2. In the left navigation pane, click on **Agents** under the "Build and customize" section
3. Click **+ New agent** to create a new agent

---

### Step 2: Create the Health Calculator Agent

Configure your agent with the following settings:

#### Agent Configuration

| Setting | Value |
|---------|-------|
| **Agent Name** | `Agent-health-calculator` |
| **Model** | `gpt-4o` |

#### Instructions

Copy and paste the following instructions into the agent's instruction field:

```
You are a health calculator agent that can:
1. Calculate and interpret BMI using the formula: BMI = weight(kg) / height(m)²
2. Analyze provided nutrition data from CSV files that are attached to messages
3. Generate charts and plots for data visualization
4. Always include disclaimers that you are not a medical professional and cannot provide medical advice
5. Use code interpreter to perform calculations and create visualizations

When working with uploaded files:
- Files will be attached to individual messages for you to analyze
- You can access them directly using pandas or other Python libraries in code interpreter
- Look for CSV files containing nutrition data with columns: Date, Calories, Protein_g, Carbs_g, Fat_g, Fiber_g

When providing health information, always remind users that:
- This is for educational purposes only
- They should consult healthcare professionals for medical advice
- Individual health needs vary significantly
```

---

### Step 3: Enable Code Interpreter

This is the key step that differentiates this agent from the basic agent!

1. After entering the agent name, model, and instructions
2. Scroll down to the **Actions** section
3. Find and **enable** the **Code Interpreter** toggle/checkbox
4. Click **Add files** or **Upload** in the Code Interpreter section
5. Upload the `nutrition_data.csv` file
6. Click **Create** to save your agent

> 💡 **Tip:** The uploaded file will be available to the agent for all conversations. Users can also attach additional files in individual messages.

---

### Step 4: Test Your Agent in the Playground

Once your agent is created, test its code interpreter capabilities!

1. After creating the agent, click **Try in Playground** or navigate to the **Playground** section
2. Ensure your `Agent-health-calculator` is selected
3. Test with the following comprehensive prompt:

---

## Test Question: BMI Calculation with Visualization 📊

**User Prompt:**
```
Hi, I'd like to check my BMI. My weight is 50 kg and my height is 158 cm

Could you please:
1. Calculate my BMI using Python and show me the steps you took?
2. Tell me which category I fall into (underweight, normal, overweight, or obese)?
3. Create a quick chart showing where I sit on the BMI scale?

Don't forget to include the necessary health disclaimers.
```

---

## Expected Behavior

When you submit this prompt, the agent should:

### 1. Execute Python Code
The agent will write and run Python code similar to:
```python
# BMI Calculation
weight_kg = 50
height_m = 158 / 100  # Convert cm to meters

bmi = weight_kg / (height_m ** 2)
print(f"BMI: {bmi:.2f}")
```

### 2. Categorize the BMI
Based on WHO standards:
| BMI Range | Category |
|-----------|----------|
| < 18.5 | Underweight |
| 18.5 - 24.9 | Normal weight |
| 25.0 - 29.9 | Overweight |
| ≥ 30.0 | Obese |

### 3. Generate a Visualization
The agent will create a chart (using matplotlib or similar) showing:
- The BMI scale with category ranges
- A marker indicating where your BMI falls
- Color-coded zones for each category

### 4. Include Disclaimers
The response should include:
- ⚠️ Statement that this is for educational purposes only
- 👨‍⚕️ Recommendation to consult healthcare professionals
- 📋 Note that individual health needs vary

---

## Additional Test: Nutrition Data Analysis

Try this follow-up prompt to test file analysis capabilities:

**User Prompt:**
```
Can you analyze the nutrition data file and:
1. Show me a summary of my daily calorie intake
2. Create a line chart of calories over time
3. Calculate my average protein, carbs, and fat intake
```

**Expected Behavior:**
- Agent reads the uploaded CSV file
- Generates statistical summary
- Creates visualization of the data
- Provides insights about nutrition patterns

---

## Validation Checklist

After testing, verify that your agent:

- [ ] Successfully executes Python code
- [ ] Correctly calculates BMI (50kg, 158cm → BMI ≈ 20.03)
- [ ] Accurately categorizes BMI result
- [ ] Generates visual charts/graphs
- [ ] Can read and analyze uploaded CSV files
- [ ] Includes appropriate health disclaimers
- [ ] Shows the code execution steps

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Code Interpreter not available | Ensure it's enabled in the Actions section |
| File upload fails | Check file size limits and format |
| Charts not displaying | Verify matplotlib/plotting code execution |
| "Cannot access file" error | Ensure file was uploaded to Code Interpreter, not just chat |
| Calculations seem wrong | Ask agent to show step-by-step code |

---

## Summary

Congratulations! 🎉 You have successfully:

1. ✅ Learned what Code Interpreter is and its capabilities
2. ✅ Created an AI Agent with Code Interpreter enabled (`Agent-health-calculator`)
3. ✅ Uploaded data files for agent analysis
4. ✅ Tested BMI calculations with Python code execution
5. ✅ Generated visualizations using the agent

---

## Key Differences from Basic Agent

| Feature | Basic Agent | Code Interpreter Agent |
|---------|-------------|------------------------|
| Text responses | ✅ | ✅ |
| Execute Python code | ❌ | ✅ |
| Process uploaded files | ❌ | ✅ |
| Generate charts/graphs | ❌ | ✅ |
| Perform calculations | Text-based only | Actual computation |

---

## Next Steps

- Proceed to the next lab to learn about Function Calling
- Explore uploading different file types (Excel, JSON)
- Create more complex data analysis workflows

---

## Additional Resources

- [Code Interpreter Documentation](https://learn.microsoft.com/en-us/azure/ai-foundry/agents/how-to/tools-classic/code-interpreter?view=foundry-classic&pivots=python)

