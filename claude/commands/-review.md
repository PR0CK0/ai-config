# /-review [type]

Analyze this codebase and report findings. Does not modify code — reports only.

If no type is given, spawn all four review types as parallel sub-agents in a single message, wait for all to complete, then present a unified report grouped by type.

## Types

**`/-review arch`** — Architecture review
- Map modules, layers, dependency direction
- Find circular dependencies, god objects, inappropriate coupling
- Assess separation of concerns and interface boundaries
- Report: what the structure is trying to be, findings by severity, what's working well

**`/-review docs`** — Documentation consistency
- Find all Markdown files and what source code they describe
- Compare docs against actual code behavior
- Report: stale commands, wrong flags, missing features, removed APIs

**`/-review security`** — Security audit
- Scan for hardcoded secrets, tokens, passwords
- Check for injection vulnerabilities, insecure patterns
- Review auth/authz patterns, sensitive data in logs
- Check dependencies for known issues if tooling available
- Report findings by severity: Critical / High / Medium / Low

**`/-review deps`** — Dependency audit
- List outdated packages with available updates
- Flag known vulnerabilities
- Identify unused dependencies

## Output

Findings only. Each with: location, description, remediation. Ask before fixing anything.
