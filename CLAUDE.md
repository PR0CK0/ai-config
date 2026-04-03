# AGENTS.md

Ontology-grounded LLM development. TDD. Secure by default.

Rules are organizational scar tissue — added the second a mistake repeats. Keep this file short.

---

## Critical Thinking

- Investigate before implementing. State assumptions explicitly.
- Multiple interpretations exist → present them, don't pick silently.
- Simpler approach exists → say so. Push back when warranted.
- Uncertain → stop, name what's confusing, ask.

## Code Quality

- Minimum code that solves the problem. No speculative abstractions.
- No features beyond what was asked. No flexibility that wasn't requested.
- Touch only what the request requires. Match existing style.
- If you wrote 200 lines and it could be 50, rewrite it.
- Before creating a numeric or string literal, grep for existing constants. Use them. Name anything used more than once.

## TDD

- Every new function gets a test. Write the failing test first, then implement.
- No function merges without a passing test covering its primary behavior.
- Transform vague tasks into verifiable criteria: "add X" → "write failing test for X, make it pass."
- Red → green → refactor. Always.

## Privacy & Paths

- Never hardcode absolute paths, usernames, machine names, or tokens.
- Dynamic resolution only: `os.path.expanduser`, `process.env`, `Path.home()`.
- Scan for hardcoded paths and secrets before every commit. Block on any match.

## Git & Release

- Protected branches (master, main, develop) — never commit or push directly.
- Feature branches → PRs. Conventional commits: `feat|fix|refactor|chore|docs|test|perf`.
- Release flow: `feature/*` → `develop` → `release/vX.Y.Z` (bump version + CHANGELOG) → `master` → tag `vX.Y.Z` → back-merge to `develop`.
- Never `--no-verify`, `--force`, or bypass hooks. Fix root causes.
- Atomic commits: only the files you touched. Check `git status` before every commit.
- No destructive ops (`reset --hard`, `clean`, `restore`) without explicit written approval in the current conversation.

## Cleanup

- Delete files your changes make irrelevant. No orphaned code, no orphaned docs.
- Update or remove stale README sections every push.
- No commented-out code blocks left behind.

## Output Format

- Prefer tables and diagrams over prose for architecture, tradeoffs, and comparisons.
- Use Mermaid for diagrams. One table beats three paragraphs.
- Offer one contextual next action, not a menu of everything possible.

## Ownership

- If you encounter a problem, fix it. No "pre-existing issue", no "outside scope."
- Fix code, not config. No suppression comments. Ask before touching tooling.
- Update docs in the same commit when changing source.
- Ask clarifying questions one at a time. Produce a plan before implementing non-trivial features.
