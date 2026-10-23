# Automated deployment

## The chain
What happens from git push to a running app, step by step.

1. **Trigger (`git push`):** Developer pushes code to the repository (e.g., merging or pushing to `main`), which triggers the CI/CD pipeline.
2. **Build:** The pipeline builds the application, compiling code and packaging artifacts.
3. **Automated Testing:** Unit and integration tests run. If any test fails, the pipeline stops immediately.
4. **OIDC Authentication:** The pipeline securely authenticates with Azure using OpenID Connect (OIDC) without storing long-lived secrets.
5. **Deployment:** The application is deployed to the production environment where users can access it.
6. **Smoke Testing:** Post-deployment smoke tests run to verify that the application responds correctly in the live environment.

## The rollback I tried
What I broke, what the smoke test said, and which run I re-ran. Links to the runs.

* **What was broken:** A faulty commit was introduced and deployed to `main`, causing the application to return errors for users.
* **What the smoke test said:** The smoke test turned **red**, indicating that the deployed version failed health checks and did not respond as expected.
* **The Rollback Action:** Instead of fixing forward immediately, I performed a fast rollback by re-running the **latest successful green deployment run** to restore service instantly.
* **Post-rollback fix:** Executed `git revert` on the problematic commit to ensure the broken code won't be redeployed on the next push.
* **Pipeline Links:** 
  * *Failed Run:* [[Link to the red pipeline run](https://github.com/roman-chumachenko/iths-devops-repo/actions/runs/39799145157)]
  * *Rollback Run:* [[Link to the re-run green deployment](https://github.com/roman-chumachenko/iths-devops-repo/actions/runs/39813181721)]
