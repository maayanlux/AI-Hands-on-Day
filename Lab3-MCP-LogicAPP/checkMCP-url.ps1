# Simple Azure POST Request to get MCP Server URL

# Update these values with your own:
# - Subscription-ID: Your Azure subscription ID
# - RG-Name: Your resource group name  
# - LogicApp-Name: Your Logic App name

$uri = "https://management.azure.com/subscriptions/Subscription-ID/resourceGroups/RG-Name/providers/Microsoft.Web/sites/LogicApp-Name/hostruntime/runtime/webhooks/workflow/api/management/listMcpServerUrl?api-version=2021-02-01"

# Ensure you're logged in to Azure CLI
# Run 'az login' if not already authenticated

# Get Azure token using Azure CLI
$tokenResponse = az account get-access-token --resource https://management.azure.com --query accessToken --output tsv
if (-not $tokenResponse) {
    Write-Error "Failed to get access token. Please run 'az login' first."
    exit 1
}

$headers = @{ 
    "Authorization" = "Bearer $tokenResponse"
    "Content-Type" = "application/json"
}

try {
    $response = Invoke-RestMethod -Uri $uri -Method POST -Headers $headers -ContentType "application/json"
    Write-Host "MCP Server URL:" -ForegroundColor Green
    $response | Format-Table -AutoSize -Wrap
} catch {
    Write-Error "Request failed: $_"
}