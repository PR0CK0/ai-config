# Claude Code Config

Installs to `~/.claude/`. Rules only or full setup — see below.

## Structure

```
claude/
├── CLAUDE.md          # Generated from AGENTS.md — rules only drop-in
├── settings.json      # Model, hooks, statusline
├── agents/            # 8 specialist sub-agents
├── commands/          # /-check, /-ship, /-review, /-discover, /-session, /-sync
└── hooks/             # pre-compact, post-compact, prompt-inject, statusline
```

## Install

**Rules only:**
```sh
cp CLAUDE.md ~/.claude/CLAUDE.md
```

**Full setup:**
```sh
cp -r . ~/.claude/
chmod +x ~/.claude/hooks/statusline.sh
```

Requires Node.js (hooks) and `jq` + `bash` (statusline).

## Commands

| Command | What it does | Args |
|---------|-------------|------|
| `/-check` | Lint, types, tests | `files` `self` `all` |
| `/-discover` | Codebase orientation via parallel sub-agents | — |
| `/-review` | Audit: arch, docs, security, deps | `arch` `docs` `security` `deps` |
| `/-session` | Write/update `SESSION.md` handoff file | — |
| `/-ship` | Git workflow | `commit` `feature` `release` `hotfix` `cleanup` |
| `/-sync` | Stash, fetch, fast-forward protected branches | — |

## Agents

| Agent | Domain |
|-------|--------|
| `ontologist` | RDF/OWL, SHACL, SPARQL, graph DBs |
| `modeler` | JSON Schema, OpenAPI, Protobuf, LinkML |
| `ml-scientist` | LLMs, RAG, embeddings, ML pipelines |
| `sqa-specialist` | Testing, coverage, performance |
| `security-expert` | Threat modeling, auth, secrets, IAM |
| `backend-architect` | Cloud infra, Docker, Terraform, databases |
| `researcher` | Deep research with citations |
| `librarian` | Docs, changelogs, API specs |

## Hooks

| Hook | Event | What it does |
|------|-------|-------------|
| PreCompact agent | `PreCompact` | Writes `SESSION.md` before compaction |
| `pre-compact.js` | `PreCompact` | Backs up session JSONL to `~/.claude/backups/` |
| `post-compact.js` | `PostCompact` | Re-injects `SESSION.md` after compaction |
| `prompt-inject.js` | `UserPromptSubmit` | Re-injects `SESSION.md` every 20 prompts |
| `statusline.sh` | Continuous | Folder, branch, context bar, tokens, cost, model |
