# CI pipeline

## What the scripts do
- `scripts/build.sh`: 
Compiles the project artifacts and outputs a success confirmation 
with exit code 0.
- `scripts/test.sh`: 
Executes automated test suites to validate component integrity and 
reports test outcomes.


## The failure the pipeline caught
- **What I broke on purpose:** I intentionally removed a required build file, causing the test assertion to fail.
- **What the pipeline said:** The GitHub Actions workflow halted on the test step, marking the run with a red status and returning exit code 1.
- **Link to the red run:** 
[[link to GitHub Action red](https://github.com/roman-chumachenko/iths-devops-repo/actions/runs/37604788631/job/112737525007)]
