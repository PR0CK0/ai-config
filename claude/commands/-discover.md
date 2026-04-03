# /-discover

Map this codebase and produce a concise orientation document.

## Steps

Spawn the following sub-agents in parallel in a single message:

**Agent 1 — Structure**
- Read root README.md
- List and describe top-level directories
- Identify the project type and tech stack

**Agent 2 — Entry points & tooling**
- Find main entry points (package.json, pyproject.toml, go.mod, Cargo.toml, Makefile, etc.)
- Identify build, run, and dev commands
- Find the test framework and how to run tests

**Agent 3 — CI & config**
- Find CI configuration (.github/workflows/, .gitlab-ci.yml, Jenkinsfile, etc.)
- Note any CLAUDE.md or .claude/ directories and what they contain
- Find environment config (.env.example, config files, feature flags)

**Agent 4 — Key files**
- Identify the 5-10 most important files to read to understand the codebase
- Note any unusual patterns, non-standard structure, or things that would surprise a new developer

Wait for all four agents to complete, then synthesize into a single orientation document.

## Output

- **What it does** — one sentence
- **Stack** — languages, frameworks, key dependencies
- **Structure** — directory map with one-line descriptions
- **Entry points** — how to run, build, test
- **CI / config** — pipeline overview, env vars needed
- **Read first** — the 5-10 most important files
- **Open questions** — anything unclear that needs asking

Keep it under 50 lines. Orientation, not documentation.
