# Lab 6: Building a Multi-Agent K8s Release Monitor

In this lab, you will orchestrate specialized AI agents to automate the monitoring of Kubernetes releases.

## 🌟 Overview

The workflow consists of:
1.  **🔍 Agent-K8s-Release-Checker**: Finds the latest K8s version using Bing Search.
2.  **📝 Agent-K8s-Change-Summarizer**: Summarizes breaking changes and features from the release notes.
3.  **✏️ Agent-Edit-Yaml**: Updates an existing `k8s.yaml` file with the new version.
4.  **❓ Ask a Question**: Prompts the user for approval with an **interactive human-in-the-loop step** where the user can approve or reject the changes.
5.  **📧 Agent-Upgrade-Notification**: Sends an email notification via Logic App based on user response.

## ✅ Prerequisites

Before starting this lab, ensure you have completed the following:
- [ ] Azure subscription with access to Azure AI Foundry
- [ ] Azure AI Foundry project created
- [ ] GPT-4o model deployed in your project
- [ ] Azure Logic App (From Lab3)
- [ ] Bing Search Connection (From Lab2)

## 📂 Step 1: Setup Files

1.  Navigate to the `Lab6-NEW-AI-Foundry-Workflow/data` folder.
2.  You will use the text content of `send-email.json` for the Logic App.
3.  You will use `schema.json` for the Custom Tool definition.
4.  You will use `k8s.zip` (containing `k8s.yaml`) for the Code Interpreter.

## ⚙️ Step 2: Configure Logic App (Email Service)

1.  Go to your existing **Logic App** in the Azure Portal.
2.  Create a new statful Workflow named **Send_an_email**.
3.  In the **Designer** view, click **Add a trigger** and search for **"When an email arrives"** (Outlook connector).
4.  Select the action to create the Outlook connection. You may need to authorize with your Microsoft account. If you don't have one, create one for free at [https://account.microsoft.com/account](https://account.microsoft.com/account).
5.  **Save** the workflow to establish the connection.
6.  Now switch to **Code View**.
7.  Replace the entire content with the JSON found in `data/send-email.json`.
8.  **Save** the workflow.
9.  Go back to the **Designer** view and verify the **Connections** are still authorized.
10. Go to the **Request** action to get the **HTTP URL**. You will need the **Signature (sig)** from it for the next step.


## 🤖 Step 3: Create the Multi-Agent Workflow

1.  Log in to the **Foundry Portal** and switch to the **New Foundry** experience.
2.  Navigate to **Build** and then **Agents**.
3.  Create the agents as follows:

### 🔍 Agent 1: Checker
*   **Description**: Queries the internet to identify the most recent stable release of Kubernetes.
*   **Name**: `Agent-K8s-Release-Checker`
*   **Model**: `gpt-4o`
*   **Tools**: Connect your existing **Grounding with Bing Search** connection.
*   **Instructions**:
    ```text
    You are a technical data extractor. Your ONLY job is to find the latest stable Kubernetes release info.

    Instructions:
    Search for the latest release at https://kubernetes.io/releases/

    Output the result ONLY as a raw JSON object.

    DO NOT use markdown backticks (e.g., no ```json).

    DO NOT include any introductory or concluding text.

    Required JSON Format: {"version": "1.30.1", "releaseDate": "2024-06-18", "url": "https://kubernetes.io/releases/"}
    ```

### 📝 Agent 2: Summarizer
*   **Description**: Analyzes release notes to highlight key changes, security updates, and operational impacts.
*   **Name**: `Agent-K8s-Change-Summarizer`
*   **Model**: `gpt-4o`
*   **Instructions**:
    ```text
    You are a Kubernetes Expert. You will receive a raw JSON string from a previous step.

    Your Task:

    Read the 'version' and 'url' from the JSON.

    Search for the release notes at that URL.

    Provide a summary for IT admins focusing on: Breaking changes, Security, and Operational impact.

    End your response with the exact line: 'VERSION_FOR_DEVOPS: [version number]
    Focus on:
    - Breaking changes
    - Security improvements
    - Operational impact

    Limit to 5 bullet points.
    ```

### ✏️ Agent 3: YAML Editor
*   **Description**: Modifies YAML file to apply the new version.
*   **Name**: `Agent-Edit-Yaml`
*   **Model**: `gpt-4o`
*   **Tools**: Enable **Code Interpreter**.
*   **Files**: Upload `data/k8s.zip`.
*   **Instructions**:
    ```text
    You are a Kubernetes Automation Specialist.
    STEP 1: Use the Code Interpreter to unzip the file in /mnt/data/
    STEP 2: Locate k8s.yaml inside the extracted contents. 
    STEP 3: Write a Python script to:
            Take the existing YAML content.
            Load the k8s.yaml into a Python dictionary.
            Metadata Update: Update metadata.labels.version to the new version provided.
            Spec Update: Update spec.template.metadata.labels.version (for the Pod template) to the same version.
            Image Update: Update all container image tags to the new version.
            Validation: Ensure the top-level apiVersion remains a valid Kubernetes API (like apps/v1) and is not overwritten by the application version.     
            Print the result.

    STEP 4: Display the final updated YAML in a markdown code block.
    show me the updated YAML directly.
    ```

### 📧 Agent 4: Notification Sender
*   **Description**: Formats and sends email notifications via Logic App for release approval.
*   **Name**: `Agent-Upgrade-Notification`
*   **Model**: `gpt-4o`
*   **Tools**: Click **+ Add a new tool** -> **Custom** -> **OpenAPI tool**.
    *   **Name**: `k8sEmailCustom`
    *   **Authentication**: Anonymous
    *   **Schema**: Copy content from `data/schema.json`.
        *   **Modify**: Update `servers.url` (Line 9) with your Logic App URL domain (e.g., `https://prod-23.eastus.logic.azure.com`).
        *   **Modify**: Update the default `sig` value (Line 50) with your Logic App Signature.
*   **Instructions**:
    ```text
    You are an IT Automation Assistant. Your primary goal is to send a Kubernetes upgrade notification using the k8ssendEmail tool.

    Step 1: Process Input Receive the Kubernetes release summary. Identify the version number and the summary text.

    Step 2: Mandatory Tool Call You MUST execute the Send_an_email_V2 action from the k8ssendEmail tool. Do not just describe the email; trigger the tool.

    Step 3: Tool Parameters

    To: "your-email@example.com" (or a placeholder).

    Subject: "Kubernetes Upgrade Notice – Version [Insert Version Here]"

    Body: Format the summary as professional HTML. Include a brief intro, the bullet points of changes, and a recommendation to review before upgrading.

    You have access to a tool named Send_an_email_V2. When you have the email details, call this tool immediately."

    Do not ask for user approval; this action is pre-authorized for the upgrade notification task
    ```

> 📝 **Important**: Edit the instructions and replace `"your-email@example.com"` with the actual email address you used for your Outlook connection.

## 📘 Workflow Variables Dictionary

Before building the workflow, understand these key concepts:

| Variable Type | Variable Name | Description |
|--------------|---------------|-------------|
| **System** | `System.ConversationId` | Built-in variable that maintains conversation context across agents |
| **System** | `System.LastMessage` | Built-in variable that save last message in the conversation (use as input) |
| **Local** | `Local.LatestMessage` | Custom variable to store agent output **messages** (object type) |
| **Local** | `Local.ChangeSummary` | Custom variable to store **text** output (string type) |
| **Local** | `Local.UserResponse` | Custom variable to stores the user's approval/rejection response |

### ⚠️ Important Notes

#### **Conversation Context**
Always add `System.ConversationId` to maintain conversation context across agents.

#### **Input vs Message**
- Use **`message`** when it is part of conversational context — it becomes part of the agent's chat history
- Use **`input`** when it is data or parameters you give the agent to work with

**Ask yourself:** *"Is this something the agent should remember as a conversation?"*
- **Yes** → Use `message`
- **No, it's just data** → Use `input`

#### **YAML View Required**
Some configurations (like saving output as `text:` instead of `message`) are **NOT** supported in the visual designer and **MUST** be configured in YAML view.

---

## 🔄 Step 4: Orchestrate the Workflow

1.  Navigate to **Workflows** in the Foundry portal.
2.  Click **Create** -> **Blank Workflow**.
3.  Design the flow as follows:

    ```mermaid
    graph TD
    Start --> A[Agent-K8s-Release-Checker]
    A --> B[Agent-K8s-Change-Summarizer]
    B --> C[Agent-Edit-Yaml]
    C --> E[Ask a Question]
    E --> F{If/Else Condition}
    F -- Approve --> G[Agent-Upgrade-Notification]
    G --> End
    F -- Reject --> J[Agent-Upgrade-Notification]
    J --> End
    ```

### Step-by-Step Workflow Configuration

#### 🔹 Step 1: Agent-K8s-Release-Checker
*   **Action**: Add Agent
*   **Agent**: Select `Agent-K8s-Release-Checker`
*   **Configuration**:
    *   **Conversation context**: Add `System.ConversationId`
    *   **Input message**: `System.LastMessage`
    *   **Save agent output as**: `Local.LatestMessage`

#### 🔹 Step 2: Agent-K8s-Change-Summarizer
*   **Action**: Add Agent
*   **Agent**: Select `Agent-K8s-Change-Summarizer`
*   **Configuration**:
    *   **Conversation context**: Add `System.ConversationId`
    *   **Input message**: `Local.LatestMessage`
    *   **Save agent output as**: `Local.ChangeSummary`
    *   ⚠️ **YAML View Required**: Switch to YAML view and change the output from `message: Local.ChangeSummary` to `text: Local.ChangeSummary` (we need text, not a message object)

#### 🔹 Step 3: Agent-Edit-Yaml
*   **Action**: Add Agent
*   **Agent**: Select `Agent-Edit-Yaml`
*   **Configuration**:
    *   **Conversation context**: Add `System.ConversationId`
    *   **Input message**: `"The new release is: " & Local.ChangeSummary & ". Extract k8s.zip and update the yaml."`
    *   **Save agent output as**: `Local.LatestMessage`

#### 🔹 Step 4: Ask a Question
*   **Action**: Add "Ask a Question"
*   **Configuration**:
    *   **Question text**: `"I have updated the YAML to the new version. Please review the code below. Reply 'Approve' to proceed or 'Reject' to cancel."`
    *   **Expected input type**: String
    *   **Save user response as**: `Local.UserResponse`

#### 🔹 Step 5: If/Else Condition
*   **Action**: Add "If/Else" condition
*   **Configuration**:
    *   **Condition**: `Lower(Local.UserResponse) = "approve"`

##### ✅ **If Branch (Approve)**

**5a. Agent-Upgrade-Notification (Approve)**
*   **Action**: Add Agent
*   **Agent**: Select `Agent-Upgrade-Notification`
*   **Configuration**:
    *   **Conversation context**: Add `System.ConversationId`
    *   **Input message**: `"Please send an email that includes BOTH the Release Summary and the full updated YAML code: " & Local.ChangeSummary`
    *   **Save agent output as**: `Local.LatestMessage`


##### ❌ **Else Branch (Reject)**

**5b. Agent-Upgrade-Notification (Reject)**
*   **Action**: Add Agent
*   **Agent**: Select `Agent-Upgrade-Notification`
*   **Configuration**:
    *   **Conversation context**: Add `System.ConversationId`
    *   **Input message**: `"User rejected the upgrade. Release Summary: " & Local.ChangeSummary`
    *   **Save agent output as**: `Local.LatestMessage`

---

> 💡 **Reference**: You can review the complete workflow configuration in `data/workflow.yaml` as a reference for the YAML structure and settings.

4.  **Save** and click on **Preview** the workflow.

## Test Your Workflow

**User Prompt:**
```
What are the updates in the new Kubernetes release?
```

> 💡 When prompted with the approval question, respond with either "Approve" or "Reject" to test both branches.

---

## Summary

Congratulations! 🎉 You have successfully:

1. ✅ Created an orchestrated multi-agent workflow in Azure AI Foundry
2. ✅ Implemented conditional logic with approval gates
3. ✅ Created a Logic App email workflow with OpenAPI schema
4. ✅ Built specialized AI agents for Kubernetes release monitoring
5. ✅ Configured Bing Search integration for version detection
6. ✅ Implemented Code Interpreter for YAML manipulation

---

## Key Concepts Learned

| Concept | Description |
|---------|-------------|
| **Multi-Agent Workflows** | Orchestrating multiple specialized agents in a sequential workflow with conditional branching |
| **Workflow Variables** | Using System and Local variables to pass data between workflow steps |
| **Conversation Context** | Maintaining agent memory and context across workflow steps using `System.ConversationId` |
| **Conditional Logic** | Implementing approval gates and decision branches with If/Else conditions |
| **Ask a Question Action** | Adding human-in-the-loop approval steps within automated workflows |
| **Custom Tools Integration** | Extending workflows with external services via OpenAPI specifications (Logic Apps) |
| **Code Interpreter** | Leveraging Python execution for file manipulation and data processing within workflows |
| **Bing Search Grounding** | Real-time web data retrieval for up-to-date information in workflows |

> 💡 **Tip: Extend Your Workflows Further**  
> - **DevOps Integration**: Connect workflows to Azure DevOps, GitHub Actions, and other CI/CD pipelines for automated deployments
> - **MCP Extensibility**: Integrate MCP servers to add custom functionality and external data sources
> - **Foundry IQ**: Use Azure AI Foundry IQ as intelligent knowledge layer

---

## Additional Resources

- [Azure AI Foundry Workflows Documentation](https://learn.microsoft.com/en-us/azure/ai-foundry/agents/concepts/workflow?view=foundry)
- [Foundry IQ](https://techcommunity.microsoft.com/blog/azure-ai-foundry-blog/foundry-iq-unlocking-ubiquitous-knowledge-for-agents/4470812)
