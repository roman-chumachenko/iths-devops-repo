# Infrastructure as Code

## What the templates describe
infra/identity.bicep:
- Purpose: Creates the User-Assigned Managed Identity for GitHub Actions and sets up the 
  OIDC Federated Identity Credentials along with the Role Assignment (Contributor).
- Execution: Executed manually once from the local terminal by a subscription/resource 
  group admin because it requires identity and access management permissions.

infra/main.bicep & infra/app-service.bicep:

- Purpose: Defines the core application infrastructure, including the App Service Plan 
  (Free tier F1) and the Web App instance.
- Execution: Executed automatically by the GitHub Actions pipeline 
  (.github/workflows/infra-deploy-pipeline.yml) during every push to main.

## What the templates do not recreate
If the resource group is completely emptied, the following manual steps are required 
before automated deployments can resume:

- Re-run identity.bicep: The GitHub Actions runner loses its deployment identity 
  if the Managed Identity is deleted. It must be created manually first using az 
  deployment group create.
- Re-configure GitHub Secrets and Variables:  

    Secrets: AZURE_CLIENT_ID, AZURE_TENANT_ID. AZURE_SUBSCRIPTION_ID 
    (retrieved from the newly created Managed Identity).

    Variables: AZURE_RESOURCE_GROUP, AZURE_APP_NAME, AZURE_APP_URL  

