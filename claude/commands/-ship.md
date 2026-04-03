# /-ship [action]

All git workflow operations. Always works on feature branches — never commits directly to master, main, or develop.

If called with no action, list the available actions and ask which to run:
- `commit` — self-review and commit current changes
- `feature` — create or push a feature branch
- `release` — cut a release from develop
- `hotfix` — apply an urgent fix from master
- `cleanup` — prune stale local branches

## Actions

**`/-ship commit [message]`**
- Run `/-check self` first
- Stage modified tracked files
- Commit with conventional commit format (feat/fix/refactor/chore/docs)
- Ask before committing if self-review flagged anything

**`/-ship feature [name]`**
- Create `feature/name` from develop (confirm develop is up to date)
- Or push current feature branch and open a PR targeting develop

**`/-ship release [version]`**
- Create `release/vX.Y.Z` from develop
- Bump version references, update CHANGELOG.md
- Open PR targeting master; tag after merge; back-merge to develop

**`/-ship hotfix [version]`**
- Create `hotfix/vX.Y.Z` from master (urgent prod fixes only)
- Apply fix, bump patch version, update CHANGELOG
- Open PR targeting master; tag after merge; back-merge to develop

**`/-ship cleanup`**
- Fetch and prune, list merged/stale local branches
- Show list before deleting anything; confirm unless `--force`

## Rules

- Never use --no-verify, --force, or any hook bypass
- Always ask if integration/e2e tests have been run before pushing
- PR template: Summary, Type of Change, Testing, Checklist, Related Issues
