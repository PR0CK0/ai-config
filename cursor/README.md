# Cursor Config

## Global rules (all projects)
Paste `user-rules.md` content into Cursor → Settings → Rules for AI.

## Per-project rules
```sh
mkdir -p .cursor/rules && cp rules/global.mdc .cursor/rules/
```

Both files are generated from root `AGENTS.md` via `build.sh`. Do not edit them directly.
