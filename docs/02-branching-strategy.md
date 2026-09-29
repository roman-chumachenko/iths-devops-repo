# Branching strategy

## Chosen strategy
For this project, operating as a single backend developer building a microservices 
and DevOps pipeline, a lightweight GitHub Flow strategy is chosen. Features and 
documentation changes are developed on short-lived feature branches, reviewed via 
pull requests, and merged directly into the `main` branch to ensure continuous 
integration readiness without unnecessary overhead.

## Branch protection
In a team environment with more than one person, branch protection rules on `main`-
such as requiring pull requests, enforcing strict code ownership via `CODEOWNERS`, 
and forbidding direct pushes—are essential. For this solo setup, rules were tested 
temporarily and disabled to allow efficient PR lifecycles, but establishing the 
`CODEOWNERS` file and PR templates guarantees operational readiness and review 
accountability from day one.

## Tagging and versioning
Version `v0.1.0` contains the foundational infrastructure of the repository: the 
branching strategy documentation, the pull request template, and the `CODEOWNERS` 
configuration, with no application code deployed yet. The leading zero (`0`) indicates 
that the project is pre-release and subject to change. Future version numbers will 
follow Semantic Versioning (MAJOR.MINOR.PATCH) driven by Conventional Commits: 
a `fix:` commit will increment the patch version (e.g., v0.1.1), 
a `feat:` commit will increment the minor version (e.g., v0.2.0), and 
`docs:` or `chore:` commits will not alter the version number.
