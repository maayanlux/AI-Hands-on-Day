# Lab 6: Building a Multi-Agent K8s Release Monitor

In this lab, you will orchestrate specialized AI agents to automate the monitoring of Kubernetes releases.

## 🌟 Overview

The workflow consists of **5 Agents**:
1.  **🔍 Agent-K8s-Release-Checker**: Finds the latest K8s version using Bing Search.
2.  **📝 Agent-K8s-Change-Summarizer**: Summarizes breaking changes and features from the release notes.
3.  **✏️ Agent-Edit-Yaml**: Updates an existing `k8s.yaml` file with the new version.
4.  **📧 Agent-Upgrade-Notification**: Sends an email notification via Logic App.
5.  **💾 Agent-K8s-YAML-Saver**: Uploads the updated YAML to Azure Blob Storage.

## ✅ Prerequisites

Before starting this lab, ensure you have completed the following:
- [ ] Azure subscription with access to Azure AI Foundry
- [ ] Azure AI Foundry project created
- [ ] GPT-4o model deployed in your project
- [ ] Azure Logic App (From Lab3)
- [ ] Storage Account (From Lab2)
- [ ] Bing Search Connection (From Lab2)

## 📂 Step 1: Setup Files

1.  Navigate to the `Lab6-NEW-AI-Foundry-Workflow/data` folder.
2.  You will use the text content of `send-email.json` for the Logic App.
3.  You will use `schema.json` for the Custom Tool definition.
4.  You will use `k8s.zip` (containing `k8s.yaml`) for the Code Interpreter.

## ⚙️ Step 2: Configure Logic App (Email Service)

1.  Go to your existing **Logic App** in the Azure Portal.
2.  Create a new Workflow named **Send_an_email**.
3.  Go to **Designer** -> **Code View**.
4.  Replace the content with the JSON found in `data/send-email.json`.
5.  **Save** the workflow.
6.  Go to the **Designer** view. You may need to authorize the **Outlook** connection with your Microsoft account. If you don't have one, create one for free at [https://account.microsoft.com/account](https://account.microsoft.com/account).
7.  
> ⚠️ **Important:**
> Run the workflow once or go to the "Overview" to get the **HTTP POST URL**. You will need the **URL endpoint** and the **Signature (sig)** from it for the next step.

## 🤖 Step 3: Create the Multi-Agent Workflow

1.  Log in to the **Foundry Portal** and switch to the "New Foundry" experience.
2.  Navigate to **Build** -> **Agents**.
3.  Create the agents as follows:

### 🔍 Agent 1: Checker
*   **Description**: Queries the internet to identify the most recent stable release of Kubernetes.
*   **Name**: `Agent-K8s-Release-Checker`
*   **Model**: `gpt-4o`
*   **Tools**: Connect your existing "Grounding with Bing Search" connection.
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
*   **Description**: Modifies infrastructure-as-code files to apply the new version and checks validity.
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

### 💾 Agent 5: YAML Saver
*   **Description**: Securely uploads the updated YAML configuration to Azure Blob Storage.
*   **Name**: `Agent-K8s-YAML-Saver`
*   **Model**: `gpt-4o`
*   **Tools**: Enable **Code Interpreter**.
*   **Instructions**:
    ```text
    You are a Cloud Automation Agent.

    Your task is to upload YAML content to Azure Blob Storage using an HTTP PUT request with a SAS URL.

    Steps:
    1. Extract the SAS URL from the message.
    2. Extract the YAML content from the message.
    3. Use Python with the requests library (no Azure SDKs).
    4. Perform an HTTP PUT to the SAS URL + "/deployment-updated.yaml".
    5. Set header:
       Content-Type: application/x-yaml
       x-ms-blob-type: BlockBlob
    6. Upload the content.
    7. Confirm success if status code is 201 or 200.

    Do NOT use azure-storage-blob.
    Do NOT ask for user input.
    Execute the upload immediately.
    ```

## 🔄 Step 4: Orchestrate the Workflow

1.  Navigate to **Workflows** in the Foundry portal.
2.  Click **Create** -> **Blank Workflow**.
3.  Design the flow as follows:

    ```mermaid
    graph TD
    Start --> A[Agent-K8s-Release-Checker]
    A --> B[Agent-K8s-Change-Summarizer]
    B --> C[Agent-Edit-Yaml]
    C --> D[Set Variable]
    D --> E[Ask a Question]
    E --> F{If/Else Condition}
    F -- Approve --> G[Agent-Upgrade-Notification]
    G --> H[Set Variable]
    H --> I[Agent-K8s-YAML-Saver]
    I --> End
    F -- Reject --> J[Agent-Upgrade-Notification]
    J --> K[End]
    ```

    *   **Start** connects to **Release Checker**.
    *   **Release Checker** passes JSON to **Summarizer**.
    *   **Summarizer** passes summary to **Edit Yaml**.
    *   **Edit Yaml** generates new content.
    *   **Ask a Question**: Prompt user to approve the change.
    *   **If/Else condition**: Check if response contains "approve".
    *   **If True**:
        *   Send Notification.
        *   Save YAML to Storage.
    *   **If False**:
        *   Send Notification only.

4.  **Save** and **Run** the workflow.

---

## Summary

Congratulations! 🎉 You have successfully:

1. ✅ Created a Logic App email workflow with OpenAPI schema
2. ✅ Built 5 specialized AI agents for Kubernetes release monitoring
3. ✅ Configured Bing Search integration for version detection
4. ✅ Implemented Code Interpreter for YAML manipulation
5. ✅ Connected custom tools via OpenAPI to trigger Logic Apps
6. ✅ Orchestrated a multi-step workflow with conditional logic
7. ✅ Integrated Azure Blob Storage for artifact management

---

## Key Concepts Learned

| Concept | Description |
|---------|-------------|
| **Multi-Agent Orchestration** | Coordinating multiple specialized agents in a workflow |
| **Custom Tools (OpenAPI)** | Extending agent capabilities with external services |
| **Code Interpreter** | Using Python execution for data manipulation and API calls |
| **Bing Search Grounding** | Real-time web data retrieval for up-to-date information |
| **Conditional Workflows** | Implementing approval gates and decision branches |
| **Azure Integration** | Connecting Logic Apps, Blob Storage, and AI Foundry |

---

## Real-World Applications

This lab demonstrates patterns applicable to:

- 🔄 **DevOps Automation**: Monitoring infrastructure updates and triggering deployments
- 📊 **Compliance Auditing**: Tracking version changes and generating reports
- 🔔 **Alert Systems**: Notifying teams about critical updates with contextual information
- 📝 **Documentation Generation**: Automatically updating configuration files
- 🔐 **Security Patching**: Identifying and applying security updates across environments

---

## Next Steps

- Add a **Sentiment Analysis Agent** to assess the impact of breaking changes
- Implement **Azure DevOps Pipeline Integration** to auto-deploy approved changes
- Create a **Rollback Agent** that can revert changes if issues are detected
- Build a **Monitoring Dashboard** using Power BI to track K8s version history
- Explore **Azure Functions** as an alternative to Logic Apps for lightweight automation

---

## Additional Resources

- [Azure AI Foundry Multi-Agent Patterns](https://learn.microsoft.com/en-us/training/modules/develop-multi-agent-azure-ai-foundry/)
- [OpenAPI Specification for Custom Tools](https://learn.microsoft.com/en-us/azure/ai-services/openai/how-to/function-calling)
- [Azure Logic Apps Integration](https://learn.microsoft.com/en-us/azure/logic-apps/)
- [Code Interpreter Best Practices](https://learn.microsoft.com/en-us/azure/ai-services/openai/how-to/code-interpreter)
- [Kubernetes Release Documentation](https://kubernetes.io/releases/)
