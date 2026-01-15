# Lab 2.5: Azure AI Search Agent - Fitness Product Search

## What is Azure AI Search?

**Azure AI Search** (formerly Azure Cognitive Search) is a powerful search service that enables sophisticated searching across structured and unstructured data. Unlike simple File Search, AI Search allows you to create custom indexes with defined schemas for precise, filtered, and faceted search experiences.

### Key Capabilities:
- 🔍 **Custom Indexes** - Define exactly how your data should be searched
- 🎯 **Filtered Search** - Search with specific criteria (price ranges, categories)
- 📊 **Faceted Navigation** - Enable drill-down filtering like e-commerce sites
- ⚡ **Fast Performance** - Optimized for large-scale data retrieval

---

## Prerequisites

Before starting this lab, ensure you have completed the following:

### 1. Azure AI Foundry Setup
- [ ] Azure subscription with access to Azure AI Foundry
- [ ] Azure AI Foundry project created
- [ ] GPT-4o model deployed in your project
- [ ] Required Permissionst

### 2. Permissions
- [ ] Contributor or Owner role to create Azure AI Search resource

### 3. Storage Account
- [ ] Storage Account created (if not already existing)

#### Create Storage Account (if needed):

1. Go to the [Azure Portal](https://portal.azure.com)
2. Click **+ Create a resource**
3. Search for **Storage account** and select it
4. Click **Create**
5. Fill in the details:

| Setting | Value |
|---------|-------|
| **Subscription** | Select your subscription |
| **Resource group** | `rg-ai-foundry-lab` |
| **Storage account name** | Enter a unique name (e.g., `stfitnesslabXXXX`) |
| **Region** | Same as your AI Foundry resource |
| **Preferred storage type** | Azure Blob Storage |
| **Primary workload** | Other |
| **Performance** | Standard |
| **Redundancy** | Locally-redundant storage (LRS) |

6. Click **Review + create** and then **Create**
7. Wait for deployment to complete
8. Give yourself the **Storage Blob Data Contributor** permission

---

## Infrastructure Setup

### Step 1: Create Azure AI Search Resource

1. Go to the [Azure Portal](https://portal.azure.com)
2. Click **+ Create a resource**
3. Search for **Azure AI Search**
4. Click **Create**
5. Fill in the details:

| Setting | Value |
|---------|-------|
| **Subscription** | Select your subscription |
| **Resource group** | `rg-ai-foundry-lab` |
| **Service name** | Enter a unique name (e.g., `search-fitness-lab`) |
| **Location** | Same as your AI Foundry resource |
| **Pricing tier** | Standard |

6. Click **Review + create** and then **Create**
7. Wait for deployment to complete

---

### Step 2: Create Connection in AI Foundry

Connect your Azure AI Search resource to your AI Foundry project.

#### Steps to Create the Connection:

1. Navigate to [Azure AI Foundry portal](https://ai.azure.com)
2. Go to your **Project** → **Management Center** → **Connected Resources**
3. Click **New Connection** → **Azure AI Search**
4. Provide the following details:

| Setting | Value |
|---------|-------|
| **Connection Name** | `my-ai-search` |
| **Subscription** | Select your Azure subscription |
| **Resource Group** | Choose your resource group |
| **Azure AI Search Resource** | Select your search service (`search-fitness-lab`) |

5. Click **Add Connection** to complete the setup

---

### Step 3: Create an Index

Now we'll create an index in Azure AI Search to store and search fitness product data.

> 💡 **What is an Index?**
> 
> An **Index** is like a database table optimized for search. It's a container that holds your searchable content in a structured format. When you search, the search engine looks through the index (not the original data) to find matching results quickly.
> 
> Think of it like the index at the back of a book - it helps you find information fast without reading every page.

#### Create the Index:

1. Go to the [Azure Portal](https://portal.azure.com)
2. Navigate to your **Azure AI Search** resource (`search-fitness-lab`)
3. Click **Indexes** in the left menu
4. Click **+ Add index**
5. Enter Index name: `myfitnessindex`

---

### Step 4: Define Index Schema

> 💡 **What is an Index Schema?**
> 
> An **Index Schema** defines the structure of your searchable data - what fields exist and how each field can be used. It's like defining columns in a database table, but with special search attributes.
> 
> **Why do we need it?**
> - Determines which fields can be searched, filtered, or sorted
> - Optimizes search performance for your specific use case
> - Enables features like faceted navigation and autocomplete

#### Add the Following Fields:

Configure your index with these fields and attributes:

| Field Name | Type | Searchable | Filterable | Retrievable |
|------------|------|:----------:|:----------:|:-----------:|
| **id** | String | ❌ | ❌ | ✅ |
| **Name** | Edm.String | ✅ "analyzer": "standard.lucene"| ✅ | ✅ |
| **Category** | Edm.String | ✅ "analyzer": "standard.lucene"| ✅ | ✅ |
| **Price** | Double | ❌ | ✅ | ✅ |
| **Description** | Edm.String | ✅ "analyzer": "standard.lucene"| ❌ | ✅ |

#### Field Attributes Explained:

| Attribute | Purpose |---|
| **Retrievable** | When `true`, the data is saved in the index and will show up in your search results. This allows you to display the field value to users. |
| **Searchable** | When `true`, you can search for words inside these fields. For example, searching for "Yoga" will find the Yoga Mat product. |
| **Filterable** | When `true`, allows you to use that field within a `$filter` expression to narrow down your search results based on specific criteria (e.g., `Category eq 'Strength'`). |

6. After configuring all fields, click **Create**

---

### Step 5: Upload Data to Storage Account

Now we need to upload the fitness products data to Azure Blob Storage.

1. Go to the [Azure Portal](https://portal.azure.com)
2. Navigate to your **Storage Account** (e.g., `stfitnesslabXXXX`)
3. In the left menu, click **Containers**
4. Click **+ Container** to create a new container
5. Enter container name: `fitness-data`
6. Click **Create**
7. Open the `fitness-data` container
8. Click **Upload**
9. Browse and select the `fitness-products.json` file from `Lab2-Agents/sample-data/`
10. Click **Upload**

---

### Step 6: Add Data Source in Azure AI Search

Connect your blob storage to Azure AI Search as a data source.

1. Go to your **Azure AI Search** resource in the Azure Portal
2. In the left menu, click **Data sources**
3. Click **+ Add data source**
4. Fill in the details:

| Setting | Value |
|---------|-------|
| **Data source type** | Azure Blob Storage |
| **Name** | `azureblob-fitness` |
| **Connection string** | Click "Choose an existing connection" → Select your storage account |
| **Container** | `fitness-data` |

5. Click **Save**

---

### Step 7: Create an Indexer

> 💡 **What is an Indexer?**
> 
> An **Indexer** is an automated crawler that reads data from your data source and populates your index. It's like a bridge between your raw data (in blob storage) and your searchable index.
> 
> **Key benefits:**
> - Automatically extracts and transforms data
> - Can run on a schedule to keep index updated
> - Handles the mapping between source fields and index fields

#### Create the Indexer:

1. In your **Azure AI Search** resource, click **Indexers** in the left menu
2. Click **+ Add indexer**
3. Click **Add indexer (JSON)**
4. Paste the following JSON configuration:

```json
{
  "name": "indexer-fitness",
  "dataSourceName": "azureblob-fitness",
  "targetIndexName": "myfitnessindex",
  "parameters": {
    "configuration": {
      "parsingMode": "jsonArray"
    }
  },
  "fieldMappings": [
    { "sourceFieldName": "ID", "targetFieldName": "id" },
    { "sourceFieldName": "Name", "targetFieldName": "Name" },
    { "sourceFieldName": "Category", "targetFieldName": "Category" },
    { "sourceFieldName": "Price", "targetFieldName": "Price" },
    { "sourceFieldName": "Description", "targetFieldName": "Description" }
  ]
}
```

> 💡 **Understanding the JSON Configuration:**
>
> - **parsingMode: "jsonArray"** - This tells the indexer to loop through your JSON list. Since our `fitness-products.json` file contains an array of products `[{...}, {...}]`, the indexer needs to know to process each item in the array separately.
>
> - **fieldMappings** - This ensures the field names in your JSON file map correctly to the fields in your index. For example, `ID` in the JSON maps to `id` in the index.

5. Click **Save**
6. Click **Run** to start the indexer
7. Wait for the indexer to complete (check status shows "Success")

---

### Step 8: Create the AI Search Agent

1. In Azure AI Foundry portal, select your **Project**
2. Navigate to **Agents** in the left menu
3. Click **+ New agent**
4. Configure the agent:

#### Agent Configuration

| Setting | Value |
|---------|-------|
| **Agent Name** | `Agent-fitness-search` |
| **Model** | `gpt-4o` |

#### Instructions

```
You are a Fitness Shopping Assistant with access to a live product catalog through Azure AI Search.

**Your Capabilities:**
- Search the fitness equipment catalog directly when users ask about products
- Provide fitness advice with proper health disclaimers
- Recommend equipment based on goals, budget, and safety

**Guidelines:**
- Always search for products when users ask about specific categories or items
- Include safety considerations and proper usage tips
- Remind users this is educational only - consult healthcare providers for medical advice

Be helpful, encouraging, and prioritize user safety!
```

---

### Step 9: Connect Agent to AI Search Index

1. In the agent configuration, find the **Knowledge** section
2. Click **+ Add**
3. Select **Azure AI Search**
4. Choose **"Indexes that are not part of this project"**
5. Select your AI Search connection
6. Select your index: `myfitnessindex`
7. Set Search type: **Simple**
8. Click **Add**
9. It will automaticlly save your agent

---

## Test Your Agent

### Test in the Playground

1. After creating the agent, click **Try in Playground**
2. Test with the following prompts:

#### Test 1: Strength Equipment Under Budget 💪

```
What strength training equipment do you have available under $100?
```

**Expected Response:**
- Agent searches the catalog
- Returns Adjustable Dumbbell ($59.99) and Resistance Bands ($15.00)
- Includes safety tips for strength training

---

#### Test 2: Cardio Equipment Recommendations 🏃

```
I'm looking for cardio equipment. What do you recommend?
```

**Expected Response:**
- Agent finds Treadmill ($499.00) in the Cardio category
- Provides recommendation with features
- Includes proper usage tips

---

#### Test 3: Budget-Friendly Options 💰

```
What's the cheapest fitness equipment you have?
```

**Expected Response:**
- Agent searches by price
- Returns Resistance Bands ($15.00) as the most affordable option
- May also mention Yoga Mat ($25.00)
- Includes health disclaimer

---

## Validation Checklist

- [ ] Azure AI Search resource created
- [ ] Storage Account created with container
- [ ] `fitness-products.json` uploaded to blob storage
- [ ] Data source `azureblob-fitness` created
- [ ] Index `myfitnessindex` created with schema
- [ ] Indexer created and run successfully
- [ ] Connection established in AI Foundry
- [ ] Agent connected to AI Search index

---

## Summary

Congratulations! 🎉 You have successfully:

1. ✅ Created an Azure AI Search resource
2. ✅ Uploaded fitness product data to Blob Storage
3. ✅ Created a data source connecting to blob storage
4. ✅ Created a custom index (`myfitnessindex`)
5. ✅ Defined an index schema with appropriate field attributes
6. ✅ Created an indexer to populate the index
7. ✅ Connected AI Search to AI Foundry
8. ✅ Created an agent with AI Search capabilities

---

## Key Concepts Learned

| Concept | Description |
|---------|-------------|
| **Azure AI Search** | Managed search service for structured data |
| **Index** | Container for searchable content, optimized for fast retrieval |
| **Index Schema** | Defines fields and their search capabilities |
| **Data Source** | Connection to where your raw data lives (e.g., Blob Storage) |
| **Indexer** | Automated crawler that populates the index from the data source |
| **Field Attributes** | Control how each field can be searched, filtered, and displayed |

---

## Comparing Search Options

| Feature | File Search | AI Search |
|---------|-------------|-----------|
| **Setup** | Simple upload | Create index + schema |
| **Data Type** | Documents (PDF, MD) | Structured data |
| **Filtering** | Basic | Advanced (filters, facets) |
| **Best For** | Unstructured docs | Product catalogs, databases |

---

## Next Steps

Continue to the next lab to learn how to build a **Multi-Agent Solution** for complex workflows.

---

## Additional Resources

- [Azure AI Search Documentation](https://learn.microsoft.com/azure/search/)
- [Create an Index](https://learn.microsoft.com/azure/search/search-what-is-an-index)
- [Index Schema Definition](https://learn.microsoft.com/azure/search/search-how-to-create-search-index)
