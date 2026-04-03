# /-check [scope]

Run validation for this project and report results.

## Scope

- (default) — lint + types + unit tests
- `files` — validate all config, manifest, and script files
- `self` — review changes in this conversation before committing
- `all` — full ordered pipeline (build → lint → types → tests → files → docs); run this before opening a PR

## Steps

**Default / all:**
1. Detect available tools (package.json scripts, Makefile, CI config)
2. Run checks in order — collect all failures, do not stop on first
3. Report consolidated results

**`files`:**
Validate all of the following if present in the project:
- JSON (syntax + schema if detectable)
- YAML / TOML (syntax, duplicate keys, ambiguous booleans)
- Markdown (broken links, malformed frontmatter)
- ENV files (hardcoded absolute paths, secrets accidentally included)
- Dockerfile (root user, missing healthcheck, unpinned base image tags)
- Shell scripts (shellcheck if available)
- OpenAPI / JSON Schema specs (structural validity)
- Package manifests (package.json, pyproject.toml, Cargo.toml — obvious issues)

**`self`:**
Run `git diff`, review each changed file for:
- Does the change do what was requested and nothing more?
- Hardcoded paths, secrets, or magic values
- Leftover debug statements or commented-out code
- Unintended files modified

## Rules

- Fix failures — never suppress, ignore, or downgrade config
- After fixing, re-run to confirm clean
- For `self`: flag any Block-level issue and fix before committing
- For `all`: ask user if integration/e2e tests have been run locally before treating it as PR-ready

## Output

```
Build    ✓ passed
Lint     ✗ 3 errors  (src/api.ts:12, src/utils.ts:44, src/utils.ts:58)
Types    ✓ passed
Tests    ✓ 38 passed
Files    ✓ 12 files checked
Docs     ⚠ README.md may be stale (src/server.ts changed)
```
