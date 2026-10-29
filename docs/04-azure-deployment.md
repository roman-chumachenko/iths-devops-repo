# Azure deployment

## What I deployed
App Service Plan: Linux App Service Plan running on the B1 tier.

Web App: Node.js web application (app-waypoint-roman) created in 
resource group rg-waypoint-roman.

Deployment Commands:
```bash
./scripts/deploy-app-service.sh "$APP_NAME" "$RESOURCE_GROUP"
```
Health check verification:
```bash
./scripts/health-check.sh "$APP_URL/health"
```
## What I saw in the log
Log Line: OK: the app answered 200 on attempt 1.

Meaning: The application successfully booted up, passed the health 
probe endpoint (/health), and responded with an HTTP status code 
200 OK, confirming that the service is healthy and accessible over 
the internet.
