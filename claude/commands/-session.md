# /-session

Write or update SESSION.md — a structured context snapshot you can take at
any point. `/compact` does this automatically, but run `/-session` whenever
you want to capture state manually.

## When to use
- Before ending a long session
- After a meaningful milestone
- Before `/compact` to preserve specific context
- When switching between tasks in the same project

## Steps

1. Review the conversation — what changed, what was decided, what's next
2. Check git diff for a ground-truth list of what was actually modified
3. Write or update SESSION.md in the current working directory:

```markdown
# Session: <YYYY-MM-DD>

## Status
One sentence: current state of the work.

## Completed
- What was finished this session

## Decisions
- Key decisions made and why (non-obvious from the code)

## In Progress
- What was being worked on at session end

## Next
- Ordered list of what to do next

## Context
- Anything needed that isn't obvious from reading the code
  (known issues, things to avoid, external dependencies, blockers)
```

## Rules
- Keep SESSION.md under 50 lines — it's injected into every session in this directory
- Accuracy over completeness — only include what's actually true right now
- Add SESSION.md to .gitignore — it's personal working state, not project history
- Update with `/-session`, not manually, so Claude keeps it accurate
