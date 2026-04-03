# /-sync

Keep local branches current with remote. Stashes in-progress work, fast-forwards master/develop, returns to your branch.

## Steps

1. Check for uncommitted changes — stash if present
2. `git fetch --prune --tags`
3. Fast-forward `develop` to match remote (if it exists locally)
4. Fast-forward `master` (or `main`) to match remote (if it exists locally)
5. Return to the original branch
6. Pop the stash if one was created
7. Show divergence status — is your current branch ahead/behind develop?

## After sync

- If current branch is behind develop: offer to rebase
- If current branch has diverged: explain the situation and suggest resolution
- If conflicts on stash pop: stop and describe what conflicted — do not auto-resolve

## Rules

- Never rebase without asking first
- Never force-push or reset — sync is read-only except for fast-forwards
- If a fast-forward isn't possible (diverged protected branch), report it and stop
- Stash is always restored — never leave work stashed silently
