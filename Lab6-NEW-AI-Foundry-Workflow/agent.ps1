# 1. Get the correct token for the Foundry audience
$TOKEN = (az account get-access-token --resource https://ai.azure.com --query "accessToken" --output tsv)

# 2. Use your base endpoint URL
$BASE = "https://admin-mcsy1m56-eastus2.services.ai.azure.com"

# 3. The URI using the explicit project name and correct preview version
$URI = "$BASE/api/projects/admin-mcsy1m56-eastus2-project/agents/Agent-K8s-Automation/versions?api-version=2025-11-15-preview"

# 4. Agent Configuration wrapped in 'definition' object
$body = @{
    definition = @{
        model = "gpt-4o"
        instructions = "You are a Kubernetes Automation Specialist.
        STEP 1 [SEARCH]: Immediately use knowledge_base_retrieve to find the file k8s.yaml.
        STEP 2 [PROCESS]: Once you have the text from the file, immediately open the Code Interpreter.
        STEP 3 [PYTHON LOGIC]: Write a Python script to:
                Take the existing YAML content.
                Update the apiVersion or image tag to match the user's provided version (last realease).
                Print the result.

        STEP 4 [OUTPUT]: Display the final updated YAML in a markdown code block.
        show me the updated YAML directly."

        # input_schema = @{
        #     type = "object"
        #     properties = @{
        #         messages = @{
        #             type = "string"
        #             description = "The text passed from the summary agent"
        #         }
        #     }
        #     required = @("messages")
        # }

        tools = @(
            @{ 
                type = "code_interpreter"
                container = @{ type = "auto" }
            },
            @{ 
                type = "mcp"
                server_label = "kb_knowledgebase14_4ep2r"
                require_approval = "never"
                server_url = "https://aisearchaiworkshop.search.windows.net/knowledgebases/knowledgebase14/mcp?api-version=2025-11-01-Preview"
                project_connection_id = "kb-knowledgebase14-4ep2r"
                allowed_tools = @("knowledge_base_retrieve")
            }
        )
        kind = "prompt"
    }
} | ConvertTo-Json -Depth 10

# 5. Execute the creation
Invoke-RestMethod -Method Post -Uri $URI -Headers @{ 
    "Authorization" = "Bearer $TOKEN"; 
    "Content-Type" = "application/json" 
} -Body $body