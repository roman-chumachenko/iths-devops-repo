# Container Apps

## Base conception
**Azure Container Apps (ACA)** is a fully managed serverless platform for running containerized applications on top of **Kubernetes** and **KEDA** (Kubernetes Event-driven Autoscaling) without exposing cluster administration complexity. It sits between Azure App Service (minimal control, maximum abstraction) and Azure Kubernetes Service / AKS (full control, high operational overhead).

Core architectural building blocks of Azure Container Apps:

1. **Managed Environment** - an isolated boundary (`cae-waypoint-roman`) that hosts one or more container apps, sharing logging (Log Analytics), networking, and Dapr configurations.
2. **Revisions (`activeRevisionsMode: 'Multiple'`)** - immutable snapshots of a container app (combining a specific container image tag and configuration). When a new image or setting is deployed, ACA creates a new revision while preserving previous revisions.
3. **Traffic Splitting & Instant Rollbacks** - built-in ingress routing distributes incoming HTTPS requests across multiple active revisions by weight (e.g., 50/50 for canary testing or gradual rollouts). Rolling back simply shifts 100% of traffic back to a previous revision without rebuilding or redeploying old images.
4. **Event-Driven Autoscaling (Scale to Zero)** - powered by KEDA, replicas can automatically scale down to `0` (`minReplicas: 0`) during idle periods to eliminate idle compute costs, trading off a brief cold start on the first incoming request after inactivity.
5. **Split-Role Security Model** — separates CI/CD build permissions (`AcrPush` via GitHub Actions OIDC) from runtime container pull permissions (`AcrPull` via Managed Identity).

---

## Before and after
### Before (Traditional App Service / Single-Instance Deployment)
* **Destructive deployments and slow rollbacks:** deploying a new version overwrites the running instance; rolling back requires rebuilding or redeploying the previous artifact from scratch.
* **All-or-nothing releases:** new code immediately receives 100% of user traffic without a built-in mechanism for canary testing or gradual traffic shifting.
* **Always-on compute billing:** plans like App Service `B1` incur hourly charges continuously even when the application is completely idle.
* **Tight coupling to runtime environment:** scaling and runtime dependencies are tied to the underlying VM/plan configuration rather than portable OCI container images.

### After (Azure Container Apps with Revisions & CI/CD)
* **Immutable revisions and zero-downtime traffic shifting:** multiple versions run side by side[cite: 9], enabling safe 50/50 or canary traffic splitting (`az containerapp ingress traffic set`) before full promotion.
* **Instant rollbacks:** reverting a faulty release takes seconds by routing 100% of traffic back to a healthy previous revision.
* **Cost-efficient scale-to-zero:** idle environments scale down to zero replicas automatically[cite: 5, 15], while still supporting `minReplicas: 1` for latency-sensitive production workloads.
* **Automated GitOps / CI/CD pipeline:** every push to `main` builds and tags a container image in Azure Container Registry (ACR), provisions infrastructure declaratively via Bicep, deploys a new revision, and verifies health via automated smoke tests.
