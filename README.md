# ai-config

> my agents for ontology-driven LLM work.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-compatible-blue?logo=anthropic)](https://claude.ai/code)
[![Cursor](https://img.shields.io/badge/Cursor-compatible-purple)](https://cursor.sh)
[![Gemini CLI](https://img.shields.io/badge/Gemini%20CLI-compatible-4285F4?logo=google)](https://github.com/google-gemini/gemini-cli)
[![Codex CLI](https://img.shields.io/badge/Codex%20CLI-compatible-black?logo=openai)](https://github.com/openai/codex)

One file. One source. No drift.

---

## Philosophy

Rules here are **organizational scar tissue** — grown from real incidents, not upfront design. A rule gets added the second a mistake repeats. Nothing is added speculatively.

- **One source.** Edit `AGENTS.md` only. `build.sh` generates all tool-specific aliases.
- **Minimal surface.** Short rules shape judgment. Long rules get ignored.
- **Ontology-grounded.** Models, schemas, and knowledge graphs are first-class.
- **TDD.** Every function ships with a test. Red → green → refactor, always.
- **Secure.** No hardcoded paths, tokens, or secrets. Ever.

---

## Structure

| Path | Purpose |
|------|---------|
| `AGENTS.md` | Canonical rules — **edit this only** |
| `build.sh` | Generates `CLAUDE.md`, `GEMINI.md`, `cursor/user-rules.md` |
| `claude/settings.json` | Model, hooks, status line config |
| `claude/agents/` | Eight specialist sub-agents |
| `claude/hooks/` | Session management, context injection, status line |
| `claude/commands/` | Slash commands: `/-check`, `/-ship`, `/-review`, `/-discover`, `/-session`, `/-sync` |

---

## Install

**Claude Code — global:**
```bash
./build.sh
cp CLAUDE.md ~/.claude/CLAUDE.md
cp claude/settings.json ~/.claude/settings.json
cp -r claude/agents ~/.claude/agents
cp -r claude/hooks ~/.claude/hooks
cp -r claude/commands ~/.claude/commands
chmod +x ~/.claude/hooks/statusline.sh
```

**Per-project (any tool) — pointer pattern:**
```bash
echo "READ ~/path/to/ai-config/AGENTS.md BEFORE ANYTHING" > AGENTS.md
```

**Cursor:**
```bash
./build.sh
# copy cursor/user-rules.md content into Cursor Settings → Rules for AI
```

**Symlinks (keeps generated files always current):**
```bash
./build.sh --symlink
```

---

## Specialist Agents

Invoked by Claude Code as sub-agents. Each scoped to a domain with explicit tool grants.

| Agent | Domain |
|-------|--------|
| `ontologist` | RDF/OWL, SHACL, SPARQL, Fuseki, Neo4j, graph databases |
| `modeler` | JSON Schema, OpenAPI, Protobuf, Avro, LinkML, GraphQL |
| `ml-scientist` | LLMs, RAG, embeddings, vector databases, ML pipelines |
| `sqa-specialist` | TDD, coverage, performance profiling, test strategy |
| `security-expert` | Threat modeling, auth, secrets, IAM, audit trails |
| `backend-architect` | Cloud infra, Docker, Terraform, SQL/NoSQL, ECS |
| `researcher` | Deep research, parallel sub-agents, evidence synthesis |
| `librarian` | Docs, changelogs, API specs, release notes |

---

## Hooks (Claude Code)

| Hook | Trigger | What it does |
|------|---------|--------------|
| `pre-compact.js` | PreCompact | Backs up session JSONL to `~/.claude/backups/` before compaction |
| `post-compact.js` | PostCompact | Re-injects `SESSION.md` as context after compaction |
| `prompt-inject.js` | UserPromptSubmit | Re-injects `SESSION.md` every 20 prompts |
| `statusline.sh` | Status line | Folder, git branch, context bar, tokens, cost, model |

---

## Inspiration

| Source | What it contributed |
|--------|---------------------|
| [steipete/agent-scripts](https://github.com/steipete/agent-scripts) | Git safety rules, atomic commit discipline, the pointer pattern |
| [steipete — Just Talk To It](https://steipete.me/posts/just-talk-to-it) | "Organizational scar tissue" philosophy; blast-radius thinking |
| [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) | Think Before Coding, Simplicity First, Surgical Changes, Goal-Driven Execution |
| Home-grown | Ontologist + modeler agents, session hooks, slash commands, statusline |

---

## License

MIT
