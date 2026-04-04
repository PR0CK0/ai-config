# ai-config

> Agent config for ontology-driven LLM development. One source, minimal surface, secure by default.

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
- **Minimal surface.** Short rules shape judgment. Long rules get ignored — and the middle ones get ignored most. Research shows LLMs reliably attend to the beginning and end of long contexts, with significant degradation in between ([Liu et al., 2023 — "Lost in the Middle"](https://arxiv.org/abs/2307.03172)). Keep `AGENTS.md` short and front-load what matters.
- **Ontology-grounded.** Models, schemas, and knowledge graphs are first-class.
- **TDD.** Every function ships with a test. Red → green → refactor, always.
- **Secure.** No hardcoded paths, tokens, or secrets. Ever.

---

## Structure

```
ai-config/
├── AGENTS.md              ← single source of truth — edit this only
├── build.sh               ← generates all tool folders + wires git hooks
├── claude/
│   ├── CLAUDE.md          ← generated
│   ├── settings.json      ← model, hooks, statusline config
│   ├── agents/            ← 8 specialist sub-agents
│   ├── hooks/             ← session management, context injection, statusline
│   └── commands/          ← /-check, /-ship, /-review, /-discover, /-session, /-sync
├── cursor/
│   ├── user-rules.md      ← generated — paste into Settings → Rules for AI
│   └── rules/
│       └── global.mdc     ← generated — drop into .cursor/rules/ per project
├── gemini/
│   └── GEMINI.md          ← generated
└── codex/
    └── AGENTS.md          ← generated
```

Each tool folder is built exhaustively. You only need the generated config file for your tool — the rest (agents, hooks, commands) is Claude Code-specific.

---

## Install

**1. Clone and build:**
```bash
git clone https://github.com/PR0CK0/ai-config.git ~/ai-config
cd ~/ai-config
./build.sh        # generates all tool folders + wires pre-push hook
```

**2. Claude Code — rules only (drop-in):**
```bash
cp ~/ai-config/claude/CLAUDE.md ~/.claude/CLAUDE.md
```

**Claude Code — full setup (agents, hooks, slash commands, statusline):**
```bash
cp ~/ai-config/claude/CLAUDE.md ~/.claude/CLAUDE.md
cp ~/ai-config/claude/settings.json ~/.claude/settings.json
cp -r ~/ai-config/claude/agents ~/.claude/agents
cp -r ~/ai-config/claude/hooks ~/.claude/hooks
cp -r ~/ai-config/claude/commands ~/.claude/commands
chmod +x ~/.claude/hooks/statusline.sh
```

**3. Cursor — global rules:**
Paste `cursor/user-rules.md` content into Cursor → Settings → Rules for AI.

**Cursor — per-project:**
```bash
mkdir -p .cursor/rules && cp ~/ai-config/cursor/rules/global.mdc .cursor/rules/
```

**4. Gemini CLI:**
```bash
mkdir -p ~/.gemini && cp ~/ai-config/gemini/GEMINI.md ~/.gemini/GEMINI.md
```

**5. Codex CLI:**
```bash
cp ~/ai-config/codex/AGENTS.md ~/AGENTS.md   # global
# or copy to project root for per-project
```

**Per-project pointer (any tool):**
```bash
echo "READ ~/ai-config/AGENTS.md BEFORE ANYTHING" > AGENTS.md
```

**Symlinks instead of copies:**
```bash
./build.sh --symlink
```

> `build.sh` wires `.githooks/pre-push` automatically — if `AGENTS.md` changes, the hook rebuilds all aliases and blocks the push until generated files are committed.

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
