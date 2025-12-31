# Lab 2.3: File Search Agent - Health Resource Search

## What is File Search?

**File Search** enables AI agents to search through and retrieve information from your uploaded documents. This powerful capability allows your agent to answer questions based on the content of files like PDFs, Word documents, and Markdown files.

### Key Capabilities:
- 📄 **Document Processing** - Automatically chunks and indexes uploaded documents
- 🔍 **Semantic Search** - Find relevant information using natural language queries
- 📚 **Knowledge Base** - Build a searchable repository of your documents
- 🔗 **Citation Support** - Provides references to source documents in responses

---

## Prerequisites

Before starting this lab, ensure you have completed the following:

### 1. Azure AI Foundry Setup
- [ ] Azure subscription with access to Azure AI Foundry
- [ ] Azure AI Foundry project created
- [ ] GPT-4o model deployed in your project
- [ ] Required Permissionst

### 2. Sample Documents
- [ ] `recipes.md` - Located in `Lab2-Agents/sample-data/`
- [ ] `guidelines.md` - Located in `Lab2-Agents/sample-data/`

---

## Lab Instructions

### Step 1: Navigate to Agents

1. Go to [Azure AI Foundry](https://ai.azure.com)
2. Select your **Project**
3. In the left navigation pane, click on **Agents**
4. Click **+ New agent**

---

### Step 2: Create the Health Resource Search Agent

Configure your agent with the following settings:

#### Agent Configuration

| Setting | Value |
|---------|-------|
| **Agent Name** | `Agent-health-search` |
| **Model** | `gpt-4o` |

#### Instructions

Copy and paste the following instructions:

```
You are a health resource advisor with access to dietary and recipe files.
You:
1. Always present disclaimers (you're not a doctor!)
2. Provide references to the files when possible
3. Focus on general nutrition or recipe tips.
4. Encourage professional consultation for more detailed advice.
```

---

### Step 3: Upload Files to Knowledge (Vector Store)

This is the key step that enables your agent to search through documents!

1. In the agent configuration, find the **Knowledge** section
2. Click on **Files**
3. Click **+ Add files** or **Upload**
4. Upload both files:
   - `guidelines.md`
   - `recipes.md`
5. Wait for the files to be processed

> 💡 **What is a Vector Store?**
> 
> When you upload files, AI Foundry automatically creates a **Vector Store** (also called a data store). This is a special database that:
> - Breaks your documents into small chunks
> - Converts each chunk into numerical representations (vectors)
> - Enables fast semantic search to find relevant information
> 
> Think of it as a smart index that helps the agent quickly find the right information from your documents when answering questions.

6. Click **Create** to save your agent

---

### Step 4: Test Your Agent in the Playground

1. After creating the agent, click **Try in Playground**
2. Ensure `Agent-health-search` is selected
3. Test with the following prompts:

---

## Test Questions

### Test 1: Gluten-Free Recipe 🌾

**User Prompt:**
```
Could you suggest a gluten-free lunch recipe?
```

**Expected Behavior:**
- Agent searches the recipes.md file
- Suggests Quinoa Bowl or Rice Pasta with Vegetables
- References the source file
- Includes health disclaimer

---

### Test 2: Heart-Healthy Meals ❤️

**User Prompt:**
```
Show me some heart-healthy meal ideas.
```

**Expected Behavior:**
- Agent finds Heart-Healthy Recipes section
- Suggests Baked Salmon and Mediterranean Bowl
- Provides ingredients and instructions
- Includes disclaimer and encourages professional consultation

---

### Test 3: Diabetes Guidelines 🩺

**User Prompt:**
```
What guidelines do you have for someone with diabetes?
```

**Expected Behavior:**
- Agent searches the guidelines.md file
- Finds Diabetic Diet section
- Mentions monitoring carbohydrate intake and choosing low glycemic foods
- Strongly recommends consulting healthcare professionals
- Includes clear disclaimer

---

## Validation Checklist

After testing, verify that your agent:

- [ ] Successfully searches through uploaded documents
- [ ] Finds relevant recipes from recipes.md
- [ ] Retrieves dietary guidelines from guidelines.md
- [ ] References source files in responses
- [ ] Includes health disclaimers
- [ ] Encourages professional consultation

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Files not appearing | Wait for processing to complete |
| Agent doesn't find content | Verify files were uploaded to Knowledge section |
| No citations in response | Ask specifically: "Please reference the source" |
| Generic responses | Rephrase question to be more specific |

---

## Summary

Congratulations! 🎉 You have successfully:

1. ✅ Created a File Search agent (`Agent-health-search`)
2. ✅ Uploaded documents to create a Vector Store
3. ✅ Learned how Vector Stores enable semantic search
4. ✅ Tested document-grounded responses with recipes and guidelines

---

## Key Concepts Learned

| Concept | Description |
|---------|-------------|
| **File Search** | Enables agents to search uploaded documents |
| **Vector Store** | Automatically created database that indexes your files for fast semantic search |
| **Grounded Responses** | Answers based on actual document content |

---

## Next Steps

- Add more documents to expand your knowledge base
- Explore combining File Search with Code Interpreter
- Try uploading PDF and Word documents

---

## Additional Resources

- [File Search in AI Agents](https://learn.microsoft.com/en-us/azure/ai-foundry/agents/how-to/tools-classic/file-search-upload-files?view=foundry-classic&pivots=portal)
