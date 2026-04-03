#!/usr/bin/env bash
# build.sh — generates tool-specific configs from AGENTS.md
# Usage: ./build.sh [--symlink]
#   --symlink  create symlinks instead of copies (tools must support symlink resolution)
set -euo pipefail

SRC="AGENTS.md"
SYMLINK="${1:-}"

if [[ ! -f "$SRC" ]]; then
  echo "error: $SRC not found" >&2
  exit 1
fi

generate() {
  local dst="$1"
  local prefix="${2:-}"
  if [[ "$SYMLINK" == "--symlink" && -z "$prefix" ]]; then
    ln -sf "$(realpath "$SRC")" "$dst"
    echo "symlinked: $dst → $SRC"
  else
    { [[ -n "$prefix" ]] && printf '%s' "$prefix"; cat "$SRC"; } > "$dst"
    echo "generated: $dst"
  fi
}

# ── Claude Code ───────────────────────────────────────────────────────────────
# Drop claude/CLAUDE.md into ~/.claude/CLAUDE.md
# Full install: settings.json, agents/, hooks/, commands/ also go to ~/.claude/
mkdir -p claude
generate claude/CLAUDE.md

# ── Gemini CLI ────────────────────────────────────────────────────────────────
# Drop gemini/GEMINI.md into ~/.gemini/GEMINI.md
mkdir -p gemini
generate gemini/GEMINI.md

# ── Codex CLI ────────────────────────────────────────────────────────────────
# Drop codex/AGENTS.md into ~/AGENTS.md (global) or project root (per-project)
mkdir -p codex
generate codex/AGENTS.md

# ── Cursor ───────────────────────────────────────────────────────────────────
# user-rules.md → paste into Cursor Settings → Rules for AI (global)
# rules/global.mdc → drop into .cursor/rules/ in any project (per-project)
mkdir -p cursor/rules
CURSOR_FRONT="$(printf 'description: Global rules\nalwaysApply: true\n---\n')"
generate cursor/user-rules.md "$CURSOR_FRONT"
generate cursor/rules/global.mdc "$CURSOR_FRONT"

# ── Git hooks ────────────────────────────────────────────────────────────────
# Wire pre-push hook to enforce rebuild when AGENTS.md changes
if git rev-parse --git-dir > /dev/null 2>&1; then
  git config core.hooksPath .githooks
  chmod +x .githooks/pre-push
  echo "hooks:    .githooks wired via core.hooksPath"
fi
