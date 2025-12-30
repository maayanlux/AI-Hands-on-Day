# Lab 1: Microsoft Foundry Infrastructure

## Description

This lab covers the setup and configuration of the Microsoft Foundry infrastructure. You will create the necessary resources to start building AI applications, including a Microsoft AI Foundry Resource, a Project, and deploying a GPT-4o model.

📚 **Reference:** [Quickstart: Set up your first Foundry resource](https://learn.microsoft.com/azure/ai-studio/quickstarts/get-started-portal)

---

## Prerequisites

- [ ] An active Azure Subscription
- [ ] Owner or Contributor role on the subscription (or Resource Group) to create resources
- [ ] User Access Administrator or Owner role to assign permissions (RBAC)

---

## Steps

### Step 1: Create a Resource Group

1. Sign in to the [Azure Portal](https://portal.azure.com)
2. Search for **Resource groups** and select it
3. Click **+ Create**
4. Enter the following details:

| Setting | Value |
|---------|-------|
| **Subscription** | Select your subscription |
| **Resource group** | Enter a name (e.g., `rg-ai-foundry-lab`) |
| **Region** | Select a region (e.g., `East US 2` or `Sweden Central` where GPT-4o is available) |

5. Click **Review + create** and then **Create**

---

### Step 2: Create a Microsoft AI Foundry Resource and Project

1. In the Azure Portal, search for **Microsoft AI Foundry**
2. Click **+ Create**
3. Fill in the details:

| Setting | Value |
|---------|-------|
| **Subscription** | Select your subscription |
| **Resource group** | Select the group created in Step 1 (`rg-ai-foundry-lab`) |
| **Name** | Enter a unique name for your Foundry resource (e.g., `ai-foundry-lab`) |
| **Region** | Ensure it matches your Resource Group region |
| **Pricing tier** | Standard (S0) |
| **Your first project** | Enter a unique name for your Foundry Project (e.g., `ai-project-lab`) |

4. Click **Review + create** and then **Create**
5. Wait for the deployment to complete

---

### Step 3: Assign Permissions (RBAC)

1. Go back to your **Resource Group** in the Azure Portal
2. Select **Access control (IAM)**
3. Click **+ Add** → **Add role assignment**
4. Search for and select one of the following roles:
   - `Azure AI Developer`
   - `Azure AI User`
   - `Azure AI Project Manager`
   - `Azure AI Owner` (for full access)
5. Click **Next**
6. Click **+ Select members** and select your user account
7. Click **Select**, then **Review + assign**

---

### Step 4: Deploy GPT-4o Model

1. Return to the [Microsoft Foundry portal](https://ai.azure.com) and open your project
2. In the left navigation pane, under **My assets**, select **Models + endpoints**
3. Click on **Model deployments**
4. Click on **Deploy base model**
5. Search for `gpt-4o`
6. Select the **gpt-4o** card
7. Click **Deploy** → **Deploy to project**
8. Configure the deployment:

| Setting | Value |
|---------|-------|
| **Deployment name** | `gpt-4o` (or keep default) |
| **Model version** | Select the latest available version (e.g., `2024-05-13`) |
| **Deployment type** | Standard |
| **Tokens per Minute Rate Limit (thousands)** | Adjust as needed (e.g., `10k`) |

9. Click **Deploy**
10. Once deployed, you will be redirected to the deployment details page
11. 📝 **Note the Target URI and Key** for future labs

---

## Verification

1. Go to the **Playground** in the left menu (under **Build**)
2. Ensure your `gpt-4o` deployment is selected in the **Deployment** dropdown
3. Type a message in the chat window:
   ```
   Hello, are you ready for the workshop?
   ```
4. ✅ Verify that the model responds

---

## Summary

Congratulations! 🎉 You have successfully:

- ✅ Created an Azure Resource Group
- ✅ Created a Microsoft AI Foundry Resource
- ✅ Created a Foundry Project
- ✅ Assigned appropriate RBAC permissions
- ✅ Deployed the GPT-4o model
- ✅ Verified the deployment in the Playground

---

## Next Steps

Proceed to **Lab 2: AI Agents** to start building intelligent agents using your deployed model.
