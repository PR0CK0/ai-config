# AGENTS.md

Ontology-grounded LLM development. TDD. Secure by default.

---

## Critical Thinking

- Investigate before implementing. State assumptions.
- Multiple interpretations → present them, don't pick silently.
- Simpler path exists → say so. Push back when warranted.
- Uncertain → stop, name what's confusing, ask.

## Code Quality

- Minimum code that solves the problem. No speculative abstractions.
- Touch only what the request requires. Match existing style.
- 200 lines that could be 50 → rewrite.
- Check for existing constants before creating literals. Name anything used more than once.
- New dep → health-check: recent releases, active maintenance, adoption. Flag if suspect.

## TDD

- New function → failing test first, then implement.
- Nothing merges without a passing test on primary behavior.
- Vague task → verifiable criteria: "add X" → "failing test for X, make it pass."
- Red → green → refactor. Always.

## Privacy & Paths

- No hardcoded paths, usernames, machine names, or tokens. Ever.
- Dynamic resolution only: `os.path.expanduser`, `process.env`, `Path.home()`.
- Scan for secrets and paths before every commit. Block on any match.

## Git & Release

- Conventional commits: `feat|fix|refactor|chore|docs|test|perf`.
- On first git operation in a repo, confirm: production/team or personal/prototype?
- Production/team: feature branches → PRs, never commit to main/master/develop directly.
- Personal/prototype: commit directly to main — git history is the safety net. Revert if wrong.
- Release: `feature/*` → `develop` → `release/vX.Y.Z` (bump + CHANGELOG) → `master` → tag → ff `develop`.
- Never `--no-verify`, `--force`, hook bypass. Fix root causes.
- Atomic commits: only files you touched. `git status` before every commit.
- Commit on logical chunks with meaningful messages. Never push without permission.
- GH Actions present → monitor after push: `gh run list/view`. Rerun flakes, fix failures. Never leave CI red.
- No destructive ops (`reset --hard`, `clean`, `restore`) without explicit written approval.

## Cleanup

- Delete files your changes make irrelevant. No orphaned code or docs.
- Stale README sections → update or remove before opening a PR.
- No commented-out code left behind.

## Output Format

- Tables and diagrams over prose for architecture, tradeoffs, comparisons.
- Mermaid for diagrams. One table beats three paragraphs.

## Ownership

- Problem found → fix it. No "pre-existing issue", no "outside scope."
- Fix code, not config. No suppression comments. Ask before touching tooling.
- Docs updated in the same commit as source.
- Clarifying questions one at a time. Plan before non-trivial work.
- Unrecognized changes → assume another agent. Stay in your scope. Conflict → stop and ask.
